Return-Path: <linuxppc-dev+bounces-21260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4060CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 23:38:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLSdy1R9sz2yQH;
	Thu, 21 May 2026 09:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779320294;
	cv=none; b=IFG+y6hMF+ENkeIIoDK7wrEVP9m3ZOy1CtenuX1l74jbdvyhZJz4VG9W31DTJznt7d3LB3b5yX3beSRmFOTLfenW0rGJp9pgQ03rM+sufSU7kU5jbhsQWBBanOE57YnrRGou5xg3PLPu+bcplW5+I+qCoLkCITu4ca90uwqqgKeh0xrSE8OLEavJ7yinWm6YYHYYvfTkX7TybX3+Pi2CenY3/XFx6Hw3ONlUf6T6SCQH0eDES2Fg0RLFiJOPG65Wy60sAnqhqzDzX3drwpk9bIzoKQZgF8M7eU8HeQqsCiPFYJC/vA62/VpogSbsuWkeOBY6FjqyHhcU+Zfzrn6rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779320294; c=relaxed/relaxed;
	bh=+XojcX+cBNMxauV3CDSL9gXTCmD6yueQSzdQP2DbJ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFxM+7WaKsUIiqac3FUs9GwiKjU0oaU4tXabdhdS262da9LTHtx8++CUqarXGdTs2GHN4fK/TVMtcgrvym1V9Gzh1EcpoM9CNKprlnrsyoFyDSLkrGOmVxmWCi04LoljFtwjGvgsStiZOu/CcqRRJ7FRqX0SbAGIsH9vIw18qMfjKo/ZQl+eViEqN6LfZWjY7eLnwlMHjAevL8JYHnHc/s8B4W9WZlWJO8K3zs/4iKvR8rMTmW5ocLtfNI390Wmq+w9sPDe6LvmqH2a/yg1QO84IOomqm0Yym55BM3ZoRrs9+dd+G+hG6VVQ5bthAf8cVLwf/ZznGa/iCZei1hAM1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohUWzsQy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohUWzsQy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLSdx2fYYz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 09:38:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 32422445E9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DCE1F0155D
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320291;
	bh=+XojcX+cBNMxauV3CDSL9gXTCmD6yueQSzdQP2DbJ+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ohUWzsQy12Lp2RUlEnBLUpIu54GIgmODDx+dWdarhAtmeIMNmwk6cNzdcGmgo4qIy
	 Yaxse71rD9idF+ShHyVaV8B0pHsH11PYbLqqfEkB9dNAR0UokviE7D6k10N3Z6WRem
	 IGHDaZzmoZwKnkhoquW1BSE0oowVqnkbFZQYLDdom4mO561qefmVCsJbTRHVN35kiv
	 5hfXjkPjvlQyXGVGO+RXBVSDUEbDPfAF4ii2XnvJHsz56+jMEHNQwX3fW/QMN8Kn8w
	 q+Xc2FMz78D+TRp/bAFobADWyZ4RPxaYocop4r+YdQN5Pwig7z9KRZfJjMDpHnQM70
	 BChD9ozPtWbug==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50faeb8317bso49938811cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:38:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ssrDp/mq6yiFMZ/F5W4dS3jeZEJAvZU5boEpHp8eDFOl8K6nXX72dPIXYe5C4NIiZ0QSf1IsKbjWI6xE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyk58YvzfbIScfIqaGBzLIRBiGKMAZ3pDhd2OPiocnrZlVFROMI
	P/niv1iS9u7kKmtpE5y10r44gwC+Bxkof7U4HYbETb+r4jlq9ax8h5AYZWGf2r7QxR/kRKXGD4v
	Tl4OyJHTfqgPnpPl6zu+JLZE2tfPk5BM=
X-Received: by 2002:a05:622a:17c7:b0:50d:b0f9:1a66 with SMTP id
 d75a77b69052e-516c55ce180mr9639641cf.42.1779320290158; Wed, 20 May 2026
 16:38:10 -0700 (PDT)
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
References: <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
In-Reply-To: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 21 May 2026 07:37:58 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
X-Gm-Features: AVHnY4LEan2jPUL-UnPeql1qwutuRGUCiZMo1ZXEi3On484A8O-Avt_P3lSUuSE
Message-ID: <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:35=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/20/26 23:15, Matthew Wilcox wrote:
> > On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> >> My understanding is that we should not blame applications here. This i=
s 2026:
> >> there are basically only two kinds of applications =E2=80=94 single-th=
readed and
> >> multi-threaded =E2=80=94 and single-threaded applications are nearly e=
xtinct.
> >
> > all of the applications i run are either single threaded or don't fork.
> > what multithreaded applications call fork?
>
> Traditionally the problem was random libraries using fork+execve to launc=
h other
> programs ... instead of using alternatives like posix_spwan (some use cas=
es
> require more work done before execve and cannot yet switch to that). I'd =
hope
> that that is less of a problem on Android.
>
> I assume Android zygote might be multi threaded? Maybe sshd as well? Syst=
emd?
> But I'd be surprised if there are really performance implications.

