Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 356741A035C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 12:48:36 +1000 (AEST)
Message-ID: <1437792504.2993.280.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: fix pcie range issue for some P1/P2
 boards
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <b21284@freescale.com>
Date: Fri, 24 Jul 2015 21:48:24 -0500
In-Reply-To: <1437559704-13332-1-git-send-email-B48286@freescale.com>
References: <1437559704-13332-1-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-22 at 18:08 +0800, Zhiqiang Hou wrote:

> From: Hou Zhiqiang <B48286@freescale.com>

You CCed this to 
b21284@freescale.com.  Who is that?  It would be nice to use "friendly" 
e-mail addresses, but at least include the name along with the e-mail address.

I suggest CCing the people who added these device trees.

> Impact board list:
> P1020MBG-PC. P1022DS, P2020RDB
> All above boards have its PCIE memory range less than 0xbfff_ffff,

If you mean that the physical address of the memory region is <= 0xbfff_ffff, 
I don't see the relevance.

> but in dts its boundary value was 0xe0000000. Both of them was maped
> to the same boundary 0xe0000000 which was Overlapped and crossed.

By "boundary" do you mean the PCIe bus address?  Why is it a problem for 
these independent PCIe root complexes to have the same PCIe bus addresses?

>  Cpu will access the illicit memery addr and detect error then lead to
> cpu stall.  So update dts for these boards.

What is illicit about it?

Why isn't the problem seen in the 36-bit device trees, which do the same 
thing?

-Scott
