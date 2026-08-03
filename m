Return-Path: <linuxppc-dev+bounces-25250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF547C55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD9kk1fQBz3078;
	Mon, 03 Aug 2026 19:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785747950;
	cv=none; b=Obq3gdsjKXZ22AhjkDvc9X6CnGr5cqUVwfidz3z+32Vqsv5a657cHxCtQ6xjB0nZGYyfxjsk4EDuo52TJ01eUX86pUVv7VSg2pgukBiw6Z7szNhP7NeI6dof8omxQO1LeRqu9VlS+TNF5wgwyuS7AAgULVDVyHdNCX3F3Ccgg6ohCrXk/LChSjiD10D7DNVv7fStIMVrqE+dtLSjRBeilcOdAbSoeusAzkSs1kIR0u797MW5QPVJ4uBbaZgblf1ErFViaNKPNn7MOFZq+z8MyqKM/MpTWP3eXpDK7CE6F4sYuhPRykbFub7zFVbFVy7AcVqNyw3m2+jBgYzfQi/tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785747950; c=relaxed/relaxed;
	bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YqTG/ObkeUEg4/X4n0OIVv87vyixur92FKX4Qz7RFiAMTXPW2Ny17P4T4nCVrob7kho1I5Eo7TsIF7OhUgvsn7Q8WvCy3/dK4Pi0EmUgsa8/yd0KMHoZ5nwGha9wOLRlShzQpEQfwuwJ3ZoKpDFkqhfcUH/IMZXJxOm1J4jOJG4zmIUaJ5SwPZeodP6F19rcNqpCXZolDQ6e5UWVolXMKJ5iTwO/ce1DOJvOSoEFK+/rPqo3aSiTHjXJ9kbnReju9vA3CI9i1qsYtRYkW1zHKmz0SykUwbsNwUyercm6xEcH15M0Jb2gEYZfz2LjUAKnWZKkygRXgiAI5y5KdCjF6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=L0KnyfMq; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GMj+2Fse; dkim-atps=neutral; spf=pass (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=L0KnyfMq;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GMj+2Fse;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD9kf0dChz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 19:05:44 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42AE114000CC;
	Mon,  3 Aug 2026 05:05:38 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785747938;
	 x=1785834338; bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=; b=
	L0KnyfMqEanfuLJms+4Htc4y20xWQ8nXZXQymKtiQc4FnDncdS1/2nalkzg1kJGr
	GPy4CHOC3xieo49RvSZ73DufPtIB0+HRWi1nXrNuIkzsA6dt+kGUO7/+2mLrB7GK
	7EddNe49cXkbehL/shOutGkVJLdzVYS0jxxnJF02K4+yvDd0oj5grUYrLhXafBnX
	QGLwBd0qYWWIkJXqJ1N6QArWFBX0z0Aj6Fpl11Ucco6X3SR7iDPnhHtQ+Ry/Weg4
	+SdYcgq9cj2Sl/lYVtuavCU/MGniQzc+drKQ33UwQYWbY7ED45oxsqery4R/9Jh2
	gpylNd0D1dfZeg4Hv22W5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785747938; x=
	1785834338; bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=; b=G
	Mj+2FsePoKPkAlo6H29nlAncoexiuhfxd7uv1wGF0taBZOm6FobwEuQ55SzHSvd9
	R8fqCoM679LPDYR8mmUnTJ1O0DXoWZFs+6V1Kev5UrqleGloEI/Se5/JfL9CWk2X
	4/K4vPk/BNd6CmqW8qWiLJh2FUEFdEk6tnCa4916lSmDycyi8XuS4PogkXDLtYCa
	SLt5O6aN5dx8oH9CV2R9Np3RWn3wKTL4j9N14Knc8PpF9cJaJOup4FKPqInUVqVG
	1kfJafA/m6BtD4TmT0L3PCRSjz8amFgkA6DJuOl8CyTwZ66q2Vq7ZJckJcbxrlr/
	PBecWw1H1V/6CI6srSSSA==
X-ME-Sender: <xms:21lwapyNsTshWBY8FdqTU_ji8L7cPfPy3Rt0fZCykbfDizM0wiygWg>
    <xme:21lwakFHMp_8QCgwU-4z6ZppPva2mMhl6y-RFIBF9HOewzxjiRcmdQeMK7yJWJkgx
    bHNTzMHXgOm48A8wrCDXInRaMVJfhqOF6WCAriMKzGKqeXtWN3fUJM>
X-ME-Proxy-Cause: dmFkZTFzyMgTqu0jLIpbo2pKkb6HHBDTgg0uSi900V1ofKJ5LwtvHQE/955DGS70N4VIcS
    4A7QluVgyDmnJ+babjbGyQ4oTOWbds9YJS3vuXNkrNeNNhPZ9se7AF3h5NbsrHgpoSm1i/
    wFi+QQAhdVa8WIbsQIYw1irvqGYsdky6vE619SAaEdj9n+MD96sfCit3bIERdjcNB9Hb2P
    chUS0eYnCr2ZV0MQ0ASSsT9TkAtwtqfbwjvYGj5cPqEJTUN2sqF2aPvJIG69ZOilUa2L8B
    MzQEw6x94i9bYT7+29QJlDC4y4hakw/NcpPXkKqyax5MIG6Ivzt9dAmGa6Xv0o5IGBt1CK
    pTAw4R/doSiLhcivx8hrqonhMUsP2L9lCLZ7RoBzQ/pMVF7RsknTcqr49Lt5nst9czkm2M
    gppwaGVht1sORSBrUGSuD3nrotm89aXe1nJecGVBwCU7o5E81sNngYGcG5qlNbKStQX9yr
    pKNfxFH9KQ8xQ47sPVtVVPyxU2lgYDNIWzTl29Xj9vAFA3Y6F2yaVltPqVLwuJgt0XJcoG
    7W72lrocRGpK81Zhc8N06U8qYEo2RT4O4lKSc+Cs5id5jhTFSWDRon8Y6rI5aZSF5BO25i
    r8ktVf/yFIHNlWuqIe/cuZMNiCC1WYQpITBqOj+HP2ju2FPGUUTGaPELy3EQ
X-ME-Proxy: <xmx:3llwatDA3EUAYi7NPnEbont1T5KrUo5ea1BCuU7dOHS5y_2h_mF-DQ>
    <xmx:3llwaiCYZpnjemypq3XeOEZBenDyzK7Sp28NShLEyIEHVyTVskKRCQ>
    <xmx:3llwammQxROwO74-mNoHE5C-s2VDwi_zJHRUjlw9m06FzUTrzFzxLw>
    <xmx:3llwaqgeUyfG2gh1Z5yZTMIwkgEAjE6MDwVv0GFTXApmF4NSdZVzug>
    <xmx:4llwatvbkwAU_gfhIkt8O-hvvKrdmr0pvAMPCyt3lMPH3jIYecaE3gSp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6A40732A0060; Mon,  3 Aug 2026 05:05:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AP-oKdSeCNZ7
Date: Mon, 03 Aug 2026 11:05:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <034d9118-b2b9-4521-88eb-3d88d805834b@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-1-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-1-7368423440f4@outlook.com>
Subject: Re: [PATCH 1/6] powerpc/spufs: fix spu_context leak in coredump
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>
> coredump_next_context() returns a spu_context with a reference taken by
> get_spu_context(), which the caller must drop.
> spufs_coredump_extra_notes_size() does so on all of its exits, but
> spufs_coredump_extra_notes_write() never calls put_spu_context(), so
> every context dumped through elf_coredump_extra_notes_write() leaks a
> reference, including on the success path.
>
> Fix by dropping the reference on each of the three exits of the loop,
> mirroring ..._size().
>
> Fixes: 38b407be172d ("powerpc/spufs: Rework fcheck() usage")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

