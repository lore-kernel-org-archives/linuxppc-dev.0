Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:48:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4207A21872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFSVyk0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4207A21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WcLv4Rp4zDqPX
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 07:48:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WcKF2n9SzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 07:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFSVyk0h"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43WcKF1MMbz8syK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 07:46:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43WcKF0yxyz9sBn; Sat,  5 Jan 2019 07:46:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFSVyk0h"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43WcKD3SQbz9s4s
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2019 07:46:56 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so37792325wrw.1
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Jan 2019 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wcL4Mwt8tayj3Nbn+8PUe5UgbuHPb21EUyoyt5cU6OQ=;
 b=hFSVyk0hJmfkXTMTgJkp06UvRwYB7LSE9q77X2ZJ/vGL4lNMOKyLBq6I+GQfndOlZ1
 8/jxKXfv1zRSh3YoNaOfGgBUMs00EXtThPUbjReoTfIfPFwFMcxYtMtb+mPVt6/5a7U6
 Q/jgb2EpcnGiDi1iyzNYgrc3t0bwhYVu7YDNabt0gKykZ9gxP6l1+GcefoeSgRn39YkA
 Gk/Q57yVrZfyK1SE0xzW12GeuP5Mo6+NHqhTvniZtjDUjQPfQwVMj0sEBNAHBcZgQeyl
 3ohp0zVs5Gl/uFTgMBz9uSmvR2ty0VLaFUEkilAUSKBVl+1omGsnpCmPRROj/OHT/LxB
 eU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wcL4Mwt8tayj3Nbn+8PUe5UgbuHPb21EUyoyt5cU6OQ=;
 b=JMP6+bBmjbsv7EVj2w+qt2jDIEpm8Li60vlbu/6lslIgh7rMWtFqCKvj+eUe2I5RYK
 cQLMQ5fksUO93LN5rP6cRvxrW7t7F9IlRR9epP8Y//R8PmJGlpRTbnY9zm6mcgVdpwkL
 mxFlLCqqsHLJWbcB8fZwF+NipZAG3hMZ7X2lbDVremHzDetHDV7+4Jr+SdZo8s3ldOfp
 YQsA3OfAkv2plXYc601qys+Pr3mboSlrO3CCfnbDTmCiDn5KLAr+WM/vE8ZYYh3aKwhO
 WWgvmibiRgegr3A3AAM/h8YjcudqSumKfQ/XDvdFjwQuPBGjaPUcpQ7obbQ82Iqpt4Kt
 QHvw==
X-Gm-Message-State: AJcUukcPKPQnwWCShnIv1taNU1957TmndRFRHmF7kJpShVNxwd0ptJI2
 JCro4z1yqHKf/4LaULQn8275jpUD
X-Google-Smtp-Source: ALg8bN6ahusqXjHhmvuzMu6UI6/PCRU+vRQKaFkv61HvmXBnLccCtJXtpii832sBqfd9lBwq2auDqA==
X-Received: by 2002:adf:df01:: with SMTP id y1mr47259097wrl.127.1546634813287; 
 Fri, 04 Jan 2019 12:46:53 -0800 (PST)
Received: from debian64.daheim (p5B0D7521.dip0.t-ipconnect.de. [91.13.117.33])
 by smtp.gmail.com with ESMTPSA id
 a187sm2066344wmf.33.2019.01.04.12.46.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 12:46:52 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.92-RC3)
 (envelope-from <chunkeey@gmail.com>)
 id 1gfWMl-0000zD-Fc; Fri, 04 Jan 2019 21:46:51 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
Date: Fri, 04 Jan 2019 21:46:51 +0100
Message-ID: <3480116.KzcvcCly6l@debian64>
In-Reply-To: <43V85g033hz9sCX@ozlabs.org>
References: <43V85g033hz9sCX@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wednesday, January 2, 2019 12:31:50 PM CET Michael Ellerman wrote:
> On Tue, 2019-01-01 at 03:56:00 UTC, Michael Ellerman wrote:
> > Currently the code produces several warnings, eg:
> > 
> >   arch/powerpc/platforms/4xx/ocm.c:240:38: error: format '%llx'
> >   expects argument of type 'long long unsigned int', but argument 3
> >   has type 'phys_addr_t {aka unsigned int}'
> >      seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
> >                                    ~~~^     ~~~~~~~~~
> > 
> > Fix it by using the special %pa[p] format for printing phys_addr_t.
> > Note we need to pass the value by reference for the special specifier
> > to work.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Series applied to powerpc fixes.
> 
> https://git.kernel.org/powerpc/c/52b88fa1e8c7bae03bb691178a9f8b

Well, I guess I'm a late. I had issues with the getting 4.20+
crosscompiled on debian with make-kpkg. 

Nevertheless, I finally got a working kernel and 
on the MyBook Live APM82181:

---
root@mbl:/sys/kernel/debug# cat ppc4xx_ocm/info 
PPC4XX OCM   : 1
PhysAddr     : 0x0000000400040000[p]
MemTotal     : 32768 Bytes
MemTotal(NC) : 32768 Bytes
MemTotal(C)  : 0 Bytes

NC.PhysAddr  : 0x0000000400040000[p]
NC.VirtAddr  : 0x6bc84b36
NC.MemTotal  : 32768 Bytes
NC.MemFree   : 32768 Bytes

C.PhysAddr   : 0x0000000000000000[p]
C.VirtAddr   : 0x  (null)
C.MemTotal   : 0 Bytes
C.MemFree    : 0 Bytes
---

Yes, nobody is using the ocm. Though I do have a patch
for the crypto4xx and emac.


