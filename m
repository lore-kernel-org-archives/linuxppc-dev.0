Return-Path: <linuxppc-dev+bounces-28273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0286CC98318
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 12:04:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsR7q15tQz30Nl;
	Sat, 26 Sep 2026 22:04:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790399926;
	cv=none; b=DVJdB30dJQuQ05Mv4AN84lhHHisCU65KVAtkTXuoUNLQtHyceh2lMmxgYpnvvXbU3BL+g1vyduj+5ErF68dcXWEvn2RPDIOa0woSc9zBMZta24rMZXgUFfAW8N+DmkVwkuuCqWDfh2Bv9ZPYS0BBIhYqNKypE6I3taJ+xs430Rf1HeCId/2aWn5TS+FyDsxRlGj7/eag/wgkxgZfCWY9t0o/gZTmQZSwuCa9691LWkPMs7NO+zHhCdP28bmMMe7hjtDRI55mKYEACkAAM6ZO68puyH5gzg6VG7ocaMITXP0KOwflmsFzNtWogtb/LbI2tP4Fxnh7HTTk7h3hr4tjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790399926; c=relaxed/relaxed;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=A1JSq1ocB8SLzkBlhsE+4+obRqscWH8W7VGLNMhSYRNGJzAykOtfYhlV+TxjcsleQnh3B7dI4iwS61Sd9aVq4sEWfinuWWUtYuh8k8DwViqFTgTRkcvHzmN1E+su97qjvrRipoXcfVnCgPmoOym0pGolh+PhSq6QvE6iqeVx7BLSXeiJx6U89mt3z2H0NC2OS7ysQye0DYl9WrL0a6hsv0+A0hQqBnBFxOU9wLGQwmOFWH9Rf7nQBe9LtMZyiSowEHiTvLanCkhibnjwo88QrecTsZi3f7/eH7a6MxP7b1ZnHVL0t9OSL1QNNuQK9gSerfo12JHJOxqk7sVGLkEFjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+6Jei1j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsG7n4CK1z2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 15:18:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790399918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=c+6Jei1jUpv7lv+G/3h2yLMmi/x/hyXyMi0WzKaRdqJgIPgou7+xQ5Qkgnb53PEPCdN/m5
	8bmHls+dYlHuDCKT8HA9UDCrnELQAqOUTBh6vucija6fN/4Uf5YtQJKC8tcUtRsmpBLoeQ
	AsqhR8jc0OgmsCOOUpDFqQb5Wzv0SOw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790399918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=c+6Jei1jUpv7lv+G/3h2yLMmi/x/hyXyMi0WzKaRdqJgIPgou7+xQ5Qkgnb53PEPCdN/m5
	8bmHls+dYlHuDCKT8HA9UDCrnELQAqOUTBh6vucija6fN/4Uf5YtQJKC8tcUtRsmpBLoeQ
	AsqhR8jc0OgmsCOOUpDFqQb5Wzv0SOw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790399918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=c+6Jei1jUpv7lv+G/3h2yLMmi/x/hyXyMi0WzKaRdqJgIPgou7+xQ5Qkgnb53PEPCdN/m5
	8bmHls+dYlHuDCKT8HA9UDCrnELQAqOUTBh6vucija6fN/4Uf5YtQJKC8tcUtRsmpBLoeQ
	AsqhR8jc0OgmsCOOUpDFqQb5Wzv0SOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-j_rOfgzlNsqWzvsOBAFx3Q-1; Sat,
 26 Sep 2026 01:18:30 -0400
X-MC-Unique: j_rOfgzlNsqWzvsOBAFx3Q-1
X-Mimecast-MFC-AGG-ID: j_rOfgzlNsqWzvsOBAFx3Q_1790399908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271711955F29;
	Sat, 26 Sep 2026 05:18:27 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9392180036E;
	Sat, 26 Sep 2026 05:18:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Atish Patra <atish.patra@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jean-Christophe Guillain <jean-christophe@guillain.net>,
	=?UTF-8?q?Pawe=C5=82=20S?= <spawel523@gmail.com>
Subject: Re: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids tracking
Date: Sat, 26 Sep 2026 01:18:20 -0400
Message-ID: <20260926051820.192707-1-pbonzini@redhat.com>
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
References: 
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MOaMezuvyKnSZ3g61m6nZVSqlTO5uM3Vrgqv5NKWvvQ_1790399908
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Queued, thanks.

Paolo



