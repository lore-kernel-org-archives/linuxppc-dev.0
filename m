Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73328606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EepsqkPd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc9fQ0xrqz2xLg;
	Sun, 29 Nov 2026 00:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795871502;
	cv=none; b=dXchWOU1xSxgcwyz9AXTNgDE+mcyFoFKGINzpCzn1Jt2XZi3corx++Ec22zv/2s7MggQOoUXJzuItXUOZb5koaqaCze/C3/CwIPHFjM9/e8kQtyx13s2eNlPLEW9RbsS8b/nVJNOXrFfzmcHbqPfpH3Tkw7kvBuMUnzh+MJ8YRT3tEgW5PWhGofodII1xZhY8bPYJ0hM/kaigwu3N2pBkTClJf0xzjPx5AV4enhG31jK7tE0iYWj6XOnRJVYRWdscWdVhiRVijQVu+VZdYtlVxVNCtTV1et574HpBCqMTfDAVdJoCj3xiqxnkDlxcxELnxw0ykM8dUohAV94hXqETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795871502; c=relaxed/relaxed;
	bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=mtgUdWT2aFjKcV8bwKLi89wayppzk2cSo38H0c0J1V9S3sqmb93OH0h9b1qnCWlQxy2P2EiQi4HAGuDT/DQKXrIBy5PhAsjJSsvs1+N8uoX9h8fMTF83UlBZMz88PCtnMOJmdxm8MLEDbgC5U9H1EO9mkVu4maOABJH4rPuMQ6/bLac2pZIItd15lEWtaEquCluhw/YWgqWykzP1BGtLdmNRZqKsFGNU+cBJG+Z2NFjTrtiQmIGSyRZ+zbsZGY+3bc3qAb+OIeiPssubCsxPfozOhiLH9NOauBN2eOClPtyMcYvICsUJUBM3P3gazCE6Pxyri7C0d1cd5jzXHj/uWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EepsqkPd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EepsqkPd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc9fN25XQz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2026 00:11:39 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-386bd881d39so71404eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795871497; x=1796476297; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
        b=EepsqkPdYHSNxHm5VC6p0tKN9L73lzYBytz1Zx/LhuW4QZuxcbDUimuLqmTwf9pHPa
         GRkyb5diMcq4An8ty/QTMnyvdhrt1ToHeXVLXVze9X2zqDn7OUUbNWNxYthl3VVxoB0Q
         xWrikC8SIEZAd55a7jtn332EbdWafXyG/lYYk5v3D5OfQihbYSh7KEfm4TzS7zOyLJkH
         FLKJIGW3FytEH+U1w3iXsCO8Mz+hIXCM3qoea8m2r7nnsBQ5tqUZzzA+5JFo6S9/hw36
         itLOCFpFqr9pFyfz3fzx9f1sD6gHZmSnY7Q58PCZZEgr4tt/1MQPoCSzJ9R+1djd30gD
         MyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795871497; x=1796476297;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
        b=P29TV6jnhw5VixxQ9D4MZ4Ti5HZo+2J05iPJpGGVoXMweVh65NuL0UTZ3SqqP8enZR
         yOiKC7iViZR2Tv4tx+RiyKyHpUWLRB434O+bTIbsnFOnp5T1Tz0kEawuazijxl/yIKI1
         IMJZLDBZyj0JhJYJxFhZSsq/Ws+bVMcQMZCt3+yujizRqKEMf/iN58e9NTPr65ibulUO
         MUH7ZXqIvoWkqtFrlAvwa2jnoIqTsIwiWL6721n03aBRvjUr+2paIItvDkwl23KqSCWt
         KJIgxM1ft0xuz+D6jTUMRr6jZuIY+49Wbbh4zZQaGo/2EG1YqBb2OxJHcFPdXiEqpdxt
         Z+3A==
X-Gm-Message-State: APuU4Z+lu7hYHoJgbiw7DEGN4uF8djyMaEPpGU6cIYxrChg0K5Wt9z+m
	vraSBw7AfvuNlxhwk7GUG+VdCwxjkQyiycX7gs1CTWqq1Pso1s8G5Xua
X-Gm-Gg: AZFdTZf71LiAsr3sDtpGabT25VPGvuLCmScx2GMG5RN6rtA0ePNgReetb9HLNpxDmNq
	FxEFnizBh304kKazXbQzgn7xnr14XOSgatX/c3dNsG/zeSPDO+wPt3B1Dg9nCToiqwNkiMnXRBs
	ax8L4z4Yke6uS3AlIdU72GzSvUGC7bZG+238lyu1Kno7fzsgsg41MRdzVDrLzR5wdYv/DZmu3Cf
	gknQZ2CD2k3LEWdwAV+6n0/vz+oRMLFRg8mugXkkGxVvueqpB5wZ0ajaxJzo5vza+vPHXCd+Woj
	R4PrdeleFmhZZyf/u959UD7EYe1E0O5fBwMSUSunCA6a+L8k8cCuKf/LSPmk/KhbFuhcUafoZt0
	FmZj25I3OdHPEDyeFd+/gv4XR4XNCnkZCf4wSDmoen7sKzJCuam62fBmEkRVB/YSq7nU/ZY1Cd7
	ZummOPq5e1qrc/WCKIvJ6YNenYbxCYMn9Nshc/NPulP0JtQVOCAvRo4eclOhuo+o9j+r3PIlrIZ
	UT/6bOL+mzwnjRpO+aXY7VqDHuMXNSp0E+RZ5dPI8sO7gnRDYSfHV0BtL/B0nDQOOXyqa6+gt1J
	MWsfoDchFSKHoRs73bDYRSl43MQ=
