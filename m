Return-Path: <SRS0=ASHh=5B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B2BC18E5B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 21:15:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A314020663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 21:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IIbbRosY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48h8GJ20lkzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 08:15:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=google header.b=IIbbRosY; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48h8DN28PLzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2020 08:13:39 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id f11so6287373wrp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2020 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rA/inJ3N2dzQGtrL1M4Qr6g56ao5g6/q7NGAAMSseqI=;
 b=IIbbRosYhmoGbMSReB5jZmMjLoa7dNfhds1z14gzkwdNCqWcXtCVTdnAWdh411B9Xw
 Pf4v7dC2pqSP+PigEeewQpeiNq10Yt6zj9neGcC6dL72ZVmjZ9adFtKImkTFJN5byWrA
 YV5qo+jNI+wyc6KLos5URe77rW8L/15fw9fVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rA/inJ3N2dzQGtrL1M4Qr6g56ao5g6/q7NGAAMSseqI=;
 b=Bf2X0g+8AXe9JV2NOtnxPB6PVQVSnvPY02bHIM+HbiHr2nN3POILVclrFMBJa2Sghy
 Dw7DZSEF9vzuNhh0DoC6V4z9p8XbJOMxJ1QqtVp2NkMGvS2CZYQ2cXz5YJpl9h7VoyvA
 /jcZWtgKRqWVde2zODdAY6DMJNqsSNX6p6hEhvQ9lKigmvXx51RDGPC4vABzxYzPI/E5
 ZlPucEofbtjCfhaO6juutbcH3bzBoHbLuneZRSSlmQAFQpk3O09niju3jRo7bJoG7ITn
 38s9ylSqWXVk7fm9T7iblgBIxAv6d1L3HbEmgA6qrNfQd4v35IqmvwGVfdxpQXOxuyhU
 JvIA==
X-Gm-Message-State: ANhLgQ3AUeY2BYKnba7HsCRUDa7hzTBJwdN1cysKHy1zEqx81VRMPOSw
 i+0L4jbik8j4Ir7LWljZAtfdmQ==
X-Google-Smtp-Source: ADFU+vuuSfZ5TW55YNV+T4hvZhIZ2NQ7sFNgir1TJISFKzU6o6dDmFBAVVlV4Y0u5pMnIX54CY0E7A==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr1354253wrt.102.1584393216479; 
 Mon, 16 Mar 2020 14:13:36 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-114-43.cgn.fibianet.dk.
 [5.186.114.43])
 by smtp.gmail.com with ESMTPSA id k133sm1209338wma.11.2020.03.16.14.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 14:13:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Fix sparse warnings for common qe library code
To: Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>,
 Zhao Qiang <qiang.zhao@nxp.com>
References: <20200312222827.17409-1-leoyang.li@nxp.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <766263cd-6b84-0c6b-d80a-d7f05fabd875@rasmusvillemoes.dk>
Date: Mon, 16 Mar 2020 22:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312222827.17409-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/03/2020 23.28, Li Yang wrote:
> The QE code was previously only supported on big-endian PowerPC systems
> that use the same endian as the QE device.  The endian transfer code is
> not really exercised.  Recent updates extended the QE drivers to
> little-endian ARM/ARM64 systems which makes the endian transfer really
> meaningful and hence triggered more sparse warnings for the endian
> mismatch.  Some of these endian issues are real issues that need to be
> fixed.
> 
> While at it, fixed some direct de-references of IO memory space and
> suppressed other __iomem address space mismatch issues by adding correct
> address space attributes.
> 
> Li Yang (6):
>   soc: fsl: qe: fix sparse warnings for qe.c
>   soc: fsl: qe: fix sparse warning for qe_common.c
>   soc: fsl: qe: fix sparse warnings for ucc.c
>   soc: fsl: qe: fix sparse warnings for qe_ic.c
>   soc: fsl: qe: fix sparse warnings for ucc_fast.c
>   soc: fsl: qe: fix sparse warnings for ucc_slow.c

Patches 2-5 should not change the generated code, whether LE or BE host,
as they merely add sparse annotations (please double-check with objdump
that that is indeed the case), so for those you may add

Reviewed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I think patch 1 is also correct, but I don't have hardware to test it on
ATM. I'd like to see patch 6 split into smaller pieces, most of it seems
obviously correct.

Rasmus
