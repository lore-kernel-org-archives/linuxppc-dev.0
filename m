Return-Path: <SRS0=0kbc=FX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C3C4361B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 06:51:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BA223A82
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 06:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BA223A82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cybwj5Bz8zDqb1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 17:51:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cybv46ZVNzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2020 17:49:32 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Cybtr5RPRz9vBmg;
 Sat, 19 Dec 2020 07:49:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7Ve97Cjsox_2; Sat, 19 Dec 2020 07:49:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Cybtr2wDLz9vBmf;
 Sat, 19 Dec 2020 07:49:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C2458B75B;
 Sat, 19 Dec 2020 07:49:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TKWO6ylO7YgG; Sat, 19 Dec 2020 07:49:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1563E8B78A;
 Sat, 19 Dec 2020 07:49:24 +0100 (CET)
Subject: Re: GIT kernel with the PowerPC updates 5.11-1 doesn't boot on a FSL
 P5040 board and in a virtual e5500 QEMU machine
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Denis Kirjanov <kda@linux-powerpc.org>
References: <a546bc22-1e18-8e71-e973-65cf7095594a@xenosoft.de>
 <CAOJe8K3+j3kGHYhSfjyywXcSQFca0Y370LiAa2uVsW5znUPsAA@mail.gmail.com>
 <ad682b81-60f6-4e13-46f4-39539de2be72@xenosoft.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7543ec1a-005d-f868-5607-448baaccb88a@csgroup.eu>
Date: Sat, 19 Dec 2020 07:49:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ad682b81-60f6-4e13-46f4-39539de2be72@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/12/2020 à 23:49, Christian Zigotzky a écrit :
> On 18 December 2020 at 10:25pm, Denis Kirjanov wrote:
>  >
>  >
>  > On Friday, December 18, 2020, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>  >
>  >     Hello,
>  >
>  >     I compiled the latest Git kernel with the new PowerPC updates 5.11-1 [1] today. Unfortunately 
> this kernel doesn't boot on my FSL P5040 board [2] and in a virtual e5500 QEMU machine [3].
>  >
>  >     I was able to revert the new PowerPC updates 5.11-1 [4] and after a new compiling, the kernel 
> boots without any problems on my FSL P5040 board.
>  >
>  >     Please check the new PowerPC updates 5.11-1.
>  >
>  >
>  > Can you bisect the bad commit?
>  >
> Hello Denis,
> 
> I have bisected [5] and d0e3fc69d00d1f50d22d6b6acfc555ccda80ad1e (powerpc/vdso: Provide 
> __kernel_clock_gettime64() on vdso32) [6] is the first bad commit.
> 
> I was able to revert this bad commit and after a new compiling, the kernel boots without any problems.

That's puzzling.

Can you describe the symptoms exactly ? What do you mean by "the kernel doesn't boot" ? Where and 
how does it stops booting ?

This commit only adds a new VDSO call, for getting y2038 compliant time. At the time I implemented 
it there was no libc using it yet. Is your libc using it ?

Where can I find all the elements you are using to boot with QEMU ? Especially the file 
MintPPC32-X5000.img

Can you also share you kernel config

Thanks
Christophe
