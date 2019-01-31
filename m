Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 12:51:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A3A2086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 12:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="PmQ8PR2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A3A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r0Vf2tC0zDqcb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 23:51:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::6; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="PmQ8PR2j"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r0R90hXnzDqSH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 23:48:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548938925;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=EqQYlxpU6mBYE+dw1eVkplvtBBO9xJm9m5wbjwiYkAw=;
 b=PmQ8PR2ju/XDRqgOFuWDG+UgJJ3pMgjmt1E6Gj9GMleqPRDG8aLUY+X9olQXvTqDs0
 JL17oE/CeYjYaOpH6XXLr73iw6mQrrBrZQGR4LvB4sKW1DURqna9UQe3dofOuTFhm5qz
 me62/lCLcsoSmQxFdyb46FKUntpBfWJ99QCfYHIoLRzy3rhgDFW3FKRbwho0V4rvFDvT
 WyjpagXKtNc4l+mZAe6M41JJvnZAxdKEOF/Ez7Y0j4WcSOYfI+98D7TR2FxqhEZ8a6nm
 LJL+AMux6LyXoxGongfBw1NGup/TSE/oq6NacC0k7B3R6Gw86iYV9au52Nuh7vYhjW3z
 rq2Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Clbj7FgaTSY4jzuFv3SP8KtXZNiDQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:d119:512c:5b90:22aa]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0VCmRObC
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 31 Jan 2019 13:48:27 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
Message-ID: <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
Date: Thu, 31 Jan 2019 13:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
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

I compiled kernels for the X5000 and X1000 from your branch 
'powerpc-dma.6' today.

Gitweb: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet 
doesn't work.

Error messages (X1000):

[   17.371736] pci 0000:00:1a.0: overflow 0x00000002691bf802+1646 of DMA 
mask ffffffff bus mask 0
[   17.371760] WARNING: CPU: 0 PID: 2496 at kernel/dma/direct.c:43 
.dma_direct_map_page+0x11c/0x200
[   17.371762] Modules linked in:
[   17.371769] CPU: 0 PID: 2496 Comm: NetworkManager Not tainted 
5.0.0-rc4-3_A-EON_AmigaOne_X1000_Nemo-54580-g8d7a724-dirty #2
[   17.371772] NIP:  c00000000010395c LR: c000000000103a30 CTR: 
c000000000726f70
[   17.371775] REGS: c00000026900e9a0 TRAP: 0700   Not tainted 
(5.0.0-rc4-3_A-EON_AmigaOne_X1000_Nemo-54580-g8d7a724-dirty)
[   17.371777] MSR:  9000000000029032 <SF,HV,EE,ME,IR,DR,RI> CR: 
24002222  XER: 20000000
[   17.371786] IRQMASK: 0
                GPR00: c000000000103a30 c00000026900ec30 
c000000001923f00 0000000000000052
                GPR04: c00000026f206778 c00000026f20d458 
0000000000000000 0000000000000346
                GPR08: 0000000000000007 0000000000000000 
0000000000000000 0000000000000010
                GPR12: 0000000022002444 c000000001b10000 
0000000000000000 0000000000000000
                GPR16: 0000000010382410 0000000000000000 
0000000000000000 c00000026bd9d820
                GPR20: 0000000000000000 c00000026919c000 
0000000000000000 0000000000000000
                GPR24: 0000000000000800 c000000269190000 
c0000002692a4180 c000000269190000
                GPR28: c000000277ada1c8 000000000000066e 
