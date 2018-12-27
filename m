Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF73CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 19:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE75214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTWiVq/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE75214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QfVy29qBzDqFw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 06:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qTWiVq/p";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qTWiVq/p"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QfSG3DgBzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 06:05:47 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id d72so9096671pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Gb9fJTDy7+aTBoygNzSgsHwiwaiZrEziG3CIsYcRIss=;
 b=qTWiVq/p3i8ktd5TZkM40gUZSAVe4LdnapCLBWo1n2GCTo+A4NaSA/4bQlTKV1qFbv
 PjfhLZfCYcLkVVFdiFR5u3LK9QaHLt2B49SZR8/lj8wrGaB3muAfh0b5hD4rnO87sgyP
 GYibaMHPfozehAhppWvf3d8+uu9TQzwyKhBaqHQpQN22FYHF9SZ0HkRNWN2IzxG+bgjS
 /vcGgHe8l98dEV/dKSDrOtwvqSyo9YEZf7J0+hyte59VfDzUTFFMv+mcybCoibNz5SwW
 efM+sW4oIftzJCW31KkFguDI0U4UuDXKNHzLNIWNek3wXeWVw43V37Jf7Vitj4kJtB7/
 SQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=Gb9fJTDy7+aTBoygNzSgsHwiwaiZrEziG3CIsYcRIss=;
 b=orQrQNCZPMMSQ087YngZoIaBbTDb7KJpPziYbWpFbSEdCXvITRwlA34az61EMX95Rt
 hb80/xrDYoE2pRVVD4KltD+L+bOrRUobb6G5gqnfFteh0QBPKbbbRq9XMhTPqaeiGpeC
 UFCCOo+tsIAdAXDVv/7n484HRtIbz2XJKAVn4M9UVa2fNSbwkhr+BOgLPL6Z/tnF6Ipx
 LyUdtQy6cRBLuFlpMOcDDWg6955vDemtF4/nxq1CJNy1WudKg1yC6cYywulUeYnOyP7B
 7iJePqzoRliN5radN4zbeQUXNNzKoqwG6/begza798c6VOeK4mobfhmEVj+vKubhggxK
 bCBw==
X-Gm-Message-State: AJcUukfHtZ/OlFf1PQdAmoATn3aPhfTKXxZ+LQPoR3rX+bUe7tAB+BxS
 gK/okrvgd9MjJkxcaay6aOHsXB1m
X-Google-Smtp-Source: ALg8bN7KpssEd+stAXi6cMqEWI++ggo9fF9oBlTZyF0mnW8Oc4olDg4indBKzzm+eKtisJItRDWAvA==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr23769217pgb.408.1545937544817; 
 Thu, 27 Dec 2018 11:05:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id b26sm92103338pfe.91.2018.12.27.11.05.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 11:05:43 -0800 (PST)
Date: Thu, 27 Dec 2018 11:05:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Runtime warnings in powerpc code
Message-ID: <20181227190542.GA29444@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

I am getting the attached runtime warnings when enabling certain debug
options in powerpc code. The warnings are seen with pretty much all
platforms, and all active kernel releases.

Question: Is it worthwhile to keep building / testing powerpc builds
with the respective debug options enabled, and report it once in a while,
or should I just disable the options ?

Thanks,
Guenter

---
CONFIG_DEBUG_ATOMIC_SLEEP

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<(ptrval)>]
prepare_to_wait+0x54/0xe4
WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:6099 __might_sleep+0x94/0x9c
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.20.0-yocto-standard+ #1
NIP:  c00667a0 LR: c00667a0 CTR: 00000000
REGS: cf8df8c0 TRAP: 0700   Not tainted  (4.20.0-yocto-standard+)
MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28888822  XER: 20000000

