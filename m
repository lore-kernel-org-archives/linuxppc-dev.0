Return-Path: <linuxppc-dev+bounces-22759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C42DCD98F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:13:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggtlX2p50z2xM7;
	Thu, 18 Jun 2026 18:13:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781770408;
	cv=none; b=DFJBeLkICYOmJXHHdifLh6ai3ChtzNVSAYmKonVBKK7zcDL5wKDs10G4/bKyYb0MIFG9lsJTWxvyLz/lcjDlgfWq6b8o8Vpj7/9HoAqXfnPB8dzZPwCbYesu+6xz7yfz30J2A3KVjfHBUOfAVV4OyXSaerIkSMXgCdDwMJFbrhateLTHANmyQ4nO5ZNXIXloug0TqoFY0xgbyjbROmJeEpmbav17OPBmc0b8Dxoq6BS3OLx+NAQmfO213XdrPDOdC2K+outReqh4ZjLdf3TcVBGyfloKTJcYsuAowYI4tMITsgELmiclUCoo99K6rjdpdzy6xxzVoTnb4gdNm8vSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781770408; c=relaxed/relaxed;
	bh=CKAZNU0FmJW8v6thQLRjRHc5rQqn36zhhyWy7vfjOZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxkTNIvk5g8fZsVkPC9Rbdcc/Cq3lKfE009NiR9qJ8VduT5udUdgppaLxoxuaLIZXIT+qMbrQW0y5Th8dW8sCIBFy7MQdl8iPlx9qIeyyfcw9fkmFXeJSbi/S3oJpG0uCaw2s4pXrTRARS0igrZPPHwLNxlsVr+vn3RqGsJgyvvHphIBs8y9jw/AiFIVSUM1p0A86n9PyC/XXVz7O/c1EzkCaWUFq+5Cmh+T+HurCBoojj9wor9pVQpw3i6QcAqbvsGMihfn1MNZKh/107s7CnWuOErSfthieoXwRpEASPIQA3DdtDsHDehwY/HQztCJsj8YAGxL5AJNEfpLF1PZfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.43; helo=mail-ua1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.43; helo=mail-ua1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggtlW0F7Yz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 18:13:26 +1000 (AEST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-963f63fe025so171305241.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 01:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770403; x=1782375203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKAZNU0FmJW8v6thQLRjRHc5rQqn36zhhyWy7vfjOZ8=;
        b=i0fOap+z8ej2lx2JL2Yot8VTcPMbb9UFXzH/+jOViXw0Ix4POK0t47IMjVoAO3IrqU
         4SdcvXnT/4nGLgrUrjS3zuhuIzLfjtvxcgeS20hZbX6F4nwc5LZB6nAGjtKy6DF/uT6I
         nIVgQuxOfa4ZwZCFjfNC3/hUHGu+Z5VlN2HaGGGVwZTbOgN23/w1plfZYEL+iH9E3b9N
         i9WwLLX1KOBnPHwqP7/E9AnG4VRXn3oSEHGx24sRK3nyzD9z+6Ph69LreM/Azwhrn3AY
         Pqdpj6PwWNw7Pm3mrE9nSiFJ0D1rfZDbAvZ8021rnK6EnNjknEBuBqFzX6tDUsnPqgt2
         zBnw==
X-Forwarded-Encrypted: i=1; AFNElJ+9XhUZI7EtXhEeVsY55P1j6tVzTR7Udeg+IX0Tgz1+J4AK25UQxpZyLIM/qK2hbeNflMw6pwrIKF7Sw64=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKtS3KjOwSteau7+PXNVCvWL8hSnWXMM1C1HfwSQ6SOmF4vsVP
	CSR9IeQS+gW78cAHssG2UnnjkiRJgklOHkEqQbsNl6x8lqhrc00hxs29e6s9JomC
X-Gm-Gg: AfdE7cmKXAXgm6zY/DTytz0F8CNDLHNZd8shcqEzuqCaAoSHl3we/oacZGs1ZxdSJej
	f29EMfEbOFO1UpnQ2f7I7xCijk0RKUn8tJDFakW9yepEusXCwWA8TVOEqR34h5FG5fWMIHbYI1P
	Gp5Jlqv0m3azsHOtQeD2VPdtce7foZ92GuBEpdifBSH6YtE9TewXtPAjjnvKkmN3stXNG3t4T1L
	zaNVVw/bOZ7LObgyCbYhSxyR65xBS6N9szvQKC1zEQZmhT5rRjjGTxaFnO6gnzI360V8I4BbLCR
	TQ0PY1rz4k2f26V/QbJuGd4RICLntxq+KardL8CaTOjbNEL6KtCJTXE8PVOJZmgE5boCluVy1sc
	99/ISIbWAxQfAXVtntKO8XfLEN1ptk96G7WbGJYManUqMd0XwTPzhv9/zD0NImaVBo+FDJrrxM3
	vnMzE/f+iCSWj9K9EtUWb4JZ5a0L3T6cXYubVtWt29YRXFKq/Lu4p3nXbQKWIu
X-Received: by 2002:a05:6122:1989:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5bbbe77c882mr3411710e0c.13.1781770403509;
        Thu, 18 Jun 2026 01:13:23 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbc6c7400fsm3042122e0c.16.2026.06.18.01.13.22
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:13:22 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-966f494f18bso44058241.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 01:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9OqXY3Wp7qqbIPSUcZXJ+D1XYiPLkEfaUsH97G2kSonpvVxP5f44HFFqQGsbsQ9D1qT9aALTX2p7TFCN4=@lists.ozlabs.org
X-Received: by 2002:a05:6102:1626:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-7245cec5b37mr3787588137.6.1781770401826; Thu, 18 Jun 2026
 01:13:21 -0700 (PDT)
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
References: <20260616084901.3319d82e@kernel.org> <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org> <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
In-Reply-To: <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jun 2026 10:13:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
X-Gm-Features: AVVi8CfLJ0ddT-LhKt0W0uHSh_81VvaoqDXBIXepEwXCQOI5G8FSGq0oRl6-8XI
Message-ID: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Finn Thain <fthain@linux-m68k.org>, Carsten Strotmann <carsten@strotmann.de>, 
	Jakub Kicinski <kuba@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, chleroy@kernel.org, 
	npiggin@gmail.com, mpe@ellerman.id.au, maddy@linux.ibm.com, 
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 18 Jun 2026 at 10:01, Andrew Lunn <andrew@lunn.ch> wrote:
> If the appletalk community can take the workload off the top level
> maintainers, respond to all patches within 2 to 3 days, give
> Reviewed-by, or make change requests, it can probably stay in the
> Mainline kernel. Otherwise it will move out of tree.

"2 or 3 days" is rather short.  If we would have to move all code
maintained by people who cannot respond to all patches within 2 to
3 days out of the mainline kernel, you'd end up with a networking
subsystem without supporting OS ;-)

git grep three.*week -- Documentation/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

