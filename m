Return-Path: <linuxppc-dev+bounces-16526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C7E7DF11
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:39:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4b4X2vV1z30BR;
	Tue, 03 Feb 2026 05:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770057564;
	cv=none; b=bGDNjRL+6ujQxz+j9QzuxmUubX+XF/RNv2Q8kO8776nvL99JeXFWh9tHFLps5/Dn2qht4I4mviyE5R/124ArNErm4QSwzS53+fk+mkWtMEPuG41NOt52rYyaJHI2kw8HNqFaZcpL9h9HTup0SvoWrt8ZDPDtNq8yvdxI+d85vWQEPjj8kTAC46kUtSEkQ9oiikEik5cDmXF+9oUxpZZVEUuCBOvjkGNGApO/Q9pBZyHugiQrrEFDI2JULsvY+bGEsfShKEykpkgHheyaNNBoa8LV34+SXvpwi6sItzPqB3vxXdstudaicGpc2fWnq8DB+V3ghrUbuAZk5t+uQT106g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770057564; c=relaxed/relaxed;
	bh=ZAqpkXq2kL2gtcSXa768E/ZejVg2PGn4Rs/J2aKfSBg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ha1aujjhwCjsYzrhSp5Chbq4SLA9SlPuMcz0pMlMIZ9PCCemgfEKy2kYv3n/n2zoC16rGS0vmB364ZQBVNX7nWJTgkGzS5qU+cQdi5g5shuOqOyEdr9Ah5q8bfWVbuC4ZK5tVIr2A0bDmoZhIcw+H7xKeB8O8oZAD23AS9HpnjdOjFa91tthU2ZcNbXphhGlzlD+v4SxWHdZXcb4eVuSh12Z2JpBIjb9ZiIQLmSatmhVUviHKHeOdQz0Q1NG/ShHnTCW9q2v7NiMbEz1yg5ZRkRkq/5FfKSCaCWX5TBjH8egK2lQ/0wZt2TkruPRMydmKm9ZYY+e4C+nYcFG1jNqyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga0UAXpq; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga0UAXpq; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga0UAXpq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga0UAXpq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 33449 seconds by postgrey-1.37 at boromir; Tue, 03 Feb 2026 05:39:22 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4b4V5syPz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 05:39:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770057557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAqpkXq2kL2gtcSXa768E/ZejVg2PGn4Rs/J2aKfSBg=;
	b=ga0UAXpqvu5yb3BlLKip/KGfV5p2OKgWS/Ms061isaDyKRwBsXDDphtbuH1G/6AXzrCOn1
	Yvw8IRQm+gKRdZsFpWj7+Z8i1gvb1xgh3F28cvw/NewQu5QSTQWcdwYdrl64D6IFEJv/9B
	QTpm9Mr2EZ2h9ZfJk/G3a32fXDZhPkg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770057557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAqpkXq2kL2gtcSXa768E/ZejVg2PGn4Rs/J2aKfSBg=;
	b=ga0UAXpqvu5yb3BlLKip/KGfV5p2OKgWS/Ms061isaDyKRwBsXDDphtbuH1G/6AXzrCOn1
	Yvw8IRQm+gKRdZsFpWj7+Z8i1gvb1xgh3F28cvw/NewQu5QSTQWcdwYdrl64D6IFEJv/9B
	QTpm9Mr2EZ2h9ZfJk/G3a32fXDZhPkg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-eAiG1k3lOsGBC8Pm1b-xlQ-1; Mon,
 02 Feb 2026 13:39:14 -0500
X-MC-Unique: eAiG1k3lOsGBC8Pm1b-xlQ-1
X-Mimecast-MFC-AGG-ID: eAiG1k3lOsGBC8Pm1b-xlQ_1770057549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F1921955F34;
	Mon,  2 Feb 2026 18:39:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21EE21801768;
	Mon,  2 Feb 2026 18:38:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260202183055.GB2036@quark>
References: <20260202183055.GB2036@quark> <20260201201218.GA15755@quark> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk> <2339369.1770024079@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com,
    =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2513498.1770057531.1@warthog.procyon.org.uk>
Date: Mon, 02 Feb 2026 18:38:51 +0000
Message-ID: <2513499.1770057531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Eric Biggers <ebiggers@kernel.org> wrote:

> On Mon, Feb 02, 2026 at 09:21:19AM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > With that being the case, why is there still effort being put into
> > > adding more features to module signing?  I would think efforts should be
> > > focused on hash-based module authentication, i.e. this patchset.
> > 
> > Because it's not just signing of modules
> 
> Module signing is indeed about the signing of modules.

The signature verification stuff in the kernel isn't just used for modules.
kexec, for instance; wifi restriction database for another.

> > and it's not just modules built with the kernel.
> 
> Could you give more details on this use case and why it needs
> signatures, as opposed to e.g. loading an additional Merkle tree root
> into the kernel to add to the set of allowed modules?

Because we don't want to, for example, include all the nvidia drivers in our
kernel SRPM.

David


