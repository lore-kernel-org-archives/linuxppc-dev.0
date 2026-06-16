Return-Path: <linuxppc-dev+bounces-22733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B9CD98E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg8vZ4NSvz3bqh;
	Wed, 17 Jun 2026 13:47:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=46.38.233.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781594529;
	cv=none; b=ai5XRxpBD15Zez4C/Tfendg3CsAHaBa70dpxRy5YYtLT6KDdfYrwPluUzl//j6esZyfuD/CN3yY9t5tpAa9IgoYiz7JVh5miOwngOriEvJQu5ltviSxBGWL4pJgLbyUn2cu5CnxM5u7iWdXmORbrwUnN/vCUvx25cGsDmXwswn+XnBsfsTdiQ0ADvJP7BNsHTmcDTL2SpQP/4p+w7dVcsC0yv0U512EIthTmxns3Ewj0/9P6jqMr0JXnqR09C37zAtFyQ6CMwqJgTVqibVcIuOr7ySQaaUaOJ701lWNCtsBMpTznnJmU1k0NpeS8U6eIiiZZC+F/nkYuidCxYGg6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781594529; c=relaxed/relaxed;
	bh=juhXNLlnPzgyRynEqG91o/WPu2WsUH4/kzqpgpcpPCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vsyttsx9F7K3XB+rv26fNE0SLVDUnuzrqJqB/cPn5d3+J7y28N54R97tRHCbYcrjMOh04+acacI9P2uFyYsB2jarmlHup4sMYqHhuFNwQ1bxHpW+IyOZ1hf32TSPII0R8BB+SrnBDatvzrUwVaqmSt84VbsgZ+4DDPB5CLywkW1eIjCk2lzBICDr6dFBB5iaFGchcgSpHO/VGCJlFF/Mdcex+ns0FWTofZimQSsVAuBCv47nFNYLs8j3O7NJ96Zn5/XByj4GnAmRkRG+FxQenTVJepEZpbU02j92YoKDRqE1T3H0cVsRfQ/jt2y2uA1mirJ9Tst5/ed+txgf29tbsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de; spf=pass (client-ip=46.38.233.133; helo=strotmann.de; envelope-from=cas@strotmann.de; receiver=lists.ozlabs.org) smtp.mailfrom=strotmann.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=strotmann.de (client-ip=46.38.233.133; helo=strotmann.de; envelope-from=cas@strotmann.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 480 seconds by postgrey-1.37 at boromir; Tue, 16 Jun 2026 17:22:07 AEST
Received: from strotmann.de (smtp3.strotmann.de [46.38.233.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfdjC6qmMz2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 17:22:07 +1000 (AEST)
Received: from smtp2.strotmann.de (unknown [IPv6:fd01::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp3.strotmann.de (Postfix) with ESMTPS id 495787FE91;
	Tue, 16 Jun 2026 09:13:56 +0200 (CEST)
Received: from [192.168.8.114] (unknown [IPv6:fd00::1000])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp2.strotmann.de (Postfix) with ESMTPSA id 4gfdWb3KmCzHfrn;
	Tue, 16 Jun 2026 09:13:47 +0200 (CEST)
From: Carsten Strotmann <cas@strotmann.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Date: Tue, 16 Jun 2026 09:13:46 +0200
Message-ID: <A3590144-073C-46D6-8425-90EE0C4D48E8@strotmann.de>
In-Reply-To: <20260615175535.5bc56cfc@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
 <c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
 <20260615175535.5bc56cfc@kernel.org>
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
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a user of AppleTalk and other "Retro"-Features in the Linux Kernel.

On 16 Jun 2026, at 2:55, Jakub Kicinski wrote:

> We can complain about the AI slop til the cows comes home.
> I don't like it, you don't like it. What difference does it make?
>
> If y'all have real solutions please share. Complaining about
> "commercial interests" and "nuk[ing] everything in a panic reaction"
> is not helpful.

the solution, as Adrian pointed out, is to leave these features in the Li=
nux kernel but have them disabled by default. Maybe put a warning message=
 in the kernel config tools that people should only enable these if they =
know what they are doing.

These "retro"-features should not pose any security risk of they are not =
compiled into a kernel.

Greetings

Carsten

