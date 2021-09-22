Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFEC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 19:53:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2386961050
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 19:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2386961050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF89n5gzkz3c61
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 05:53:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=TrWHyvCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=5.9.137.197; helo=mail.skyhub.de;
 envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=dkim header.b=TrWHyvCo; dkim-atps=neutral
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF88Z1S2Qz2ypF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2021 05:52:22 +1000 (AEST)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A15F91EC051F;
 Wed, 22 Sep 2021 21:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632340332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=fzo+PEl8pAwSY958R9AIE6gnLhJ3Zcu0FqnZgS+Q1TY=;
 b=TrWHyvCovp1xYBCa06xEBb39RTKWLWn8eifuyhcdUuW5I5UUvkqPldeIi88B6DgpVlgBYI
 ASWuqiS9Bh001r8tMMkQ2eLdFI7a2WxUys56vjsCLc9p/oWDFK43yZPwrWhsKpt67ttN8/
 oJCfsdDzqB/NRk5+DSVx+/KMmYpDSb0=
Date: Wed, 22 Sep 2021 21:52:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <YUuJZ2qOgbdpfk6N@zn.tnic>
References: <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
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
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 22, 2021 at 05:30:15PM +0300, Kirill A. Shutemov wrote:
> Not fine, but waiting to blowup with random build environment change.

Why is it not fine?

Are you suspecting that the compiler might generate something else and
not a rip-relative access?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
