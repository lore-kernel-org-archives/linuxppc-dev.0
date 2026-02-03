Return-Path: <linuxppc-dev+bounces-16540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9C5E83060
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:23:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4xMM4sRdz30FF;
	Tue, 03 Feb 2026 19:23:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770107007;
	cv=none; b=HETeJIi/p6R5/OkS3pcErU74Fsk3x5dIUI6WxFRiDOMvlVKsO0QhiySdJ8pkosUl3QIcHbFwCBq08Ox8S0oghA2HAa7FXU6jFXijAQDLVY35ObN33EDbjNY6HcdZQpwK+zdqef53M42ipLXbqdjPPvvKmavuM0i8HNRtFr4NwFL5rh2ycvXXP9ebnleYwr5FbbqaWcWiOFIT5tGVkiCuhzFPp+xZEbwkNFunaKJRQ70tGQgvBBX1d+tKMPZPlj3U8BI0mrs0ymh/lPCyvuhOIhkgDxirWH7HlcagEud68lodzvjKik1Ee3H1Uonbm7sTbTQjoYO3Hjg7hocdRRwQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770107007; c=relaxed/relaxed;
	bh=vv0j3G+SzAoWpK+TUc6fyFah4RU5Ag6+PMWNgWTKGCI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZNwtgIKN9fRiXYE9LdVHdM//+MenZTBfyy3HXmCFl7kHMqFoIICDeoGctBJZNB5qNt1yqfP6PJSrgWa1/BnaCSJrjcXqQo7ynd+Wu6h63ZB+jZFrpOztEjXjAABfTqsDeGHA1yaetdZZnGbNC/lQ5jPaD3ImtFwl3B0Ul1xdsvb4OkCRXLb+JhroRdkdQfuCAaa/QffQXvXIp2DYcI5Idlt04xJYzrqwjiPDkXPB5Bf7TpWhPOtZ+HVNXgmUL9OfkEwokz8YCuhw5NBvkmZyN6yGquWcxX1oiR4WdScCR/hcf2F2QDMunVqtNcSsQmzQ10e6vAurrAQRB1TLUNp3cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkFghT3C; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkFghT3C; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkFghT3C;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkFghT3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4xML39Nwz2xjb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 19:23:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770107000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vv0j3G+SzAoWpK+TUc6fyFah4RU5Ag6+PMWNgWTKGCI=;
	b=DkFghT3CuRXY9AmVvR8Kn1wCB3ylS3tC45kKYxjJS1YymCQx7y0rL7SbfzIKAyCkPdaPp6
	LJ2Ug5OqHRNYke9zU5YFAEviWB6pztF9bJUJTuvtRIDeWq0fyscNli7i19PteOT5qkVR1e
	RpFLGcDg61T1c5PDxuobH/TwkKQ5+c8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770107000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vv0j3G+SzAoWpK+TUc6fyFah4RU5Ag6+PMWNgWTKGCI=;
	b=DkFghT3CuRXY9AmVvR8Kn1wCB3ylS3tC45kKYxjJS1YymCQx7y0rL7SbfzIKAyCkPdaPp6
	LJ2Ug5OqHRNYke9zU5YFAEviWB6pztF9bJUJTuvtRIDeWq0fyscNli7i19PteOT5qkVR1e
	RpFLGcDg61T1c5PDxuobH/TwkKQ5+c8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-t1AtFM9yMj2neNRwxj3iQQ-1; Tue,
 03 Feb 2026 03:23:15 -0500
X-MC-Unique: t1AtFM9yMj2neNRwxj3iQQ-1
X-Mimecast-MFC-AGG-ID: t1AtFM9yMj2neNRwxj3iQQ_1770106990
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB8FB18005B5;
	Tue,  3 Feb 2026 08:23:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F302119560B2;
	Tue,  3 Feb 2026 08:22:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8b12f1d28d3859467c3b5f6bc352038ce7627e54.camel@HansenPartnership.com>
References: <8b12f1d28d3859467c3b5f6bc352038ce7627e54.camel@HansenPartnership.com> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com,
    Mihai-Drosi =?utf-8?Q?C=C3=A2ju?= <mcaju95@gmail.com>,
    linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
    atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
    christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
    da.gomez@kernel.org, da.gomez@samsung.com, dmitry.kasatkin@gmail.com,
    eric.snowberg@oracle.com, f.gruenbichler@proxmox.com,
    jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
    mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
    nathan@kernel.org, naveen@kernel.org,
    nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
    npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
    petr.pavlu@suse.com, roberto.sassu@huawei.com,
    samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
    zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
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
Content-Type: text/plain
Date: Tue, 03 Feb 2026 08:22:52 +0000
Message-ID: <2546011.1770106972@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > There is another issue too: If you have a static private key that you
> > use to sign modules (and probably other things), someone will likely
> > give you a GPL request to get it.
> 
> The SFC just lost that exact point in the Vizio trial, so I think
> you're wrong on this under US law at least.  There's no general ability
> under GPLv2 to demand long lived signing keys.

Cool :-).  I just know that I've been sent GPL requests for kernel keys.

David


