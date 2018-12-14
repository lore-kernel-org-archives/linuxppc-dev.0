Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECBFC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB1F2075B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YG/erh/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB1F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GKjR1rCqzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:03:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="YG/erh/O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="YG/erh/O"; 
 dkim-atps=neutral
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GKfY4k9vzDqcK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 17:00:53 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id n32so5005526qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 22:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=WFJ90Ek4vck0NO/QtYguLATTOle1ASYfVBvnc3NWIpI=;
 b=YG/erh/OsXPk2KutFWFxi0wrt65/Ec2k0JUr5GQ1gD+HtNlb8b0FKMU+BhB3/fQp1s
 LNxcxGZCnm4leqo4egaSe5Ft0PBslltW1nwvxecpQnDK10rD50OL/feglIeUmYTODbtk
 f4w671JsQOE+6dJZhI3F1VHZ0iT9mlY0fsrWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=WFJ90Ek4vck0NO/QtYguLATTOle1ASYfVBvnc3NWIpI=;
 b=TqRZKx8vNsUOqHFdN56Kqk6fm/8S8sBfsUxcDJnTht38aC82jRNBzJryS1Yiuml9Eq
 ysIEGnvsOz6enmojw0jqIeHmjavJEMHBEplt4jsCL1hx0GivKrs9kczQbEFSbuG+pCfy
 +cP8MCp9feVieWV6gE68djRZssFamg13L5V9K/CQnTV7GEK99lO0nuFC86INkFMghflE
 911xi2y8Zv26ZzrG+M8f71uFyluswYJhhi4AomwGfiHODIz5hZ8WQj/Q0+XfM2Eymka6
 w4fBvemogi398SVZP2/DDGwanoWvR6kW5Ok4AhIfSsKG1ptDm6u9s3XlOP0z+ssoE4UW
 sVrA==
X-Gm-Message-State: AA+aEWYhz2RveOOk0F5OnDpRuEO5DiuLB9P+09jvdlO8dxTQq3+roINy
 S04FnsolXo9bzkpbrDeeLXaSmNZe6jijBxsGutDJAK5bP/4=
X-Google-Smtp-Source: AFSGD/WD0ON6ds8a0m/eHhTA+m0junJh5hvWlMApkZ3KfTV+lFX6FOqZQS3c1Cg+0sq64eXvcu6ye7qDmqBts8Tp9vU=
X-Received: by 2002:a0c:e789:: with SMTP id x9mr1542164qvn.245.1544767250432; 
 Thu, 13 Dec 2018 22:00:50 -0800 (PST)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 14 Dec 2018 16:30:38 +1030
Message-ID: <CACPK8XcEpPzBu28Uuz4hX8Xq2OM_LuAWD4Ljes+6k87YuQfYHw@mail.gmail.com>
Subject: lockdep WARN_ON in ppc440 with -next
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

I was booting next-20181213 in qemu with lockdep enabled and saw this:

spin_lock-torture:--- Start of test [debug]: nwriters_stress=3D2
nreaders_stress=3D0 stat_interval=3D60 verbose=3D1 shuffle_interval=3D3
stutter=3D5 shutdown_secs=3D0 onoff_interval=3D0 onoff_holdoff=3D0
spin_lock-torture: Creating torture_shuffle task
spin_lock-torture: Creating torture_stutter task
spin_lock-torture: torture_shuffle task started
spin_lock-torture: Creating lock_torture_writer task
spin_lock-torture: torture_stutter task started
spin_lock-torture: Creating lock_torture_writer task
spin_lock-torture: lock_torture_writer task started
spin_lock-torture: Creating lock_torture_stats task
spin_lock-torture: lock_torture_writer task started
spin_lock-torture: lock_torture_stats task started
torture_init_begin: Refusing rcu init: spin_lock running.
torture_init_begin: One torture test at a time!
workingset: timestamp_bits=3D30 max_order=3D15 bucket_order=3D0
jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
WARNING: CPU: 0 PID: 379 at kernel/locking/lockdep.c:3765
check_flags+0x230/0x248
Modules linked in:
CPU: 0 PID: 379 Comm: modprobe Not tainted 4.20.0-rc6-next-20181213-dirty #=
1
NIP:  c007c7a4 LR: c007c7a4 CTR: 00000000
REGS: c7b95de0 TRAP: 0700   Not tainted  (4.20.0-rc6-next-20181213-dirty)
MSR:  00021000 <CE,ME>  CR: 22000c22  XER: 20000000

GPR00: c007c7a4 c7b95e90 c7b9a580 0000002f 00000000 00000001 c0fed2d6 c0fed=
2d7
GPR08: 00000000 21637572 c0f741df 00000004 22000c22 100d803e 00000000 00000=
000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000=
000
GPR24: c7b94000 00000000 00000000 00000000 c0860f98 ffffffff 00029000 10003=
d38
NIP [c007c7a4] check_flags+0x230/0x248
LR [c007c7a4] check_flags+0x230/0x248
Call Trace:
[c7b95e90] [c007c7a4] check_flags+0x230/0x248 (unreliable)
[c7b95ea0] [c007f430] lock_is_held_type+0x4c/0x114
[c7b95ed0] [c066801c] __schedule+0x84/0x934
[c7b95f30] [c066893c] schedule+0x70/0x9c
[c7b95f40] [c000f928] recheck+0x0/0x24
--- interrupt: 901 at 0xb7bdbe18
    LR =3D 0xb7b6da7c
Instruction dump:
3c80c08d 2c030000 8084e69c 2c840000 4e823342 41940020 3c60c076 3c80c076
4cc63182 3863c724 38840cf8 4bfbdd1d <0fe00000> 3c60c076 38630d13 4cc63182
irq event stamp: 428
hardirqs last  enabled at (426): [<c066dbf8>] _raw_spin_unlock_irq+0x30/0x5=
8
hardirqs last disabled at (427): [<c066e8a4>] __do_softirq+0x394/0x52c
softirqs last  enabled at (428): [<c003ecc4>] irq_exit+0xdc/0x100
softirqs last disabled at (419): [<c003ecc4>] irq_exit+0xdc/0x100
---[ end trace 3f1ce6c3406f3dee ]---
possible reason: unannotated irqs-on.
irq event stamp: 428
hardirqs last  enabled at (426): [<c066dbf8>] _raw_spin_unlock_irq+0x30/0x5=
8
hardirqs last disabled at (427): [<c066e8a4>] __do_softirq+0x394/0x52c
softirqs last  enabled at (428): [<c003ecc4>] irq_exit+0xdc/0x100
softirqs last disabled at (419): [<c003ecc4>] irq_exit+0xdc/0x100
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler mq-deadline registered
io scheduler kyber registered

I am running ppc44x_defconfig under qemu with the bamboo machine:

qemu-system-ppc -m 128m -machine bamboo -dtb
arch/powerpc/boot/dts/bamboo.dtb -append console=3DttyS0 -initrd
images/ppc32/rootfs.cpio -nographic -kernel
linux-next/arch/powerpc/boot/zImage
