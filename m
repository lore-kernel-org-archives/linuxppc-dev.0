Return-Path: <linuxppc-dev+bounces-26611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197F2C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 18:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hch4d0mh6z2yv2;
	Sun, 06 Sep 2026 04:02:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788631345;
	cv=none; b=ZfffqRpA6wio5TeuW0nLlPkeK6wzsuBzQct7jmtZVe/wlsns6Li/6p1tvJ2FWf6OOAqugr42AFOMMo2CnWnPW6NGeenAoP2haB/mSZktPrT3n1yJFqqmmMFNsZ2dCYdRlsPjGiE3xdHI3k9iE2MHasxGuZ8e3XtL3v/1C24QJy3hJ1tvHN6JEvLB1zLuQbriTSFa4HsKJ4BtRRwn5oWUl+BiWaS7qdoFgtBI54z3deqHdnQPkpkDMRp2RSy9TL24r+/zzsBhPk2CYvjouX2N2yUCfSLIhF0b6OwNGbLqR1QvrZP2+WGvkjqap2x/ZtNXs1cL8eCVD/6SVsIKl301Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788631345; c=relaxed/relaxed;
	bh=sDLUtOQHuDEs34Sap3Ops/5mzfhoVxMW2WEbFNea95U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=QP8zhKQKuUYXwBjsT+eIALa4h8lcUcBtMyyo9LuWo9rCocStSnd8Iw4kuUQB4w9ZD2FQh5dm0ICW/Ixhf7cSsHeQMVadtbtsqjKLU8mvDQ6T1rZ58jbnVH+E/ddcQ4PLOLOQVAeTEOKaQCFIGXZhSsFrj2dK6RFE3BBqzPCdMkWhbHoP1W9qBFKu2xVvLRSJLMCPgWSMvnGoOidlCBniUIclqhQYVDfWvD60kXJ83fZqWioXuCg1QZHyrw+nQklUIK0yB4/SsmzaeCLmQtu1GmWmn6NPbod+9tCVc9xCEsfG9/zAiO8blGs60CHrGZNu8aHNeRSfVAzUyrZHyBnt8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pUnQHDYP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pUnQHDYP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hch4Z6l4wz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 04:02:22 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso2055956a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788631340; x=1789236140; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sDLUtOQHuDEs34Sap3Ops/5mzfhoVxMW2WEbFNea95U=;
        b=pUnQHDYPoiLJWqMPj3R+sCmZ8s8oGasGqvyc2hzpVVORc1uMgRh8BQr2pDekQwnLAZ
         UGBQpVpp4H0GJ5hYPIAXu0gGynukUHxy4xudbZoj3v9aa1uaJj1obtNkwFSzlnQjjaoP
         KlwpoANDtyAps85n8GYiKtF7h2QhbNswIM1v7ztzS6SxOuQmHGmHUs8iuVFWcv4xXNQX
         gG9IOHzVRLPfI88eJzi+tiHPPGIpXpLbVb3vPxIjtRx27VmK4r7wyH0xEhSpwY9v8Kud
         5VUVgk8gadrp+XuFMWzxqtfGacxICwub4rZx1PXkv6K8VW1LaD7jYTT706kHJ5ikLIiU
         UuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788631340; x=1789236140;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDLUtOQHuDEs34Sap3Ops/5mzfhoVxMW2WEbFNea95U=;
        b=a7Ly66uSiYJH+8IdIi4wt3GdUxGpttloOTelLPHZTYq8sq6dvIYePP4nP1exaZmCNu
         6M42R2LPtQNmzDk0AovRIgNzTqV1zSlXCDeLDL6l6ITe1GyqY4wpStKwKidEKumbU3Re
         27Cde5zx7PTye/D1e5/a3PqLeo+HW5iVTITGEDNiY5g+c8PLS0VYbKPAkPZjNCSYCXk5
         FukMcmOmtXdbR+/iq+J/9/kAH2D5GOXId/UjGKB6uyVZG7mXego00jAxNju57kR0PHOI
         hApuvndLt1XT1moagr9fanhn2kN57agz3wb5A1ymmXIZ8FPJhtN0LrTYE87SPf+fjAZU
         dBPQ==