GPR00: c00667a0 cf8df970 cf8e0000 00000062 c0af15c8 00000007 fa1ae97e 757148e2 
GPR08: cf8de000 00000000 00000000 00000000 1f386000 00000000 00000000 cfd83c8c 
GPR16: 00000004 00000004 00000004 00000000 0000060c 0000000a cf8dfdb8 cf267804 
GPR24: cf8dfd78 cf8dfd68 cfa88a20 cec70830 00000001 00000000 000001d3 c0b444cc 
NIP [c00667a0] __might_sleep+0x94/0x9c
LR [c00667a0] __might_sleep+0x94/0x9c
Call Trace:
[cf8df970] [c00667a0] __might_sleep+0x94/0x9c (unreliable)
[cf8df990] [c05beddc] do_ide_request+0x48/0x6bc
[cf8dfa10] [c0492bcc] __blk_run_queue+0x80/0x10c
[cf8dfa20] [c049a938] blk_flush_plug_list+0x23c/0x258
[cf8dfa60] [c006b888] io_schedule_prepare+0x44/0x5c
[cf8dfa70] [c006b8c0] io_schedule+0x20/0x48
[cf8dfa80] [c095e1ac] bit_wait_io+0x24/0x74
[cf8dfa90] [c095dd94] __wait_on_bit+0xac/0x104
[cf8dfab0] [c095de74] out_of_line_wait_on_bit+0x88/0x98
[cf8dfae0] [c0229094] bh_submit_read+0xf8/0x104
[cf8dfaf0] [c028b9a8] ext4_get_branch+0xdc/0x168
[cf8dfb20] [c028c7fc] ext4_ind_map_blocks+0x2b0/0xc08
[cf8dfc30] [c029551c] ext4_map_blocks+0x2e0/0x65c
[cf8dfc80] [c02b8c84] ext4_mpage_readpages+0x5e8/0x97c
[cf8dfd60] [c016c3cc] read_pages+0x60/0x1a0
[cf8dfdb0] [c016c6e8] __do_page_cache_readahead+0x1dc/0x208
[cf8dfe10] [c0159768] filemap_fault+0x418/0x834
[cf8dfe50] [c02a00fc] ext4_filemap_fault+0x40/0x64
[cf8dfe60] [c0198d0c] __do_fault+0x34/0xb8
[cf8dfe70] [c019e264] handle_mm_fault+0xc44/0xf88
[cf8dfef0] [c001a218] __do_page_fault+0x158/0x7b4
[cf8dff40] [c00143b4] handle_page_fault+0x14/0x40
--- interrupt: 301 at 0xb7904a70
    LR = 0xb78ef0c8
Instruction dump:
7fe3fb78 bba10014 7c0803a6 38210020 4bfffd20 808a0000 3c60c0b0 39400001 
7cc53378 3863a558 99490001 4bfd03bd <0fe00000> 4bffffc0 7c0802a6 90010004 
irq event stamp: 126702
hardirqs last  enabled at (126701): [<c0091a74>] console_unlock+0x434/0x5d0
hardirqs last disabled at (126702): [<c00140b4>] reenable_mmu+0x30/0x88
softirqs last  enabled at (126552): [<c0964614>] __do_softirq+0x42c/0x4a0
softirqs last disabled at (126529): [<c003cda4>] irq_exit+0x104/0x108
---[ end trace 4f6c84b7815474d9 ]---

---
#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
    defined(CONFIG_TRACE_IRQFLAGS)

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:3762
check_flags.part.25+0x1a0/0x1c4
Modules linked in:
CPU: 0 PID: 1 Comm: init Tainted: G        W         4.20.0-yocto-standard+ #1
NIP:  c00839f0 LR: c00839f0 CTR: 00000000
REGS: cf8dfe00 TRAP: 0700   Tainted: G        W
(4.20.0-yocto-standard+)
MSR:  00021032 <ME,IR,DR,RI>  CR: 28282222  XER: 20000000

GPR00: c00839f0 cf8dfeb0 cf8e0000 0000002f 00000001 c00938f4 c1425b76 0000002f 
GPR08: 00001032 00000000 00000001 00000004 28282828 00000000 00000000 b7927688 
GPR16: 00000000 bfe20a5c bfe20a58 0fe5fff8 10000b38 10002178 00000000 b7929c20 
GPR24: c095d81c 7c9319ee 00000000 00000000 b7929ae0 cf8e0000 00009032 c0d20000 
NIP [c00839f0] check_flags.part.25+0x1a0/0x1c4
LR [c00839f0] check_flags.part.25+0x1a0/0x1c4
Call Trace:
[cf8dfeb0] [c00839f0] check_flags.part.25+0x1a0/0x1c4 (unreliable)
[cf8dfec0] [c0085f6c] lock_is_held_type+0x78/0xb4
[cf8dfee0] [c095d35c] __schedule+0x6cc/0xb44
[cf8dff30] [c095d81c] schedule+0x48/0xb8
[cf8dff40] [c0014694] recheck+0x0/0x20
--- interrupt: 501 at 0xb78f2850
    LR = 0xb78f2a24
