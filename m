Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0593EB7092
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:07:28 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: Fix address issue when using
	relocatable kernels
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1277840527-18977-1-git-send-email-msm@freescale.com>
Date: Sun, 11 Jul 2010 11:07:24 -0500
Message-Id: <384545C4-8CA8-4041-9593-C5D329A9D24A@kernel.crashing.org>
References: <1277840527-18977-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 29, 2010, at 2:42 PM, Matthew McClintock wrote:

> When booting a relocatable kernel it needs to jump to the correct
> start address, which for BookE parts is usually unchanged
> regardless of the physical memory offset.
> 
> Recent changes cause problems with how we calculate the start
> address, it was always adding the RMO into the start address
> which is incorrect. This patch only adds in the RMO offset
> if we are in the kexec code path, as it needs the RMO to work
> correctly.
> 
> Instead of adding the RMO offset in in the common code path, we
> can just set r6 to the RMO offset in the kexec code path instead
> of to zero, and finally perform the masking in the common code
> path
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |    4 +---
> 1 files changed, 1 insertions(+), 3 deletions(-)

applied to merge

- k
