Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCfB65xxQzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 22:13:34 +1000 (AEST)
Date: Wed, 26 Apr 2017 22:13:30 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Native usage of the XIVE
 interrupt controller
Message-ID: <20170426121330.GA12057@fergus.ozlabs.ibm.com>
References: <1493172450-19636-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493172450-19636-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 26, 2017 at 12:07:30PM +1000, Michael Ellerman wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This patch makes KVM capable of using the XIVE interrupt controller
> to provide the standard PAPR "XICS" style hypercalls. It is necessary
> for proper operations when the host uses XIVE natively.
> 
> This has been lightly tested on an actual system, including PCI
> pass-through with a TG3 device.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [mpe: Cleanup pr_xxx(), unsplit pr_xxx() strings, etc., fix build
>  failures by adding KVM_XIVE which depends on KVM_XICS and XIVE, and
>  adding empty stubs for the kvm_xive_xxx() routines, fixup subject]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

The Kconfig stuff for KVM_XIVE is wrong, you need:

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 6498424..c56939e 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -200,7 +200,7 @@ config KVM_XICS
 config KVM_XIVE
 	bool
 	default y
-	depends on KVM_XICS && XIVE_NATIVE
+	depends on KVM_XICS && PPC_XIVE_NATIVE
 
 source drivers/vhost/Kconfig
 
on top of what you posted.

Paul.