I am trying to answer the question above:

1. zygote, multi-threaded on my phone using Android13.
/ # ls /proc/`pidof zygote64`/task/
1359  22728  22729  22730  22731  22732

/proc/1359/task # cat 22728/comm
Jit thread pool
/proc/1359/task # cat 22730/comm
ReferenceQueueD
/proc/1359/task # cat 22731/comm
FinalizerDaemon
/proc/1359/task # cat 22732/comm
FinalizerWatchd
/proc/1359/task # cat 1359/comm
main

But on another phone of mine running Android 16, zygote64 is
single-threaded.
Not sure if it is due to the Android team making some changes
related to threads from Android 13 to Android 16.

2. sshd, multi-processes instead of multi-threads:
$ ps aux | grep sshd
root        1192  0.0  0.0  15444  9032 ?        Ss   09:42   0:00
sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        2465  0.0  0.0  17164 10760 ?        Ss   09:42   0:00
sshd: barry [priv]
barry       2632  0.0  0.0  17164  7852 ?        S    09:42   0:00
sshd: barry@pts/0
root        3305  2.5  0.0  17164 10772 ?        Ss   09:44   0:00
sshd: barry [priv]
barry       3406  0.0  0.0  17164  7940 ?        S    09:44   0:00
sshd: barry@pts/1

3. systemd, also multi-processes

$ ps ax | grep systemd
    350 ?        S<s    0:00 /lib/systemd/systemd-journald
    387 ?        Ss     0:00 /lib/systemd/systemd-udevd
    666 ?        Ss     0:00 /lib/systemd/systemd-oomd
    667 ?        Ss     0:00 /lib/systemd/systemd-resolved
    728 ?        Ss     0:00 @dbus-daemon --system --address=3Dsystemd:
--nofork --nopidfile --systemd-activation --syslog-only
    751 ?        Ss     0:00 /lib/systemd/systemd-logind
    753 ?        Ssl    0:00 /usr/sbin/thermald --systemd
--dbus-enable --adaptive
   1350 ?        Ss     0:00 /lib/systemd/systemd --user
   1428 ?        Ss     0:00 /usr/bin/dbus-daemon --session
--address=3Dsystemd: --nofork --nopidfile --systemd-activation
--syslog-only
   1900 ?        Ssl    0:00 /usr/libexec/gnome-session-binary
--systemd-service --session=3Dubuntu
   2141 ?        Ssl    0:00 /lib/systemd/systemd-timesyncd

>
> Not sure about webbroswers .... I think most of them switched to fork ser=
vers,
> where I would assume fork servers would be single-threaded.

On my phone, Chrome is multi-process, but its parent process
chrome_zygote (10774) is single-threaded:

 ps -A | grep chrome
u0_i15        9883 10774 321066464 119452 do_epoll_wait     0 S
com.android.chrome:sandboxed_process0:org.chromium.content.app.SandboxedPro=
cessService0:15
u0_a142      10164  1359 35110548 277640 do_epoll_wait      0 S
com.android.chrome
u0_a278      10724  1359 9779864 104988 do_epoll_wait       0 S
com.google.android.apps.chromecast.app
u0_a142      10774  1359 32803908 64076 do_sys_poll         0 S
com.android.chrome_zygote
u0_a142      11173  1359 34208592 142192 do_epoll_wait      0 S
com.android.chrome:privileged_process0

/proc/10774/task # ls
10774

>
> So, yeah, getting a clear understanding how this ends up being a problem =
on
> Android would be great.

I guess the real issue is that in the Android market, there
are so many applications that are out of our control=EF=BC=9F

Here are some trace examples from Nanzhe:

iQIYI plugin
vma reader thread:
PbMisc-0, pid=3D27183, tgid=3D26444

vma writer thread:
i.video:plugin1, pid=3D27298, tgid=3D26444
writer blocked: 440394938 ns (440 ms)

reader stack:
vma_start_read
lock_vma_under_rcu
do_page_fault
do_translation_fault
do_mem_abort
el0_da
el0t_64_sync_handler
el0t_64_sync

writer stack:
__vma_start_write
dup_mmap
copy_mm
copy_process
kernel_clone
__arm64_sys_clone
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc


Baidu Tieba
vma reader thread:
elastic_pms_pro, pid=3D7731, tgid=3D7575

vma writer thread:
com.baidu.tieba, pid=3D8005, tgid=3D7575
writer blocked: 514975545 ns(515 ms)

reader stack:
vma_start_read
lock_vma_under_rcu
do_page_fault
do_translation_fault
do_mem_abort
el0_da
el0t_64_sync_handler
el0t_64_sync

writer stack:
__vma_start_write
dup_mmap
copy_mm
copy_process
kernel_clone
__arm64_sys_clone
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc

Thanks
Barry