X-Gm-Message-State: AFuF++m20WIQGEouQL47DtHUa1sVOn5Ed5AyrJI5wu4g3GAW8g8K55hD
	XwqP3PbHSE0927VhRNVsTWciUW4ax4ha8PBudGkLApSRdJ0TwXJSMjZk
X-Gm-Gg: AYBFou0ge8StBVYIoHLP5KZiAOBLAYRBid/sbOqkyn52ZNPuEH+V5jmnz5DDHFA7E+s
	FvXZR+RH7mf01kG9EHV9oRxYYLGDMLDvcrZHTOtQVGB+tHeSbo3ayWdd0i4HdDiuVDWSwHs0b49
	XrOFkvzCvRRBKbiJj+4/NuCzcN0xa/o49zFhwKSEu2iGdai5UmZWyasu4HsOliJAJWfM7zZIuWN
	GnESqcmcdYac5Sgip3DofBj+fZVKaL0kGXQvsDv4Zupn5QMtaeV8y0hpKkXaxkSpayVtFkbtiKw
	69kJXz41KRmxyD55Lxqsi36Ty6Nrj0vnIPV7egWs/2R4Ff1jGymSzmCkmrbBykPYjr+UjRzBi+b
	SLti/evtI9krJCeW4wMaKCaChKtWOtlZHcDUXXLcj9ESvgH1DjFSA/RVDb2UM8+rEtHHfC6w42z
	esYIRL/jLuKo/PEHYmrsSlKKg0HQDMuN9Ztwftm5BwAuJ+OrISvE5QxidCEyyH1MaTsDVVqEkTP
	X0+tynWDAmVGIvQSWHM4TkgwRQknxB9E9+fUVYeUJunvQ==
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr21188526a91.17.1788631339680;
        Sat, 05 Sep 2026 11:02:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm12956985c88.6.2026.09.05.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:02:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Michal =?utf-8?Q?Such=C3=A1?=
 =?utf-8?Q?nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: systemd-journal segfaulting with 7.3-rc1 on ppc64le
In-Reply-To: <20260904135555.402d5abf678499301dc672af@danny.cz>
Date: Sat, 05 Sep 2026 23:15:42 +0530
Message-ID: <tso3y4l5.ritesh.list@gmail.com>
References: <20260904125349.15b764f80bc54296b88e8f87@danny.cz> <apqr7oUzHxrcj4mW@kunlun.suse.cz> <20260904135555.402d5abf678499301dc672af@danny.cz>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dan Horák <dan@danny.cz> writes:

