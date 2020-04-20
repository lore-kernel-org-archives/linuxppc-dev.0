Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA56C54FCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 02:12:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690CB20936
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 02:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smwFGame"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690CB20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4959Dw3cMGzDqkW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 12:12:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=smwFGame; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4959Bb26THzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2020 12:09:59 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so3761235pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2020 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=0NpoVIV5BBpVC9+Ar43gGkMf3ia+u5987WDF4Vw/Yd4=;
 b=smwFGameKYkTS1UTy4KMVNxcA2U7RJMtBBfTD3bleuHOxl9VHbTIatabmqTqQDte/R
 sHxesVN7sZrWJ89xkLH37di+EdbZNsb2QBMY/BkxcPcgmb3zJp7cPJzKvafXxZx10F37
 jVCATiwe7ukeTJ4ZEG4veo4WCbIv+ezIruaEQPs26kXix4HFutgk85guc+tbOYY0/qhk
 WDpUp2hUA7K0S/Mb08MAJheprbbdOn4fVGqkIRdo4e4tQFO6XNsAt2ThQk6RxjR0jQj4
 FCmAWNqczvg7/XlBLP6nBaf2beEZVCFySnwPhXhWTtUPNlQ2AWp7I7LrQ9igvPTtfK0Z
 4DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=0NpoVIV5BBpVC9+Ar43gGkMf3ia+u5987WDF4Vw/Yd4=;
 b=KPokZAfGSdJKTcFtZ5SMxCV30C5BQovWmpLt3hJ7DeYCfZTPQHMlFA0U8K1R5e3wtm
 Jw2IMg95LOifC7sf2+4YCH3PftpWAt5BNsef8mj/YyLRpuNkouZ6tPMXDRy+3yJiTraL
 B2iybk7zwzq+SFQLAsWnxCvtRKM+PxPfwdZn2gIB+9h2z1BswoZELs+UZ97lw9AbFxYT
 /DvTywvvFIk2cWfxhZk+KU3499flVFCh5xzMH56f89CwK54D8/Nh+nHwJHEa/efjxh7O
 4xeJUEqD+jWk1bxuVN6NdpJAGaA6Tgtxk1GYjQFbnNdwux3byWuw+kkDWLa3MEsyi++v
 nl+g==
X-Gm-Message-State: AGi0PuakOdUAMweqTEgn7h1EOKEfgjOxzaSwfNDvR2ojKscHnZ9b/rIb
 xVMqnSBRMo30hA9NzDWKX4s=
X-Google-Smtp-Source: APiQypLV9QIfOcoh2wLkCPSokDBB4f5ZROkcHlo59I/B+/M5nASv+P03Cn9b/A/a2GNhbL9E9iE/xg==
X-Received: by 2002:a17:902:868d:: with SMTP id
 g13mr14171889plo.317.1587348595565; 
 Sun, 19 Apr 2020 19:09:55 -0700 (PDT)
Received: from localhost ([203.185.249.170])
 by smtp.gmail.com with ESMTPSA id c28sm357376pfp.200.2020.04.19.19.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 19:09:55 -0700 (PDT)
Date: Mon, 20 Apr 2020 12:08:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
To: Rich Felker <dalias@libc.org>
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
 <1586994952.nnxigedbu2.astroid@bobo.none>
 <20200416095800.GC23945@port70.net>
 <1587341904.1r83vbudyf.astroid@bobo.none>
 <20200420012904.GY11469@brightrain.aerifal.cx>
In-Reply-To: <20200420012904.GY11469@brightrain.aerifal.cx>
MIME-Version: 1.0
Message-Id: <1587348046.pwnfbo52iq.astroid@bobo.none>
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
Cc: libc-dev@lists.llvm.org, Szabolcs Nagy <nsz@port70.net>,
 Nicholas Piggin via Libc-alpha <libc-alpha@sourceware.org>,
 linuxppc-dev@lists.ozlabs.org, musl@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Rich Felker's message of April 20, 2020 11:29 am:
> On Mon, Apr 20, 2020 at 10:27:58AM +1000, Nicholas Piggin wrote:
>> Excerpts from Szabolcs Nagy's message of April 16, 2020 7:58 pm:
>> > * Nicholas Piggin via Libc-alpha <libc-alpha@sourceware.org> [2020-04-=
16 10:16:54 +1000]:
>> >> Well it would have to test HWCAP and patch in or branch to two=20
>> >> completely different sequences including register save/restores yes.
>> >> You could have the same asm and matching clobbers to put the sequence
>> >> inline and then you could patch the one sc/scv instruction I suppose.
>> >=20
>> > how would that 'patch' work?
>> >=20
>> > there are many reasons why you don't
>> > want libc to write its .text
>>=20
>> I guess I don't know what I'm talking about when it comes to libraries.=20
>> Shame if there is no good way to load-time patch libc. It's orthogonal
>> to the scv selection though -- if you don't patch you have to=20
>> conditional or indirect branch however you implement it.
>=20
> Patched pages cannot be shared. The whole design of PIC and shared
> libraries is that the code("text")/rodata is immutable and shared and
> that only a minimal amount of data, packed tightly together (the GOT)
> has to exist per-instance.

Yeah the pages which were patched couldn't be shared across exec, which
is a significant downside, unless you could group all patch sites into
their own section and similarly pack it together (which has issues of
being out of line).

>=20
> Also, allowing patching of executable pages is generally frowned upon
> these days because W^X is a desirable hardening property.

Right, it would want be write-protected after being patched.

Thanks,
Nick
