Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D00C47247
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 07:10:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69731206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lmD+SwIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69731206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GW840WKQzDqVP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 17:10:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GW5r2tlfzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 17:08:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=lmD+SwIf; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49GW5r1005z9sSk;
 Tue,  5 May 2020 17:08:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588662496;
 bh=4ceepXdthZbO3RPTpB2jy53jOwY5TcQVnqGiVoQ30xQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lmD+SwIf60G72wmf9LFCi4xB7rrmnGC+PplO2+1WvSdcsWJiOVpwrESdXpY2QGGeN
 wwmO/80zp4MxNu09X7mHR1TQTcOjwPlYWdhxExz0tQ76MRahl/ELpXMtHaeCtIGCKh
 XK9NIdyQmJghfermDthcfTxquJ61QEdxeXgaQJYwxaaoNQsd1uQe3KScrqiZqKVKpJ
 D4rB3C2JLKUjluAefxoTmGL8ui009WW2aOZucm7halUpgPMVJ2/jxxZukSrXiGnuxQ
 mtLbi2Q0SUVvNda6Rtl5kQgBBdJfl3uTftn3psPjQ9v5/t8DjT2lrRBmHSTmMBa0oz
 gyU35O8at0yfQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 04/28] powerpc/xmon: Use bitwise calculations
 in_breakpoint_table()
In-Reply-To: <20200501034220.8982-5-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-5-jniethe5@gmail.com>
Date: Tue, 05 May 2020 17:08:34 +1000
Message-ID: <871rnyeu4t.fsf@mpe.ellerman.id.au>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, naveen.n.rao@linux.vnet.ibm.com,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe <jniethe5@gmail.com> writes:
> A modulo operation is used for calculating the current offset from a
> breakpoint within the breakpoint table. As instruction lengths are
> always a power of 2, this can be replaced with a bitwise 'and'. The
> current check for word alignment can be replaced with checking that the
> lower 2 bits are not set.
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v6: New to series
> ---
>  arch/powerpc/xmon/xmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index bbfea22f4a96..e122f0c8a044 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -857,8 +857,8 @@ static struct bpt *in_breakpoint_table(unsigned long nip, unsigned long *offp)
>  	off = nip - (unsigned long) bpt_table;
>  	if (off >= sizeof(bpt_table))
>  		return NULL;
> -	*offp = off % BPT_SIZE;
> -	if (*offp != 0 && *offp != 4)
> +	*offp = off & (BPT_SIZE - 1);
> +	if (off & 3)
>  		return NULL;

It would be even better if you didn't hard code the 3 wouldn't it?

eg:

+	*offp = off & (BPT_SIZE - 1);
+	if (off & (BPT_SIZE - 1))
 		return NULL;

cheers
