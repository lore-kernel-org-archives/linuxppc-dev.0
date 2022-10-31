Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B073C38A02
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Oct 2022 03:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N0ynk4pP1z3c81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Oct 2022 14:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Rf3xJ5FY;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N0ymg296Sz3bc4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2022 14:09:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Rf3xJ5FY;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0ymf21HWz4xG6;
	Mon, 31 Oct 2022 14:09:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1667185762;
	bh=IyANIFo/8HBGd/DYPBGKhTkiktTsCGnlYM/01HsTLkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rf3xJ5FYfdjl5QkDmVfwVgga4ppYxi4P2Jq9R4D+i9MUG3Jp8V+5+1godFNlQtOZY
	 z4c3p9GXiVFhlI6UJfcym/pdgdjFiytWV758bghav8mfPPkzIW1gND+/GQtjnWJoum
	 EZtLywRjPptemRy+uMnwZX6JD3A05/JbOtiX/g4f267WPuzwXbp9SiFA+2D5TLY6TJ
	 QF0iHrX9y7iOc1EB6VoLJjdJgiGx792Gz4FZRZQlrJKvp08ERDU57c6po0QbSc0nVA
	 72XmKtOW9bzyVax2Ni7hEqs7KkSvblI5J1mqfc2DQuOtl9sDV6TrqIeaZ8fKTy9o6Y
	 9788mZvDPQr2Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 21/25] powerpc: Provide syscall wrapper
In-Reply-To: <87y1sxf55p.fsf@igel.home>
References: <20220921065605.1051927-1-rmclure@linux.ibm.com>
 <20220921065605.1051927-22-rmclure@linux.ibm.com>
 <87h6zlgwb1.fsf@igel.home>
 <8d567e4a-6972-458d-b220-eec56ba52ed9@app.fastmail.com>
 <87y1sxf55p.fsf@igel.home>
Date: Mon, 31 Oct 2022 14:09:19 +1100
Message-ID: <87wn8gsn8g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Rohan McLure <rmclure@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andreas Schwab <schwab@linux-m68k.org> writes:
> On Okt 30 2022, Arnd Bergmann wrote:
>
>> On Sun, Oct 30, 2022, at 16:34, Andreas Schwab wrote:
>>> This breaks powerpc32.  The fallocate syscall misinterprets its
>>> arguments.
>>
>> It was fixed in
>
> Nope.

Ack.
