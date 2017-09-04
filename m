Return-Path: <clg@kaod.org>
Received: from 2.mo68.mail-out.ovh.net (2.mo68.mail-out.ovh.net
 [46.105.52.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm3gw35lvzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 18:59:39 +1000 (AEST)
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0AACC7CAE4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 10:59:35 +0200 (CEST)
Subject: Re: linux-next: build warning after merge of the powerpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20170904185341.58e3ff62@canb.auug.org.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9bf0fd0d-c56c-3826-9301-1ef720aacb44@kaod.org>
Date: Mon, 4 Sep 2017 10:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170904185341.58e3ff62@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2017 10:53 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> WARNING: vmlinux.o(.text+0xa7cb8): Section mismatch in reference from the function .xive_spapr_init() to the function .init.text:.xive_core_init()
> The function .xive_spapr_init() references
> the function __init .xive_core_init().
> This is often because .xive_spapr_init lacks a __init 
> annotation or the annotation of .xive_core_init is wrong.
> 
> Introduced by commit
> 
>   eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
> 

yes. I just sent a patch for this :

	http://patchwork.ozlabs.org/patch/809542/

Cheers,

C.
