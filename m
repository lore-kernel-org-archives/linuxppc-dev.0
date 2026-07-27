Return-Path: <linuxppc-dev+bounces-24891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516B0C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7yFt027rz2yhY;
	Mon, 27 Jul 2026 22:14:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785154481;
	cv=none; b=mJdpv1COPaFN/EqEXFzYFp/lHWdPTvsF/+enZyr82guKaBHh5CLlhXPgz+bSBw0lO61WdzrzjMlixcNcMd9HI1kiL6J95b8Y5RxlnGSbhVt+6Qo+/maWQWcJ290FPLwAylVgCwhKSkm1/fb7bzwkCTWGTVkzSGM4s5CL9wlg3vu/CNr2qXdgQihr6pQQO0NuJl/CbzVTVks+xWtAcNTi3t1S5p4waB2P/7i45QCQ+/zjrSgupYDE51wJr+XtX1hmB8GH2s0Zbl2s3fOtTlco/iviStt+lz8l53fazoW7xYUiJuLYI1NmjIvmKX2m+uiXcxUulGmVGDD0JW4WWx/TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785154481; c=relaxed/relaxed;
	bh=6mzhEupD5KseqBDjMqsuSY2ghmb9l0u8APYTIUdn3P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIREJd92Tk764umpChQxtE9h79lJTH3wKSAEQt9NYomy7Ojyts95ENLM5fms4s0Ed+slktGfpRluju18LXitbD2ZEracg4bJjbfKjDKg9hzyKcZtqpGWe8tOxVanTLj8kicBJRJRTeBhgTS12T4kmAkzhWRSouACVeUXYJ7HV6qwD+R8diz1eE0V6Tx1YJ19Clv1Z0yW3c84MQfrL+u745CnGmrd5hwSt71RoOzICjoqJqUXq0Zr6RL0h1Ym8HUPo8v0D8+VOiI4WBxP00C4CDo8sMjzXBzn5EjW/2brIi4bIClZfXQYKkgZPRBz9iRM96K64CX1fR1eSZ0Pt1+LVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hzsFM23a; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hzsFM23a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7yFp2WyNz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 22:14:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785154448; x=1785759248; i=markus.elfring@web.de;
	bh=6mzhEupD5KseqBDjMqsuSY2ghmb9l0u8APYTIUdn3P0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hzsFM23aIdJXEv8fwddR3btBUKm2iiOzU1YMx0fp5EpzBy5FoTZd4fQ4Mk/OP94c
	 bPA2Hpb4fzN0gnMHmDSnQDHMQsuPMGv2gAOAnOM7Ormre5TVxbHDJiJZ1KKy+Byz3
	 kD8K1Hg0bZUsMtd+mal3Wm/OnolWilSu9wwdgPbu/t1tIOa5U2ep92MDs463kIGa1
	 0OAEcl7YMy9Bx0T2Ip4PtbmEqB0opJ+6lgoSatKbwWkfJmYPqeKTFg0Jz7yGtwhCg
	 gYhxphRlnwIU2S6Hlv/1F/++MNFAsBQ6+WovB+suNx184rvGZRr3ZCbuiXeNbHkAF
	 jv0CD8B3h23tNMR1QQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1wfYnI2uHo-00C79l; Mon, 27
 Jul 2026 14:14:08 +0200
Message-ID: <54b81978-7a92-4193-8a03-346ccc7857ec@web.de>
Date: Mon, 27 Jul 2026 14:14:05 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 2/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_create()
To: Dan Carpenter <error27@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <chleroy@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
 <amdB2K43gRBDhBPI@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <amdB2K43gRBDhBPI@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNsg5tIS4FQGMfscrQqKkpulvFqP4ldw9YpVgBHs5Hzxru7IxrU
 +yWM/Ua3ny1RnZ1wQSPGLiqkXeF9KDGk1wU0Kz9c1oTP13n7rOHKn/zihZLD7hKV8KvgCWF
 QfOu4AzNG8JIwK+OjL69UP/MgCEMjtXf86okpvH+0WKC0w0/iFMJawvfuYQ/oAhOSuI5dov
 JhTTNEkEWqJXHBijjz87A==
UI-OutboundReport: notjunk:1;M01:P0:LuIo1rHKq2w=;sewYNS3PuJpbJnnVNFOy0FC9OFT
 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

>> Scope-based resource management became supported for some
>> programming interfaces by contributions of Peter Zijlstra on 2023-05-26=
.
>> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
>> Introduce __cleanup() based infrastructure").
>>
>> * Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.
>>
>> * Omit two kfree() calls accordingly.
>>
>> * Reduce the scopes for the local variables =E2=80=9Cobj=E2=80=9D
>>   and =E2=80=9Cqman_256_cycles_per_ns=E2=80=9D.
>=20
> Why?  No one does this except bcachefs and that was removed.
Have you still got development difficulties with scope reductions for
selected local variables?
https://elixir.bootlin.com/linux/v7.2-rc4/source/include/linux/cleanup.h#L=
142-L146

Regards,
Markus

