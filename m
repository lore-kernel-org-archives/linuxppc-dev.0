Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:20:08 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0255820700
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE2k0gDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0255820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fRP6H7bzDrCN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:20:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oE2k0gDe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oE2k0gDe"; 
 dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNW526VzDrJf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:31 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id 64so317465pfr.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=F0SESDeMNBYao8TxEZlN/P6iHy95PRqQb9Y/KUCQvHw=;
 b=oE2k0gDesW39grT+m9srW0cnkSdYzPZOIrMmUTpEqNbhhutnzF9XS1uZ7OfpRQPujc
 fkjeP7AHwI3XDyzPr4y8Ie4ahJ9NQ97twNcY2rVRPShmKMNZg4Ru1OS2pSWBWRq1oN/H
 BF6LMEM+Hv79AJhwRZ8uepGpb+JvoK9iAVp8z4ltcx3HjX8iB41VB/PtzGCoThL5QbnX
 OksW07R3T0TBRZy2O8VPEWVzkR4HJ7fqaauFU+HScc7hLM2bDsCmQbSDdZhJ+pkIyiYu
 LvUEK2nkSn0/0L4G+7Sf3xaav+/+3Bmog2FhKNubJ4ZtL5R9jd1nelbS0BqN29Xir9pe
 hIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=F0SESDeMNBYao8TxEZlN/P6iHy95PRqQb9Y/KUCQvHw=;
 b=P5OPCq/PUuD4rBovw59u3LlWI0l+ULG42zpWy3b/lz5uVjPW5MjbFb1PtU+Rl1vU0q
 osNMcMzZOtqcl6l+xM7H//VASTqNJYk9TAvUyzSw5RacRu11f8bIl1deTUPbWOBfQdzC
 ArTn8y/n1Krl+Xqil+6y/iavPGC4e8e2kGAokNTa3SxdQ+AGJHNf8lx0iQz2rO+ZFcV1
 mfj1emLd2wQzsBUcb22+qoDytHu+goAxj6q0/faibAQm2Prn3zgKIFGZFDDs6GrKa3wA
 xD1buud3UU341aAHw6OYPI/Cyq1Pnv+C1ZhciYoxF+BeT5f7BI6OTOWxAKMa8Db/gcQu
 gQyw==
X-Gm-Message-State: AA+aEWZpBya8zmdX61l/nXC10gSObznj3LgJaoM6hcX4r2uE+payRdyV
 7R7aPy7OuHTZH0j5cNNxSbL6fWMJ
X-Google-Smtp-Source: AFSGD/XNiKwxZhQMgojlHAU5WoJCKVB4CpXYtfCh30VHdtip1E7sMXQ+vXOujY2spd9NA78GTqCXdw==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr24632242pgm.80.1544109449119; 
 Thu, 06 Dec 2018 07:17:29 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:28 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: papr SCM driver fixes 
Date: Fri,  7 Dec 2018 02:17:07 +1100
Message-Id: <20181206151714.28494-1-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
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

Various bug fixes for the papr_scm driver that were found while bringing
up the PowerVM implementation of the interface. There's a few minor bugs
there were a result of bugs in the original QEMU implementation, a few
due to the memory layouts being different and one due to a change to the
DT bindings.

Mostly self-contained to the driver with the exception of the last patch
which touches the powerpc specific parts of the vmemmap handling.


