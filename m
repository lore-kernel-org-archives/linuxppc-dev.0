Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A0C4332E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 00:36:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B429020732
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 00:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9FLNxVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B429020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48lwRd3c9fzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=j9FLNxVx; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48lwP11r3tzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 11:34:13 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id w3so5153666plz.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=hWe9aOdd/5pj4mdgqeHAG8NFTgXDcImx5GPl4CggDBs=;
 b=j9FLNxVxZXkSuWCFWgT1ncwzC+RA/8W9CZOsmXD//Fn22LmZMPpwGi3qu3MCakAufD
 1cKB/Yu6rUlGNqsPpZfzsQ1tYDke1xrjODTwIMhlm8T9736kqd7SG98M5b2BGgN8lBDm
 DP92zRaBii6LURBWEBzUAcN4Xq9jlbyIX/2OHwaMy11N3vAVMQ8V3tfgyltZOXp8mv1N
 a+RBnd9aMChrvJz482yOikPEEl8IHdmeNs8bvtKodfLjs7i1olIXMlu7JhKOe6uCKYTu
 6HO2vD/hnOfkljTRL8w1C9v45MyoDlaoxIq0Muvvm5RlYBwkDZLFCzxJ2tgdIunGMWWs
 /uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=hWe9aOdd/5pj4mdgqeHAG8NFTgXDcImx5GPl4CggDBs=;
 b=P3Vnv+w8Q29WlSyF9FAqW1sqvLO32mRWLeHwZa0+Vw0sVlwMPU/pgaJbfeujSRLKXD
 YsHW2g6hEBzv2Pa0nPp2fyRzcmlicr5hEiKgROEAOomt4uZ0BPl3lC4auJkMSqLT9SAK
 VggdW0x3xCM2AF3YTrdos+7hUX9Dhop7WGWeHIDzupiUimtZJwyNsmOivRxnUQlPZUie
 UugxxPqH/h499OcygW5xSbshu2N9u66QkfKzkNr2vsAEdt4NJqiPeKEZDporFsdROTG8
 zO0d9mOhmkNkIAsQX8xO6CQkPxGk4yYgffLcABjviUtzoTjB40cHQziwUXkA8WQ5K7Jj
 zoWw==
X-Gm-Message-State: ANhLgQ3FiA3vQTFJV2S5ddMEcGod8c7ZwSlKYLhLHKbEPQ3e3cSOZ8L8
 F26V1Ey+Mj9isCEfYeld7XI=
X-Google-Smtp-Source: ADFU+vs6QAa6xCUvaKzAnuN54MactH5nbOAj0BstrTa6XONCkRWPuGJO9nCrAmcK4ibB3D+bxu0G5A==
X-Received: by 2002:a17:90b:1b04:: with SMTP id
 nu4mr22063449pjb.81.1584923650085; 
 Sun, 22 Mar 2020 17:34:10 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id y193sm10565870pgd.87.2020.03.22.17.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 17:34:09 -0700 (PDT)
Date: Mon, 23 Mar 2020 10:30:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 03/14] powerpc/vas: Define nx_fault_stamp in
 coprocessor_request_block
To: Haren Myneni <haren@linux.ibm.com>, mpe@ellerman.id.au
References: <1584598120.9256.15237.camel@hbabu-laptop>
 <1584598437.9256.15247.camel@hbabu-laptop>
In-Reply-To: <1584598437.9256.15247.camel@hbabu-laptop>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584923120.arc9bj6gmg.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Cc: mikey@neuling.org, ajd@linux.ibm.com, hch@infradead.org, oohall@gmail.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 herbert@gondor.apana.org.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Haren Myneni's on March 19, 2020 4:13 pm:
>=20
> Kernel sets fault address and status in CRB for NX page fault on user
> space address after processing page fault. User space gets the signal
> and handles the fault mentioned in CRB by bringing the page in to
> memory and send NX request again.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/icswx.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/=
icswx.h
> index 9872f85..b233d1e 100644
> --- a/arch/powerpc/include/asm/icswx.h
> +++ b/arch/powerpc/include/asm/icswx.h

"icswx" is not a thing anymore, after 6ff4d3e96652 ("powerpc: Remove old=20
unused icswx based coprocessor support"). I guess NX is reusing some=20
things from it, but it would be good to get rid of the cruft and re-name
this file and and relevant names.

NX already uses this file, so I guesss that can happen after this series.

Thanks,
Nick

=
