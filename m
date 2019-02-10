Return-Path: <SRS0=nti5=QR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E1C282C2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 12:03:44 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A416621841
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="bgcg5grf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A416621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43y6yM5kZKzDqL4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 23:03:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::8; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="bgcg5grf"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43y6v36ZQ4zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 23:00:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549800039;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=n33DcogtNyDZz6kzk6IjadlOjeDlmA/nSiofmi/mng4=;
 b=bgcg5grf7sQ4H+FaunPvQaJYpkj13arzCoUGtGpQAELek0RIGfyJ3whRoCutEef0t0
 bwn69ABpQkEK5wsKT3naDkKjcyeKGIa10hsPprW950WrDSL3b07/4EMHUiXspKEKh3Hi
 zAsMR5X70iS5TidGGvkY9pRznqZUV5LmHQ12nZTeZ0hjHjZfAva+tyNK8bg2pGppFWmn
 e2vmiGaR5/KQPRXoSGiNkkdVjsAn2I5qip7HxiD+ArbL4rdnxo0a3RIhxjGYG8xKTR55
 s4gU8YiNjtcibARIQK42y1UPVkf+355nX051zklWAf3Tk2iB5TWadF10nyCU0wryRofg
 zPrg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CleiqvAq6ZQABFXwQhWphfFlPh+VA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:a4a8:a1be:d22f:cc48]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv1AC0KDeL
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sun, 10 Feb 2019 13:00:20 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
Date: Sun, 10 Feb 2019 13:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208091818.GA23491@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On 08 February 2019 at 10:18AM, Christoph Hellwig wrote:
> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
> Thanks a lot once again for testing!
>
> Now can you test with this patch and the whole series?
>
> I've updated the powerpc-dma.6 branch to include this fix.
>
I tested the whole series today. The kernels boot and the P.A. Semi 
Ethernet works! :-) Thanks a lot!

I also tested it in a virtual e5500 QEMU machine today. Unfortunately 
the kernel crashes.

Log:

[   54.624330] BUG: Unable to handle kernel data access at 
0xc06c008a0013014a
[   54.625640] Faulting instruction address: 0xc000000000027e7c
[   54.626140] Oops: Kernel access of bad area, sig: 11 [#1]
[   54.626456] BE SMP NR_CPUS=4 QEMU e500
[   54.626876] Modules linked in:
[   54.627284] CPU: 1 PID: 1876 Comm: systemd-journal Not tainted 
5.0.0-rc5-DMA_A1-X5000-54581-gda1d065-dirty #1
[   54.627819] NIP:  c000000000027e7c LR: c0000000000b5264 CTR: 
0000000000000000
[   54.628173] REGS: c00000007ffeb700 TRAP: 0300   Not tainted 
(5.0.0-rc5-DMA_A1-X5000-54581-gda1d065-dirty)
[   54.628607] MSR:  0000000080009000 <EE,ME>  CR: 44008486 XER: 00000000
[   54.629023] DEAR: c06c008a0013014a ESR: 0000000000800000 IRQMASK: 0
[   54.629023] GPR00: 0000000000005254 c00000007ffeb990 c0000000016b2000 
c06c008a0013014a
[   54.629023] GPR04: c00000007c54f8c0 0000000000000058 0000000000000006 
0000000000000000
[   54.629023] GPR08: 0000000000000000 000000007c54f8c0 006c008a0013014a 
c00000007c86c000
[   54.629023] GPR12: 0000000028002482 c00000003ffff8c0 0000000000000000 
c000000078dfaa70
[   54.629023] GPR16: c000000078366c00 0000000000000000 000000000000005e 
0000000000000000
[   54.629023] GPR20: 0000000000000000 c00000007c54f8c0 0000000000000007 
c000000078dfa000
[   54.629023] GPR24: 0000000000000000 0000000000000047 0000000000000000 
80000000003f6470
[   54.629023] GPR28: c00000007928d470 c000000078801dc0 000000000000005e 
c000000078dfa7c0
[   54.632572] NIP [c000000000027e7c] .memcpy+0x1fc/0x288
[   54.632886] LR [c0000000000b5264] .swiotlb_tbl_sync_single+0xb0/0xe4
[   54.633221] Call Trace:
[   54.633513] [c00000007ffeb990] [c00000007ffeba70] 0xc00000007ffeba70 
(unreliable)
[   54.633988] [c00000007ffeba00] [c0000000000b41e4] 
.dma_direct_sync_single_for_cpu+0x58/0x6c
[   54.634436] [c00000007ffeba70] [c000000000788da4] 
.e1000_clean_rx_irq+0x1bc/0x4c8
[   54.634857] [c00000007ffebb90] [c00000000078667c] 
.e1000_clean+0x714/0x8d4
[   54.635263] [c00000007ffebcc0] [c000000000a3f15c] 
.net_rx_action+0x11c/0x2a4
[   54.635712] [c00000007ffebdb0] [c000000000c48c20] 
.__do_softirq+0x150/0x2a8
[   54.636211] [c00000007ffebeb0] [c000000000064184] .irq_exit+0x6c/0xc4
[   54.636533] [c00000007ffebf20] [c000000000004124] .__do_irq+0x80/0x94
[   54.636985] [c00000007ffebf90] [c00000000000eca0] .call_do_irq+0x14/0x24
[   54.637371] [c00000007c86fd80] [c0000000000041c0] .do_IRQ+0x88/0xc4
[   54.637737] [c00000007c86fe20] [c000000000012920] 
exc_0x500_common+0xd8/0xdc
[   54.638104] Instruction dump:
[   54.638451] e861fff8 4e800020 7cd01120 7ca62850 38e00000 28a50010 
409f0010 88040000
[   54.638887] 98030000 38e70001 409e0010 7c07222e <7c071b2e> 38e70002 
409d000c 7c07202e
[   54.639594] ---[ end trace a4861de7e4c199f7 ]---
[   54.639873]
[   55.640484] Kernel panic - not syncing: Aiee, killing interrupt handler!
[   55.641556] Rebooting in 180 seconds..

-----

I tested with the following QEMU commands:

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048  -nographic -kernel 
/home/christian/Downloads/vmlinux-5.0-rc5-2-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-5.0 
-nic user,model=e1000 -drive 
format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio 
-append "rw root=/dev/vda" -smp 4

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
/home/christian/Downloads/vmlinux-5.0-rc5-2-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-5.0 
-drive 
format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio 
-nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga 
-device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw 
es1370 -smp 4

The RC5 of kernel 5.0 boots without any problems in this virtual machine.

Cheers,
Christian

