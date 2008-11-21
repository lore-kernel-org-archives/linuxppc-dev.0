Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id F1612DDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 02:56:10 +1100 (EST)
In-Reply-To: <4925B78B.2040709@freescale.com>
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
	<4569571e317d43f1b26b087fcdebcba3@bga.com>
	<4925B78B.2040709@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22538ec7f241b37d1dfcb94188d414e8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Date: Fri, 21 Nov 2008 09:57:45 -0600
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


On Nov 20, 2008, at 1:16 PM, Timur Tabi wrote:

> Milton Miller wrote:
>
>> Stated differently, if your routine (1) fundamently works one 
>> character
>> at a time and (2) is not interrupt driven, and (3) only supports one
>> channel, what avantage is there to an explicit hvc driver?
>
> I think it's because HVC has the ability to use HVC client drivers for 
> console
> and TTY, but udbg does not.  So if you have a udbg-only driver, it 
> will cease to
> function when the kernel switches to the normal console.
>
> Perhaps it would make more sense to have the kernel continue to use 
> udbg if
> there is no normal console driver, instead of relying on David's 
> driver.

First, we have that option: just specify udbg-imortal on the command 
line, and the udbg console driver removes CON_BOOT from its flags.

Second, as David said in his reply, that doesn't let your userspace 
have a tty, which means no job control.

>> I too challanged the necessity of that change.  I carefully designed
>> the hvc_console layer to find the selected console weither it was
>> registered before or after the console_initcall of hvc_console.
>
> I'm just pointing out the patch that was committed in 2006 to address 
> this
> issue.  I discovered the same bug that the patch mentioned, and only 
> after a
> long time searching did I find this patch.  And sure enough, 
> re-arranging the
> Makefile made the problem I was seeing go away.
>
> Now, it's possible that this bug in hvc_console no longer exists.  
> However, I
> have seen nothing to indicate it.  Unfortunately, I don't remember 
> enough of the
> details to reproduce the problem, so I can't verify it.

As I said, I conceeded then the patch was required the way things 
worked.  There was another propsed patch a few months ago (3-9) that I 
pointed out they needed to be fixing the common console code; I don't 
remember seeing anything related after that but I could have missed it.

>> However, I think the bottom line was that add_preferred_console is
>> suppsoed to be called by architecture setup code.   Doing it the
>> console_initcall is almost abuse.  But if the console_initcall is 
>> going
>> to call add_preferred_console, then it must link before the 
>> hvc_console
>> driver.   I would have to go back and find the discussion to remember
>> the exact details.  (maybe it only needed to call
>> add_preferreed_console before registering itself if its the only hvc
>> backend).
>
> Well, I can't comment on your theory, but I do know that the
> add_preferred_console() call should be made from the HVC client 
> driver, or at
> least HVC itself.  It should not be in the platform code, because then 
> we have a
> dependency between the driver and the platform code.  I prefer my 
> drivers to
> initialize everything on their own, without the help of the platform 
> code.

Think about this for a second.

If every console driver said "prefer me", what point is there in having 
add_preferred_console?

The second reason is its too late.  We have already started scanning 
for drivers.  We are asking the console layer to adjust its choices 
after it has started scanning.

We want the last console= parameter on the command line to win.  So if 
that implys the last call to add_preferred_console wins, then you have 
code overriding the command line.


We have code that searches the device tree for the stdout that firmware 
used.  That code then tells the console layer which driver to choose 
when it recognises it.   The pSeries platform also has code that says 
when it finds vterm channels under lpar, then it should choose it.

I think we should have the code that sets the udbg method indicate that 
the console should be preferred.  While its not really arch code, it is 
architecture code in that its hooked from early discovrey based not 
cosole_initcall based (which runs before arch_initcall).  This is also 
the point where we know if the udbg method is sharing hardware with a 
full driver and therefore udbg_hvc should not be used.

milton
