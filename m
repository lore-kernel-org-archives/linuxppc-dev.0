Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D94C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:13:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3021208B3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPQJ1pqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3021208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yy3p58fvzF3Bd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 12:13:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPQJ1pqK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPQJ1pqK"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yy0T3gGnzF3Nd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 12:10:17 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id v5-v6so10115462plz.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jg4nzIGB7QtdoRL7x2OyUuHApbndmi/XN8GQm5zFfmI=;
 b=jPQJ1pqKE3ifShdMCpSve1gKqyD/tfSRoV8+YeyL9C/22SK2tbI8auZ6mV/ss2PHbo
 GVSH4bggBFN2Bkn2Xy0ncLClLXpMVPtOpc6CKV6e9MyocEFBaG2OU22iT+5A32sbHl4A
 AplVJvFVxfpiTdW4IEKUYrRXkTrdC8yq7X8JVPkz8F3N0DnbPSYIkdcXrlJn+nD/HP2Z
 AHk/Tw+L46St+Ku9z4edjpQe6jSlw8ECYbVuFT7Ugwg5f9pNBREn5kKWiCr9syDAipnX
 D7f2XnvA+uijfV0ff68V97vmiKyINdmKiDtRABk3SEzL4K1ntEby0Znl7n/ncKPZHmpQ
 mkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jg4nzIGB7QtdoRL7x2OyUuHApbndmi/XN8GQm5zFfmI=;
 b=uki1QTXoKdTBvMZIVj1zGUR+TUCSh3T7NjmvK7uqaR8L4B2pCbIN0lPl5e9R2tIwub
 EotaJaEWkQrUi22hEiVY0VFOJMTiI0Lzj6v/bz/+JXNGiNyaeV5TDLeP/8ZhG2O2hWSN
 9hOlCQH2OmCodFBiX0okSbbtgad5hcVlRC3FwVUL6hZzq3ZS0HvEscvUJs9Xv5hHZQAW
 li56iR1FOmPEHXEkra1OptvwLhb1wmDSPLgTpbh2RM7rQlCWcsh84Jpv7pdm4aqU5S4/
 Yjq+ipghNxPMDWGVRPiUnHKVPA4GWZWiwasEreNWunAsRKBB/FGLkwmnvZaqXehpRdTw
 6Psg==
X-Gm-Message-State: ABuFfohgpL6sfmXnkoS3WrOZLX4iF8QzOGsxr+MCIxrwCF8F/iRCj2Zj
 HOuaQnvZCp16zhvCFhhUKCQ=
X-Google-Smtp-Source: ACcGV638/NkZj3qYrt99JzmkFSa+xsK/qiNoJ6ykTn0KKMwZd5z+txUnn105MYsHDDGMz2uPksZuGA==
X-Received: by 2002:a17:902:bd8d:: with SMTP id
 q13-v6mr19262591pls.167.1539652215201; 
 Mon, 15 Oct 2018 18:10:15 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id i5-v6sm14654796pgl.46.2018.10.15.18.10.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Oct 2018 18:10:14 -0700 (PDT)
Date: Tue, 16 Oct 2018 11:10:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/traps: restore recoverability of machine_check
 interrupts
Message-ID: <20181016111004.662d16cf@roar.ozlabs.ibm.com>
In-Reply-To: <ab520cc1-11b7-ddc6-2393-8f1315db4db3@c-s.fr>
References: <f79824d5da910441ede885fa32a25083c4cc9359.1539422122.git.christophe.leroy@c-s.fr>
 <ab520cc1-11b7-ddc6-2393-8f1315db4db3@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Oct 2018 09:40:50 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Cc: stable@vger.kernel.org <stable@vger.kernel.org>
>=20
> Le 13/10/2018 =C3=A0 11:16, Christophe Leroy a =C3=A9crit=C2=A0:
> > commit b96672dd840f ("powerpc: Machine check interrupt is a non-
> > maskable interrupt") added a call to nmi_enter() at the beginning of
> > machine check restart exception handler. Due to that, in_interrupt()
> > always returns true regardless of the state before entering the
> > exception, and die() panics even when the system was not already in
> > interrupt.
> >=20
> > This patch calls nmi_exit() before calling die() in order to restore
> > the interrupt state we had before calling nmi_enter()
> >=20
> > Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskabl=
e interrupt")
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

This looks good to me and probably the simplest fix.

powernv will need a fix on top of this, to remove the die and let it
just fall through unrecovered to the traps.c code. pseries seems to
be okay. But this patch looks good.

Thanks,
Nick
