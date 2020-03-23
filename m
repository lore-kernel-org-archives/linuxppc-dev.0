Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3698CC4332E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 01:36:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91B4206F9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 01:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shOLnOWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91B4206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48lxmr0vQNzDqrN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 12:36:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=shOLnOWs; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48lxjv5XpvzDqWH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 12:33:55 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id g6so5222155plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=46CfgW3kC7tkRMWLtO6WHuwNmUIIpe4VExj+dGhNGec=;
 b=shOLnOWs1IhOBKH2DGZfpdDqZEkOS/bYVtuCVbu7ABego0bwKUBAauyA/hGzRMSVqQ
 5j27PMOXbmlSMjyKefxL9cZ1GRKKdy2AByMm7D/cckKK+Ok018phzaDUzvSXxzeRZlcB
 dFLN6Is0ZYFSFX2xVPGyXJPtoP5MovwgjkLcfpGu0ndxwKTz3HdwgQCwi6Qda6VsS5Fi
 BWanaGNob6shPBEboFy2rKBmeVnm7xSBA+vLDakHXMJjpis1iRTXMSDkbwfOEv/V9sfT
 7i+QRSGhfW+ZChvbPQ2IE6oCBtIKVbwG/AF30fi1OynJYHloqUNlAaBVQy1FOeMQy9gb
 xlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=46CfgW3kC7tkRMWLtO6WHuwNmUIIpe4VExj+dGhNGec=;
 b=XYvr1pDMQ9DEMqNJds8fVHvq/SRQ51yEi4ubsGGd22uLot+WILrwGcnXPj93VuhhCX
 3iPlv0WdTeLdbYm7K+9zCjpqpwZJNGHREl6fbs/HXCCG9xZEg0qTDwCb4jyUdHCoADRc
 gc5miA5Vbcz0Ld5kEU+DSB+MHGks9c07Un05lda0xb0zkf3j/Dm41Sa6ios2yNJFQqi8
 krU7dBzIJNxdDjLuHxo93Y9qkjYuOQt3n5y7q3wesFt/TOqbDjY01b/rRQgO98HeZdNi
 4+9DV1yPXqUaInqeYZuelc4R66oCOsfrk2a2XANGF5gPNWtadIKSH7DkZ37j4Tehd4nk
 g1Fw==
X-Gm-Message-State: ANhLgQ3LSWioHRVLCD8mYfMpbIVzmdDfmdURJ5x39Vg2Zj/WPLpf9Yd9
 766EuPUO6KpDIcvRQ02RyY4=
X-Google-Smtp-Source: ADFU+vsft++LsRAVqhrNTELPG7G/02zWHBiDC7XVTHw1Ek8dw9NYnB7uGB8O4bDKAvydqsY9ScJljA==
X-Received: by 2002:a17:90a:3a8f:: with SMTP id
 b15mr21959275pjc.178.1584927233674; 
 Sun, 22 Mar 2020 18:33:53 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id w6sm11622834pfw.55.2020.03.22.18.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 18:33:53 -0700 (PDT)
Date: Mon, 23 Mar 2020 11:30:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 03/14] powerpc/vas: Define nx_fault_stamp in
 coprocessor_request_block
To: Haren Myneni <haren@linux.ibm.com>
References: <1584598120.9256.15237.camel@hbabu-laptop>
 <1584598437.9256.15247.camel@hbabu-laptop>
 <1584923120.arc9bj6gmg.astroid@bobo.none>
 <1584925071.9256.15311.camel@hbabu-laptop>
In-Reply-To: <1584925071.9256.15311.camel@hbabu-laptop>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584926988.k2k8w23rqb.astroid@bobo.none>
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

Haren Myneni's on March 23, 2020 10:57 am:
> On Mon, 2020-03-23 at 10:30 +1000, Nicholas Piggin wrote:
>> Haren Myneni's on March 19, 2020 4:13 pm:
>> >=20
>> > Kernel sets fault address and status in CRB for NX page fault on user
>> > space address after processing page fault. User space gets the signal
>> > and handles the fault mentioned in CRB by bringing the page in to
>> > memory and send NX request again.
>> >=20
>> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> > Signed-off-by: Haren Myneni <haren@linux.ibm.com>
>> > ---
>> >  arch/powerpc/include/asm/icswx.h | 18 +++++++++++++++++-
>> >  1 file changed, 17 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/a=
sm/icswx.h
>> > index 9872f85..b233d1e 100644
>> > --- a/arch/powerpc/include/asm/icswx.h
>> > +++ b/arch/powerpc/include/asm/icswx.h
>>=20
>> "icswx" is not a thing anymore, after 6ff4d3e96652 ("powerpc: Remove old=
=20
>> unused icswx based coprocessor support"). I guess NX is reusing some=20
>> things from it, but it would be good to get rid of the cruft and re-name
>> this file and and relevant names.
>>=20
>> NX already uses this file, so I guesss that can happen after this series=
.
>=20
> But NX uses icswx on P8 and icswx.h has only NX specific macros right
> now.=20

Oh P8 in kernel is still using it? Ignore me then.

Thanks,
Nick
=
