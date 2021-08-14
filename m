Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B12C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 19:09:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB58D60E96
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 19:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB58D60E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gn92R4GDSz3cVK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Aug 2021 05:09:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=n25sOE9l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=2a01:4f8:190:11c2::b:1457;
 helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=dkim header.b=n25sOE9l; dkim-atps=neutral
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gn91g1XjRz30BM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Aug 2021 05:08:23 +1000 (AEST)
Received: from zn.tnic (p200300ec2f1db90092f0c5d5424adff0.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1d:b900:92f0:c5d5:424a:dff0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54E261EC03D5;
 Sat, 14 Aug 2021 21:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1628968096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=mDvb80MdTaf2VGaprn1/RrktzLeXuWn32fRrJqO4RnI=;
 b=n25sOE9lUdWfF/+b9LVVu/c0RTBIvawG0223WpI1YjhZEQbLgR8M8pMHyOitDdblT/KimW
 wNA1cSGSX7URig9TBS5k8aka8wDk2wkKQnurLH+/Lu/L/dwizp44Ektb+n/sT1fMvyEOwE
 k/pW/5vABtT/pfK15uGy1LwHKVyiZxY=
Date: Sat, 14 Aug 2021 21:08:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YRgUxyhoqVJ0Kxvt@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
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
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, amd-gfx@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Joerg Roedel <jroedel@suse.de>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> new file mode 100644
> index 000000000000..51e4eefd9542
> --- /dev/null
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _X86_PROTECTED_GUEST_H
> +#define _X86_PROTECTED_GUEST_H
> +
> +#include <linux/mem_encrypt.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +static inline bool prot_guest_has(unsigned int attr)
> +{
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if (sme_me_mask)
> +		return amd_prot_guest_has(attr);
> +#endif
> +
> +	return false;
> +}
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* _X86_PROTECTED_GUEST_H */

I think this can be simplified more, diff ontop below:

- no need for the ifdeffery as amd_prot_guest_has() has versions for
both when CONFIG_AMD_MEM_ENCRYPT is set or not.

- the sme_me_mask check is pushed there too.

- and since this is vendor-specific, I'm checking the vendor bit. Yeah,
yeah, cross-vendor but I don't really believe that.

---
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
index 51e4eefd9542..8541c76d5da4 100644
--- a/arch/x86/include/asm/protected_guest.h
+++ b/arch/x86/include/asm/protected_guest.h
@@ -12,18 +12,13 @@
 
 #include <linux/mem_encrypt.h>
 
-#ifndef __ASSEMBLY__
-
 static inline bool prot_guest_has(unsigned int attr)
 {
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_me_mask)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return amd_prot_guest_has(attr);
-#endif
 
 	return false;
 }
 
-#endif	/* __ASSEMBLY__ */
-
 #endif	/* _X86_PROTECTED_GUEST_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index edc67ddf065d..5a0442a6f072 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -392,6 +392,9 @@ bool noinstr sev_es_active(void)
 
 bool amd_prot_guest_has(unsigned int attr)
 {
+	if (!sme_me_mask)
+		return false;
+
 	switch (attr) {
 	case PATTR_MEM_ENCRYPT:
 		return sme_me_mask != 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
