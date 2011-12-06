Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 325851007D5
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Dec 2011 20:30:50 +1100 (EST)
In-Reply-To: <4EDD32E1.7080009@freescale.com>
References: <201112051902.35285.alexander.lyasin@gmail.com>
 <4EDD32E1.7080009@freescale.com>
Subject: Re: Problem with eLBC?
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF61313592.71421E50-ONC125795E.0031F43D-C125795E.00343F25@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Dec 2011 10:30:40 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Alexander Lyasin <alexander.lyasin@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On 12/05/2011 08:02 AM, Alexander Lyasin wrote:
> > In reply to your Service Request SR 1-807899446:
> >
> > Yes, due to several design peculiarities in local bus nand controller,
> > simultaneous accesses to nand flash and to other local bus memory
> > controller may cause nand flash controller access failure. Our linux
> > team suggested to use "software lock" method to avoid this problem -
> > please do not use other local bus controllers, when nand flash is accessed.
>
> What kernel version are you using?  The latest mainline kernel should
> not have this issue.
>
> Make sure you have these patches:
>
> commit d08e44570ed611c527a1062eb4f8c6ac61832e6e
> Author: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Date:   Thu May 19 18:48:01 2011 +0800
>
>     powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum
>
>     Simultaneous FCM and GPCM or UPM operation may erroneously trigger
>     bus monitor timeout.
>
>     Set the local bus monitor timeout value to the maximum by setting
>     LBCR[BMT] = 0 and LBCR[BMTPS] = 0xF.
>
>     Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> and
>
> commit 476459a6cf46d20ec73d9b211f3894ced5f9871e
> Author: Scott Wood <scottwood@freescale.com>
> Date:   Fri Nov 13 14:13:01 2009 -0600
>
>     mtd: eLBC NAND: use recommended command sequences
>
>     Currently, the program and erase sequences do not wait for completion,
>     instead relying on a subsequent waitfunc() callback.  However, this
> causes
>     the chipselect to be deasserted while the NAND chip is still
> asserting the
>     busy pin, which can corrupt activity on other chipselects.
>
>     This patch switches to using the sequences recommended by the manual,
>     in which a wait is performed within the initial command sequence.
> We can
>     now re-use the status byte from the initial command sequence, rather
> than
>     having to do another status read in the waitfunc.
>
>     Since we're already touching the command sequences, it also cleans
> up some
>     cruft in SEQIN that isn't needed since we cannot program partial pages
>     outside of OOB.
>
>     Signed-off-by: Scott Wood <scottwood@freescale.com>
>     Reported-by: Suchit Lepcha <suchit.lepcha@freescale.com>
>     Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>     Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
>
> -Scott

Scott, you seem know something about eLBC and NAND. I have been told
that using NAND and other memory mapped devices on the same LB may
stall accesses to the other devices as the FCM may hold the bus for
long periods(a whole write or erase op.), is this so?

If still true, I guess the whole CPU "freezes" until the NAND op.
is complete?

 Jocke
