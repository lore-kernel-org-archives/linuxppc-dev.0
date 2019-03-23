Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4644C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 13:24:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6132175B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 13:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6132175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RLpf2vMWzDqQ3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 00:24:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RLjX47YtzDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 00:19:58 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 399663DDB6;
 Sat, 23 Mar 2019 13:19:55 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A409160140;
 Sat, 23 Mar 2019 13:19:52 +0000 (UTC)
Date: Sat, 23 Mar 2019 09:19:50 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
Message-ID: <20190323131950.GA30948@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sat, 23 Mar 2019 13:19:55 +0000 (UTC)
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
Cc: Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Steve, Nicholas,

I stumbled across this while working on livepatch self-tests, which like
the ftrace self-tests, specify $(CC_FLAGS_FTRACE) to ensure that target
functions are indeed trace-able.

On ppc64le, v5.0 fails the self-tests on my machine:

  % gcc --version
  gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)

  % git checkout v5.0

  % grep FTRACE_SELFTEST .config
  CONFIG_FTRACE_SELFTEST=y

After building the kernel, I noticed no mcount sections and of course
the self-tests fail as it can't hook functions:

  % readelf --sections kernel/trace/trace_selftest_dynamic.o | grep mcount
  (nothing)

  [ ... snip ... ]
  [  126.147892] Testing all events: OK
  [  126.390487] WARNING: CPU: 0 PID: 1 at kernel/trace/trace_events.c:3421 event_trace_self_tests_init+0x94/0xf4
  [  126.390498] Modules linked in:
  [  126.390510] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.0.0 #10
  [  126.390520] NIP:  c000000000f044d4 LR: c000000000f044cc CTR: c000000000b63d70
  [  126.390530] REGS: c0000001fb183910 TRAP: 0700   Tainted: G        W          (5.0.0)
  [  126.390540] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 20040007
  [  126.390564] CFAR: c00000000025b1f4 IRQMASK: 0
  [  126.390564] GPR00: c000000000f044cc c0000001fb183ba0 c000000001453c00 ffffffffffffffed
  [  126.390564] GPR04: 0000000000000000 c0000000017a0aac 000000000000037d c0000001fb142d00
  [  126.390564] GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000000
  [  126.390564] GPR12: 0000000000000000 c000000001880000 c000000000010530 0000000000000000
  [  126.390564] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  [  126.390564] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  [  126.390564] GPR24: 0000000000000000 0000000000000000 c000000000eb8908 c000000000f4ea68
  [  126.390564] GPR28: c000000000f4eaa8 0000000000000000 c000000000f04440 c000000000f581a8
  [  126.390662] NIP [c000000000f044d4] event_trace_self_tests_init+0x94/0xf4
  [  126.390672] LR [c000000000f044cc] event_trace_self_tests_init+0x8c/0xf4
  [  126.390682] Call Trace:
  [  126.390690] [c0000001fb183ba0] [c000000000f044cc] event_trace_self_tests_init+0x8c/0xf4 (unreliable)
  [  126.390705] [c0000001fb183c10] [c000000000010134] do_one_initcall+0x64/0x264
  [  126.390719] [c0000001fb183ce0] [c000000000ed443c] kernel_init_freeable+0x36c/0x470
  [  126.390731] [c0000001fb183db0] [c000000000010554] kernel_init+0x2c/0x148
  [  126.390744] [c0000001fb183e20] [c00000000000b65c] ret_from_kernel_thread+0x5c/0x80
  [  126.390755] Instruction dump:
  [  126.390765] 3fe2ffb0 f9284578 3bff3d50 794ad182 0b0a0000 2fa90000 419e0058 3bff0858
  [  126.390789] 7fe3fb78 4b356cc1 60000000 54690ffe <0b090000> 2f830000 409c0018 3c62ff96
  [  126.390814] ---[ end trace b5898e7f7f73e163 ]---
  [  126.390822] Failed to enable function tracer for event tests

I git bisected to 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC
4.9 and newer").  Reverting this change and rebuilding, I could see the
mcount sections once again:

  % readelf --sections kernel/trace/trace_selftest_dynamic.o | grep mcount
    [ 3] __mcount_loc      PROGBITS         0000000000000000  00000060
    [ 4] .rela__mcount_loc RELA             0000000000000000  000258c8

Reboot and the self-test now passes.


Perhaps this is gcc version specific?  I didn't see any other reports,
so maybe its specific to my config.  If I run make V=1, I can see that
gcc is called with '-pg -mprofile-kernel', but then the record_mcount
script is skipped.  Any ideas?

Regards,

-- Joe
