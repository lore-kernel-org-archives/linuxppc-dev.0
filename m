Return-Path: <linuxppc-dev+bounces-26027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A88C5DF87
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 02:23:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hR3yY6wT1z2xQ7;
	Fri, 21 Aug 2026 12:23:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787279029;
	cv=none; b=epUFgrQgLmFRr2UUfg/PghrAJMyRBFErG0f4XLGLT+A+qhAreCe8AJNvBd1a6eF9UpWZAhSf1dnRH2Ydd5FTTDvGLYakKeL9XJeRHgKrwSATVWqUgnimXaY4REbEXXQHk2Pf1qz5U9j510cWC5BbzxI82p/gS7hhJMA7mBKwgHYpn05UmJXgscn4Hl9eyGmXYYkpYWn4Cb2m6+GdvznhOWOTOJxn5939eb8/Ou1QPzKssY32t7F4krmy+DLyFs2QXjXCPx9SoWvfY9OErpwdHYXWS3qcCkmAycbYGKlN11dQU5pITh8ZJHqOfO8Eco0JEYg8bl6c3lfzKQx5kzKztg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787279029; c=relaxed/relaxed;
	bh=nwj029qvfIuS0n2IlGGdFsymc671fa/erueghYr3m0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FL25CO6Y5twu9eL6AeUxZ/xvDOBIyaK17fz3TGymU6StwiuvLt3rK6VreyJ+/cy634xu5K6tyqCXM2I9HsM/YzUSZFopJ0K2WZqbk/0k1T3zTgx7ECmFo/Wq85W0etbnsfiosy2Dio5EoVdG+1MY5WvYFQD2Se0+BumNvG+VVTgaUrnNTdFIDXohGm3lwN9z9yJakAqdRk1Vn0nBUJUfHZtj53JaIu020f4IFHA/Sr3civergiRECw9cdbEF5Z3pxVrpF2l2JWZ4nUf0fOdxgo2NCpcJJDXLhQ4n5Jcmr+qW50QwJMLnMlGtjjSNlbR0SQ0dutzkKvcWL7+lchpUMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKOdp80K; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKOdp80K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hR3yX4mK3z2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 12:23:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E251A40179;
	Fri, 21 Aug 2026 02:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7941F000E9;
	Fri, 21 Aug 2026 02:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787279025;
	bh=nwj029qvfIuS0n2IlGGdFsymc671fa/erueghYr3m0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FKOdp80K1NCdExfZ1tcV6jarRclI8uxefHf43o0VfsGMY7h6gHGbb2Rx1STpUXm3W
	 ZqllCnvzbL/8/x8dercSC6kVEvqT2XPEZGyYrbE/rwLPpSiTtbtKl/4vEvNiotiM+H
	 /ppk8euQ1OD384/8sy5svQj87ViMgNLjapwxeRn6TmnDbBv5i/zXQQ8t/325nQ2NjH
	 AqolJF6RXXh+L7bpAQA8mNzojnq//qqj9QpSOI+LWw5dQiVChms/JXaexpX7c34u1l
	 e++Owow0HeRcTCq1jG3DhsIBIx9wYnOEK/idwAIO06GpBh+b3diywe7T4A4oLu4hfJ
	 p6mVte1Qi/1sw==
Date: Thu, 20 Aug 2026 20:23:44 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
    linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
    linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
Message-ID: <236a0edb-76f4-a28c-175b-f43994310a9f@kernel.org>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
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
Content-Type: multipart/mixed; BOUNDARY="8323329-746012605-1787278993=:86110"
Content-ID: <1dd06b80-a066-feec-b1fa-addb8fb6fff9@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-746012605-1787278993=:86110
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c4da6fb9-7dfb-d0d8-ef0a-6c21140cde31@kernel.org>

On Mon, 2 Mar 2026, Thomas Weiﬂschuh wrote:

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
> 
> Move the symbol to a kernel-internal header.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul
--8323329-746012605-1787278993=:86110--