Instruction dump:
3c80c0b0 3c60c0af 3884d684 38635f94 4bfb3189 0fe00000 4bfffec8 3c80c0b0 
3c60c0af 3884d668 38635f94 4bfb316d <0fe00000> 4bfffefc 3c80c0b0 3c60c0af 
irq event stamp: 127630
hardirqs last  enabled at (127629): [<c09636f4>]
_raw_spin_unlock_irq+0x3c/0x94
hardirqs last disabled at (127630): [<c00140b4>] reenable_mmu+0x30/0x88
softirqs last  enabled at (127402): [<c0964614>] __do_softirq+0x42c/0x4a0
softirqs last disabled at (127393): [<c003cda4>] irq_exit+0x104/0x108
---[ end trace 4f6c84b7815474da ]---
possible reason: unannotated irqs-on.
irq event stamp: 127630
hardirqs last  enabled at (127629): [<c09636f4>] _raw_spin_unlock_irq+0x3c/0x94
hardirqs last disabled at (127630): [<c00140b4>] reenable_mmu+0x30/0x88
softirqs last  enabled at (127402): [<c0964614>] __do_softirq+0x42c/0x4a0
softirqs last disabled at (127393): [<c003cda4>] irq_exit+0x104/0x108

DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:3762
check_flags.part.25+0x1a0/0x1c4
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.20.0-yocto-standard+ #1
NIP:  c00a53bc LR: c00a53bc CTR: 00000000
REGS: cf8e9df0 TRAP: 0700   Not tainted  (4.20.0-yocto-standard+)
MSR:  00021032 <ME,IR,DR,RI>  CR: 28028222  XER: 00000000

GPR00: c00a53bc cf8e9ea0 cf8e0000 0000002f 00000001 c00b6614 c149a08e 0f054000 
GPR08: 0f054000 00000000 00000001 00000004 28028822 00000000 00000000 b78c4200 
GPR16: 00000000 bfebc2d8 00000000 b78c2af0 0000000a cfd274a0 00000000 c09c343c 
GPR24: 00000000 c0d7ebdc b78c4200 00000000 c0d6faf2 cf8e0000 00009032 c0da0000 
NIP [c00a53bc] check_flags.part.25+0x1a0/0x1c4
LR [c00a53bc] check_flags.part.25+0x1a0/0x1c4
Call Trace:
[cf8e9ea0] [c00a53bc] check_flags.part.25+0x1a0/0x1c4 (unreliable)
[cf8e9eb0] [c00a7a80] lock_is_held_type+0x78/0xb4
[cf8e9ed0] [c09c2e50] __schedule+0x740/0xce4
[cf8e9f30] [c09c343c] schedule+0x48/0xb8
[cf8e9f40] [c0015698] recheck+0x0/0x20
--- interrupt: 901 at 0xb788cfe8
    LR = 0xb788cd44
Instruction dump:
3c80c0b7 3c60c0b6 38849aac 38631790 4bf955f5 0fe00000 4bfffec8 3c80c0b7 
3c60c0b6 38849a90 38631790 4bf955d9 <0fe00000> 4bfffefc 3c80c0b7 3c60c0b6 
irq event stamp: 131268
hardirqs last  enabled at (131266): [<c00d0c84>]
rcu_process_callbacks+0x594/0x770
hardirqs last disabled at (131267): [<c09caf7c>] __do_softirq+0x494/0x5e4
softirqs last  enabled at (131268): [<c09caff8>] __do_softirq+0x510/0x5e4
softirqs last disabled at (131255): [<c0042310>] irq_exit+0x128/0x12c
---[ end trace 0fd813db98ea17dc ]---
possible reason: unannotated irqs-on.
irq event stamp: 131268
hardirqs last  enabled at (131266): [<c00d0c84>]
rcu_process_callbacks+0x594/0x770
hardirqs last disabled at (131267): [<c09caf7c>] __do_softirq+0x494/0x5e4
softirqs last  enabled at (131268): [<c09caff8>] __do_softirq+0x510/0x5e4
softirqs last disabled at (131255): [<c0042310>] irq_exit+0x128/0x12c
