Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id BDE58DE002
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:34:27 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so24445qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:34:26 -0700 (PDT)
Message-ID: <9e4733910809241434n8d76c46pd70f99cf6104e667@mail.gmail.com>
Date: Wed, 24 Sep 2008 17:34:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: MPC5200 PCI interrupt routing
In-Reply-To: <1222291345.8277.92.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200809221556.34353.jbe@pengutronix.de>
	<48D807C5.4070002@genesi-usa.com>
	<200809231334.19175.jbe@pengutronix.de>
	<200809241716.35285.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca>
	<1222291345.8277.92.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 5:22 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2008-09-24 at 12:15 -0600, Grant Likely wrote:
>> On Wed, Sep 24, 2008 at 05:16:34PM +0200, Juergen Beisert wrote:
>> > On Dienstag, 23. September 2008, Juergen Beisert wrote:
>> > > What Kernel do you run on your target? On my hardware a 2.6.23 still work
>> > > as expected, but a 2.6.26 fails all the time.
>> >
>> > One should enable the internal USB clock. If done, it works... In 2.6.23 is
>> > was done in mpc52xx_common.c. It was removed in 2.6.24.
>>
>> It was removed because some 5200 platform do not use USB and should not
>> enable the internal clock.  In general, it is not the kernel's job to configure
>> clocking and pin usage on the chip.  Instead, it should be set correctly
>> at power up by U-Boot.
>
> Or by the USB host driver :-)
>
>> However, if firmware *cannot* be changed, there is a workaround.
>> You can create a new platform specific board support file in
>> arch/powerpc/platforms/52xx/ that matches against your specific board
>> and performs the needed fixups.  An example of this is lite5200.c.  Many
>> lite5200 boards have older versions of U-Boot installed which does not
>> correctly configure clocks or port-config.  So, lite5200.c matches to
>> the board instead of mpc5200_simple.c so that the board specific fixups
>> can be performed easily.  You should do the same for your board.
>
> I tend to thing that drivers should deal with their own clocks. In fact
> it would be nice if one could stop the clocks while the host port is in
> suspend no ?

There's a nice skeleton in arch/powerpc/kernel/clock.c for tracking
who is using a clock and disabling it when not in use. Nobody is using
it on PowerPC. It is used all over the place on ARM.

-- 
Jon Smirl
jonsmirl@gmail.com
