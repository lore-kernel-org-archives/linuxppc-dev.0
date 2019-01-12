Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1384C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 01:10:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBF220870
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 01:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpeHnrIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBF220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43c1rZ6qjhzDr6b
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 12:10:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VpeHnrIn"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43c1pm726HzDr5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 12:09:20 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id y4so7009943pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XlXUPbxPbc6dFamk7UVLDAA4k4Zc1CWGAZOER/iHJA8=;
 b=VpeHnrInLHCLSTwP5nhE/p5hwoy1puz6lVfa28+/eczPGL3o9W9hzZHjyJDTrbv9KR
 0YjUqhOT5BEQLbW9kaZWx5V/nfTVZY+LS+IkLuzHYQcJonCNGwVY4Sq4B+euZ5pxNbUJ
 GQU7p9MpwxRIpRNgvhNiEAn+izhYuIqCMiVAO4pXYHWb39lxI7HqIhe9sRcckKql35UJ
 4SgtfwDEBPNDIOoINJH7OVly5T6vIJZYr1R4Nhz/I0XQZ+5Z3zLrZ4zGzhK6VILGVUXK
 KQBLLQhylcUidM1RX6R4CyDe6H94l3+GsusHWA0eh944lctkmGoPiU1eEwZYcODm7mHG
 klKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XlXUPbxPbc6dFamk7UVLDAA4k4Zc1CWGAZOER/iHJA8=;
 b=WyQqU2NohbkyrT1BEz9Or/SOrqJdMKfAyyS+p81V3P2/r34tWWNonuJTT1kTYUOlCP
 xL15m7kvOh51dtbmdKu96uASHjLSovIeJ/QUCt5S8RheZ51B/B1BL6xmFUFkY5Q9Vag2
 jmo64qUUoa6OK1TmxzefM1/e7qdt+U3yv027CsEfOPZxK/KNmxxGaDNS2hK1h5ERX+6G
 JVaI0607XJtP3y5uQ0Z0BlGUlgw9sVkQyVSDCdkFkTJ4yUuk8pfDYaTkYk4cSn9GHPjJ
 tbYl37Bm96/OD2ZimaIDCVHBEdb1getd36kzFDamFOUp6AsWEHjCUo+kKvod2HIr/Q68
 wQGw==
X-Gm-Message-State: AJcUuke8yWRoiMzg4rMADpIa13vS/4ERPtpDJgemDRVAacgM4uJVammk
 fLp4oK4QyLE8+M5OhycUHGU=
X-Google-Smtp-Source: ALg8bN6REqyT7Q6CUsv1MEk8iIoqG0o/uHOGTtbwBDHjdxeMuqPBH3VvfcewkKX5+kQjZCm1xiRlqQ==
X-Received: by 2002:a62:9657:: with SMTP id c84mr17163528pfe.77.1547255357974; 
 Fri, 11 Jan 2019 17:09:17 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 y6sm148083877pfd.104.2019.01.11.17.09.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 17:09:17 -0800 (PST)
Date: Sat, 12 Jan 2019 12:09:14 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190112010914.GB10427@350D>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 04:14:00PM -0500, Joe Lawrence wrote:
> Hi all,
> 
> tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
>        about?
> 
> I am looking at a bug in which ~10% of livepatch tests on RHEL-7 and
> RHEL-8 distro kernels, the ppc64le reliable stack unwinder consistently
> reports an unreliable stack for a given task.  This condition can
> eventually resolve itself, but sometimes this state remains wedged for
> hours and I can live-debug the system with crash-utility.
>

In summary, you think the reliable stack tracer is being conservative?
xmon (built in debugger) also allows for live-debugging and might
be more easier to get some of this done.
 
> I have tried reproducing with upstream 4.20 kernel, but haven't seen
> this exact condition yet.  More on upstream in a bit.
> 
> That said, I have a question about the ppc64 stack frame layout with
> regard to scheduled tasks.  In each sticky "unreliable" stack trace
> instance that I've looked at, the task's stack has an interesting
> frame at the top:
>