c00000026d3c68b0 0000000000000802
[   17.371823] NIP [c00000000010395c] .dma_direct_map_page+0x11c/0x200
[   17.371827] LR [c000000000103a30] .dma_direct_map_page+0x1f0/0x200
[   17.371829] Call Trace:
[   17.371833] [c00000026900ec30] [c000000000103a30] 
.dma_direct_map_page+0x1f0/0x200 (unreliable)
[   17.371840] [c00000026900ecd0] [c00000000099b7ec] 
.pasemi_mac_replenish_rx_ring+0x12c/0x2a0
[   17.371846] [c00000026900eda0] [c00000000099dc64] 
.pasemi_mac_open+0x384/0x7c0
[   17.371853] [c00000026900ee40] [c000000000c6f484] .__dev_open+0x134/0x1e0
[   17.371858] [c00000026900eee0] [c000000000c6f9ec] 
.__dev_change_flags+0x1bc/0x210
[   17.371863] [c00000026900ef90] [c000000000c6fa88] 
.dev_change_flags+0x48/0xa0
[   17.371869] [c00000026900f030] [c000000000c8c88c] .do_setlink+0x3dc/0xf60
[   17.371875] [c00000026900f1b0] [c000000000c8dd84] 
.__rtnl_newlink+0x5e4/0x900
[   17.371880] [c00000026900f5f0] [c000000000c8e10c] .rtnl_newlink+0x6c/0xb0
[   17.371885] [c00000026900f680] [c000000000c89838] 
.rtnetlink_rcv_msg+0x2e8/0x3d0
[   17.371891] [c00000026900f760] [c000000000cc0f90] 
.netlink_rcv_skb+0x120/0x170
[   17.371896] [c00000026900f820] [c000000000c87318] 
.rtnetlink_rcv+0x28/0x40
[   17.371901] [c00000026900f8a0] [c000000000cc03f8] 
.netlink_unicast+0x208/0x2f0
[   17.371906] [c00000026900f950] [c000000000cc09a8] 
.netlink_sendmsg+0x348/0x460
[   17.371911] [c00000026900fa30] [c000000000c38774] .sock_sendmsg+0x44/0x70
[   17.371915] [c00000026900fab0] [c000000000c3a79c] 
.___sys_sendmsg+0x30c/0x320
[   17.371920] [c00000026900fca0] [c000000000c3c3b4] 
.__sys_sendmsg+0x74/0xf0
[   17.371926] [c00000026900fd90] [c000000000cb4da0] 
.__se_compat_sys_sendmsg+0x40/0x60
[   17.371932] [c00000026900fe20] [c00000000000a21c] system_call+0x5c/0x70
[   17.371934] Instruction dump:
[   17.371937] 60000000 f8610070 3d20ffff 6129fffe 79290020 e8e70000 
7fa74840 409d00b8
[   17.371946] 3d420001 892acb59 2f890000 419e00b8 <0fe00000> 382100a0 
3860ffff e8010010
[   17.371954] ---[ end trace a81f3c344f625f76 ]---
[   17.396654] IPv6: ADDRCONF(NETDEV_UP): enp0s20f3: link is not ready

--------

Additionally, Xorg doesn't start on a virtual e5500 QEMU machine 
anymore. I tested with the following QEMU command:

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
/home/christian/Downloads/vmlinux-5.0-rc4-3-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-5.0 
-drive 
format=raw,file=/home/christian/Downloads/Fienix-Beta120418.img,index=0,if=virtio 
-nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga 
-device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw 
es1370 -smp 4

Cheers,
Christian


On 30 January 2019 at 05:40AM, Christian Zigotzky wrote:
> Hi Christoph,
>
> Thanks a lot for the updates. I will test the full branch tomorrow.
>
> Cheers,
> Christian
>
> Sent from my iPhone
>
>> On 29. Jan 2019, at 17:34, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Tue, Jan 29, 2019 at 05:14:11PM +0100, Christoph Hellwig wrote:
>>>> On Tue, Jan 29, 2019 at 04:03:32PM +0100, Christian Zigotzky wrote:
>>>> Hi Christoph,
>>>>
>>>> I compiled kernels for the X5000 and X1000 from your new branch
>>>> 'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi Ethernet
>>>> works!
>>> Thanks for testing!  I'll prepare a new series that adds the other
>>> patches on top of this one.
>> And that was easier than I thought - we just had a few patches left
>> in powerpc-dma.6, so I've rebased that branch on top of
>> powerpc-dma.6-debug.2:
>>
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>
>> I hope the other patches are simple enough, so just testing the full
>> branch checkout should be fine for now.


