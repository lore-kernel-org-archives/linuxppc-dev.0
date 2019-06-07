Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2C1C468BC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 10:34:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073C52080C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nTJyHCcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073C52080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KzQt0grdzDqpq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 20:33:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nTJyHCcx"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KzL95v3czDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 20:29:50 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 45KzL05sW5z9v0N1;
 Fri,  7 Jun 2019 12:29:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nTJyHCcx; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ggd64qK6VA06; Fri,  7 Jun 2019 12:29:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 45KzL04Tc1z9v0N0;
 Fri,  7 Jun 2019 12:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1559903384; bh=QqGs4+5lP3Vvq3GSmi+wNBdAHeaTGhMw0c3zzFsW8Wc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=nTJyHCcxMYGIWLK3fz9FPjhYJq/e3XNx0CksKhElVxpwJ0mnMxNqRwLyATGzrO+/i
 DrCuWxESfbpCqOcCcBi0ucPIhiF5uvcGE27Wtvhbn+tbK35nU9bc773bzPwINa8jGq
 TIKx5+o8TmPHrRWGTnMX92KhW2CRlVw+ikAhNkh0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CD2708B865;
 Fri,  7 Jun 2019 12:29:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sCwL232M5gUW; Fri,  7 Jun 2019 12:29:45 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FE8C8B862;
 Fri,  7 Jun 2019 12:29:45 +0200 (CEST)
Subject: Re: [Bug 203839] Kernel 5.2-rc3 fails to boot on a PowerMac G4 3,6:
 systemd[1]: Failed to bump fs.file-max, ignoring: invalid argument
To: bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <bug-203839-206035@https.bugzilla.kernel.org/>
 <bug-203839-206035-rblwljoM5C@https.bugzilla.kernel.org/>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1ac1091f-e3ad-bff3-8b49-dd895746f51b@c-s.fr>
Date: Fri, 7 Jun 2019 10:29:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bug-203839-206035-rblwljoM5C@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Could you try and revert the following commits ?

38b4564cf042 powerpc/32: don't do syscall stuff in transfer_to_handler
1a4b739bbb4f powerpc/32: implement fast entry for syscalls on BOOKE
b86fb88855ea powerpc/32: implement fast entry for syscalls on non BOOKE

Thanks
Christophe

On 06/07/2019 12:03 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=203839
> 
> --- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
> Created attachment 283139
>    --> https://bugzilla.kernel.org/attachment.cgi?id=283139&action=edit
> kernel .config (5.2-rc3, G4 MDD)
> 
