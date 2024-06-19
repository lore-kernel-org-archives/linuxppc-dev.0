Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB13C27C53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2024 16:46:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W48dS27hRz3d89
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2024 02:46:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W48cz3HGPz30Wc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2024 02:45:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E2BF61EAE;
	Wed, 19 Jun 2024 16:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47094C2BBFC;
	Wed, 19 Jun 2024 16:45:32 +0000 (UTC)
Date: Wed, 19 Jun 2024 17:45:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
Subject: Re: [PATCH v4 13/29] arm64: convert protection key into vm_flags and
 pgprot values
Message-ID: <ZnMLKb_gWsbLgMf3@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>
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
Cc: szabolcs.nagy@arm.com, dave.hansen@linux.intel.com, Joey Gouly <joey.gouly@arm.com>, linux-mm@kvack.org, hpa@zytor.com, shuah@kernel.org, maz@kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, naveen.n.rao@linux.ibm.com, will@kernel.org, npiggin@gmail.com, broonie@kernel.org, bp@alien8.de, kvmarm@lists.linux.dev, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 28, 2024 at 12:24:57PM +0530, Amit Daniel Kachhap wrote:
> On 5/3/24 18:31, Joey Gouly wrote:
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > index 5966ee4a6154..ecb2d18dc4d7 100644
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -7,7 +7,7 @@
> >   #include <uapi/asm/mman.h>
> >   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > -	unsigned long pkey __always_unused)
> > +	unsigned long pkey)
> >   {
> >   	unsigned long ret = 0;
> > @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >   	if (system_supports_mte() && (prot & PROT_MTE))
> >   		ret |= VM_MTE;
> > +#if defined(CONFIG_ARCH_HAS_PKEYS)
> 
> Should there be system_supports_poe() check like above?

I think it should, otherwise we end up with these bits in the pte even
when POE is not supported.

> > +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> > +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> > +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
> > +#endif
> > +
> >   	return ret;
> >   }
> >   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)

-- 
Catalin
