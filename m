Return-Path: <timur@freescale.com>
Message-ID: <4925B78B.2040709@freescale.com>
Date: Thu, 20 Nov 2008 13:16:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: udbg based backend for hvc_console
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
	<4569571e317d43f1b26b087fcdebcba3@bga.com>
In-Reply-To: <4569571e317d43f1b26b087fcdebcba3@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Milton Miller wrote:

> Stated differently, if your routine (1) fundamently works one character  
> at a time and (2) is not interrupt driven, and (3) only supports one  
> channel, what avantage is there to an explicit hvc driver?

I think it's because HVC has the ability to use HVC client drivers for console
and TTY, but udbg does not.  So if you have a udbg-only driver, it will cease to
function when the kernel switches to the normal console.

Perhaps it would make more sense to have the kernel continue to use udbg if
there is no normal console driver, instead of relying on David's driver.

> I too challanged the necessity of that change.  I carefully designed  
> the hvc_console layer to find the selected console weither it was  
> registered before or after the console_initcall of hvc_console.

I'm just pointing out the patch that was committed in 2006 to address this
issue.  I discovered the same bug that the patch mentioned, and only after a
long time searching did I find this patch.  And sure enough, re-arranging the
Makefile made the problem I was seeing go away.

Now, it's possible that this bug in hvc_console no longer exists.  However, I
have seen nothing to indicate it.  Unfortunately, I don't remember enough of the
details to reproduce the problem, so I can't verify it.

> However, I think the bottom line was that add_preferred_console is  
> suppsoed to be called by architecture setup code.   Doing it the  
> console_initcall is almost abuse.  But if the console_initcall is going  
> to call add_preferred_console, then it must link before the hvc_console  
> driver.   I would have to go back and find the discussion to remember  
> the exact details.  (maybe it only needed to call  
> add_preferreed_console before registering itself if its the only hvc  
> backend).

Well, I can't comment on your theory, but I do know that the
add_preferred_console() call should be made from the HVC client driver, or at
least HVC itself.  It should not be in the platform code, because then we have a
dependency between the driver and the platform code.  I prefer my drivers to
initialize everything on their own, without the help of the platform code.

-- 
Timur Tabi
Linux kernel developer at Freescale
