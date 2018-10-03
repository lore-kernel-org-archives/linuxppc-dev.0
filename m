Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB51C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:48:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9675320684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y213uGWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9675320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q6796lfjzF3JQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:48:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y213uGWn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y213uGWn"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5jz5qwfzF3JG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:30:31 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id v133-v6so1094991pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WJ+x0j1ZqUyIQJ+mmUgq6vFgh8pHPZe/S9Q9U/fZl/Y=;
 b=Y213uGWn8udyuGZhlTAB0lV9Zc01AwIkar2n0+4i1W7YsTxn9VZwX04YYZ2GzyqLuO
 lCMiHo+Ia3LBu8OWexiTKkk4oUSd4f81c+JEWd5lbuK21/yvfwqL1v9T/51y47+qcAsP
 y3Nsv0ZsbSQ+j2r1/zAUZpQN0oYhGGz4CJUiYrZjsDNz2UwzFiCs4KN4+dfkUu2GUhYc
 5asd7lUkDD3RGUEehxm4/1w45W7i5wrgJBRvf59GQPm8RmKpp98VBfAaaBp8xkvGaPAI
 vIut2v4Kf0EYH3HSKNwDxGlLb6JhRI8Zj85VR1Azftx/+5sCySJZzN0skNQoFJpdbO7t
 U6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WJ+x0j1ZqUyIQJ+mmUgq6vFgh8pHPZe/S9Q9U/fZl/Y=;
 b=nfRl13RZ3/FnN/D0whnb+yvq4bWwaRGRYyPlVN4pkk2K690ufHiw2btElU3krkU8d8
 UwecJa1ahuCWpPLMOFe13sN6F0yh2gXWNgeVtBIzran6Vv20ZKHJ6p7221McKPZetLOn
 J0mc5jlcBIxKq1ULYeNCeEtAW61U0qWtArllIqdPk7j0RR8mpplfngH3MNNpYJaE8HhI
 bWVl441Nckw0AekvYDK7dvIWybQyVnFh2wubOe8pVbzmLoYuZlnaZpWxpdW9UpW/R9rr
 NOH0ICdWQs+mUsuhIrXaj7ABA8/4jloosm87+Q+BiaBGupXCsSFcCxOoJC1d1PHQuDf+
 nLiw==
X-Gm-Message-State: ABuFfoiCGQQAKcvDSOCSfc4ZlJEWQgq6wUKLZdvx//u7vhImvyqcYxoN
 SYesZ4Qnm0QVHwZK0t7aQQ4=
X-Google-Smtp-Source: ACcGV61EyxPtLOHsDgLSd11V37DD2fHuIzZU0AlanlBC9O4TiYZ4O/E3G4u421aeeaVXNeg5biId4A==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr27519pgs.350.1538548229812; 
 Tue, 02 Oct 2018 23:30:29 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id 76-v6sm1063253pfk.134.2018.10.02.23.30.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 23:30:29 -0700 (PDT)
Date: Wed, 3 Oct 2018 16:30:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003163024.281254bf@roar.ozlabs.ibm.com>
In-Reply-To: <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
 <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
 <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Oct 2018 07:52:59 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:34, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> thread_info is not anymore in the stack, so the entire stack
> >> can now be used. =20
> >=20
> > Nice.
> >  =20
> >>
> >> In the meantime, all pointers to the stacks are not anymore
> >> pointers to thread_info so this patch changes them to void* =20
> >=20
> > Wasn't this previously effectively already the case with patch
> > 3/7? You had thread_info sized space left there, but it was not
> > used or initialized right? Does it make sense to move this part
> > of it to the previous patch? =20
>=20
> Not really.
>=20
> In 3/7 I changed the prototypes of two functions that really used the=20
> pointer as a task pointer only.
>=20
> Here it change things that before 4/7 were really used as both stack=20
> pointers and thread_info pointers.

What uses it as a thread_info pointer? It seems more like a stack
with some amount of unused space in it but that's all.

That said I don't care to nitpick too much where things go exactly
if you like it better here that's fine.

Thanks,
Nick
