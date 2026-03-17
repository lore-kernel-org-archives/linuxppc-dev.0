Return-Path: <linuxppc-dev+bounces-18284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490F5FB5EA6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 02:10:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZb696qm8z2ySB;
	Tue, 17 Mar 2026 13:10:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773713457;
	cv=none; b=JFWMbw3aGN2NY+x8NiUsNNE2tgj0Y+LtLuu1CzjEMHOoK2voUb0/7MD5YPnT7Fcl/Ady02z66TbK8ozvZN7VOf9ZLYRkGv2iakM/AF8Ycf4K6Khnles0nxp3HimOI8HuTcrYKedOYxtDe1ZEwFIcMkmhMbLOqcTcX3jwU96sGbfQcHYGvG+Sp51AINE4PicarHmDF+k2D1JIU5SX74k62e4iSAud4phv8DWwC6xSITfRYs2dnvBpIFCkSIcwp3RIxfqRdDS70ncDVJzQHRl5j4+1YhTJBTMX+Fjb55uqBzTlWxERNR5IrD4gTRDYw/QbohLPK9GUOFayZeFzq56zwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773713457; c=relaxed/relaxed;
	bh=j4sbtWDw4DJ2JBJ+y1C7vQWjeEXxcelaEAyT7ptHthE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=URSKWbiYKmCvFTUBSiWsw0bFbkxT5F2el4/wrtuxuHtJMYyODHh91Sbp+DkFIIavuxXi/h/lZktDdHhFTAJFvr5mifRj5kWf2r+FUdJV7iIViKbvN+YP2Lrgv/aTEqRj4R/VcAziaHEESazq5qw/Cm9Q8yarYjbpxZe4H2o9tHvELa4bhK1MMVApe24H2YQIS4ygrL/P2mC0OluFp50ce1KSmAOswZb1r3qTeghHObh3EjqgghZ7AUlsfjtKXNzZSR37OMNm8DItMKX9AGQ9RC1kLeJ18+PuUviGSnfe1hUUmQR9n2nUvubQ+Dqlmd2PgAK3J/wSxpOf/pW9WE0GCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYqTjj+c; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYqTjj+c; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYqTjj+c;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYqTjj+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZb685WjHz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:10:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773713451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4sbtWDw4DJ2JBJ+y1C7vQWjeEXxcelaEAyT7ptHthE=;
	b=DYqTjj+c9+/be1Xtzq8etVG2CpFtcqQP4sCQnlDZdyybwytxKGnhIAHR6XV4CBSj3Ja1PO
	WmtcylxYO8wMr36rRwuXj+dgvL6p/Pci2J68ebV/U+mxqRaTETawBsvHOkQQwqzlDaScvl
	mID7s8Q1eu+eR04vNUcqxi5BUTOX7dU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773713451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4sbtWDw4DJ2JBJ+y1C7vQWjeEXxcelaEAyT7ptHthE=;
	b=DYqTjj+c9+/be1Xtzq8etVG2CpFtcqQP4sCQnlDZdyybwytxKGnhIAHR6XV4CBSj3Ja1PO
	WmtcylxYO8wMr36rRwuXj+dgvL6p/Pci2J68ebV/U+mxqRaTETawBsvHOkQQwqzlDaScvl
	mID7s8Q1eu+eR04vNUcqxi5BUTOX7dU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-3Bd5hukVNg6_8EEIPcheoQ-1; Mon,
 16 Mar 2026 22:10:46 -0400
X-MC-Unique: 3Bd5hukVNg6_8EEIPcheoQ-1
X-Mimecast-MFC-AGG-ID: 3Bd5hukVNg6_8EEIPcheoQ_1773713443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4D218005B6;
	Tue, 17 Mar 2026 02:10:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B823C1955F19;
	Tue, 17 Mar 2026 02:10:38 +0000 (UTC)
Date: Tue, 17 Mar 2026 10:10:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
Message-ID: <abi4Gumt0Qr_h-3W@fedora>
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
 <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: MEZ2JDP5y5vum4C4bFgplwwSfQaUALieYwGBl43oVcQ_1773713443
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 03/12/26 at 12:23pm, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
> > 
> > 
> > On 25/02/26 13:44, Baoquan He wrote:
> > > Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
> > > 
> > > This includes 32bit, book3s/64 and book3e/64.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > ---
> > >   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
> > >   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
> > >   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
> > >   3 files changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/mm/kasan/init_32.c
> > > b/arch/powerpc/mm/kasan/ init_32.c
> > > index 1d083597464f..0ea2a636c992 100644
> > > --- a/arch/powerpc/mm/kasan/init_32.c
> > > +++ b/arch/powerpc/mm/kasan/init_32.c
> > > @@ -141,6 +141,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       int ret;
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       for_each_mem_range(i, &base, &end) {
> > >           phys_addr_t top = min(end, total_lowmem);
> > > @@ -170,7 +174,7 @@ void __init kasan_init(void)
> > >   void __init kasan_late_init(void)
> > >   {
> > > -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> > > +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
> > >           kasan_unmap_early_shadow_vmalloc();
> > >   }
> > > diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c
> > > b/arch/powerpc/mm/ kasan/init_book3e_64.c
> > > index 0d3a73d6d4b0..fbe4c9a7e460 100644
> > > --- a/arch/powerpc/mm/kasan/init_book3e_64.c
> > > +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
> > > @@ -111,6 +111,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page),
> > > PAGE_KERNEL_RO);
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       for_each_mem_range(i, &start, &end)
> > >           kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
> > > diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c
> > > b/arch/powerpc/mm/ kasan/init_book3s_64.c
> > > index dcafa641804c..f7906f9ef9be 100644
> > > --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> > > +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> > > @@ -54,6 +54,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page),
> > > PAGE_KERNEL);
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       if (!early_radix_enabled()) {
> > >           pr_warn("KASAN not enabled as it requires radix!");
> > >           return;
> > 
> > Should we log in the kernel log buffer that KASAN is disabled?
> > 
> > Right now, I don't see the kernel advertising the same.
> 
> When KASAN is enabled it is advertised with:
> 
> 	pr_info("KernelAddressSanitizer initialized (generic)\n");
> 
> Isn't the absence of that message enough to understand KASAN is not there ?

Right, that's the way I took when I tested it.

> 
> > 
> > $ dmesg | grep -i kasan
> > [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v-
> > scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+
> > crashkernel=2G kasan=off
> > 
> > Tested this series on powerpc Pseries platform.
> > So feel free to add:
> > Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for testing.


