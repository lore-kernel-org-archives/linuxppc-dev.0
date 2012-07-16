Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 64DE32C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 18:53:20 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 17901-01 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 16 Jul 2012 09:46:36 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V3] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Mon, 16 Jul 2012 09:45:57 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F82@saturn3.aculab.com>
In-Reply-To: <1342406750-32694-1-git-send-email-B38951@freescale.com>
References: <1342406750-32694-1-git-send-email-B38951@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jia Hongtao" <B38951@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.

Does skipping the faulting instruction really help?

We use the mpc83xx and have seen PCIe issues that may be
related to a documented errata in the CSB-PEX bridge (which
I can't find my copy of).
Do the 85xx and 83xx have the same PCIe block?
Recovery from it seems almost impossible - my interpretation
was that you have to hard reset the PCIe block and rewrite
the entire configuration.

The problem we see happens during some PEX DMA transfers
(possibly due to issues with the target), the DMA doesn't
complete and any further PIO transfers fault (and panic).
Unfortunately the PEX has no documented status registers,
so it is difficult to determine what is (or rather isn't)
Happening.

	David
