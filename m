Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 56342B7108
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 01:26:22 +1000 (EST)
Received: by pzk5 with SMTP id 5so3568984pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Sep 2010 08:26:20 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 1 Sep 2010 09:26:16 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] gpiolib: Add 'struct gpio_chip' forward declaration
	for !GPIOLIB case
Message-ID: <20100901152616.GD13421@angua.secretlab.ca>
References: <1282631168.22370.517.camel@pasglop>
	<20100824092623.GA20334@oksana.dev.rtsoft.ru>
	<20100831080344.GA20515@angua.secretlab.ca>
	<20100831083716.GA28362@oksana.dev.rtsoft.ru>
	<AANLkTi=EaHxDgwVfh-bhGANcBYWjHW7-aZt4K5ZZ7WRi@mail.gmail.com>
	<20100831170756.GA24887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100831170756.GA24887@oksana.dev.rtsoft.ru>
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

On Tue, Aug 31, 2010 at 09:07:56PM +0400, Anton Vorontsov wrote:
> On Tue, Aug 31, 2010 at 10:44:14AM -0600, Grant Likely wrote:
> > On Tue, Aug 31, 2010 at 2:37 AM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> > > On Tue, Aug 31, 2010 at 02:03:44AM -0600, Grant Likely wrote:
> > >> On Tue, Aug 24, 2010 at 01:26:23PM +0400, Anton Vorontsov wrote:
> > >> > With CONFIG_GPIOLIB=n, the 'struct gpio_chip' is not declared,
> > >> > so the following pops up on PowerPC:
> > >> >
> > >> >   cc1: warnings being treated as errors
> > >> >   In file included from arch/powerpc/platforms/52xx/mpc52xx_common.c:19:
> > >> >   include/linux/of_gpio.h:74: warning: 'struct gpio_chip' declared
> > >> >                               inside parameter list
> > >> >   include/linux/of_gpio.h:74: warning: its scope is only this definition
> > >> >                               or declaration, which is probably not what
> > >> >                           you want
> > >> >   include/linux/of_gpio.h:75: warning: 'struct gpio_chip' declared
> > >> >                               inside parameter list
> > >> >   make[2]: *** [arch/powerpc/platforms/52xx/mpc52xx_common.o] Error 1
> > >> >
> > >> > This patch fixes the issue by providing the proper forward declaration.
> > >> >
> > >> > Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > >>
> > >> This doesn't actually solve the problem, and gpiochip should
> > >> remain undefined when CONFIG_GPIOLIB=n to catch exactly these
> > >> build failures.  The real problem is that I merged a change
> > >> into the mpc5200 code that required CONFIG_GPIOLIB be enabled
> > >> without reflecting that requirement in Kconfig.
> > >
> > > No, look closer. The error is in of_gpio.h, and it's perfectly
> > > fine to include it w/o GPIOLIB=y.
> > 
> > Looking even closer, we're both wrong.  You're right I didn't look
> > carefully enough, and the error is in of_gpio.h, not the .c file.
> > 
> > However, it is not okay to get the definitions from of_gpio.h when
> > CONFIG_GPIOLIB=n.  If GPIOLIB, or more specifically OF_GPIO isn't set,
> > then the of_gpio.h definitions should either not be defined, or should
> > be defined as empty stubs (where appropriate).
> 
> Grrr. Grant, look again, even closer than you did.

Gah.  Very bad day yesterday.  Applied and sorry for the noise.

g.
