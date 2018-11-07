Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F129AC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 06:49:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C7420862
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 06:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="HnVjVQVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C7420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qcTK6H2qzF3Gq
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="HnVjVQVe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::6; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="HnVjVQVe"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qcQc14bczF3G5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 17:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541573199;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=9rXucP+VydhFZHYYOVC/L4J86dH74YDElhThYk0ss1Y=;
 b=HnVjVQVex79MYK5008gl6NVgcL5h6suQ0Gr3B9V2yIyTkyFQom0fQxBEgWjiEIbRJR
 FhXYOTqMkKA2BmmPSddsaqnEvlxLFFDS49cS7I5jw98hKDlCEbHBNx/9NJEUyIxe9beX
 D0XL9wWD2AsCF59IjMSXiqXVIRCAKqtmUBYetF090vNvz1yKDIQ7Ele3lK8oL8VEqRew
 O6Q6rohYRGAN+vj0+c6jvPVfnpb6MtrGyqVYSdxafGI29xtKlDtXq2MVAUZQro1Qa7jC
 16yy+Xz9thyyPbf8sK4H++ztM0j4GccB1FDbcKalvXb7Ryo90CEMos9dc7B8xAtjSrVX
 bf4A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOj0+/iQYamBVLJFShcRXdnjDmgA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1157:d9dd:1305:fbcc]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cuA76kcohI
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 7 Nov 2018 07:46:38 +0100 (CET)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <6d196807270630668eb91f1448a043bddd43d291.camel@buserror.net>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <31eab5a0-3e24-2e65-8a9d-704dbfcc3319@xenosoft.de>
Date: Wed, 7 Nov 2018 07:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6d196807270630668eb91f1448a043bddd43d291.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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

On 07 November 2018 at 03:11AM, Scott Wood wrote:
> On Sun, 2018-10-28 at 17:35 +0100, Christian Zigotzky wrote:
>> Hello,
>>
>> SMP doesn't work anymore with the latest Git kernel (28/10/18 11:12AM
>> GMT) on my P5020 board and on virtual e5500 QEMU machines.
>>
>> Board with P5020 dual core CPU:
>>
>> [    0.000000] -----------------------------------------------------
>> [    0.000000] phys_mem_size     = 0x200000000
>> [    0.000000] dcache_bsize      = 0x40
>> [    0.000000] icache_bsize      = 0x40
>> [    0.000000] cpu_features      = 0x00000003008003b4
>> [    0.000000]   possible        = 0x00000003009003b4
>> [    0.000000]   always          = 0x00000003008003b4
>> [    0.000000] cpu_user_features = 0xcc008000 0x08000000
>> [    0.000000] mmu_features      = 0x000a0010
>> [    0.000000] firmware_features = 0x0000000000000000
>> [    0.000000] -----------------------------------------------------
>> [    0.000000] CoreNet Generic board
>>
>>       ...
>>
>> [    0.002161] smp: Bringing up secondary CPUs ...
>> [    0.002339] No cpu-release-addr for cpu 1
>> [    0.002347] smp: failed starting cpu 1 (rc -2)
>> [    0.002401] smp: Brought up 1 node, 1 CPU
>>
>> Virtual e5500 quad core QEMU machine:
>>
>> [    0.026394] smp: Bringing up secondary CPUs ...
>> [    0.027831] No cpu-release-addr for cpu 1
>> [    0.027989] smp: failed starting cpu 1 (rc -2)
>> [    0.030143] No cpu-release-addr for cpu 2
>> [    0.030304] smp: failed starting cpu 2 (rc -2)
>> [    0.032400] No cpu-release-addr for cpu 3
>> [    0.032533] smp: failed starting cpu 3 (rc -2)
>> [    0.033117] smp: Brought up 1 node, 1 CPU
>>
>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel
>> /home/christian/Downloads/vmlinux-4.20-alpha4-
>> AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-4.20
>> -drive
>> format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,in
>> dex=0,if=virtio
>> -nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga
>> -device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw
>> es1370 -smp 4
>>
>> .config:
>>
>> ...
>> CONFIG_SMP=y
>> CONFIG_NR_CPUS=4
>> ...
>>
>> Please test the latest Git kernel on your NXP P50XX boards.
> I wasn't able to reproduce this with top-of-tree (commit 8053e5b93eca9b) with
> either qemu (e5500 on ppce500) or a hardware t4240.
>
> -Scott
>
>
Hi Scott,


Thanks for testing but your test was too late because Rob Herring fixed 
this issue last week. [1]


Cheers,

Christian


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c961cb3be9064d1097ccc019390f8b5739daafc6

