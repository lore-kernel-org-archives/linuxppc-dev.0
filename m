Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_A1,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E8FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 16:00:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593A561151
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 593A561151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H87Nl5BX0z2yNT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 02:00:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BjUFbC9I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.171;
 helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=BjUFbC9I; 
 dkim-atps=neutral
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H87MQ2qZRz2xxn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 01:59:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631635156;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:To:Subject:From:Cc:Cc:Date:From:Subject:Sender;
 bh=k9TIbzaI6YCzIIim5KA1yto+Q6vQDBo2qeUwWSXaJAY=;
 b=BjUFbC9IHKRz/mEX/uXthUk4lN1ChBd2iHCRaR8VepJ3H3lAfkD7yK3maQ51RTSZ4D
 Ls3MIruKK2ozwMKjSbxiZp+NrZVrnZHUlv6bZXxVNg9ktcR8CLL/gLgSlr3hL2zEPj8W
 7XSqdxKM99U0Ia3zC9u0ljpuv0OUlD89jBqLZEy4DoehYIqy9raC92Dmg8KAP5ASiJkV
 j6pFMkJR8RSL0Jvm1jsmb3uoq/XLdHrruKDxpSdH48ew8pIKqqNzuOPv5gbuNIs6LStP
 tGv4H3WlWFzEnk7afaSEF4m5Xw5lh4u/5KG8LUvA2or7FeAwhsRDsxNfHN+KGej8Q22h
 G+2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhQJ6mmIg736XZSO7Y3Xb2NMPx2Lg=="
X-RZG-CLASS-ID: mo00
Received: from Christians-iMac.fritz.box by smtp.strato.de (RZmta 47.33.3 AUTH)
 with ESMTPSA id a03989x8EFxEFP3
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 14 Sep 2021 17:59:14 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to, KVM_MAX_VCPU_IDS
To: Juergen Gross <jgross@suse.com>
Message-ID: <6d3333b1-05cc-103b-4bdb-88bec5e3e9fd@xenosoft.de>
Date: Tue, 14 Sep 2021 17:59:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
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
Cc: x86@kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 mad skateman <madskateman@gmail.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Darren Stevens <darren@stevens-zone.net>, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Joerg Roedel <joro@8bytes.org>, "Huacai Chen, " <chenhuacai@kernel.org>,
 "Aleksandar Markovic, " <aleksandar.qemu.devel@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 kvm-ppc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jim Mattson <jmattson@google.com>, "Thomas Bogendoerfer,
 " <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Vitaly, Kuznetsov" <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Juergen,
Hello All,

Since the RC1 of kernel 5.13, -smp 2 and -smp 4 don't work with a 
virtual e5500 QEMU KVM-HV machine anymore. [1]
I see in the serial console, that the uImage doesn't load. I use the 
following QEMU command for booting:

qemu-system-ppc64 -M ppce500 -cpu e5500 -enable-kvm -m 1024 -kernel 
uImage -drive format=raw,file=MintPPC32-X5000.img,index=0,if=virtio 
-netdev user,id=mynet0 -device virtio-net,netdev=mynet0 -append "rw 
root=/dev/vda" -device virtio-vga -device virtio-mouse-pci -device 
virtio-keyboard-pci -device pci-ohci,id=newusb -device 
usb-audio,bus=newusb.0 -smp 4

The kernels boot without KVM-HV.

Summary for KVM-HV:

-smp 1 -> works
-smp 2 -> doesn't work
-smp 3 -> works
-smp 4 -> doesn't work

I used -smp 4 before the RC1 of kernel 5.13 because my FSL P5040 BookE 
machine [2] has 4 cores.

Does this patch solve this issue? [3]

Thanks,
Christian

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-May/229103.html
[2] http://wiki.amiga.org/index.php?title=X5000
[3] 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-September/234152.html
