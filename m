Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 962FB1007D4
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Dec 2011 08:09:00 +1100 (EST)
Message-ID: <4EDD32E1.7080009@freescale.com>
Date: Mon, 5 Dec 2011 15:08:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Lyasin <alexander.lyasin@gmail.com>
Subject: Re: Problem with eLBC?
References: <201112051902.35285.alexander.lyasin@gmail.com>
In-Reply-To: <201112051902.35285.alexander.lyasin@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2011 08:02 AM, Alexander Lyasin wrote:
> In reply to your Service Request SR 1-807899446:
> 
> Yes, due to several design peculiarities in local bus nand controller,
> simultaneous accesses to nand flash and to other local bus memory
> controller may cause nand flash controller access failure. Our linux
> team suggested to use "software lock" method to avoid this problem -
> please do not use other local bus controllers, when nand flash is accessed.

What kernel version are you using?  The latest mainline kernel should
not have this issue.

Make sure you have these patches:

commit d08e44570ed611c527a1062eb4f8c6ac61832e6e
Author: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date:   Thu May 19 18:48:01 2011 +0800

    powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum

    Simultaneous FCM and GPCM or UPM operation may erroneously trigger
    bus monitor timeout.

    Set the local bus monitor timeout value to the maximum by setting
    LBCR[BMT] = 0 and LBCR[BMTPS] = 0xF.

    Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

and

commit 476459a6cf46d20ec73d9b211f3894ced5f9871e
Author: Scott Wood <scottwood@freescale.com>
Date:   Fri Nov 13 14:13:01 2009 -0600

    mtd: eLBC NAND: use recommended command sequences

    Currently, the program and erase sequences do not wait for completion,
    instead relying on a subsequent waitfunc() callback.  However, this
causes
    the chipselect to be deasserted while the NAND chip is still
asserting the
    busy pin, which can corrupt activity on other chipselects.

    This patch switches to using the sequences recommended by the manual,
    in which a wait is performed within the initial command sequence.
We can
    now re-use the status byte from the initial command sequence, rather
than
    having to do another status read in the waitfunc.

    Since we're already touching the command sequences, it also cleans
up some
    cruft in SEQIN that isn't needed since we cannot program partial pages
    outside of OOB.

    Signed-off-by: Scott Wood <scottwood@freescale.com>
    Reported-by: Suchit Lepcha <suchit.lepcha@freescale.com>
    Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

-Scott