> On Fri, 4 Sep 2026 13:30:54 +0200
> Michal Suchánek <msuchanek@suse.de> wrote:
>
>> On Fri, Sep 04, 2026 at 12:53:49PM +0200, Dan Horák wrote:
>> > Hi,
>> > 
>> > I am using the rc kernels via
>> > https://fedoraproject.org/wiki/RawhideKernelNodebug on my Fedora 44
>> > Power9 based system (Talos II) and after installing
>> > kernel-7.3.0-0.rc1.18.fc46.ppc64le my system failed to boot
>> > successfully and I have found systemd-journal segfaults in the boot log
>> > like this
>> > 
>> > [   12.485876] systemd-coredump[1464]: Process 1409 (systemd-journal) of user 0 terminated abnormally with signal 6/ABRT, processing...
>> > [   12.578533] systemd-coredump[1464]: Process 1409 (systemd-journal) of user 0 dumped core.
>> > [   12.578554] systemd-coredump[1464]: Coredump diverted to /var/lib/systemd/coredump/core.systemd-journal.0.b7f8bc16143c4cc1832aeb4c64ff16a4.1409.1788339090000000.zst
>> > [   12.578560] systemd-coredump[1464]: Module libpcre2-8.so.0 from rpm pcre2-10.47-1.fc44.1.ppc64le
>> > [   12.578566] systemd-coredump[1464]: Module libselinux.so.1 from rpm libselinux-3.11-1.fc44.ppc64le
>> > [   12.578572] systemd-coredump[1464]: Module libz.so.1 from rpm zlib-ng-2.3.3-3.fc44.ppc64le
>> > [   12.578578] systemd-coredump[1464]: Module libcrypto.so.3 from rpm openssl-3.5.8-1.fc44.ppc64le
>> > [   12.578583] systemd-coredump[1464]: Module libcrypt.so.2 from rpm libxcrypt-4.5.2-3.fc44.ppc64le
>> > [   12.578596] systemd-coredump[1464]: Module libsystemd-shared-259.8-1.fc44.so from rpm systemd-259.8-1.fc44.ppc64le
>> > [   12.578602] systemd-coredump[1464]: Module systemd-journald from rpm systemd-259.8-1.fc44.ppc64le
>> > [   12.578608] systemd-coredump[1464]: Stack trace of thread 1409:
>> > [   12.578613] systemd-coredump[1464]: #0  0x00007fffaa82ae74 abort (libc.so.6 + 0x2ae74)
>> > [   12.578619] systemd-coredump[1464]: #1  0x00007fffaa8a4e60 __libc_message_impl (libc.so.6 + 0xa4e60)
>> > [   12.578624] systemd-coredump[1464]: #2  0x00007fffaa8a4eec __libc_fatal (libc.so.6 + 0xa4eec)
>> > [   12.578630] systemd-coredump[1464]: #3  0x00007fffaa8b54bc start_thread (libc.so.6 + 0xb54bc)
>> > [   12.578635] systemd-coredump[1464]: #4  0x00007fffaa9613e8 __clone (libc.so.6 + 0x1613e8)
>> > [   12.578641] systemd-coredump[1464]: #5  0x00007fffaa9613e8 __clone (libc.so.6 + 0x1613e8)
>> > [   12.578646] systemd-coredump[1464]: #6  0x00007fffaa8b4e40 create_thread.constprop.0 (libc.so.6 + 0xb4e40)
>> > [   12.578652] systemd-coredump[1464]: #7  0x00007fffe66094a0 n/a (n/a + 0x0)
>> > [   12.578657] systemd-coredump[1464]: ELF object binary architecture: PowerPC64
>> > [   12.646917] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 2.
>> > 
>> > I have reproduced the behaviour with the latest mainline kernel and my
>> > bisecting points to
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3424d8c18a7da1010d03391a22e728b857d0d5c5
>> > (which is not that helpful as it is a merge commit). There are also
>> > messages about "dbus-broker.service: Failed with result 'exit-code'",
>> > so the journal crash might be a symptom of another root cause. Using
>> > the Fedora prebuilt kernels
>> > - kernel-7.3.0-0.rc0.260818g0f23d56f17fd.3.fc46.ppc64le  = OK
>> > - kernel-7.3.0-0.rc0.260819gbd5f485f3f02.5.fc46.ppc64le  = BAD
>> > doesn't help much in narrowing as it is when the big merges happened.
>> > 
>> > ---
>> > git bisect start
>> > # status: waiting for both 'good' and 'bad' commits
>> > # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
>> > git bisect good 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
>> > # status: waiting for 'bad' commit, 1 'good' commit known
>> > # bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
>> > git bisect bad cee9395acd8043be0644b25c34bfa86623f2b935
>> > # bad: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
>> > git bisect bad 55ab7e14222e5f0b0fd9f7711ca391d2924b35e3
>> > # bad: [e5c91aac491def6ab3f90c4cc246e3fcb0f8f058] Merge tag 'sound-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> > git bisect bad e5c91aac491def6ab3f90c4cc246e3fcb0f8f058
>> > # bad: [cbe8aadf1551f3f4a853f24b3b96d9f0eea49c53] Merge tag 'soc-dt-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> > git bisect bad cbe8aadf1551f3f4a853f24b3b96d9f0eea49c53
>> > # bad: [762fffa407d8d24288513538cf5d17c2c5425258] Merge tag 'irq-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect bad 762fffa407d8d24288513538cf5d17c2c5425258
>> > # good: [a5778046a02570fd23bdf0b48dce330237d1996c] Merge tag 'pm-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> > git bisect good a5778046a02570fd23bdf0b48dce330237d1996c
>> > # good: [85cdaca6970028bf6f544c355c90035586836ddf] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>> > git bisect good 85cdaca6970028bf6f544c355c90035586836ddf
>> > # good: [8915457146a11d20a6c0786396376afda65eec40] Merge tag 'perf-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect good 8915457146a11d20a6c0786396376afda65eec40
>> > # good: [e2457a664ea02c414c6b9828bff3a0df4c300f63] Merge tag 'sched-core-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect good e2457a664ea02c414c6b9828bff3a0df4c300f63
>> > # good: [3a0dd7ba4f44cdc116d83712f61e7c1a95be3588] Merge tag 'x86-documentation-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect good 3a0dd7ba4f44cdc116d83712f61e7c1a95be3588
>> > # good: [fb419d53f2619e29bf4f96613d9a614e1c263736] x86/entry: Simplify the syscall number logic
>> > git bisect good fb419d53f2619e29bf4f96613d9a614e1c263736
>> > # bad: [6138016752322261e26ac88eaeb64c0c890f98a2] Merge tag 'core-rseq-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect bad 6138016752322261e26ac88eaeb64c0c890f98a2
>> > # good: [71ff30013f19ca46c2c72c25731c32b6cc7b5620] entry: Make return type of syscall_trace_enter() bool
>> > git bisect good 71ff30013f19ca46c2c72c25731c32b6cc7b5620
>> > # good: [2a98ffac7733e77a178af7240f9fa9392ca45aad] selftests/rseq: Add missing test binaries to .gitignore
>> > git bisect good 2a98ffac7733e77a178af7240f9fa9392ca45aad
>> > # bad: [3424d8c18a7da1010d03391a22e728b857d0d5c5] Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > git bisect bad 3424d8c18a7da1010d03391a22e728b857d0d5c5
>> > # good: [05c033db7e9ad3c34f6968ec568cb6ee01051c57] entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution
>> > git bisect good 05c033db7e9ad3c34f6968ec568cb6ee01051c57
>> > # first 'bad' commit: [3424d8c18a7da1010d03391a22e728b857d0d5c5] Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > ---
>> > 
>> > Also can be reproduced by using the recent Fedora Rawhide installers
>> > which won't initialize properly.
>> 
>> Hello,
>> 
>> can you try applying recent fixes for the entry code?
>> 
>> https://lore.kernel.org/all/10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com/
>> powerpc: Don't drop _TIF_RESTOREALL on syscall restart

>> https://lore.kernel.org/all/20260820134718.2176411-1-mkchauras@gmail.com/
>> powerpc/entry: Fix irq_soft_mask corruption on replayed

If I am not wrong, the above was superseded by - 
https://lore.kernel.org/all/20260904090858.128563-1-mkchauras@gmail.com/

>> https://lore.kernel.org/all/52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com/
>> powerpc: Do not restore KUAP in
>> https://lore.kernel.org/all/20260828053811.1042300-1-sshegde@linux.ibm.com/
>> powerpc/entry: Clear TIF_SYSCALL_RET before syscall error
>> https://lore.kernel.org/all/20260904025831.3439809-1-aboorvad@linux.ibm.com/
>> powerpc/entry: Fix double accounting of user time on

Thanks Michal

>
> thanks for pointers, Michal. With all of them applied the crash goes
> away. Forgot to mention that I tried with the "powerpc: Don't drop
> _TIF_RESTOREALL on syscall restart" alone and it didn't help.
>

Thanks Dan for testing and confirming that these fixes the problems for
you. IIUC, v7.3-rc2 should mostly get these fixes in.

-ritesh


