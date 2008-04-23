Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 63976DE06C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 22:49:31 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] AMCC PPC440EPx/sequoia stability question...
Date: Wed, 23 Apr 2008 14:49:24 +0200
References: <480EADF4.2020706@verizon.net>
In-Reply-To: <480EADF4.2020706@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804231449.24746.sr@denx.de>
Cc: Dave Littell <littelld@verizon.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 23 April 2008, Dave Littell wrote:
> I'm working on an AMCC PPC440EPx-based platform that's similar to the
> Sequoia.  The board runs pretty well, but occasionally takes exceptions
> both in U-Boot and while running Linux.  The exceptions vary from
> Illegal Instructions to FP Unavailable to FP Unimplemented to ITLB and
> DTLB Errors, to DSI, etc., which made us believe there's a problem with
> SDRAM.

Yes, this is my first idea too. Almost every time such "random" errors are 
seen, SDRAM setup/initialization is the cause for it.

> Sometimes there are simple hard lockups from which even the JTAG 
> can't regain control.  However, the SDRAM physical/electrical and DDR
> Controller configurations have been investigated in detail (and some
> corrections made) with no resulting improvement in the exception behavior.

Is the SDRAM termination similar to the one used on Sequoia too? Are you using 
soldered chips and not DIMM modules? Is ECC available?

> We see problems primarily at 667 MHz but have noted some issues at 533
> MHz as well.  Some boards seem particularly susceptible to this while
> others rarely (if ever) exhibit the problem.
>
> At this point all possibilities are on the table and I'm looking for any
> input from anyone with experience (good, bad, or whatever) with this
> processor and/or designs similar to the Sequoia.

If you scan the U-Boot mailing list for 440EPx/Denali DDR2 problems, you will 
most likely find some references.

Please note that I recently introduced a CFG_MEM_TOP_HIDE option for the 
440EPx CHIP 11 errata. I suggest you take a look at this too and see if this 
changes your behavior.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
