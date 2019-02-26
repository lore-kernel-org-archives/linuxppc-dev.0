Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 13:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDBC20651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJj1haDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDBC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447zY23tj9zDqNB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 00:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJj1haDe"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447zSL4NWtzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 00:00:18 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y5so6215420plk.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
 b=iJj1haDeQ/N4knB6ZkfPIbBBikEijc4XMQEhvso+uGw3Gzonlx2LMHbxDNhxdOsLO5
 9/RC7drvjRuaIn9F0S3cLM0+Nf2VDOHoOBcPVpE04JoO4DDFvYHnfNhs3GM3TDepBHHL
 x3uKoOE/K+vdpA+YGX5nfTLL8rGudeiuruGtiPzknZPEsi1M+w74lrRcVnhePEkZKzSm
 hnJ+9/urf6gLp/t3HOljNrg3FSXuSCHaFrniZmdn16YbkBYxmGnUX+M73aEZGT3um4Zl
 RvuLmLpg/dPuOkvCJnfMcBVQMFa+KO/Cdp+mtyFhSiUVeuti7z0gGmnmt7LRbfq0Bfzj
 OJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
 b=NMW7Nu5IjJZOS/dhjizVUIR4CNr9vjZAkEgBLvEvkM/DMQL6EG+DtASkZVDtnof4NR
 7tb/msB/7DbxeSsTy4kUIbS5MKxE8To2TMaocm15ouUvRhTEO/vtGD1V4D9vUha5dF1D
 97+/Nad2oqljhcj/jbDzHJUFnACTsoJIs1JvsvEoYY4QOPfr2+bWfi4RqcubGCjMfXhh
 iEEGYhxRsvA1W8j9zyZDXfpplSVJbJAD41d3qVunB1/Zku0GcJS4rV3NxtwtDXhGk1Q0
 aqfn1dhcvTk5JDspdPfsVNjaf4tpvAmuYwD29Duw3uqWW1ZAPFICEirY3gC7ImvYqVyY
 2RKQ==
X-Gm-Message-State: AHQUAuYU5KiHUtaYktnO19arJH53iMt8Bc0uRav2tHpgTUE6StKeCxkH
 +Ty5bvQIc3ovddpI92GaMaTF4SQOeJ/odoOt5qM=
X-Google-Smtp-Source: AHgI3IaS1g7D372cnowLzJym/B9Y1K14HF4sJbQbbdphhYleutKi1EM8iKYA0AgMOkK+w28JpCc2kA1tVi6yaSNleEo=
X-Received: by 2002:a17:902:8b8b:: with SMTP id
 ay11mr26134560plb.162.1551186014272; 
 Tue, 26 Feb 2019 05:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
 <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Tue, 26 Feb 2019 21:00:03 +0800
Message-ID: <CAOLK0pzVwH-1pObn3FjmLorc_pjLu2q0Q_EG4iYm3yb2aXL7PQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
To: Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "sashal@kernel.org" <sashal@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>, "jhogan@kernel.org" <jhogan@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Michael Kelley <mikelley@microsoft.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, vkuznets <vkuznets@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Stephen:
               Thanks for your review.
On Sat, Feb 23, 2019 at 1:08 AM Stephen Hemminger
<sthemmin@microsoft.com> wrote:
>
> int hyperv_fill_flush_guest_mapping_list(
>                 struct hv_guest_mapping_flush_list *flush,
> -               u64 start_gfn, u64 pages)
> +               int offset, u64 start_gfn, u64 pages)
>  {
>         u64 cur = start_gfn;
>         u64 additional_pages;
> -       int gpa_n = 0;
> +       int gpa_n = offset;
>
>         do {
>                 /*
>
> Do you mean to support negative offsets here? Maybe unsigned would be better?

Yes, this makes sense. Will update. Thanks.

-- 
Best regards
Tianyu Lan
