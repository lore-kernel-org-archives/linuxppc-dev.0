Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92DC72C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 10:00:42 +1100 (EST)
Message-ID: <1389999629.24905.290.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 17 Jan 2014 17:00:29 -0600
In-Reply-To: <1389758064.6933.56.camel@pasglop>
References: <20140111004451.GA7353@home.buserror.net>
 <1389758064.6933.56.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-15 at 14:54 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-01-10 at 18:44 -0600, Scott Wood wrote:
> > Highlights include 32-bit booke relocatable support, e6500 hardware
> > tablewalk support, various e500 SPE fixes, some new/revived boards, and
> > e6500 deeper idle and altivec powerdown modes.
> 
> This breaks WSP (A2) build with 64K pages:
> 
> /home/benh/linux-powerpc-test/arch/powerpc/mm/tlb_low_64e.S: Assembler messages:
> /home/benh/linux-powerpc-test/arch/powerpc/mm/tlb_low_64e.S:334: Error: can't resolve `L0^A' {*ABS* section} - `PUD_SHIFT' {*UND* section}
> /home/benh/linux-powerpc-test/arch/powerpc/mm/tlb_low_64e.S:334: Error: expression too complex
> /home/benh/linux-powerpc-test/arch/powerpc/mm/tlb_low_64e.S:334: Error: operand out of range (67 is not between 0 and 63)
> make[2]: *** [arch/powerpc/mm/tlb_low_64e.o] Error 1
> 
> I'm merging anyway because nobody uses WSP anymore (I'm keen to remove it by 3.15 or so)

Does this apply to all non-FSL 64-bit book3e, or is there anything else
that is still in use?

> but in the meantime you may want to fix it (probably just ifdef the PUD level walk on
> 64k pages, look at what I do elsewhere).

Ifdeffing the PUD level doesn't make much sense in this case (other than
perhaps as the least intrusive way to make the error go away) because
that codepath is specific to e6500 which doesn't support 64K pages.  The
whole e6500 section should be ifdeffed out if there are 64K pages (or
really, if CONFIG_PPC_FSL_BOOK3E isn't defined, and 64K pages should
conflict with PPC_FSL_BOOK3E).

-Scott
