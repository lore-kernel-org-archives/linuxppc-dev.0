Return-Path: <linuxppc-dev+bounces-16498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC902E6529D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:10:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f3x8H2cYSz2yGx;
	Mon, 02 Feb 2026 04:10:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769965823;
	cv=none; b=lKZHCERw+IGmnPp0+S+3wR1rwJDGzqWQczW280XxsdCD6zeu6PFdb3/xnKtWLhO2PfeRD+LJlGKY18BEPT5tLJ8Asq+GLEH7LVeguCtI28kJkAZRx1rYBm7AkoKFP8Y8TjgLO80oW+5vCPyxJFww8ZQnS6Y2ZDtH0VNZk9SHw1Msg6OgOiwwIKAAsnzgmWDhz6OwNqBc9+Bx5p3fRBwRbcg01fPIs0xdZlmCJPCH6tv7LlNeHioYZ7GWgGDc/rRNP5pw8wmx5iwAm4uri0knLeTnvQdonV6cSuUt1cgshng/WbajzDfJGBatn3qpgUrC1KGv94CZJVz15HQou9hE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769965823; c=relaxed/relaxed;
	bh=AXzGf8dg7zdwjSpH9NQ85FkESCYj8y44yqTfJ6FGfkQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=P1qb/1gpBUPdfkDg4yNFFY1dVQC/IDM77jriCQJ7HRTEVkUN6iZgjMdjDAoNfRaOjHQJ11JdsvX3gL6SjnEVaVlLqklXrwfFgtdowu6pyWvJGI2+TYzf7gh+MIPS7VWyzH7uYGZwCy6iYxbugrrQhtIR4uOmm5zB7+w5F2oHfH8hXdkNqjvfBeXMIr9BPsVuL/ycpASkqQW8eOXjbRQR3l3P8bOfNjCOM2uwKDWDqUR3/5MCbZ1sUV3Rhp2JmfnmbcHO++ETtOx+1T2qpktSIrDSKkpwwFR86N0CGnkrfKKmpLZwOFSBkTIjRT1YkrOmPXgAee2jdADc0ZP038zXZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKbBqLBP; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKbBqLBP; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKbBqLBP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKbBqLBP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f3x8G0MLhz2yDk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2026 04:10:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769965815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXzGf8dg7zdwjSpH9NQ85FkESCYj8y44yqTfJ6FGfkQ=;
	b=DKbBqLBPl4hPr0jsOScvmYifKqR6CfkpCX35Lbs7ZhtCnrAgGB2DvmgW1zvVIqxrbD3Ac9
	U179HmV67I/6F+9xo528x4zrNs+CgIIQsFyIhpBZiQLw6sbUx7FuNo+LYpKlqS3fonYpn4
	z+fDEu6PBFGqChb5lDDCYgWhNm8x6F4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769965815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXzGf8dg7zdwjSpH9NQ85FkESCYj8y44yqTfJ6FGfkQ=;
	b=DKbBqLBPl4hPr0jsOScvmYifKqR6CfkpCX35Lbs7ZhtCnrAgGB2DvmgW1zvVIqxrbD3Ac9
	U179HmV67I/6F+9xo528x4zrNs+CgIIQsFyIhpBZiQLw6sbUx7FuNo+LYpKlqS3fonYpn4
	z+fDEu6PBFGqChb5lDDCYgWhNm8x6F4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-oQw7rZraM7KagOwiXj8BJg-1; Sun,
 01 Feb 2026 12:10:11 -0500
X-MC-Unique: oQw7rZraM7KagOwiXj8BJg-1
X-Mimecast-MFC-AGG-ID: oQw7rZraM7KagOwiXj8BJg_1769965807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99D621956066;
	Sun,  1 Feb 2026 17:10:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D41A18004D8;
	Sun,  1 Feb 2026 17:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260131073636.65494-1-mcaju95@gmail.com>
References: <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMihai-Drosi=3D20C=3DC3=3DA2ju=3F=3D?= <mcaju95@gmail.com>
Cc: dhowells@redhat.com, linux@weissschuh.net, arnd@arndb.de,
    arnout@bzzt.net, atomlin@atomlin.com, bigeasy@linutronix.de,
    chleroy@kernel.org, christian@heusel.eu, corbet@lwn.net,
    coxu@redhat.com, da.gomez@kernel.org, da.gomez@samsung.com,
    dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
    f.gruenbichler@proxmox.com, jmorris@namei.org, kpcyrd@archlinux.org,
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
    linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
    lkp@intel.com, maddy@linux.ibm.com, mattia@mapreri.org,
    mcgrof@kernel.org, mpe@ellerman.id.au, nathan@kernel.org,
    naveen@kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr,
    nicolas.schier@linux.dev, npiggin@gmail.com, nsc@kernel.org,
    paul@paul-moore.com, petr.pavlu@suse.com, roberto.sassu@huawei.com,
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Feb 2026 17:09:48 +0000
Message-ID: <2316630.1769965788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mihai-Drosi C=C3=A2ju <mcaju95@gmail.com> wrote:

> > The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.

There is another issue too: If you have a static private key that you use to
sign modules (and probably other things), someone will likely give you a GPL
request to get it.

One advantage of using a transient key every build and deleting it after is
that no one has the key.

One other thing to remember: security is *meant* to get in the way.  That's
the whole point of it.

However, IANAL.

David


