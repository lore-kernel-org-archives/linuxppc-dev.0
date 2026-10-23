Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA2606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TI9Xr+8o
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB5xr75l6z2yDc;
	Sat, 24 Oct 2026 02:08:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792768112;
	cv=none; b=ia0Zqr48T46K00fYr1wcnGFkxfrSH/ZSL8Cp51iw+a6QmYJmA12a/P0e9A1FeNvYEaBH7pmQy0yhtGyYN+BO4MFrIyeM1S5fUmhDtaFYzrQDNkOtPuDdiThfG2OopESi1l0gmk3W6Pgxra7pvyg4CwneVz+0dReIr1WAu6TIqgEDInEOMLxSibe3nZcfkgK7kHISAt1umvw5Rn3/w+Ure2jqI2CSs1LktvnyGnMFnJYph7TM14uqB+mDEJgple+z9Hd2A2u13EJwQnhAPfMWmZ+ygk+HVFjKczv7L+qvDArHoahpsoc/mFoxt5lE1LG+aXzgFrwOQKXOxi1eqcS5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792768112; c=relaxed/relaxed;
	bh=GTu+v8DMOAbysoph/cbjE04nLy4WCnUvKq56fF3kka4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EywLIfTi1iYN95K/cyZwNlPn9q3Tn0/pFZ9sq+HH8yajSYpbk5+mGgg2WhAS1p+V9lBLwAiTJspoJPpEKG4vpSWrFgqIOUAp5cqZM6g1HxpxnZZjl1XA5phmD9U/v2+G7cazw9fEfYfVsd55vkXPlIQ8L26pCCOJhIdvAKquapwNdb47R96NEJv3uT4nxyjJrwSwGDZwcHB9n4HGiDSbZsbAr2Zun0PRK4mDQ1/LL7S2CxXxN20NrPYh3DRz9lJal2DDtRYtVBHe8cy6Jeh0R3XOrdRlBSJ5MaaVZt3dhVKSyqUnjSFnLIBy/WNQ6gJ9flSawEGriUXrHLUN2SyXqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TI9Xr+8o; dkim-atps=neutral; spf=pass (client-ip=216.40.44.15; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TI9Xr+8o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.15; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 481 seconds by postgrey-1.37 at boromir; Sat, 24 Oct 2026 02:08:30 AEDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB5xp6lhKz2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 02:08:30 +1100 (AEDT)
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A963AA013B;
	Fri, 23 Oct 2026 15:00:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A14466000A;
	Fri, 23 Oct 2026 15:00:18 +0000 (UTC)
Date: Fri, 23 Oct 2026 11:00:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michal =?UTF-8?B?U3VjaMOhbmVr?=
 <msuchanek@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261023110017.72c9bf20@gandalf.local.home>
In-Reply-To: <atsYQtXHRH_cCQ5A@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
	<20261022181817.49717-1-amachhiw@linux.ibm.com>
	<atsYQtXHRH_cCQ5A@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A14466000A
X-Stat-Signature: tsgqnq55n4bydcajbc8ijqh5raais9q9
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dr23hATlAmtnFLsRTaJj5AYAM/0nesZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=GTu+v8DMOAbysoph/cbjE04nLy4WCnUvKq56fF3kka4=; b=TI9Xr+8oVB6/+eVuQw+nTLqDmoNjjNuBMRtAMGsUhsE7X0UQlJMvu49btqrDm9TTIsj6gH+vW/oYEGjQIpQ9XYrYUvylOdS1PCiZ8lzx/KfRuG0Ccmcw4xO5zGBJpWLbkbBYvny9UNF1jhMFUwvB+c74cTvapHDCVly8gyaQsf8=
X-HE-Tag: 1792767618-41480
X-HE-Meta: U2FsdGVkX18eMYXpWfWbgSCecZIfpE2quM/PgZsA53xA0TIJn+8ZQ/5BZDMttsoN5sWy8uyv2gK0+37paM/0cZzQYcrbooTiMVkW4J/bog/mmOWcE75yU0KRtXc6eRTVe1QmX4AuA+Eq3/zDzCCrTQEaOMU24HmBuHDQ6yb8kPvuWcvSJC3ZTUv24CH4QfhAghPvRzh6GhzExdPK2e187Zc9EKsFV+8cFl0bWcqdOVBkhxtnSO+4SMymwGcoybpxPTu/WaGw8SOSXwIRtpE/quLsB+2OBLvDKfIycX0XhNaJhHU2+30azvxnzwYu5+4Mq4bga5stik7X6fhgzH91y2qmUPFC+69y6Emm5KNzXcJ6DXrqFUzE5jARsrBvoWwmLnWdSTzyU/M=
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 09:18:10 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> >=20
> > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before =
allocation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com> =20
>=20
> It is usually good practice to not use in-reply-to to link the series bet=
ween
> each other.

Correct, the best thing to do is add a link to v2 below:

>=20
> > ---
> > Changes since v2:

As in:

  Changes since v2: https://lore.kernel.org/all/20261016134247.70722-1-amac=
hhiw@linux.ibm.com/

As versions in threads of previous versions gets messing and confusing. And
in most cases, just dropped entirely.

> >  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefo=
rt;
> >    update threshold to i < (nr_pages << subbuf_order). (Michal Such=C3=
=A1nek)
> >=20

-- Steve

