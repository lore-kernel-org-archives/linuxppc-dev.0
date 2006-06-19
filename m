Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9B23667A63
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Jun 2006 23:35:37 +1000 (EST)
Message-ID: <4496A363.8080802@varma-el.com>
Date: Mon, 19 Jun 2006 17:15:15 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Trueskew <trueskew@gmail.com>
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)
References: <44965226.33b91fca.1abe.ffffd120@mx.gmail.com>
In-Reply-To: <44965226.33b91fca.1abe.ffffd120@mx.gmail.com>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Trueskew wrote:
> I should've let you all know, I'm more of a 2.4 person than a 2.6 person.
> So I read what I could on 2.6 difference with 2.4, and it looked like my
> easiest choice was to modify the bestcomm code to export a couple tables and
> its API functions.  I found that kallsyms has almost all of the functions I
> needed to resolve (with 'T' next to them), but they were still not working.
> I added EXPORT_MODULE(TaskBDReset) and similar declarations in the bestcomm
> api code, but that still didn't do the trick for me.  So what is the trick?
> I think I'm on the right track, I can insmod a module that my driver needs,
> see kallsyms get updated, and access the functions directly in my driver.  I
> hope I'm close to doing something similar with the bestcomm functions, can
> anyone offer me some advice on what else I need to do?
> 
> Thanks.
Please, check Sylvain's patchset (http://www.246tNt.com/mpc52xx/)
_before_ you will do anithing. If be more shortly - Freescale's
BestcommAPI _deprecated_ and will _not_ included to 2.6.xxx.

--
Regards
Andrey Volkov


> 
> ________________________________
> 
> From: Trueskew [mailto:trueskew@gmail.com] 
> Sent: Friday, June 16, 2006 9:47 PM
> To: 'linuxppc-embedded@ozlabs.org'
> Subject: Using bestcomm in an external module (MPC5200B to be exact)
> 
> 
> I'm writing a driver for a TI codec attached to the MPC5200B PSC3 codec
> lines on a Lite5200b.  It's an external module, and I'd like to use Bestcomm
> with it.  I've already tried a bunch of horrible things to get it to work.
> I could say it's close, but by close I mean the FEC still runs, my stuff
> doesn't.  
>  
> 1. Can the Bestcomm I/F be used by an external module, or is the module
> required to be built in if built-in drivers use Bestcomm?  TasksInitAPI (no
> so bad) and TasksLoadImage (yeah, bad) aren't really supposed to be called
> more than once from what I've read, and the kernel loads them for ethernet
> and ATA (no disk in my system if that matters).  
>  
> 2. If it can be used by an external module, how would I do it?  I've tried
> compiling the source into my module and replicating the initialization the
> kernel does in addition to my own stuff.  It's not too bad, though I don't
> get any interrupts yet.
>  
> The LTIB from Freescale includes AIC23 and AC97 drivers that use Bestcomm.
> I built my kernel with them set as modules, and they had the same unresolved
> problems that my driver has on insmod, so I'm pessimistic.  If someone could
> put me out of my misery one way or another, I'd appreciate it.
>  
> Thanks.
> Sal
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
