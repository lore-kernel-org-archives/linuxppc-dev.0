Return-Path: <SRS0=fJvf=KW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D9C4707F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 May 2021 05:36:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608E8613B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 May 2021 05:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608E8613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FrGlm5HbPz307j
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 May 2021 15:36:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=jkNadJyv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=sandipan.osd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jkNadJyv; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FrGlG0kXcz2xts
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2021 15:36:23 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id
 o17-20020a17090a9f91b029015cef5b3c50so1660529pjp.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2021 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G05gQ3dPBmQfteu43SLXPRarN8pVbgQ2PJJuMw+2DMo=;
 b=jkNadJyvwjn3sEs1y7wP2PLqooW8T//t53JnwgL7Q8HwwsypgzUF+8lb1FDuxHwlfX
 ugkpQhFoCNJSUX61OZ5P75rfokdM+x9lT4vzIKRx+emWkGO5JXvruo+eajuhXpt0fMpm
 DAxLf5+EOj+VV8M8+lJBGBU6UxpN1ztJwf3PIgPbduKaeVIYIqsPVB4iSacJaVU6Pkj7
 RghIo85dAixpbm/2dCSCBehEIggF2Jypu+/pGGU+XrP7BnNtTOr7nfsWth9o0BMcjJp0
 dQ7BFEzHPVe42qKpPuohcRGgFJIEroa0rHbsTlttOWqP9YFyMwrKm3bnx7LPGmCUas71
 w8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G05gQ3dPBmQfteu43SLXPRarN8pVbgQ2PJJuMw+2DMo=;
 b=cynhA3v5CM7ztJHDpM5ZlZZk9PRocE5a2peSLfz1fX6WgZb6216wC0gdBmOePmSeJk
 Z/lDvqntnNse/OsnocGB9QYO6/tLnfYtHzRiDmKjnTlhALACz+1PtcLrMKXJJpEpNqLH
 w5GFTKUEkkLcNjdzBk05MJjJimDhHpWNPxHPR5vi7BBfbQjkrdfLw5DDi3D8uiia+9hH
 ixs/CqloBSN2Kv9r5XnhI1YxvM42lJLyDmj+AcMEMPh4acrq2DKQFGfulZ6xhxKycjYM
 o+P09FNrHtBtuARBeGXufIqLqs7fBQn1C6i4koq1vLooJgJVz40JWLEcVzld2BQGwl9w
 YEBg==
X-Gm-Message-State: AOAM532yYEiAvMx4mNRl1ZucdzlNYvDwi0SGxeoIUbNzEjYpTyhwoxCt
 bk2ez8U6cAavRcgMJaH3V3BfsfiylWQ=
X-Google-Smtp-Source: ABdhPJxIBcO6WvJhMn4SbVgZLpWyrXYh7+sSrgpguQuWtAiBWDGtZ3cppsO2MGX6h74o27rZXAwWcw==
X-Received: by 2002:a17:90a:cc05:: with SMTP id b5mr1999552pju.6.1622093780340; 
 Wed, 26 May 2021 22:36:20 -0700 (PDT)
Received: from [192.168.0.105] ([45.64.236.52])
 by smtp.gmail.com with ESMTPSA id l20sm766587pjq.38.2021.05.26.22.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 22:36:19 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_1/2=5d_powerpc/sstep=3a_Add_emulation_s?=
 =?UTF-8?B?dXBwb3J0IGZvciDigJhzZXRi4oCZIGluc3RydWN0aW9u?=
To: Sathvika Vasireddy <sathvika@linux.vnet.ibm.com>
References: <cover.1620727160.git.sathvika@linux.vnet.ibm.com>
 <7b735b0c898da0db2af8628a64df2f5114596f22.1620727160.git.sathvika@linux.vnet.ibm.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <9fae7bdb-f398-7556-ab30-a1d59713d470@gmail.com>
Date: Thu, 27 May 2021 11:06:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7b735b0c898da0db2af8628a64df2f5114596f22.1620727160.git.sathvika@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/05/21 5:48 pm, Sathvika Vasireddy wrote:
> This adds emulation support for the following instruction:
>    * Set Boolean (setb)
> 
> Signed-off-by: Sathvika Vasireddy <sathvika@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

LGTM.

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>