Could you please define interesting frame on top a bit more? Usually
the topmost return address is in LR
 
> 
> Example 1 (RHEL-7)
> ==================
> 
> crash> struct task_struct.thread c00000022fd015c0 | grep ksp
>     ksp = 0xc0000000288af9c0
> 
> crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[0]:
> 
> c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
> c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............
> 
>         crash> sym c000000000002a94
>         c000000000002a94 (T) hardware_interrupt_common+0x114

What does bt look like in this case? what does r1 point to? I would
look at xmon and see what the "t" (stack trace) looks like, I think
it's a more familiar tool.

> 
> c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
> c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
> c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
> c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
> c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......
> 
>         Uh-oh...
> 
>         /* Mark stacktraces with exception frames as unreliable. */
>         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER
> 
> c0000000288afa30:  c0000000001240ac c0000000288afcb0   .@.........(....
> c0000000288afa40:  c0000000013e4d00 0000000000000000   .M>.............
> c0000000288afa50:  0000000000000001 0000000000000001   ................
> c0000000288afa60:  c0000000014322e0 0000000000000804   ."C.............
> c0000000288afa70:  c0000000288ac080 c00000022fd015c0   ...(......./....
> c0000000288afa80:  c0000000288afae0 00000000ffffffff   ...(............
> c0000000288afa90:  c0000000288afae0 c000000007b80900   ...(............
> c0000000288afaa0:  c000000000e90a00 c000000000e90a00   ................
> c0000000288afab0:  c0000000001240ac c000000000e90a00   .@..............
> c0000000288afac0:  c000000000e90a00 c000000004790580   ..........y.....
> c0000000288afad0:  0000000000000001 c000000000e90a00   ................
> c0000000288afae0:  0000000000000000 0000000000000004   ................
> c0000000288afaf0:  c00000022fd01ad0 c000000000e73be0   .../.....;......
> c0000000288afb00:  c00000023900f450 c000000001488190   P..9......H.....
> c0000000288afb10:  0000000000ad0000 c00000023900ef40   ........@..9....
> c0000000288afb20:  c0000000288ac000 c000000000e73be0   ...(.....;......
> c0000000288afb30:  c00000000001b514 c00000022fd01628   ........(../....
> c0000000288afb40:  c0000000288afbb0 c000000000008800   ...(............
> c0000000288afb50:  c000000000162880 0000000000000000   .(..............
> c0000000288afb60:  00000000240f3022 0000000000000004   "0.$............
> c0000000288afb70:  c000000000e90a00 c00000022fd01a20   ........ ../....
> c0000000288afb80:  c0000000288afbf0 c0000000014322e0   ...(....."C.....
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[1]:
> 
> c0000000288afb90:  c0000000288afbf0 c000000001960a00   ...(............
> c0000000288afba0:  c00000000001b514 0000000000000004   ................
> 
>         crash> sym c00000000001b514
>         c00000000001b514 (T) __switch_to+0x264
> 
> c0000000288afbb0:  c000000000e90a00 0000000000000000   ................
> c0000000288afbc0:  c0000000288ac000 c0000000014322e0   ...(....."C.....
> c0000000288afbd0:  c000000000e90a00 c000000001960a00   ................
> c0000000288afbe0:  c00000022fd015c0 c00000023900ef40   .../....@..9....
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[2]:
> 
> c0000000288afbf0:  c0000000288afcd0 c000000000003300   ...(.....3......
> c0000000288afc00:  c000000000a83918 c0000000013e4d00   .9.......M>.....
> 
>         crash> sym c000000000a83918
>         c000000000a83918 (t) __schedule+0x428
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[3]:
> 
> c0000000288afcd0:  c0000000288afd80 0000000000003300   ...(.....3......
> c0000000288afce0:  c0000000001240ac 0000000000000000   .@..............
> 
>         crash> sym c0000000001240ac
>         c0000000001240ac (t) rescuer_thread+0x3ac
> 
> 	   [ ... and so on as we would normally expect ... ]
> 
> 
> Example 2 - (RHEL-7)
> ====================
> 
> crash> struct task_struct.thread c00000004a660a00 | grep ksp
>     ksp = 0xc0000005e85439c0,
> 
> crash> rd 0xc0000005e8543b90 -e 0xc0000005e8544000
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[0]:
> c0000005e85439c0:  c0000005e8543b90 0000000000000000   .;T.............
> c0000005e85439d0:  c000000000002a94 0000000000000000   .*..............
> 
>         crash> sym c000000000002a94
>         c000000000002a94 (T) hardware_interrupt_common+0x114
> 
> c0000005e8543a20:  7265677368657265 c0000000013e4d00   erehsger.M>.....
> 
>         /* Mark stacktraces with exception frames as unreliable. */
>         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[1]:
> c0000005e8543b90:  c0000005e8543bf0 c000000001960a00   .;T.............
> c0000005e8543ba0:  c00000000001b514 0000000000000004   ................
> 
>         crash> sym c00000000001b514
>         c00000000001b514 (T) __switch_to+0x264
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[2]:
> c0000005e8543bf0:  c0000005e8543cd0 c000000000003300   .<T......3......
> c0000005e8543c00:  c000000000a83918 c0000000013e4d00   .9.......M>.....
> 
>         crash> sym c000000000a83918
>         c000000000a83918 (t) __schedule+0x428
> 
> 	   [ ... and so on as we would normally expect ... ]
> 
> 
> Example 3 (upstream 4.20)
> =========================
> 
> This is not a repro of the sticky "unreliable" stack trace, but just the
> stack of a workqueue that fired and called msleep.
> 
> 
> crash> struct task_struct.thread c0000002257f0e00 | grep ksp
>     ksp = 0xc00000022715f9b0,
> 
> crash> rd 0xc00000022715f9b0 100
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[0]:
> 
> c00000022715f9b0:  c00000022715fb90 c00000023f4e8280   ...'......N?....
> c00000022715f9c0:  c00000022715f9e0 0000000000000003   ...'............
> 
>         crash> sym c00000022715f9e0
>         c00000022715f9e0 (B) _end+0x22594f9e0

That is weird, can you compare this to the output of "bt" or "t"
from xmon?

> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[1]:
> 
> c00000022715fb90:  c00000022715fbf0 c00000000158634c   ...'....LcX.....
> c00000022715fba0:  c00000000001ebfc c000000001318a60   ........`.1.....
> 
>         crash> sym c00000000001ebfc
> 	c00000000001ebfc (T) __switch_to+0x2dc
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[2]:
> 
> c00000022715fbf0:  c00000022715fcd0 c000000000008800   ...'............
> c00000022715fc00:  c000000000abcf40 c0000000013abf00   @.........:.....
> 
>         crash> sym c000000000abcf40
> 	c000000000abcf40 (t) __schedule+0x3b0
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> sp[3]:
> 
> c00000022715fcd0:  c00000022715fd00 2c50fff000000000   ...'..........P,
> c00000022715fce0:  c000000000abd628 c00000023bff57e8   (........W.;....
> 
>         crash> sym c000000000abd628
> 	c000000000abd628 (T) schedule+0x48
> 
> 			    [ ... etc ... ]
> 
> 
> save_stack_trace_tsk_reliable
> =============================
> 
> arch/powerpc/kernel/stacktrace.c :: save_stack_trace_tsk_reliable() does
> take into account the first stackframe, but only to verify that the link
> register is indeed pointing at kernel code address.
> 
> Can someone explain what __switch_to is doing with the stack and whether
> in such circumstances, the reliable stack unwinder should be skipping
> the first frame when verifying the frame contents like STACK_FRAME_MARKER,
> etc.
> 
> I may be on the wrong path in debugging this, but figuring out this
> sp[0] frame state would be helpful.
>

I would compare the output of xmon across the unreliable stack frames with
the contents of what the stack unwinder has.

I suspect the patch is stuck trying to transition to enabled state, it'll
be interesting to see if we are really stuck

Balbir Singh.
