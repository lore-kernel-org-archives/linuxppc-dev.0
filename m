Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11720C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 12:11:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4020772
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 12:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZxP3k9u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZxP3k9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yH5C4Kk2zDqCg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 22:11:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=dyoung@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HZxP3k9u; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HZxP3k9u; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49yH2g18QvzDqTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2020 22:09:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593691764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHNyDKxONfk5ZuiA6wqr2UGhxhodt5B2XvkEDH0Vso4=;
 b=HZxP3k9ub8vQ+tpDXODmOLjuRnxELGNzKuWJazvm7FjrxJLbJivR115oSMwPI7AKBtqBBl
 SWwmhHF7ClyVTZ7wR3wbesgsf5K2ewf4asVYvxajLtfiLESAjbc6hHLaan+/Jsm3iiWdhA
 Ri9gjsoxCqqZ9z+3mTROdCP+i3Z4LbE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593691764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHNyDKxONfk5ZuiA6wqr2UGhxhodt5B2XvkEDH0Vso4=;
 b=HZxP3k9ub8vQ+tpDXODmOLjuRnxELGNzKuWJazvm7FjrxJLbJivR115oSMwPI7AKBtqBBl
 SWwmhHF7ClyVTZ7wR3wbesgsf5K2ewf4asVYvxajLtfiLESAjbc6hHLaan+/Jsm3iiWdhA
 Ri9gjsoxCqqZ9z+3mTROdCP+i3Z4LbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-zAl8HdTEN3u_pbMtHfe0Qg-1; Thu, 02 Jul 2020 08:09:20 -0400
X-MC-Unique: zAl8HdTEN3u_pbMtHfe0Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F407F18CA26C;
 Thu,  2 Jul 2020 12:09:16 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD4245C1D0;
 Thu,  2 Jul 2020 12:08:58 +0000 (UTC)
Date: Thu, 2 Jul 2020 20:08:55 +0800
From: Dave Young <dyoung@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
Message-ID: <20200702120855.GD21026@dhcp-128-65.nay.redhat.com>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-2-git-send-email-bhsharma@redhat.com>
 <20200702110003.GC22241@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702110003.GC22241@gaia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Bhupesh Sharma <bhsharma@redhat.com>, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Boris Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
 Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Dave Anderson <anderson@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Catalin,
On 07/02/20 at 12:00pm, Catalin Marinas wrote:
> On Thu, May 14, 2020 at 12:22:36AM +0530, Bhupesh Sharma wrote:
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 9f1557b98468..18175687133a 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> >  #endif
> >  	VMCOREINFO_STRUCT_SIZE(page);
> >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> 
> I can queue this patch via the arm64 tree (together with the second one)
> but I'd like an ack from the kernel/crash_core.c maintainers. They don't
> seem to have been cc'ed either (only the kexec list).

For the VMCOREINFO part, I'm fine with the changes, but since I do not
understand the arm64 pieces so I would like to leave to arm64 people to
review.  If arm64 bits are good enough, feel free to add:

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

