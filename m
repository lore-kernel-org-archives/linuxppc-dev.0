Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB85C32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 02:15:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987492085B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 02:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987492085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qVQ44dNRzF3GW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 13:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qVMw1bkzzF3Fr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 13:14:04 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gKDJu-0005P8-VU; Tue, 06 Nov 2018 20:11:51 -0600
Message-ID: <6d196807270630668eb91f1448a043bddd43d291.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 06 Nov 2018 20:11:50 -0600
In-Reply-To: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: chzigotzky@xenosoft.de, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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

On Sun, 2018-10-28 at 17:35 +0100, Christian Zigotzky wrote:
> Hello,
> 
> SMP doesn't work anymore with the latest Git kernel (28/10/18 11:12AM 
> GMT) on my P5020 board and on virtual e5500 QEMU machines.
> 
> Board with P5020 dual core CPU:
> 
> [    0.000000] -----------------------------------------------------
> [    0.000000] phys_mem_size     = 0x200000000
> [    0.000000] dcache_bsize      = 0x40
> [    0.000000] icache_bsize      = 0x40
> [    0.000000] cpu_features      = 0x00000003008003b4
> [    0.000000]   possible        = 0x00000003009003b4
> [    0.000000]   always          = 0x00000003008003b4
> [    0.000000] cpu_user_features = 0xcc008000 0x08000000
> [    0.000000] mmu_features      = 0x000a0010
> [    0.000000] firmware_features = 0x0000000000000000
> [    0.000000] -----------------------------------------------------
> [    0.000000] CoreNet Generic board
> 
>      ...
> 
> [    0.002161] smp: Bringing up secondary CPUs ...
> [    0.002339] No cpu-release-addr for cpu 1
> [    0.002347] smp: failed starting cpu 1 (rc -2)
> [    0.002401] smp: Brought up 1 node, 1 CPU
> 
> Virtual e5500 quad core QEMU machine:
> 
> [    0.026394] smp: Bringing up secondary CPUs ...
> [    0.027831] No cpu-release-addr for cpu 1
> [    0.027989] smp: failed starting cpu 1 (rc -2)
> [    0.030143] No cpu-release-addr for cpu 2
> [    0.030304] smp: failed starting cpu 2 (rc -2)
> [    0.032400] No cpu-release-addr for cpu 3
> [    0.032533] smp: failed starting cpu 3 (rc -2)
> [    0.033117] smp: Brought up 1 node, 1 CPU
> 
> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
> /home/christian/Downloads/vmlinux-4.20-alpha4-
> AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-4.20 
> -drive 
> format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,in
> dex=0,if=virtio 
> -nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga 
> -device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw 
> es1370 -smp 4
> 
> .config:
> 
> ...
> CONFIG_SMP=y
> CONFIG_NR_CPUS=4
> ...
> 
> Please test the latest Git kernel on your NXP P50XX boards.

I wasn't able to reproduce this with top-of-tree (commit 8053e5b93eca9b) with
either qemu (e5500 on ppce500) or a hardware t4240.

-Scott

