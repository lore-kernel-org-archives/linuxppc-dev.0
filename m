Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA42C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 03:54:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96C220869
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 03:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKeVIeNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96C220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xh775mNrzF3Xt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 14:54:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKeVIeNz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=alexei.starovoitov@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKeVIeNz"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xh4Z0yJ0zF3R7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 14:52:10 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id v18-v6so26752970wrt.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 19:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1V3A8w/Fwi81Vu+7hJ4pVQug84DlliIEPUp7wQQJ788=;
 b=fKeVIeNzgApVf+LUrDkEr2sM1HIC6sLHJiloKrivEx9vjv4PBMdA1UxGZ7jbGlgitl
 AF3t5rITkB+krGN3iRWpCcFxjk6bgcPSh4ofUuhCtHzhs5OJkT1Xte023aYKJXqZCXFZ
 l5e1uUtB7zpL7w23iQexP5nnrGCLTzPFODG9bSnUbY/cUJ2r20M4X2Vrd7FaYnSQD1CY
 s6LiQVX+MhImT3EaYCayDMZdd81LGGc9RccUmTx+tP0EEk+EzIgDbQcV9twQ+Bu5uyWE
 egxnn7KBhrG2dcKtomddJEsJK7A8niY/K2W+dNhNKtBa/vtcKVbDEc9LfR/aoPy85MHg
 t++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1V3A8w/Fwi81Vu+7hJ4pVQug84DlliIEPUp7wQQJ788=;
 b=LOiZBRWOcrNJmF8M7SbbQWjfgVFVKFx3WG8mqsmbVWqT9WL3+eUQPoeskREpedXaO2
 1jDZOHfQO43u3BAvPpOXAeTQcjii4gRW6+fx6S+/9y9qfAfG1Kn/TWJuBze1L0JZifq0
 UUGPnzpvNjgb/ZUQLivTbc/XBtp+3ONiGn78vPQyFn4339Uo5R5KuHLEH+KnzaCqIRSX
 XhCD6TabIb+6L1YplvChNXQw6tovzyQIrBi2xILF5KoxlVADxstkP+rwFngwoZ+JBdwC
 WR/Pd4/kIXaf7pwNkYtjMPNPNG5iTkFxt/hATqSdpXSB9If6oqz2YvlbQp54jDCI3r/A
 ZxVQ==
X-Gm-Message-State: AGRZ1gL3KJemnRRespa7jy6i9ITwvLYxX6TJGow77rpv76Sr7b9Aar4S
 Ez5wFT5Y3DsWwqInA+TEqdY9kegcR8yiE7zt7Mc=
X-Google-Smtp-Source: AJdET5eWrUYnjKdnCuoyOuQ0nkQqX95j/lVXyc5NG+X7l0WZi4ZpflyBMWsMgSogpqti50438FIp4njd1lyWcdhZT7U=
X-Received: by 2002:a5d:40cc:: with SMTP id
 b12-v6mr12090508wrq.133.1542426727398; 
 Fri, 16 Nov 2018 19:52:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <20181110.134758.693752342395888727.davem@davemloft.net>
In-Reply-To: <20181110.134758.693752342395888727.davem@davemloft.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Nov 2018 19:51:55 -0800
Message-ID: <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
To: "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-mips <linux-mips@linux-mips.org>,
 Daniel Borkmann <daniel@iogearbox.net>, jhogan@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 paul.burton@mips.com, Paul Mackerras <paulus@samba.org>,
 Network Development <netdev@vger.kernel.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 10, 2018 at 1:48 PM David Miller <davem@davemloft.net> wrote:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Date: Sat, 10 Nov 2018 19:58:29 +0100
>
> > Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
> > storage and finally move the flag to separate storage in skbuff.
> >
> > This is final step to make CLAN.CFI transparent to core Linux
> > networking stack.
> >
> > An #ifdef is introduced temporarily to mark fragments masking
> > VLAN_TAG_PRESENT. This is removed altogether in the final patch.
>
> Daniel and Alexei, please review.

It was on my todo list.
All reviews got delayed due to LPC.

I guess too late to comment now.
Anyhow I don't see the value in this patch set.
Seems like code churn.

Michal, could you please explain the reasoning?
