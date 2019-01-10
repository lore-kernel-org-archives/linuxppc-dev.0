Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D351C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 21:46:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE43D20874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 21:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE43D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bKLj5grgzDqym
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 08:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bJdq1MtWzDqwm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 08:14:04 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C7C1C0C9A83;
 Thu, 10 Jan 2019 21:14:02 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C41657A5;
 Thu, 10 Jan 2019 21:14:01 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
Subject: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
Date: Thu, 10 Jan 2019 16:14:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 21:14:02 +0000 (UTC)
X-Mailman-Approved-At: Fri, 11 Jan 2019 08:44:23 +1100
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
Cc: Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
        about?

I am looking at a bug in which ~10% of livepatch tests on RHEL-7 and
RHEL-8 distro kernels, the ppc64le reliable stack unwinder consistently
reports an unreliable stack for a given task.  This condition can
eventually resolve itself, but sometimes this state remains wedged for
hours and I can live-debug the system with crash-utility.

I have tried reproducing with upstream 4.20 kernel, but haven't seen
this exact condition yet.  More on upstream in a bit.

That said, I have a question about the ppc64 stack frame layout with
regard to scheduled tasks.  In each sticky "unreliable" stack trace
instance that I've looked at, the task's stack has an interesting
frame at the top:


Example 1 (RHEL-7)
==================

crash> struct task_struct.thread c00000022fd015c0 | grep ksp
     ksp = 0xc0000000288af9c0

crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[0]:

c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............

         crash> sym c000000000002a94
         c000000000002a94 (T) hardware_interrupt_common+0x114

c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......

         Uh-oh...

         /* Mark stacktraces with exception frames as unreliable. */
         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER

