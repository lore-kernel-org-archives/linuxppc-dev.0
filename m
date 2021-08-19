Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49196C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 17:27:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E7F6023D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 17:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82E7F6023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrBXM3N79z3cMK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 03:26:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=QQBp8NHu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=5.9.137.197; helo=mail.skyhub.de;
 envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrBWW04rCz3bXv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 03:26:09 +1000 (AEST)
Received: from zn.tnic (p200300ec2f0f6a00894cffc8901d9ad3.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:6a00:894c:ffc8:901d:9ad3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D09E1EC04F3;
 Thu, 19 Aug 2021 19:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629393952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=/gAtsE7QtBH5j9ttL3SuPKWfuXAyQgTTaUQCvmLoufU=;
 b=QQBp8NHuP+11G06yi7BdGA+HaVdnbkry0TMbR80aBtGTWa+AS2GGnsUl92jeGasIkZJxjG
 vbA27TU+69/cDt/R71KHjVUhLNS00XEkqnozCdieagZOK0jWv65x9AAvusLIXItaBgTbsA
 IoE8XMNOekYHfnDaNqS/LMVqj09wsDs=
Date: Thu, 19 Aug 2021 19:26:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YR6UR9JWD6l6z9Cn@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YR4p9TqKTLdN1A96@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YR4p9TqKTLdN1A96@infradead.org>
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
 linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 19, 2021 at 10:52:53AM +0100, Christoph Hellwig wrote:
> Which suggest that the name is not good to start with.  Maybe protected
> hardware, system or platform might be a better choice?

Yah, coming up with a proper name here hasn't been easy.
prot_guest_has() is not the first variant.

From all three things you suggest above, I guess calling it a "platform"
is the closest. As in, this is a confidential computing platform which
provides host and guest facilities etc.

So calling it

confidential_computing_platform_has()

is obviously too long.

ccp_has() clashes with the namespace of drivers/crypto/ccp/ which is
used by the technology too.

coco_platform_has() is too unserious.

So I guess

cc_platform_has()

ain't all that bad.

Unless you have a better idea, ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
