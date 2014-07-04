Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by lists.ozlabs.org (Postfix) with ESMTP id 6DB421A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 20:49:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 024D212B0A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 12:44:31 +0200 (CEST)
Date: Fri, 4 Jul 2014 12:44:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Message-ID: <20140704104430.GD13434@8bytes.org>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 07:27:15PM +0530, Varun Sethi wrote:
>  	/* window size is 2^(WSE+1) bytes */
> -	return __ffs(addrspace_size) - 1;
> +	return fls64(addrspace_size) - 2;

This looks bogus, why do you replace ffs (find-first-bit) by fls
(find-last-bit)?


	Joerg
