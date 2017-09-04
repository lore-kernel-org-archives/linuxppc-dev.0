Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm3Y3002gzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 18:53:42 +1000 (AEST)
Date: Mon, 4 Sep 2017 18:53:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater <clg@kaod.org>
Subject: linux-next: build warning after merge of the powerpc tree
Message-ID: <20170904185341.58e3ff62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

WARNING: vmlinux.o(.text+0xa7cb8): Section mismatch in reference from the function .xive_spapr_init() to the function .init.text:.xive_core_init()
The function .xive_spapr_init() references
the function __init .xive_core_init().
This is often because .xive_spapr_init lacks a __init 
annotation or the annotation of .xive_core_init is wrong.

Introduced by commit

  eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")

-- 
Cheers,
Stephen Rothwell