c0000000288afa30:  c0000000001240ac c0000000288afcb0   .@.........(....
c0000000288afa40:  c0000000013e4d00 0000000000000000   .M>.............
c0000000288afa50:  0000000000000001 0000000000000001   ................
c0000000288afa60:  c0000000014322e0 0000000000000804   ."C.............
c0000000288afa70:  c0000000288ac080 c00000022fd015c0   ...(......./....
c0000000288afa80:  c0000000288afae0 00000000ffffffff   ...(............
c0000000288afa90:  c0000000288afae0 c000000007b80900   ...(............
c0000000288afaa0:  c000000000e90a00 c000000000e90a00   ................
c0000000288afab0:  c0000000001240ac c000000000e90a00   .@..............
c0000000288afac0:  c000000000e90a00 c000000004790580   ..........y.....
c0000000288afad0:  0000000000000001 c000000000e90a00   ................
c0000000288afae0:  0000000000000000 0000000000000004   ................
c0000000288afaf0:  c00000022fd01ad0 c000000000e73be0   .../.....;......
c0000000288afb00:  c00000023900f450 c000000001488190   P..9......H.....
c0000000288afb10:  0000000000ad0000 c00000023900ef40   ........@..9....
c0000000288afb20:  c0000000288ac000 c000000000e73be0   ...(.....;......
c0000000288afb30:  c00000000001b514 c00000022fd01628   ........(../....
c0000000288afb40:  c0000000288afbb0 c000000000008800   ...(............
c0000000288afb50:  c000000000162880 0000000000000000   .(..............
c0000000288afb60:  00000000240f3022 0000000000000004   "0.$............
c0000000288afb70:  c000000000e90a00 c00000022fd01a20   ........ ../....
c0000000288afb80:  c0000000288afbf0 c0000000014322e0   ...(....."C.....

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[1]:

c0000000288afb90:  c0000000288afbf0 c000000001960a00   ...(............
c0000000288afba0:  c00000000001b514 0000000000000004   ................

         crash> sym c00000000001b514
         c00000000001b514 (T) __switch_to+0x264

c0000000288afbb0:  c000000000e90a00 0000000000000000   ................
c0000000288afbc0:  c0000000288ac000 c0000000014322e0   ...(....."C.....
c0000000288afbd0:  c000000000e90a00 c000000001960a00   ................
c0000000288afbe0:  c00000022fd015c0 c00000023900ef40   .../....@..9....

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[2]:

c0000000288afbf0:  c0000000288afcd0 c000000000003300   ...(.....3......
c0000000288afc00:  c000000000a83918 c0000000013e4d00   .9.......M>.....

         crash> sym c000000000a83918
         c000000000a83918 (t) __schedule+0x428

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[3]:

c0000000288afcd0:  c0000000288afd80 0000000000003300   ...(.....3......
c0000000288afce0:  c0000000001240ac 0000000000000000   .@..............

         crash> sym c0000000001240ac
         c0000000001240ac (t) rescuer_thread+0x3ac

	   [ ... and so on as we would normally expect ... ]


Example 2 - (RHEL-7)
====================

crash> struct task_struct.thread c00000004a660a00 | grep ksp
     ksp = 0xc0000005e85439c0,

crash> rd 0xc0000005e8543b90 -e 0xc0000005e8544000

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[0]:
c0000005e85439c0:  c0000005e8543b90 0000000000000000   .;T.............
c0000005e85439d0:  c000000000002a94 0000000000000000   .*..............

         crash> sym c000000000002a94
         c000000000002a94 (T) hardware_interrupt_common+0x114

c0000005e8543a20:  7265677368657265 c0000000013e4d00   erehsger.M>.....

         /* Mark stacktraces with exception frames as unreliable. */
         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[1]:
c0000005e8543b90:  c0000005e8543bf0 c000000001960a00   .;T.............
c0000005e8543ba0:  c00000000001b514 0000000000000004   ................

         crash> sym c00000000001b514
         c00000000001b514 (T) __switch_to+0x264

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[2]:
c0000005e8543bf0:  c0000005e8543cd0 c000000000003300   .<T......3......
c0000005e8543c00:  c000000000a83918 c0000000013e4d00   .9.......M>.....

         crash> sym c000000000a83918
         c000000000a83918 (t) __schedule+0x428

	   [ ... and so on as we would normally expect ... ]


Example 3 (upstream 4.20)
=========================

This is not a repro of the sticky "unreliable" stack trace, but just the
stack of a workqueue that fired and called msleep.


crash> struct task_struct.thread c0000002257f0e00 | grep ksp
     ksp = 0xc00000022715f9b0,

crash> rd 0xc00000022715f9b0 100

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[0]:

c00000022715f9b0:  c00000022715fb90 c00000023f4e8280   ...'......N?....
c00000022715f9c0:  c00000022715f9e0 0000000000000003   ...'............

         crash> sym c00000022715f9e0
         c00000022715f9e0 (B) _end+0x22594f9e0

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[1]:

c00000022715fb90:  c00000022715fbf0 c00000000158634c   ...'....LcX.....
c00000022715fba0:  c00000000001ebfc c000000001318a60   ........`.1.....

         crash> sym c00000000001ebfc
	c00000000001ebfc (T) __switch_to+0x2dc

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[2]:

c00000022715fbf0:  c00000022715fcd0 c000000000008800   ...'............
c00000022715fc00:  c000000000abcf40 c0000000013abf00   @.........:.....

         crash> sym c000000000abcf40
	c000000000abcf40 (t) __schedule+0x3b0

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sp[3]:

c00000022715fcd0:  c00000022715fd00 2c50fff000000000   ...'..........P,
c00000022715fce0:  c000000000abd628 c00000023bff57e8   (........W.;....

         crash> sym c000000000abd628
	c000000000abd628 (T) schedule+0x48

			    [ ... etc ... ]


save_stack_trace_tsk_reliable
=============================

arch/powerpc/kernel/stacktrace.c :: save_stack_trace_tsk_reliable() does
take into account the first stackframe, but only to verify that the link
register is indeed pointing at kernel code address.

Can someone explain what __switch_to is doing with the stack and whether
in such circumstances, the reliable stack unwinder should be skipping
the first frame when verifying the frame contents like 
STACK_FRAME_MARKER, etc.

I may be on the wrong path in debugging this, but figuring out this
sp[0] frame state would be helpful.

Thanks,

-- Joe
