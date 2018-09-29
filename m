Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35580C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 21:27:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DAE206B8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 21:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzMt+Qx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DAE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42N1pR2QdYzF3CR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 07:27:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzMt+Qx/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzMt+Qx/"; 
 dkim-atps=neutral
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42N1lq6qyCzF39p
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 07:24:51 +1000 (AEST)
Received: by mail-ed1-x533.google.com with SMTP id u23so10977240edx.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=4y/aGya0tcduBYJgr7MGw+OB3blvM5D1Zr3QjktnGlQ=;
 b=TzMt+Qx/wJrro1TMoDIOUldxWCnJGrdTEST20bBhaHOcXxgMMN3+h+WxKrvYVlbmDP
 UGR3ikPH2mmtiECHoZIPwnv0ukPemxJSKbEvGEFAa8SLE+v6IfDcJP0U39H+R1J1vRsV
 eL+RRFPvWLnMnDFf48u5CozbMTJfAUqBHhm4YHwbKk+9QLOysbd/p9hxI8r+Q8aaAGeu
 JZBHUyZHPzxecL80+MQKsRcFDMco/lPfgV9oJ7DxwJie69Hip29Z5oImi8n1wNZA2aM9
 0i6fK3h3hb9UINxqWQz6NwM0pz3DEYxYCeIdWwdgOvoYcJqBwT5ZubrRn1WMd66s1sd2
 1Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=4y/aGya0tcduBYJgr7MGw+OB3blvM5D1Zr3QjktnGlQ=;
 b=NraG2ulPxJndu6fF0A9RHVZZEjwKFYvvazrfaDgDH4Qvp9Cq1WZfnRVEPHVX+TxKwX
 Bz+HX1LBWKUzyUevAM1UA/utFYjE3qBEIxByKd/RZJV0uDUD0fM3tS6k7qdyjTA74rHa
 QGeW52IE1NsrZ8sb7XKRpRlOE6naIDJrhiX7ajKkRF0kqwfAjRFpwrrktCadIQCC/NvR
 vywNSynaIHcqotVFQ0sgj+7sO+gye0PA0h011II1zHy96LU4cjMzZyLn5K0SdhS71YAp
 Yc/WgJwigV7PNbrWolL9uf/2i6jasAsYHRHbaBBgyQzuR9pe5J6mL0tIoHHkDXJY0KnQ
 guJw==
X-Gm-Message-State: ABuFfogG6dTDdahPRqfqvz4YKk1M0Wd0Akqccu3nrd09npg+MwmfC1+b
 yhoFznOIz6LJVhBmJYBtf5XC3Iq5MuOpLk7JfcaHMEVf
X-Google-Smtp-Source: ACcGV63/XBU7ynsCAXBZjqH2qWUhxjhaQQBeENmcZCOVjx2f6H0THZeR/rG/EvOOFW8OMwgk7QtkVqiX2tBVpCx7/R8=
X-Received: by 2002:a50:f197:: with SMTP id
 x23-v6mr4861787edl.21.1538256287065; 
 Sat, 29 Sep 2018 14:24:47 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Sun, 30 Sep 2018 00:24:35 +0300
Message-ID: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
Subject: Looking for architecture papers
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hello

I want to learn about powerpc architecture, mainly hypervisor and
partioning.  I download the books (1,2, and 3 ) but I feel it lacks
a lot of information. Are there other books ?

Kind regards
