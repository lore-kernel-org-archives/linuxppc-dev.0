Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F5471A0088
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 03:12:39 +1000 (EST)
Message-ID: <1400865146.12823.54.camel@snotra.buserror.net>
Subject: Re: powerpc: remove checks for CONFIG_BOOK3E_MMU_TLB_STATS
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 23 May 2014 12:12:26 -0500
In-Reply-To: <1400839597.31526.21.camel@x220>
References: <1400608550.4912.48.camel@x220>
 <20140522223758.GA20343@home.buserror.net> <1400830406.31526.6.camel@x220>
 <1400839597.31526.21.camel@x220>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 12:06 +0200, Paul Bolle wrote:
> On Fri, 2014-05-23 at 09:33 +0200, Paul Bolle wrote:
> > Scott,
> > 
> > On Thu, 2014-05-22 at 17:37 -0500, Scott Wood wrote:
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S: Assembler messages:
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:89: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:238: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:269: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:281: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:441: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:510: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:881: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:918: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > 
> > Thanks for testing!
> > 
> > That's a bit surprising. The patch is intended to be a non event. Ie, it
> > only removes what the preprocessor would have removed anyway. Unless I
> > botched it, of course.
> > 
> > What exactly did you test there?
> 
> For what it's worth: I can't reproduce this error with the cross
> compiler now shipped with Fedora 20 (ie, powerpc64-linux-gnu-gcc (GCC)
> 4.8.1 20130717 (Red Hat 4.8.1-5)). It shows a nice and clean
>      AS      arch/powerpc/mm/tlb_low_64e.o
> 
> in the output.
> 
> That's v3.15-rc6, with just this patch, and using a .config generated,
> with "make oldconfig", from arch/powerpc/configs/ppc64e_defconfig.

Hmm, I tried applying again and it was fine.  I guess I accidentally
removed one line too many when resolving a conflict with
b1576fec7f4dd4657694fefc97fda4cf28ec68e9 "powerpc: No need to use dot
symbols when branching to a function" that's in Ben's -next tree.

-Scott
