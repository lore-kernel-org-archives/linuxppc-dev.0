Return-Path: <linuxppc-dev+bounces-22069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C012CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:00:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWjlP2L5Cz2ySS;
	Fri, 05 Jun 2026 11:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780621201;
	cv=none; b=GbYGWlEMshJ5Oh1WP+fFZ4UTfsVKFqd34JZKgJEGUYddu/MWLUxUbaIOhmNjdx8OKaW+I/4FzOUo55JXOh9v9Vnt6270586WdDHLyJu1eNCP65oDfYGcPJWXW++Nwz8hWXC/74XVJtaY3ApF/sHu8x9hGjePogPrOB3h9yZKG89AfPSqlhNHRuMeSQ16aIZ3z6I+Fc17uuy8jwA+GZVDIyT5mHE7kibAw4SDwbJ6gQF4p1eIzwhs6unyQVWs0rtebY01xSNfqnT3sYlaWeujifKUCxvYHNAuYgBHKuVmeMXJa74qAyxgvEiuDbqWxfAJEZ7iPcz5tm3mc+uiPZ8bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780621201; c=relaxed/relaxed;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxBnaoTXqj7ekMvVXttp0EBdd+Ah6MOWGL0fJWPowzlSJHbDDlct39ZlKnnAekersdMZYpxymH8v71HXxXlQYSoW41NYOZSiz2JsteXfM0gMg0LJkqhyypCJpSruuPd+zaCLvns+w45DOHtXOkZOrrrx8g70xRzs3Q6ewUy0JCr9uMzDmRlPsQeYN8Qa/cF53dXo1OWgyUZlJ+tsEN4e8srvOKayCoMtfYN0+t7uWmMzrSNpBfyiZb2nDZ1lfTqkXhI0wtMavrdWsAEWsSRydq7TvRPrPfKV3Yyit21bLEsqTyfsosRkmFZdicLlfqC3lZ6Y2GQMz360gTgaVsMQ8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV7UuTIA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV7UuTIA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWjlN5GQcz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:00:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 158FB6001A;
	Fri,  5 Jun 2026 00:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEDF1F00893;
	Fri,  5 Jun 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621197;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FV7UuTIA9nXYCTQdrZZfkYLPla7MfXoMk9JBQGXD8E6O3JeVZ8noXFwAiRTcGSkiG
	 W1E6UfVYL1zDmwogaVZj3DwZpjueen+dGCzKQo0ke5ZCdkt5y4s6jQvB3vcBr0q2k/
	 5zMUf1gXU4yYCb9VaqZ1FpKBYaxlJRzL8seAwf8I1EV3xbsR5RzcirVhuu+7mcYerp
	 2iHf8scUUAf0UGYnrFlhzWpP25WM1cMsSOLI91OeLkt8yMjFwVNEf8x7lNB0JkDCVX
	 FA7XptQIIQkiVR9RNrq6zyb+w3n9rtX2CXGMXtneI5zgxSgBjxNGwz6mh+H34odnWw
	 kP5OoFOiPLZYg==
Date: Thu, 4 Jun 2026 17:59:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Keith Busch <kbusch@kernel.org>, Alexander
 Duyck <alexanderduyck@fb.com>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604175955.56ca1406@kernel.org>
In-Reply-To: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
	<20260604182031.GB2487554@ziepe.ca>
	<a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 16:49:05 -0700 Dimitri Daskalakis wrote:
> Hey Jason, thanks for the feedback. We (at Meta) are definitely
> interested in SIOV-like capabilities for device passthrough to containers.

I think "definitely interested" is quite an exaggeration.
More importantly, which big company is interested in what
tech should be irrelevant upstream. Please don't make these
sort of arguments. The code has to stand on its own.

