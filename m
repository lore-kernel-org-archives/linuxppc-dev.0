Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A3606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=681BB8d+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBDTR3vYqz2xjh;
	Sat, 24 Oct 2026 07:02:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792785771;
	cv=none; b=iNUESxXlwWBk+aUIubnq0RdaS1bCym76n3QhJF0DwtO1/S99Ky6vE9eDOVcPfaRv6maBMMjeJYZ4w2vKkiS/VClQPbbvTrfZS/ddpRdKimPQBXARqG6saEWYWqI8K16L17kNSABxbCMMzlwqEVExwosbC36WvlxVGfEyEoDivOnzQjX5H4JXBLWLkp3SUJ6GxvL+6XMRkd9yZZrrHfbppxiK6Gell+RSkOVqUsILDp2BGGvFNms67lwOuVGCcO1PG3HBYVylqYuRoWRJxAEFkBTCaWAh1Z2PVg8OKzUknXT1UOMAXqdiWTqjSq6BMtYiDFpD2ug0CPINB9GUSsUhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792785771; c=relaxed/relaxed;
	bh=d97B7DGSwYnjTm5Kwz4PWWCWdPZ6fPA043aH/oFYy/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmmDvhWUfqqbWfk+6FswzH/Amj9s4JAMP/W1g7URZjtVeDiIeu1C2jnHsu0638zwn940c6llzx+ET19sE2YY+lrJ6wQh9coyXjTlUl1+QkfkSHVbB0D/XF3/CWTHP5pmTPL6AavSwWvGCSx2/5HsdYsN8/SFynINmZbVTMrUt0IkXzS1ageflyZu+m94SdTOGlN04GWey5jW3uvbWsDj+CDvOVM+mKwyA0IdXjvp8KFLnNv80q+PKb+tO2w7z1UNQagdSiRunVHO7dZOesPEA88TkNTJpfI1lIaDhjSvsYAneNSvRTpa68Vp39tUqpvfJdGfMMyu0i1DlsGrzG2Gug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=681BB8d+; dkim-atps=neutral; spf=pass (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=681BB8d+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBDTN3LrJz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 07:02:47 +1100 (AEDT)
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6288814020D;
	Fri, 23 Oct 2026 20:02:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E01D520012;
	Fri, 23 Oct 2026 20:02:38 +0000 (UTC)
Date: Fri, 23 Oct 2026 16:02:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use raw_local_irq_pmu_save/restore() in
 local_t functions
Message-ID: <20261023160237.2e24b2e6@gandalf.local.home>
In-Reply-To: <d9660f99-c230-4107-a89c-c62e0b3e7f03@redhat.com>
References: <20261023155529.3895393-1-jmarchan@redhat.com>
	<20261023130943.775b2b65@gandalf.local.home>
	<d9660f99-c230-4107-a89c-c62e0b3e7f03@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E01D520012
X-Stat-Signature: ki5tx63i5thngxz9az4j194cbjmyrzj5
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19upykk7vjP7AE3xFI+T0cfvyIJLuFTCfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=d97B7DGSwYnjTm5Kwz4PWWCWdPZ6fPA043aH/oFYy/8=; b=681BB8d+n/B3WE+LWMOAnGrny0y4vK4ZQw62dVF1byKD+K6WTsncjUswCQGIeeCWGxd/2ukTEZ2369G2xYpIpBtQxi5/aXHyjGgkgbZjiklrO5W0yA4YOz18pgXEddGUAoDVywKGc1JuCnNFLy5wAI1cXmMWxdZVBIgYKEwKr3I=
X-HE-Tag: 1792785758-982417
X-HE-Meta: U2FsdGVkX18pFf7PQhBjFORmMestaCa8SS3iYWvAt1qqi0EwMsSyPI0Nn+ZWDAGTqtUfjpz9Zwn6GI2ztqCat52ZCtA2+YRZhtoLVV04twEj10c3YqDdMosrcf0Oi0yyPOsClamY9KxDdz/zP/IodW/tdkFRRr9Plw/Bx1g0fiOVBtt60+lFFr6gYp2WVt9LD3PpEO7D77DTfnetGLJ4TSb/MZNKGbOgeXazrx53iwSrxvmtDtHZ4VCbjJlSO6CjFugg6HFUljVNE/Xv+F7lJJPDcG/n8vfQ9E6HkuFweMwz9toaFX8tu9Gip7m+DmwPnztJ/0s/Ere/+W56Sd+cZZJUTGE3+upO
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 21:11:52 +0200
Jerome Marchand <jmarchan@redhat.com> wrote:

> I might have jumped to conclusion when I found the recursion and the
> peculiarity of the powerpc local_t functions. I now think that the issue
> lie in loop in powerpc arch_local_irq_restore() (goto again label). That
> somehow it keeps replaying the soft interrupt when event tracing is on
> and CONFIG_TRACE_IRQFLAGS is enabled.
> 
> Here the output of the watchdog where we can see that most time is spent
> in softirq:
> 
> [257154.724054] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:107460]
> [257154.724084] CPU#2 Utilization every 4000ms during lockup:
> [257154.724099] 	#1:   0% system,	100% softirq,	  1% hardirq,	  0% idle
> [257154.724120] 	#2:   0% system,	100% softirq,	  1% hardirq,	  0% idle
> [257154.724141] 	#3:   0% system,	100% softirq,	  1% hardirq,	  0% idle
> [257154.724161] 	#4:   0% system,	100% softirq,	  2% hardirq,	  0% idle
> [257154.724182] 	#5:   0% system,	100% softirq,	  1% hardirq,	  0% idle

