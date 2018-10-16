Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9218C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:01:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D072098A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE3AZMqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D072098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZNQq6YxZzF3Wf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 05:01:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QE3AZMqi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QE3AZMqi"; 
 dkim-atps=neutral
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZNMx16qTzF3W7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 04:58:36 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id c1-v6so22255401ede.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=2FWe5Y2mE6agvnZPm7nNr9q6kzgvsZJXaCChCSDsPKo=;
 b=QE3AZMqiG4WvtHM0SzlOYAXZRhvyMNzc5wz/qj1vjZlpMDLW78UmuinRAzofwN2KQP
 XqypgscrRoKtDocJ2TSfpObCTLDKckRdFLxeYDyewo4UbeTxpjPIjCN5/5SW3g81mOJ2
 csm5SGi8rpZirgMF+9m+c5mOLc7SuoT+wV87rrSOIlYLZXpT4Rgb6+63dnoxd0Ikkvlv
 3bs0eo14VizSjpVj97lBUWePwTsYAD9vCduUvk3AysoZDkOMpyudHrMtvX7NdxhN2G6e
 sAvIqGXQUj3oGumxqxrirkkGfg/m6drauDae5i1lOrC2/uNNU2KbUYZINC6OOBZrv/hb
 22tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2FWe5Y2mE6agvnZPm7nNr9q6kzgvsZJXaCChCSDsPKo=;
 b=jqrnvcvLrFvwLvnkMwnNsWcpZsHrL+4rLnpbtxjkv+UMV0A42gaBdqfACeMG1Q2eCx
 NvkJZvQNdsa9hohYYuJwlj3n91fVOAgvKjujR8KwYPm3aoUl5GUQuWftnQzZb2Jor4t+
 Z+mizM9eB2h5vsxTpu4XTYnhEMQU7yzRXftI76hrFsIwMflSnj8+cAuaUU12uQwUPBLx
 fNmRoV7j5kbk3Gsc1g8qq6XgWpteOR8ZgXbBrBHDFLvJEU9M5I/tBtbIN1rlX/CgMCmQ
 oIhUYGW6h18485blmKH4DTL6Ln+zfSfC8wuYBKbGyPZvhs6jdZSIkkqlUaFDNP8/8+Kc
 oL1A==
X-Gm-Message-State: ABuFfoiIol5Cdj8iu+h8qd/gEAuPRsAUbmDiD6QVbSxureDmRANma/2V
 LUfg5E4LzvGXTK4SskKTE8em/uEXpzxXOPC2D1SA8gAC
X-Google-Smtp-Source: ACcGV60PllnmtPnIjDGQ5N2BBTdsW3wB3lzoAlEoOUe11hGS//rycNyek7tMZd/a3/IF37m2QdiH/ofFWUGMl/xvDnw=
X-Received: by 2002:aa7:d7d6:: with SMTP id
 e22-v6mr31011722eds.69.1539712713116; 
 Tue, 16 Oct 2018 10:58:33 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Tue, 16 Oct 2018 20:58:20 +0300
Message-ID: <CAPB=Z-ospEB9cyjaqk1zKy8axVKnri4=A=wBRHB_fMM_MKgCbA@mail.gmail.com>
Subject: What is an address translation in powerISA jarogn ?
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

Section 5.7.3
"Storage accesses in real, hypervisor real, and virtual real
addressing modes are performed in a manner that depends on the
contents of MSR HV , VPM, VRMASD, HRMOR, RMLS, RMOR (see Chapter 2),
bit 0 of the
effective address (EA0),"

Hello
1. If MSR_IR = 0 and MSR_DR = 0, does it mean that addresses are not
translated by the MMU ?
2. If EA0 is the 63-rd bit of the effective address e address ? Does
this mean that the translation model is
   derived from the address ? a non privileged context may access
privileged memory.

thank you
