Return-Path: <linuxppc-dev+bounces-16505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C5CE7314F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:23:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4Lkf56qhz30FD;
	Mon, 02 Feb 2026 20:23:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770024186;
	cv=none; b=CwCkrwtOFLl+KZZG7Xmfiu3UF3ohtmibj6kD4HChX13HSPunFH5kVxxA8Jo5CSb3Gm6cQK3qS22H6IyuRNad5iNgTYz1RpyQCe+C0QwWFANJxVHT5thIjUs2zHIkPFPVomi3aZrtfsIfqfrsUZTh4q9AJrbaUI86ZDk+QKQdajU0tTWxoT61ZZMaM6h+59gqFVCD4Kak4O/2JkxVqYv5cpRj6ZOs7HmK9/us0OGyI/h2OzlxF7BeOYLlVDbdZY8lfzyv6TY9AL9Xp6Av0H313RimCsyJcSHJERuMS9lhGV+hjrXb7VreW2seQmy2k/gNv4nlILdqVtXXlvhm3NRSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770024186; c=relaxed/relaxed;
	bh=5lbDw7o/RaxnPFlRJ1INa0R+IZJyXDgWQKuA97onDkQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Drp4riLEj4BUk2ILD9Q9CiCNT32Li1aUZ36LW6/KIZMryppw7EjHaLKXQ983A272fhYEHnBYMOdCfZhW/Ml0JKLmvhndNGYlnQEdFk2LV5MvkUzONk/e04Ilp8iZeOt6tW2EEQLH8CHlAJkdxqGT5z1wUd+/STITLU25QTXTBehBVSaYFNf84MwiHYpxKr6uEbnQ1j6Qbj0XnCdjsVDAb9QUgUN2opH3VF8LXPnavkiPez8cQ4CO/nsgCNjTfFDfcAGFmNKltzbMP42ArJOu6DpXlaTzW8Y/VZEX38tgld0aLcGDYyLdl73W8eHUCBkvzXqsLNZjQ+LEWqkmErL3Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WwnSMt6U; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz+ZCOJr; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WwnSMt6U;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz+ZCOJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4Lkd3Kv6z30BR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2026 20:23:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770024181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lbDw7o/RaxnPFlRJ1INa0R+IZJyXDgWQKuA97onDkQ=;
	b=WwnSMt6ULqtfJyb4zG9k316Fa87QK6F29Awn8PL8NoMxactlg7TvMVkZdn2PnPg0k/UNCU
	NT+3IXHP12TISZLqLBquwQaDfhwplcTCdWeFOdgLKq/8fthqe3/NxzG4DKH9WDt5efBgo0
	KXOcV8bF5kB+tjSXsUdh52U/8x2xuRM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770024182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lbDw7o/RaxnPFlRJ1INa0R+IZJyXDgWQKuA97onDkQ=;
	b=Fz+ZCOJr3SZ2gQNy3Z1U7dpY8mtEDcdVW99R5hh97zShRf1D2M1h1VFH0z/AjAooyDpJtK
	CbaypHLwFyR2Mm/r4TVzasA2LRotgPzmHcTyRDKrtaLJrPi5x4aufJZxPJKugjasTGQkqy
	CN6TMFpHhyYvXbnRROFspxQ8plx1f9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-vRYKonroPPacvPvXG9Mi7g-1; Mon,
 02 Feb 2026 04:21:43 -0500
X-MC-Unique: vRYKonroPPacvPvXG9Mi7g-1
X-Mimecast-MFC-AGG-ID: vRYKonroPPacvPvXG9Mi7g_1770024097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 468A818002CE;
	Mon,  2 Feb 2026 09:21:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77AA43001DB7;
	Mon,  2 Feb 2026 09:21:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260201201218.GA15755@quark>
References: <20260201201218.GA15755@quark> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk>
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
Content-ID: <2339368.1770024079.1@warthog.procyon.org.uk>
Date: Mon, 02 Feb 2026 09:21:19 +0000
Message-ID: <2339369.1770024079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> With that being the case, why is there still effort being put into
> adding more features to module signing?  I would think efforts should be
> focused on hash-based module authentication, i.e. this patchset.

Because it's not just signing of modules and it's not just modules built with
the kernel.  Also a hash table just of module hashes built into the core
kernel image will increase the size of the kernel by around a third of a meg
(on Fedora 43 and assuming SHA512) with uncompressible data.

David