X-Received: by 2002:a05:7301:b02:b0:382:48a5:cd53 with SMTP id 5a478bee46e88-3857111f187mr29171697eec.31.1795871497156;
        Sat, 28 Nov 2026 05:11:37 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm49634928eec.9.2026.11.28.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:11:36 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <jylzkbvr.ritesh.list@gmail.com>
Date: Sat, 28 Nov 2026 18:37:29 +0530
Message-ID: <33slw1da.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <o6bdjkq1.ritesh.list@gmail.com> <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org> <jylzkbvr.ritesh.list@gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Christophe,

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>
>> Le 25/11/2026 à 10:58, Ritesh Harjani a écrit :
>>> Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:
>>> 
>>>> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>>>>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>>>>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>>>>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>>>>>
>>>>>    root@buildroot:/# echo w > /proc/sysrq-trigger
>>>>>    sysrq: Show Blocked State
>>>>>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>>>>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>>>>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>>>>    Call Trace:
>>>>>     dump_stack_lvl+0x138/0x150 (unreliable)
>>>>>     check_preemption_disabled+0x120/0x158
>>>>>     arch_touch_nmi_watchdog+0x3c/0xd4
>>>>>     show_state_filter+0xf0/0x338
>>>>>     sysrq_handle_showstate_blocked+0x24/0x38
>>>>>     __handle_sysrq+0x134/0x3a8
>>>>>     write_sysrq_trigger+0x178/0x22c
>>>>>     proc_reg_write+0xf4/0x150
>>>>>     vfs_write+0xfc/0x71c
>>>>>     ksys_write+0x8c/0x150
>>>>>     system_call_exception+0x310/0x590
>>>>>     system_call_vectored_common+0x15c/0x2ec
>>>>>    ---- interrupt: 3000 at 0x7ffd01755b98
>>>>>
>>>>> Unlike the generic version, which only sets a flag, we update the CPU's
>>>>> timebase stamp and its SMP watchdog pending bit, so a migration in
>>>>> between touches the state of a CPU we are no longer on.
>>>>>
>>>>> Disable preemption across the update. While at it, let's also mark the
>>>>> function as notrace (since we might be within a tracer when this
>>>>> function gets called).
>>>> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>>>>
>>> 
>>> aah yes, I didn't see that there is another function which is not
>>> inlined. Thanks for spotting that. The reason I added "notrace" was
>>> mainly to have consistency with kernel/watchdog.c which is due to this
>>> commit:
>>> 
>>> cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")
>>> 
>>> 
>>> However, after looking more closely now, I don't think we need notrace
>>> here at all. To simply put, on powerpc, we don't use stop_machine() from
>>> within arch_ftrace_update_code() like how arch/arm does and besides, I
>>> think it is even safe for one cpu to be executing the instruction on
>>> powerpc, while another cpu modifying that atomically.
>>
>> But haven't we identified in another discussion that it might be needed 
>> to use stop_machine() ? See 
>> https://lore.kernel.org/all/qzh06fxn.ritesh.list@gmail.com/
>>
>
> Yes, that is why I also quoted second reason too on why we don't need it
> on powerpc. But here is the detailed explaination of what I understood -
> while looking at the history of changes on why "notrace" was added to
> some arch (like arm or to the generic definition) in the first place.
>
> On ARM, ftrace call sites were patched under stop_machine() and the code
> used to rely on other CPUs not executing any call site meanwhile. (Note
> that this itself is not needed on PowerPC see commit ee456bb346e7).
> However, with a THUMB-2 instruction set on ARM, a 4byte instruction is
> only 2 byte aligned, so while patching the instruction it can result
> into a 2 x 16bit stores. Now after commit ce4f06dcbb5d ("stop_machine:
> Touch_nmi_watchdog() after MULTI_STOP_PREPARE"), stopped cpus started
> calling the watchdog touch functions (which were not marked notrace yet)
> from multi_cpu_stop(), so a stopped cpu could therefore execute the
> ftrace call site of those functions between the two stores. This
> resulted into kernel crashes as seen on ARM while enabling/disabling
> ftrace on ARM kernels built with THUMB-2 instruction set.
> Therefore commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> as notrace") was needed on ARM to fix these crashes.
>
> So I still think we don't need a "notrace" on arch_touch_nmi_watchdog()
> on powerpc, even if tomorrow, we extend the use of stop_machine() for
> patching usecase, as we discussed on that other thread.
>

Just wondering if this answer your concerns? I see that others have
provided their Tested-by on v4 of this patch series. If that looks ok to
you - I was hoping if we could get that series queued up in powerpc's
next. Thoughts?

-ritesh


