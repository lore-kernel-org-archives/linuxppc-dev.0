Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A72C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 19:44:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5400E20842
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 19:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5400E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43d6WH2wjczDqSN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 06:44:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43d6TZ4Jg9zDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 06:43:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43d6TM1420z9vBmY;
 Sun, 13 Jan 2019 20:43:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 27nKnvwlEY0Z; Sun, 13 Jan 2019 20:43:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43d6TM0S1bz9vBmX;
 Sun, 13 Jan 2019 20:43:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F60E8B786;
 Sun, 13 Jan 2019 20:43:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6JNNLbj4fb6g; Sun, 13 Jan 2019 20:43:08 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F2D8B8B74C;
 Sun, 13 Jan 2019 20:43:07 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
Date: Sun, 13 Jan 2019 20:43:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190113181621.GA22334@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/01/2019 à 19:16, Jonathan Neuschäfer a écrit :
> On Thu, Jan 10, 2019 at 03:11:38PM +0000, Christophe Leroy wrote:
>> The purpose of this serie is to:
>> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 12 for details.)
>> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 14 for a few details.)
> 
> Hi,
> 
> I just tested the whole series on my Wii (I didn't test any intermediate
> steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
> with it, I get the following error while booting:

Argh !

Can you please send the System.map file generated at compile time ?

Thanks
Christophe

> 
>> top of MEM2 @ 13F00000
>>
>> zImage starting: loaded at 0x01000000 (sp: 0x0178afa0)
>> Allocating 0x166b2c8 bytes for kernel...
>> Decompressing (0x00000000 <- 0x01011000:0x01788398)...
>> Done! Decompressed 0xf421f4 bytes
>>
>> Linux/PowerPC load: root=/dev/mmcblk0p2 rootwait console=usbgecko1
>> Finalizing device tree... flat tree at 0x178b7a0
>> [    0.000000] printk: bootconsole [udbg0] enabled
>> [    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x00100000 bytes below 0x00000000.
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00038-g335347fa417f #1337
>> [    0.000000] Call Trace:
>> [    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
>> [    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
>> [    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
>> [    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
>> [    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78
>> [    0.000000] Rebooting in 180 seconds..
> 
> 
> Jonathan
> 
