Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 455B2474C2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 06:11:10 +1100 (EST)
In-Reply-To: <4926DE26.7030607@freescale.com>
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
	<4569571e317d43f1b26b087fcdebcba3@bga.com>
	<4925B78B.2040709@freescale.com>
	<22538ec7f241b37d1dfcb94188d414e8@bga.com>
	<4926DE26.7030607@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0fb05d76b5c1663b1c8de754e2ebd4b3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Date: Fri, 21 Nov 2008 13:09:30 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 21, 2008, at 10:13 AM, Timur Tabi wrote:
> Milton Miller wrote:
>> We want the last console= parameter on the command line to win.  So if
>> that implys the last call to add_preferred_console wins, then you have
>> code overriding the command line.
>
> Hmm, good point.  However, how likely is it that we'll have more than 
> one
> console driver?

For anything than custom embedded configs, quite likely.   As I said, I 
have 3 hvc clients, but that is unusual.  But frame buffer, vterm, 
rtas, and serial console would be a typical mix for a distribution.

> Also, without calling add_preferred_console(), the kernel needs
> to have a console= on the command line.

I'm not arguing against the call, I'm arguing when/from where it should 
be made.

> In my case, my driver only calls add_preferred_console() if the device 
> tree
> contains a specific property that it looks for.  In effect, this 
> property
> override the console= line.  However, the console= line goes to the HVC
> subsystem, and not my driver, and I can't use it to send the 
> configuration data
> the driver needs.

Discovering the hardware from the device tree and triggering your 
regitration is the right approach.  I think if you discover from an 
early setup then you can go before the command line.

As far as getting parameters, you are talking like ttyS0,9600,8,n,1 ? 
If you go after hvc_console then you could add a patch for hvc_console 
to remember the setup and return it to possible clients.

> Unfortunately, my driver hasn't been published yet, so it's hard to 
> explain the
> details.  I guess I need to think about this more.

I dont' know what details you would want on the console= command line 
that you should not have in the device tree.   If its which hypervisor 
channel, then I would think just choosing your hvc number accordingly 
would work.  But I can only make wild guesses without details.

milton
