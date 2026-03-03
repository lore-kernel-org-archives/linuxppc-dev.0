Return-Path: <linuxppc-dev+bounces-17558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B0DEC0461
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 09:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ96y1Qrkz3bn4;
	Tue, 03 Mar 2026 20:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772529146;
	cv=none; b=P3+T3vrZ2jj1OoZCzcL8dE2yEK7xIb31E5joHe0ipmHxSJzPYTOUS0bYC+tmjSvGq4f/SxocuTHz8h/z29ycKjoWGUj5+hRvUVdEXjNKvJdqq8Ogh/JCHZ5AC2WOx809zW3F9J3Kaa0iZvokUkkqU1WQTTkO9h1qU0yilkjSYKbc/yF3gEpHKMyrhg8h5FGBNpMlFXndziDeuz3Bmpk0VBKQPtXjrOzVbAJiiDrRsTVj1J+S863OLRZbRnxZ5V4YfDVmCI1Of1yf+0SSntA9SrPFU3ZR0f7EIJ5tycGOLCUcUWXpVSKE4vPKRTWvj6nBwvXYq/PICK0NsG48IKs3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772529146; c=relaxed/relaxed;
	bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTP9Y6aKgLxkFfqE8MdqqUYY3sGRT/4EJef/tGLk/wGkZC81wwom9UI95tAYvvsAKruk5/kam2JoXl2lDRye/YtWCzN1XMKznrIOcpnCfYlycyOuCSmOC/kxDm2h2gaZ3ARivG9oIgZipOwhwFA7EGz7KkOD7grfYotnmS+BErf56B79ytvJho/u9FFsv1iD9l4RGA27r1B4ctXEY4MnXrKTwH30XKaCqeZRGK1tSV0mFhfwxeYc00Fs9rR2sWb2UOMmv8prLhqjZW15eVNIuVZqgz3+wpoMLvzoKUP+6Uq31zWI7Q7zv38lAIqjmXok0MI8rUHF3ouiZl/xquNMBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bdbS6GhS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bdbS6GhS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ96w3bxBz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 20:12:23 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso48066075e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529135; x=1773133935; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=bdbS6GhSNBKIkRHIqumHV82J8v8/X4rpJktG5MgEZO6kR9uE9xTvvaBnACvujyBXEQ
         TzSNYctTsrJ8TNt6LgLWiKbRIdzBFUdSkhaGmypaLf/5G48i8T/HAoO7UNTHF8o7TT+u
         Y4H2TtiCZHYtIoCYPHNI9ZJMHATWWO+Vhl2iWB4LojFvOFk6wDgtMBxIoqhh3LO5UhEe
         JkguKkrlez4+I7slhyDxEbO4jyWq0vzin+mJM9QY/wFoQIlQhC7XApu/O9/ghTyqf+0H
         eZGXTx35xa9EYG7RA6BWLAHmx+7q70wTKF+ZUABCZqYJex7ed6+KME5hFg+MceaGct8Y
         BDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529135; x=1773133935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=I4b9gYe3EdCFS0LoZBTqYuPsiHnI8M96HmVLkTsUYVrhIlguzU/8ORydWowwxVWpGL
         qjuTxWgEVE4/Gm9evI0aWY/mcUNiFn0rmtzS9dSEb0UGGrhylL+amjLQgn3+AepUq7i5
         QK4tRNqXn4ahpadjicOMXg0jgo6Suz2V49/dIrIEs9BoZqdr/ySknRZgcPQ1Y826gpJl
         +o2gamtkJXtePwPEwdBROgHAIdD0nyr8LdSs+twaY0JVFAz99RjLZchMYZCUI2vGVO6J
         wVoeBjoMkIH8+WTvSFUY+CZ4qRWLw/INvp37cwNTT6Ymo0GzWkftEaxyIZjLJ2z5Rzxt
         W8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtxxvZyUSqrs2qH01LINwyHvsJM+nFwFjK1mLph/QddH7qrpsYfLHeWeoXEVNd2zw3/obVK/50aY2xak=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRcPhCNBlO5cXrhgFmFF3nkPW2XQ/D86wta+ZomPskPh+B450M
	oGSGedZQO1jFBRoHLCMJtbMfy7gnPQhHkThdtJgbInlcJuucfIBz9cdG
X-Gm-Gg: ATEYQzy0+FrSS1+F3pG0CKzhom4wMTtj58kRrq1OazXU38hC0v0bLUVmUuXg42k/tbn
	tCnP8hu7pTuLwLs1mzJKe/g9PWCtJBCvNjd+Q0CWA6/YPVFlYk3pxsCnLRfE4/naocsSS6LI3f/
	e8cSLUzymMN3O/4ELPv5z3Q7wda2N5DsNDpAIflwTRIGtjH+PlqCQJ1JBoWbzRq2pfucnRiqCB4
	fClrstdGQN+thxFq+OLcX0Dyo0sjGOhqXscPaNqZFLItaB/0ERL+QjCXjCjTK2L+l6RHXIxlgdO
	qIHhqTteDZoBy4KAuCOsttU8YzTsf9TR1PhiTg8vRfVFr2CV2M+TzsG7s6dUHFyg982WS9H0O95
	XvJQYTqCZXVLnWhsbqKSkLO4kHzmWyljN6qaqsntyZCRyBUUxeQzFYM9TQN7g6cZFANvtedr1a6
	7kvL3LRsMRE03nrJLcJHGcuIhrDUsqGKjbH8LRuaAMz78HOtU4QiGfoTILUk7rW7cl
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr280473755e9.2.1772529134880;
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48512692c14sm13045615e9.7.2026.03.03.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Date: Tue, 3 Mar 2026 09:12:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner
 <brauner@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara
 <jack@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in
 __scoped_user_access()
Message-ID: <20260303091212.620241c8@pumpkin>
In-Reply-To: <e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-5-david.laight.linux@gmail.com>
	<e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 16:00:26 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 02/03/2026 =C3=A0 14:27, david.laight.linux@gmail.com a =C3=A9crit=C2=
=A0:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > -Wshadow is enabled by W=3D2 builds and __scoped_user_access() quite
> > deliberately creates a 'const' shadow of the 'user' address that
> > references a 'guard page' when the application passes a kernel pointer.
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com> =20
>=20
> There is a problem with this patch:

(badly line-wrapped errors deleted)

It seems to need gcc 12.
(So Linus is in luck.)

Prior to gcc 12 the #pragma generated by _Pragma() act as the
controlled statement of the for () loop.

Trying to put the _Pragma() inside the for statement doesn't work at all.

	David

