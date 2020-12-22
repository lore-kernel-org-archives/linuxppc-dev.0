Return-Path: <SRS0=Rflt=F2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00EDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9922313C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9922313C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0cgN64SpzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:31:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0cHh0vzSzDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2020 00:14:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=LT3Esv19; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4D0cHf3dGJz9sTg;
 Wed, 23 Dec 2020 00:14:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1608642862;
 bh=0sBoTvAiTmdiIm5MUkK6srFJXpCmJYMR0XbrbVjDNtg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LT3Esv193n+QhCyyXiTNOHitvKX4zqavfAzaJ3PRolXjaae6q3TmhtwkyTq9PkSMz
 1iNkQ6vuyHZECj876ws9SdrYCQOKOhAfo1bJ0O87PUFJ/HJfvxzp/mKKSd6oIpgWs2
 K2b3ZQzBZso6ZlPQiP3XtnoDsIdVLixsioEkVqrSclGlhZOBbg70SXuPorH2S0p886
 Dz8109DhN09UT0hQ/c/wFgPpxmCMea/Lyzt7sgnQdxDZ/PeJyE2Uc3duf3eU+Ej4GW
 Sbw+JKrcy78X12IKZc7qMkXLfipebz4sZZ5TO9biCq8i5n6WR6XfgTryIgb4BrXUoJ
 aiLShoAi4eWzg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: GIT kernel with the PowerPC updates 5.11-1 doesn't boot on a FSL
 P5040 board and in a virtual e5500 QEMU machine
In-Reply-To: <8d25f58b-a7bf-4413-b8cc-ed3bd0107263@xenosoft.de>
References: <a546bc22-1e18-8e71-e973-65cf7095594a@xenosoft.de>
 <CAOJe8K3+j3kGHYhSfjyywXcSQFca0Y370LiAa2uVsW5znUPsAA@mail.gmail.com>
 <ad682b81-60f6-4e13-46f4-39539de2be72@xenosoft.de>
 <7543ec1a-005d-f868-5607-448baaccb88a@csgroup.eu>
 <8d25f58b-a7bf-4413-b8cc-ed3bd0107263@xenosoft.de>
Date: Wed, 23 Dec 2020 00:14:20 +1100
Message-ID: <87lfdq6l03.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
...
> Download: http://www.xenosoft.de/MintPPC32-X5000.tar.gz (md5sum: 
> b31c1c1ca1fcf5d4cdf110c4bce11654) The password for both 'root' and 
> 'mintppc' is 'mintppc'.
...
>
> QEMU command without KVM on macOS Intel: qemu-system-ppc64 -M ppce500 
> -cpu e5500 -m 1024 -kernel uImage -drive 
> format=raw,file=MintPPC32-X5000.img,index=0,if=virtio -netdev 
> user,id=mynet0 -device virtio-net-pci,netdev=mynet0 -append "rw 
> root=/dev/vda" -device virtio-vga -usb -device usb-ehci,id=ehci -device 
> usb-tablet -device virtio-keyboard-pci -smp 4 -vnc :1

I was able to boot the above (on powerpc, but not using KVM), using my
fixes branch.

Please give that branch a test:
  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=fixes


cheers
