Return-Path: <SRS0=rTx2=YM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C849CCA9EAC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Oct 2019 16:49:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C95F20869
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Oct 2019 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gKiPiwJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46wTPs24jdzDqRJ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Oct 2019 03:49:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46wTMh0nk4zDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Oct 2019 03:47:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="gKiPiwJk"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46wTMg2g0qz8tTr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Oct 2019 03:47:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 46wTMg26Wyz9sPJ; Sun, 20 Oct 2019 03:47:11 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="gKiPiwJk"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46wTMc3d36z9sNx
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Oct 2019 03:47:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46wTMQ17kCz9vBLG;
 Sat, 19 Oct 2019 18:46:58 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=gKiPiwJk; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jMAOFNygB_kl; Sat, 19 Oct 2019 18:46:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46wTMP6sPmz9vBLB;
 Sat, 19 Oct 2019 18:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1571503618; bh=wizkMiHMuhK5/UDdy6nlAVvpOVhaRPZ0QF0ozudsClg=;
 h=To:From:Cc:Subject:Date:From;
 b=gKiPiwJk78W0O9Q1D7KxvFtE29fs5+WFnQJn1CNRHVtJcwcYirneBbluIQTZ6IAKa
 vOSUUPGnQ6elJo7dgU9MeYURMBofy7hVRpM8M7GDHChGj7vTSDdls/y3QoR6j+KZRy
 4uZ+PURBNcDLWzrRxRtRvmxRAaWMkQ/8W+YYuJZE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 936498B862;
 Sat, 19 Oct 2019 18:46:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qvBoyfVR2ooa; Sat, 19 Oct 2019 18:46:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 46D0C8B85F;
 Sat, 19 Oct 2019 18:46:59 +0200 (CEST)
To: Nathan Lynch <nathanl@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: passing NULL to clock_getres (VDSO): terminated by unexpected signal
 11
Message-ID: <0fc22a08-31d9-e4d1-557e-bf5b482a9a20@c-s.fr>
Date: Sat, 19 Oct 2019 18:46:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nathan,

While trying to switch powerpc VDSO to C version of gettimeofday(), I'm 
getting the following kind of error with vdsotest:

passing NULL to clock_getres (VDSO): terminated by unexpected signal 11

Looking at commit a9446a906f52 ("lib/vdso/32: Remove inconsistent NULL 
pointer checks"), it seems that signal 11 is expected when passing NULL 
pointer.

Any plan to fix vdsotest ?

Thanks
Christophe
