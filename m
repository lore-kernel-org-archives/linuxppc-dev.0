Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C16C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ACA2082B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="DikgAE9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ACA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438HM14HGDzDqZS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 20:56:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="DikgAE9Z";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::12; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="DikgAE9Z"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438HJ53VhgzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 20:53:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543917231;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=fV6Oq88QW84WgDR4XQNS7Mjr7KzgOPfnxos1rNZEUog=;
 b=DikgAE9ZKhKjG9JctRucJQnxXRpGoIaxRCCDp2ovts3BRYmR1OT6sqsNu8fHcyOuRs
 4LyptXT2Md+ThPGRHdG5qwA+0Fo/QiwLAps1lZbWpDr70e1It4OMg/rwrsZ8Nyq27njD
 it+tO1Vr03ZctAahrG8IkTm7YVph41tcTAkSeM/UzdG3GOiM8drRS641DBCDPP9exvgW
 I3uE9XooioDcSUjOO6TmgGUb8rFdaad6l7Nb0jmyq5aRMhQ9XTeKl7fGxv4zwh//DLBH
 51+5+vqnqswiaRnsrt92UzHbnA2D55MccULSl0nhhEMa++idD80a3qlEZBIMeM3o8CFr
 m+hA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOjkRqsj0YvdYw8SBQvk+g3Fshzw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1027:9d07:f327:cfc7]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uB49reYRW
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 4 Dec 2018 10:53:40 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
Message-ID: <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
Date: Tue, 4 Dec 2018 10:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04 December 2018 at 08:31AM, Christian Zigotzky wrote:
> Hi All,
>
> Could you please test Christoph's kernel on your PASEMI and NXP 
> boards? Download:
>
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>
> Thanks,
> Christian
>
I successfully tested this kernel on a virtual e5500 QEMU machine today.

Command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
uImage-dma -drive 
format=raw,file=MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio -nic 
user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga -device 
virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw es1370 -smp 4

QEMU version 3.1.0.

I don't know why this kernel doesn't recognize the hard disks connected 
to my physical P5020 board and why the onboard ethernet on my PASEMI 
board doesn't work. (dma_direct_map_page: overflow)

-- Christian

