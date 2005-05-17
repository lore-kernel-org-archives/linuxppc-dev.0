Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp08.mail.mci.yahoo.co.jp (ybbsmtp08.mail.mci.yahoo.co.jp
	[210.80.241.157]) by ozlabs.org (Postfix) with SMTP id 19D31679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 15:53:46 +1000 (EST)
Message-ID: <42898825.3000803@ybb.ne.jp>
Date: Tue, 17 May 2005 14:59:01 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42884448.6040505@ybb.ne.jp>
	<63792af268f18c480d5ecf218a4e61af@freescale.com>
In-Reply-To: <63792af268f18c480d5ecf218a4e61af@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:

Kumar Gala wrote:
> No problem, can you replace all the cmd line parsing with early_param() 
> code in arch/ppc/kernel/setup.c.  Take a look at 
> arch/ppc64/kernel/setup.c for an example.  We still need to add a call 
> to parse_early_param() in setup_arch().
>
Sorry, I can not figure out what you want.
As far as I look the source tree,arch/ppc/kernel/setup.c does not have 
the function called early_param.
Would you give me a more precise explanation?

> Matt & I need to talk about the driver patch.  Once I have more feedback 
> on that I'll let you know.  The major issue I have is having the 
> interrupt handler in drivers/char/watchdog/.. instead of 
> arch/ppc/kernel/traps.c.  However, I dont have a good idea how to 
> structure the changes.
>

Certainly, moving the interrupt handler from 
drivers/char/watchdog/booke_wdt.c to arch/ppc/kernel/traps.c
is easy, but I can not tell whether it is good or not.

But the handler is not used by the core kernel.
 From this point of view, the handler should not be placed
in arch/ppc/kernel/traps.c. This is the reason why I locate
the exception handler in the driver part.

Anyway, I'll try to move this handler into arch/ppc/kernel/traps.c
for the moment.
