Return-Path: <SRS0=MUiv=6C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F2C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 08:30:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B5521D82
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 08:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YTZxs//j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B5521D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4945kp7589zDrnD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 18:30:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=YTZxs//j; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4945hv61gqzDrLZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 18:29:03 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4945hp6Yqlz9tyjt;
 Sat, 18 Apr 2020 10:28:58 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YTZxs//j; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vrKjyk7ZXOGw; Sat, 18 Apr 2020 10:28:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4945hp4gl7z9tyjs;
 Sat, 18 Apr 2020 10:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1587198538; bh=Cv9xcT2aNarUu2KPbvEQ/kk1/fAyjgfRlS/UomgKUnw=;
 h=To:Cc:From:Subject:Date:From;
 b=YTZxs//j+oCFBUF9u2rxptftD+pmTlw0wnzEXcNYQtht2O44Tbp6Ns1YwyqRAP0Sc
 2S8dM8vrC2mJIfNqdD1oKeWtaIeQbWZjuxR4PI00nULDCW4KwWToyrZXiuh8DSVthv
 w2GZIox397+mFP0ustIKm/qP1nySpKyFqmzTWXgU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CC9068B772;
 Sat, 18 Apr 2020 10:28:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mkoibPO_wpFm; Sat, 18 Apr 2020 10:28:59 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4768B8B75E;
 Sat, 18 Apr 2020 10:28:59 +0200 (CEST)
To: Segher Boessenkool <segher@kernel.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: How to use "y" constraint in GCC inline powerpc assembly ?
Message-ID: <9fd93f18-652e-c301-f110-d9f07201330d@c-s.fr>
Date: Sat, 18 Apr 2020 08:28:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Segher,

I'd like to use cr instead of gpr to return error condition from 
__get_user().

I saw in GCC doc 
(https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html) that it is 
possible to use "y" as constraint to refer to "Any condition register 
field, cr0…cr7".

I tried the test below, but it fails with "error: impossible register 
constraint in 'asm'"

How does "y" has to be used ?

int test(char *p)
{
	struct {
		int r:1;
	} res = {0};

	asm("crnot %0 * 4 + eq, %0 * 4 + eq": "=&y"(res.r));

	if (res.r)
		return -14;
	return 0;
}

Christophe
