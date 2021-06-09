Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C22C4743D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:47:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E90361042
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E90361042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G0BNr4Dhcz3bnh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 12:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bm0MeJbc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UeTbimAl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Bm0MeJbc; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UeTbimAl; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G0BNK67PNz2xvL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 12:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623206844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6AD2nLmb56QVhFCgYdZqvhrlY7oWTcZgGvZozkCcw0=;
 b=Bm0MeJbcVx3fNkJGJBjuwjyysvIlfbKWSPfmMJmuafsBWgCF8RzjNNO52EzD60A0WWXED7
 CGt4qoMir+MqGlwvcTQo7KWHwId74lUWeMjRUKZf2jSWudIgZyW7+VN3k5Z+GRnQsoIFNW
 KAifj9S4oAzDBn+YDjYNyVdFns6vcrA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623206845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6AD2nLmb56QVhFCgYdZqvhrlY7oWTcZgGvZozkCcw0=;
 b=UeTbimAl9f0bN8XHl4m6sHdFb2TuowigmXIbOXz4bG+iqcOJkJI0ZoU0z67f1qR+PofbRQ
 rOUVjtXCa/fAimGLPy5+Moz0jROMeEevLv+ydHxmiM4daKm+8iU0aDtBVRUN8CnuDfXOjd
 QU+Q+hmlh/e6yXkVc8mBmiLWjgt9ap8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-ycxNtIymMJ2lkUBWT-83bg-1; Tue, 08 Jun 2021 22:47:23 -0400
X-MC-Unique: ycxNtIymMJ2lkUBWT-83bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFB2107ACE4;
 Wed,  9 Jun 2021 02:47:20 +0000 (UTC)
Received: from localhost (ovpn-13-223.pek2.redhat.com [10.72.13.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C5160CC9;
 Wed,  9 Jun 2021 02:47:12 +0000 (UTC)
Date: Wed, 9 Jun 2021 10:47:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-ID: <20210609024709.GA591017@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
 <20210608142432.GA587883@MiWiFi-R3L-srv>
 <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 x86@kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
 Boris Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Dave Anderson <anderson@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 06/08/21 at 02:14pm, Andrew Morton wrote:
> On Tue, 8 Jun 2021 22:24:32 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 06/08/21 at 06:33am, Pingfan Liu wrote:
> > > As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> > > Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> > > formula:
> > >     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> > > 
> > > Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> > > PAGES_PER_SECTION in makedumpfile just like kernel.
> > > 
> > > Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> > > recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> > > SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> > > info. Such info is impossible to be deduced from a crashdump vmcore.
> > > Hence append SECTION_SIZE_BITS to vmcoreinfo.
> > 
> > ...
> >
> > Add the discussion of the original thread in kexec ML for reference:
> > http://lists.infradead.org/pipermail/kexec/2021-June/022676.html
> 
> I added a Link: for this.

Thanks, Andrew.

>  
> > This looks good to me.
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> I'm thinking we should backport this at least to Fixes:f0b13ee23241. 
> But perhaps it's simpler to just backport it as far as possible, so I
> added a bare cc:stable with no Fixes:.  Thoughts?

Yeah, it should add cc:stable, thanks. Otherwise it will break
vmcore dumping on 5.12 stable kernel even though with the updated
makedumpfile utility. Fixes:f0b13ee23241 will help stable kernel
maintainer easier to identify which kernel this patch need be applied
on? If only having cc:stable with no Fixes is allowed, it's also OK. 

