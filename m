Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 8D021B714D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 02:44:42 +1000 (EST)
Received: by yxj4 with SMTP id 4so2707956yxj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 09:44:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100831083716.GA28362@oksana.dev.rtsoft.ru>
References: <1282631168.22370.517.camel@pasglop>
	<20100824092623.GA20334@oksana.dev.rtsoft.ru>
	<20100831080344.GA20515@angua.secretlab.ca>
	<20100831083716.GA28362@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 31 Aug 2010 10:44:14 -0600
Message-ID: <AANLkTi=EaHxDgwVfh-bhGANcBYWjHW7-aZt4K5ZZ7WRi@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Add 'struct gpio_chip' forward declaration for
	!GPIOLIB case
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: David Brownell <david-b@pacbell.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 2:37 AM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Tue, Aug 31, 2010 at 02:03:44AM -0600, Grant Likely wrote:
>> On Tue, Aug 24, 2010 at 01:26:23PM +0400, Anton Vorontsov wrote:
>> > With CONFIG_GPIOLIB=3Dn, the 'struct gpio_chip' is not declared,
>> > so the following pops up on PowerPC:
>> >
>> > =A0 cc1: warnings being treated as errors
>> > =A0 In file included from arch/powerpc/platforms/52xx/mpc52xx_common.c=
:19:
>> > =A0 include/linux/of_gpio.h:74: warning: 'struct gpio_chip' declared
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inside par=
ameter list
>> > =A0 include/linux/of_gpio.h:74: warning: its scope is only this defini=
tion
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 or declara=
tion, which is probably not what
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 you want
>> > =A0 include/linux/of_gpio.h:75: warning: 'struct gpio_chip' declared
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inside par=
ameter list
>> > =A0 make[2]: *** [arch/powerpc/platforms/52xx/mpc52xx_common.o] Error =
1
>> >
>> > This patch fixes the issue by providing the proper forward declaration=
.
>> >
>> > Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
>>
>> This doesn't actually solve the problem, and gpiochip should
>> remain undefined when CONFIG_GPIOLIB=3Dn to catch exactly these
>> build failures. =A0The real problem is that I merged a change
>> into the mpc5200 code that required CONFIG_GPIOLIB be enabled
>> without reflecting that requirement in Kconfig.
>
> No, look closer. The error is in of_gpio.h, and it's perfectly
> fine to include it w/o GPIOLIB=3Dy.

Looking even closer, we're both wrong.  You're right I didn't look
carefully enough, and the error is in of_gpio.h, not the .c file.

However, it is not okay to get the definitions from of_gpio.h when
CONFIG_GPIOLIB=3Dn.  If GPIOLIB, or more specifically OF_GPIO isn't set,
then the of_gpio.h definitions should either not be defined, or should
be defined as empty stubs (where appropriate).

So, instead of adding a forward declarations of the struct, the
correct thing I think to do is to #ifdef out the contents of of_gpio.h
when GPIOLIB isn't selected so that extra #includes are completely
benign.  I've been doing the same thing on the other linux/of*.h
headers.  I've got a patch in my tree that I'm testing right now and
I'll post later today.

g.

>
>> > ---
>> >
>> > On Tue, Aug 24, 2010 at 04:26:08PM +1000, Benjamin Herrenschmidt wrote=
:
>> > > I get that with my current stuff:
>> > >
>> > > cc1: warnings being treated as errors
>> > > In file included from [..]/mpc52xx_common.c:19:
>> > > of_gpio.h:74: error: =91struct gpio_chip=92 declared inside paramete=
r list
>> > [...]
>> > > make[3]: *** Waiting for unfinished jobs....
>> >
>> > That's because with GPIOCHIP=3Dn no one declares struct gpio_chip.
>> >
>> > It should be either of_gpio.h or gpio.h. Let's make it gpio.h, as
>> > this feels more generic, and we already have some !GPIOLIB handling
>> > in there.
>> >
>> > =A0include/linux/gpio.h | =A0 =A06 ++++++
>> > =A01 files changed, 6 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/include/linux/gpio.h b/include/linux/gpio.h
>> > index 03f616b..85207d2 100644
>> > --- a/include/linux/gpio.h
>> > +++ b/include/linux/gpio.h
>> > @@ -15,6 +15,12 @@
>> > =A0struct device;
>> >
>> > =A0/*
>> > + * Some code might rely on the declaration. Still, it is illegal
>> > + * to dereference it for !GPIOLIB case.
>> > + */
>> > +struct gpio_chip;
>> > +
>> > +/*
>> > =A0 * Some platforms don't support the GPIO programming interface.
>> > =A0 *
>> > =A0 * In case some driver uses it anyway (it should normally have
>> > --
>> > 1.7.0.5
>> >
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
