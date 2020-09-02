Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0203C433E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 01:51:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3242E206EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 01:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OOsMu7X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3242E206EF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bh6Nm6xrCzDqcP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 11:51:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bh6LL2wHPzDqTh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 11:49:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=OOsMu7X2; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Bh6LK5jm1z9sSJ; Wed,  2 Sep 2020 11:49:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1599011353; bh=hTaXmDx448oQYoyezs5f5Rukwes/5nA+Fn7vM9Nl0n8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OOsMu7X2nDHa6F7OzcSZVptEYMumaeL2UkBfmg7M3+JbgDG/3FWooN3c4DWto5Sft
 1Z27emBpzzXKPNtDQLGTVa2AMqqYC9XcDU3K2/tEaYeBQvjjwwNYZDPzEHlKW6O3rE
 G9cRpY3uUQZyK5xgKIrAHh6LywbCfTti69J8sNigC22VUC7u9fXd1tTF7gyB87KKK/
 gTnJtCaERj+NMBZgLfcMnGuIxf6gF90RM1xm25AVr3Soy4GuDuKzYd6Ko9tBIvrTql
 q/VAKEPeI5Dp8lmfixFxXTCo/SYUDSXVyLhJ2zkocUYVOWAVABWF2RiGURS1UCBa+x
 8fkzom8P1jefw==
Date: Wed, 2 Sep 2020 11:49:08 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 1/7] powerpc/watchpoint/kvm: Rename current DAWR macros
 and variables
Message-ID: <20200902014908.GA272502@thinks.paulus.ozlabs.org>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
 <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: christophe.leroy@c-s.fr, mikey@neuling.org, rogealve@br.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 kvm-ppc@vger.kernel.org, linux-kselftest@vger.kernel.org, jniethe5@gmail.com,
 pedromfc@br.ibm.com, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 23, 2020 at 03:50:52PM +0530, Ravi Bangoria wrote:
> Power10 is introducing second DAWR. Use real register names (with
> suffix 0) from ISA for current macros and variables used by kvm.

Most of this looks fine, but I think we should not change the existing
names in arch/powerpc/include/uapi/asm/kvm.h (and therefore also
Documentation/virt/kvm/api.rst).

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 426f94582b7a..4dc18fe6a2bf 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -2219,8 +2219,8 @@ registers, find a list below:
>    PPC     KVM_REG_PPC_BESCR               64
>    PPC     KVM_REG_PPC_TAR                 64
>    PPC     KVM_REG_PPC_DPDES               64
> -  PPC     KVM_REG_PPC_DAWR                64
> -  PPC     KVM_REG_PPC_DAWRX               64
> +  PPC     KVM_REG_PPC_DAWR0               64
> +  PPC     KVM_REG_PPC_DAWRX0              64
>    PPC     KVM_REG_PPC_CIABR               64
>    PPC     KVM_REG_PPC_IC                  64
>    PPC     KVM_REG_PPC_VTB                 64
...
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 264e266a85bf..38d61b73f5ed 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -608,8 +608,8 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_BESCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa7)
>  #define KVM_REG_PPC_TAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa8)
>  #define KVM_REG_PPC_DPDES	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa9)
> -#define KVM_REG_PPC_DAWR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> -#define KVM_REG_PPC_DAWRX	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
> +#define KVM_REG_PPC_DAWR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> +#define KVM_REG_PPC_DAWRX0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
>  #define KVM_REG_PPC_CIABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xac)
>  #define KVM_REG_PPC_IC		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xad)
>  #define KVM_REG_PPC_VTB		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xae)

The existing names are an API, and if you change them you will break
compilation of existing userspace programs.  I don't see that adding
the '0' on the end is so important that we need to break userspace.

Paul.