Yeah, the 100% softirq could be suspect.

-- Steve


> [257154.724203] Modules linked in: bonding tls rfkill binfmt_misc pseries_rng ibmveth vmx_crypto vsock_loopback zram vmw_vsock_virtio_transport_common vsock lz4hc_compress ibmvscsi scsi_transport_srp fuse i2c_dev aes_gcm_p10_crypto crypto_simd cryptd
> [257154.724399] irq event stamp: 0
> [257154.724410] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [257154.724471] hardirqs last disabled at (0): [<c0000000002b04b8>] copy_process+0x1418/0x34e0
> [257154.724516] softirqs last  enabled at (0): [<c0000000002b04b8>] copy_process+0x1418/0x34e0
> [257154.724558] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [257154.724621] CPU: 2 UID: 0 PID: 107460 Comm: cat Tainted: P        W           7.2.0-rc4 #1 PREEMPT(lazy)
> [257154.724654] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN
> [257154.724665] Hardware name: IBM,8247-22L POWER8 (architected) 0x4b0201 0xf000004 of:IBM,FW860.81 (SV860_215) hv:phyp pSeries
> [257154.724688] NIP:  c00000000004f50c LR: c00000000004fc84 CTR: 0000000000000000
> [257154.724708] REGS: c0000003affdfa68 TRAP: 0900   Tainted: P        W            (7.2.0-rc4)
> [257154.724727] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24082800  XER: 00000000
> [257154.724819] CFAR: 0000000000000000 IRQMASK: 0
> [257154.724819] GPR00: 0000000000000004 c0000003affdfa30 c000000003c8be00 c0000003affdfa38
> [257154.724819] GPR04: 0000000000000000 0000000000000000 c0000003affdfc08 0000000000000000
> [257154.724819] GPR08: 0050244d39e48235 0000000000000049 fffffffffffffffc 0000000000000002
> [257154.724819] GPR12: c000000000669520 c00000002ec9df00 c0000000060bbd40 c00000000453e200
> [257154.724819] GPR16: c000000006d66b80 c000000004366af0 c00000000280b940 0000000000000007
> [257154.724819] GPR20: c000000006d61100 0000000000000007 c000000024832600 0000000000000103
> [257154.724819] GPR24: 0000000000160003 c00000000c573400 0000000000b5240f c00000000e555fe8
> [257154.724819] GPR28: c00000000e53e108 0000000000000000 fcffffffffffffff c00000002ec9df00
> [257154.725212] NIP [c00000000004f50c] __replay_soft_interrupts+0x6c/0x5f0
> [257154.725255] LR [c00000000004fc84] arch_local_irq_restore.part.0+0x1f4/0x290
> [257154.725299] Call Trace:
> [257154.725309] [c0000003affdfa30] [c00000000004f6dc] __replay_soft_interrupts+0x23c/0x5f0 (unreliable)
> [257154.725369] [c0000003affdfc30] [c00000000004fc84] arch_local_irq_restore.part.0+0x1f4/0x290
> [257154.725423] [c0000003affdfc70] [c0000000006946dc] rb_commit+0x50c/0x620
> [257154.725468] [c0000003affdfcf0] [c0000000006992cc] ring_buffer_unlock_commit+0x6c/0x3c0
> [257154.725514] [c0000003affdfd40] [c0000000006ae9c8] trace_buffer_unlock_commit_regs+0x118/0x2a0
> [257154.725569] [c0000003affdfda0] [c0000000006aec74] trace_event_buffer_commit+0x124/0x3e0
> [257154.725623] [c0000003affdfe10] [c0000000002cae68] trace_event_raw_event_softirq+0xb8/0x170
> [257154.725675] [c0000003affdfe90] [c0000000002cc964] handle_softirqs+0x864/0xc00
> [257154.725725] [c0000003affdffe0] [c00000000001cd1c] do_softirq_own_stack+0x5c/0x90
> [257154.725777] [c000000040b279e0] [c00000000001cce4] do_softirq_own_stack+0x24/0x90
> [257154.725827] [c000000040b27a10] [c0000000002c9ff8] __irq_exit_rcu+0x458/0x560
> [257154.725876] [c000000040b27a60] [c0000000002cd72c] irq_exit+0x2c/0x90
> [257154.725924] [c000000040b27a90] [c00000000004fc88] arch_local_irq_restore.part.0+0x1f8/0x290
> [257154.725978] [c000000040b27ad0] [c0000000006942b0] rb_commit+0xe0/0x620
> [257154.726021] [c000000040b27b50] [c0000000006992cc] ring_buffer_unlock_commit+0x6c/0x3c0
> [257154.726067] [c000000040b27ba0] [c0000000006ae9c8] trace_buffer_unlock_commit_regs+0x118/0x2a0
> [257154.726122] [c000000040b27c00] [c0000000006aec74] trace_event_buffer_commit+0x124/0x3e0
> [257154.726175] [c000000040b27c70] [c000000000527c4c] trace_event_raw_event_sys_exit+0xcc/0x180
> [257154.726222] [c000000040b27cf0] [c00000000052837c] trace_syscall_exit+0xec/0x1e0
> [257154.726266] [c000000040b27d70] [c0000000000440e8] syscall_exit_prepare+0xce8/0xde0
> [257154.726315] [c000000040b27e30] [c00000000000d6ac] system_call_common+0x16c/0x2c4
> [257154.726368] ---- interrupt: c00 at 0x7fff9f08f8b0
> [257154.726421] NIP:  00007fff9f08f8b0 LR: 00007fff9f070a20 CTR: 0000000000000000
> [257154.726440] REGS: c000000040b27e60 TRAP: 0c00   Tainted: P        W            (7.2.0-rc4)
> [257154.726458] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000802  XER: 00000000
> [257154.726582] IRQMASK: 0
> [257154.726582] GPR00: 000000000000007d 00007fffca534fd0 00007fff9f0b7f00 0000000000000000
> [257154.726582] GPR04: 0000000000010000 0000000000000001 0000000000000000 00007fff9f0b0b40
> [257154.726582] GPR08: 000000000005edb0 0000000000000000 0000000000000000 0000000000000000
> [257154.726582] GPR12: 0000000000000000 00007fff9f0ba580 00000001359c09b8 0000000000000000
> [257154.726582] GPR16: 00007fff9f0b3580 0000000080001000 00007fff9f0984c8 00007fffca535420
> [257154.726582] GPR20: 00007fff9f0b0b40 0000000000000000 00502449f00961a6 00007fff9f0b0cc8
> [257154.726582] GPR24: 0000000000000000 00007fff9f0b0cd0 00007fff9f0afbe8 fffffffffffffff8
> [257154.726582] GPR28: 0000000000000000 000000000002fd2d 00007fff9f0b12f0 00007fffca535000
> [257154.726956] NIP [00007fff9f08f8b0] 0x7fff9f08f8b0
> [257154.727011] LR [00007fff9f070a20] 0x7fff9f070a20
> [257154.727063] ---- interrupt: c00
> [257154.727075] Code: 39200000 48178df1 60000000 7dbf6b78 386d0933 48b427e9 60000000 893f0933 38610038 61290040 993f0933 481176d1 <60000000> e9210140 7dbe6b78 386d0933


