Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58AC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 04:57:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C8E61041
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 04:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C8E61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZ6z127ktz2yjK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 14:57:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZ6yY0Lrkz2xxp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 14:57:05 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FZ6yQ4TVnz9sVS;
 Tue,  4 May 2021 06:57:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYtrN8i6KVvp; Tue,  4 May 2021 06:57:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FZ6yQ3HzWz9sVR;
 Tue,  4 May 2021 06:57:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C20AE8B78B;
 Tue,  4 May 2021 06:57:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bqB3rxvuS9iN; Tue,  4 May 2021 06:57:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E3E238B763;
 Tue,  4 May 2021 06:56:58 +0200 (CEST)
Subject: Re: [FSL P50x0] Xorg always restarts again and again after the the
 PowerPC updates 5.13-1
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <c5b0ac7c-525f-0208-7587-c90427eae137@xenosoft.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0886c1dc-e946-69cb-a0a9-57247acfd080@csgroup.eu>
Date: Tue, 4 May 2021 06:56:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c5b0ac7c-525f-0208-7587-c90427eae137@xenosoft.de>
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
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/05/2021 à 00:25, Christian Zigotzky a écrit :
> Hello,
> 
> Xorg always restarts again and again after the the PowerPC updates 5.13-1 [1] on my FSL P5040 Cyrus+ 
> board (A-EON AmigaOne X5000) [2]. Xorg doesn't start anymore in a virtual e5500 QEMU machine [3].
> 
> I bisected today [4].
> 
> Result: powerpc/signal32: Convert do_setcontext[_tm]() to user access block 
> (887f3ceb51cd34109ac17bfc98695162e299e657) [5] is the first bad commit.
> 
> Please find attached the kernel config.
> 
> Please check the first bad commit.

I'm not sure you can conclude anything here. There is a problem in that commit, but it is fixed by 
525642624783 ("powerpc/signal32: Fix erroneous SIGSEGV on RT signal return") which is the last 
commit of powerpc-5.13-1.

So any bisect from there will for sure point to 887f3ceb51cd ("powerpc/signal32: Convert 
do_setcontext[_tm]() to user access block") but that's unconclusive. If the problem is still there 
at the HEAD of powerpc-5.13-1, the problem is likely somewhere else.

I think you need to do the bisect again with a cherry-pick of 525642624783 at each step.

Thanks
Christophe


> 
> Thanks,
> Christian
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c70a4be130de333ea079c59da41cc959712bb01c 
> 
> [2] http://wiki.amiga.org/index.php?title=X5000
> [3] qemu-system-ppc64 -M ppce500 -cpu e5500 -m 1024 -kernel uImage -drive 
> format=raw,file=fedora28-2.img,index=0,if=virtio -netdev user,id=mynet0 -device 
> virtio-net-pci,netdev=mynet0 -append "rw root=/dev/vda" -device virtio-vga -usb -device 
> usb-ehci,id=ehci -device usb-tablet -device virtio-keyboard-pci -smp 4 -vnc :1
> [4] https://forum.hyperion-entertainment.com/viewtopic.php?p=53101#p53101
> [5] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=887f3ceb51cd34109ac17bfc98695162e299e657 
> 
