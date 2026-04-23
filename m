Return-Path: <linuxppc-dev+bounces-20016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C89FDEE29
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 16:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1j1G1PPnz2y2B;
	Fri, 24 Apr 2026 02:56:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.169 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776963410;
	cv=pass; b=Jrt7dgy4VfCgjBYv6AYgMMPjyZHSfQYVh3zF+g5YB3MYv+l/0hNxqKOK6bMmHh3BbOcM3r22WIyYW3sM6zW6OMiCYyMi/3hU67HL3P3ayRckL/ZVg8FPLjvwxG37lp0eiy9RneN2wJsNBg1+E1FNkb2g46pCbMy5AqOERh6s2nNhzTiwwvJy7bCf9sQ1Loo1316nqp+BQKZ0bXUtL2T/EKHG4XVhZ0F68A+XVnGiwHuRsgUIzluOjW9FchJiPQ0B0Uc5Ap8w6MI880RbMzf1YUQGoBsJVCxmr8jRW0AijXlor4+LUhtW09BocerKDN7zmz1RU0EPoGV/KKNKHACixw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776963410; c=relaxed/relaxed;
	bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JeFb7pPT/K/6tW8zTbZLZgJCJEKeCrXXh49qsPEPgxzJSWDGApOudh0NBTcNhxwKcYqelNfkroZ3nUfYw0kPQ6cNH/7jyw+h4n/MHXW1F0yUW01wRlusiUNOJltC8XX56/Cf8F+lyvCifuOWToLxQGetY+3qZ2r8WpdmqpLha2oZKdvaP3fVgbCQmYrBJQ3ciQmHnZJrF6GS0UMNWglH5PAarQhmjz9r8pKONdz3Dxi/Y5+CUAk8ZxDJJFL+kKb7H7ZWPmvloNLeEcEe1oPy/uVndH4Wy1o5Q5gaVP3iiBUFb4dh/EYR4/AuHqWu8H+MJNniU7uJZb0NAZXWQDJ2kA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a9HAa0+W; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RSbtY0TT; dkim-atps=neutral; spf=pass (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a9HAa0+W;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RSbtY0TT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 358 seconds by postgrey-1.37 at boromir; Fri, 24 Apr 2026 02:56:44 AEST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1j186l8qz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 02:56:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776963038; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JOb3Y4qgRrupDvb8beHEpK0m8hfhZiWF4x3PMMEEf0Qh2utt4dCOKrOFtgvV0bY1Uv
    pImMeOX0Ew+Fp2fzIzvZlFkGo6WfFSIO57A8/Wgi83X0LpMTvVLBJYjb+Xg9NnJadLyR
    eRaPYHtVGenKtbdx9YarDJmsFKqKu/Ai4qy8rKo2My6bh4kuoh8legm8yStemBm2RTv8
    pz4/OkvYZIE6wAZEzCaBbrGcr3/0PXSHFqJXEnC78G0hLDtOsbc+gnjBTWPUg/+c0rtc
    NSQ9qBcQADQ/p/O/WuVDMBf6pi5CqCGk30d0aOaeP0oTgsIo5iLtqx4y1d5O+nRIp02J
    Y1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=Urrqm/PaR14GAUmfgSjf8G48s+sxBNbSU1tUKp94QLHN369EVI2zl7J3LH8CgK5JjP
    TB8imSZTr7gJQ+cIAYSRSJqmE9gcGOnaREwSFXClbab/HCD1UJ1wn+1fej1lpVpRrJwv
    0e61v111smD9HlI7HPcwlseSQEIhZwbmgEeC64L/cx+2K2uAOP0Xu7SzBAxImBy37zJp
    uitft8PieRE5gHLqpUZc/bGfQzk9JwOAt88xrkNMllGRnknUyoOhT67mkMQ9i4wS+Ujn
    Hd+/siGuxqGwLrhZ7rAX+iCzU1Cz1MEPi345irNIeGB/Z3FxNK8AaAOY/2tPbw69GOjz
    HZEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=a9HAa0+Wcj7tqtYx/0bCyojw/Lc4HGmELzrwOXxWNtsMwSnNKQadqLPfzRytm4D4Pn
    R8VYj4QcypygIG/2s2KXkpILbMhProUV7jdtfpu1spVhdaNf0t7b0+gpmEYtb9k1P8yq
    8NiF3mO97svl+YgPPY9ci80cb4nU3i+YpSVqlurg88/LUGz6p4g7F+LTexAi7nwwXCrq
    N45S4T9Ujlt5mbVJj7XD/v+7kTHqu9zNZZCb8swHyWJBgcnzBtKmPRuRwlzPLqvlDZTo
    v3k6W9RTWoPukITquKPkEac1vloYktGcAnQbfqjk8i761JQzRH7nbS/buneOgKp41abN
    RidQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=RSbtY0TTooAYupA587BNWSzYV33lzVqJPLOnfs3xPDbNjEYyrTkqaKjPoE2W55568b
    Rn/uRvQDgMiuI0LvF+AA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l5B/g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id e7876023NGocuXi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 23 Apr 2026 18:50:38 +0200 (CEST)
Subject: KVM-PR no longer works when compiled with new GCC compilers
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
Date: Thu, 23 Apr 2026 18:50:37 +0200
X-Mailer: BrassMonkey/34.1.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/25 08:37, Christian Zigotzky wrote:
> Hello,
>
> KVM-PR (-enable-kvm) doesn't work anymore on our PA Semi Nemo boards 
> [1] if we compiled it with new GCC compilers.
> The VM can't boot. There aren't any messages on the serial console of 
> QEMU.
>
> It boots without KVM-PR.
>
> Kernel config with new GCC compiler [2]:
>
> - CONFIG_CC_VERSION_TEXT="powerpc64-suse-linux-gcc (SUSE Linux) 11.5.0"
> - CONFIG_TARGET_CPU="power4"
> - CONFIG_TUNE_CPU="-mtune=power10"
>
> It works if I compile it with an old GCC compiler [3]:
>
> - CONFIG_CC_VERSION_TEXT="powerpc-linux-gnu-gcc (Ubuntu 
> 9.4.0-1ubuntu1~20.04.1) 9.4.0"
> - CONFIG_TARGET_CPU="power4"
> - CONFIG_TUNE_CPU="-mtune=power9"
>
> Mtune changes to power9 automatically if I compiled it with an old GCC 
> compiler. If I compile it with a new GCC compiler again it changes 
> automatically to mtune=power10.
>
> Is mtune the reason of the KVM-PR issue? I think the issue is the new 
> GCC. [4]
>
> Could you please check whether KVM-PR is compatible with new versions 
> of GCC compilers?
>
> Thanks in advance,
>
> Christian
>
>
>
> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>
> [2] 
> https://github.com/chzigotzky/kernels/blob/45186997e6f347fd092f9ab629d62d6041426227/configs/x1000_defconfig
>
> [3] 
> https://github.com/chzigotzky/kernels/blob/bc7a3e27b3fcdee52a8135435f02cf807a43872a/configs/x1000_defconfig
>
> [4] KVM-PR no longer works on an X1000 if the kernel has been compiled 
> with a new GCC: 
> https://forum.hyperion-entertainment.com/viewtopic.php?p=57146#p57146
>
Error messages (kvm-pr compiled with powerpc64-linux-gnu-gcc 14.1.1 
20240507 Red Hat Cross 14.1.1-1, GNU ld version 2.41-2.el10_0):

[  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)

-- 
Sent with BrassMonkey 34.1.0 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.1.0)


