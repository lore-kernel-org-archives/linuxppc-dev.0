Return-Path: <linuxppc-dev+bounces-18527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171D71099B59
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 01:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd25D0gCgz2yVP;
	Sat, 21 Mar 2026 12:33:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774056816;
	cv=none; b=g+LlpcwPjuQUy4pGEesclLKJu1x6ZZbPWKLpzvh4LTZ0NNMZYd18YTTlx8BDRcvtuCeH7sgeh8eyoNQj7zrQIHeSEyaijjbhe78u9KBFAS8ExKym9Ak5QcIGXyEm63DFx6ooQjP7EFyJrqykbfgxdOqQX8CIj29tGtvKgQqLtusExPOq3gMX5Aa2viXTy6y5M+CvATCF9yNmzNJzJHUZlUZCbyPpom6CHwSOSFX/vfgc2G+JMTSXlKYBjw1l+sEHlLLZWtsoFI+qUiyN9gDVUu/pV+ficiKmj99vvn5YA2yapr1ocQRJjZchbNQxG3LtFEfJ5PMGX5gZ9mPrrEP/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774056816; c=relaxed/relaxed;
	bh=vqCvjJm0bWKZTBGX1/5T2XI0o4s04odjPkD7DfRdD1M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=FL+GaU6zxqnT+r+jaqAc+Vxk1OKfgKvTvARLsQLmHvBwsOfJpYvxLPkQOFf2sQY0XAIeaTWeb1ZAdmJ0BRFmqDUBQTgCV+Xqmw+RzbOy1Vi7U+B9esqBjHXmgylhpEghuOey6l2YDdWw1QFh2a7H5Q0O79Egr6Ziq3hPYcR9eqgh27mMDknzQbd09Y9Gfz+Ap6gzDpgnOJ3e0W9jHzglMK3t97wsLSllxYfv7h1sCVm61gK9fwNLgYWP6hyBqcb+X7mn1JXcNTuN7gF6pVDtJxhLPzYFQNjqisiSm5WlcpYo5nSd68e3MkRy5Kv3NOy/XV4aMqQSHfGj3BhQ0sXRsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6I5mpCF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6I5mpCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd2593Rsfz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 12:33:32 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82985f42664so1719972b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774056809; x=1774661609; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqCvjJm0bWKZTBGX1/5T2XI0o4s04odjPkD7DfRdD1M=;
        b=d6I5mpCFDzMOFGADzjo1M6i7fqQWjPjHLux18NjFnuhK7vfhleY/VPNFstLJM13ByB
         ycdWOkQqAM2ZZV7pNSgvukLCGpjygAdfuTh92UzL2INOBQYYzzjiGGGpcjvKTGp0FEO7
         AVQIfYYrxBa688mz8kJ33rCpkD+MndBm64GotDJDpUz9NYixH5Gdk0K3ZhDZtmQjTrJp
         0O8ua1C55tfRr5XQEBCFyy9iTyBgjiWndVvilctoLPp0fGhIVpV2tk2miGBj021NdJKn
         kNRkMJEbuDLRr0FqFhWQJdcygWb4CbnM5uG2E0o8a9sKAxdkdTCqnFWn0M9g5QZ+mVgc
         2cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774056809; x=1774661609;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqCvjJm0bWKZTBGX1/5T2XI0o4s04odjPkD7DfRdD1M=;
        b=qajSp0S3R3CyVpU2aoQzs/FijBTFvRCm8+pNmkDS+pezyo38HMdGF8iaJxZ2sfgwGK
         SMq+lNG+7EsZ1Lg9HrEDPgp2xRm5BKlLsYOQjzC24hhpWbw6bwyTY+y1XXcoI6aBGUlj
         aL8xbLgRR+oK7pqIB9owcvsbkTMUGbHZpeL01FYTfxu+9AJE2CVFr6Zz6bCp+sNpfF3Q
         1Bi6S440GLpkDYx08uVbVDFillUnBUtRRndf7kLzmgZxzVzaw6ZY2vHVosGfnhTln6QE
         z2PMhz5APO3WlNqSwuRdVTnSM7Vhc+ARWMutrbk5D6dYKU/sEETjE/ZAYw6v0kLw9PKJ
         tWVA==
X-Forwarded-Encrypted: i=1; AJvYcCU3eP9iesLUxTZgPpJOe+BylNz8g5sdUX2GJCQM65wfmvEa4jdzgDBM1kV4yNl4AVriaXU4fnZHAVWlezc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJJfQvDs44HW+Q9GZtzabLXvbHMkJ+SCTJgaZ/GaT6jctf+nNW
	Xd5kcSEky6EZA+vJq4blLIh0CcZtw65e4th5MLInYw+/vw9MwJc8sIYx
X-Gm-Gg: ATEYQzz8uyGXlel3XN9oT4LZkLRGMe3VX0nWXPHjI9HqQj5gzOTjZtGMMD0krKcxSB5
	hNOlIYn4L0z9dQpe5MprLl94pmdi0EvMRqT3iE7WfUiYbWJ30F1FSt4idpw0KrLu38ZA9HJ2gzH
	oDMD2SmLYZnknSE34rdTC5kiZW08w8LOrnQmzpYfHUYXcXwXJoCPdSJOgTNXfPqkV1bcPbWaepZ
	fk0ZCQhU0Hezh8oxx6lnaB6T2dW6x7fgZi7T1gucgrJUZosjANf+NoobHPulZO6zhpaGyF8BgTC
	6mVGcMmaqhZwLzynnxplzG7myzW8Dpuw+1DSkrjIaKSEi3fofOVqL7TsPOuck9tf+VM97amBtPF
	1KLqGcw9U+ri8tcImitcREmZ/Oa/AahRlk4pgdRF2qimH618ok3Pz9+fv4aPkHWaRI0Z8zvY7ky
	6OcY5JTMIHZraiBnIv6S+2Mw==
X-Received: by 2002:a05:6a00:1397:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82a8c25fa6cmr4148762b3a.16.1774056809329;
        Fri, 20 Mar 2026 18:33:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa9fc6sm3253724b3a.7.2026.03.20.18.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 18:33:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Harry Yoo (Oracle)" <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com> 
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in QEMU on -next
In-Reply-To: <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
Date: Sat, 21 Mar 2026 06:42:41 +0530
Message-ID: <h5qax9x2.ritesh.list@gmail.com>
References: <20260319233745.GA769346@ax162> <abzKcGiRSR_E8lLN@hyeyoo> <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com> <ab1J9ODkX5iChu-C@hyeyoo> <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com> <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
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


++ linuxppc-dev

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> On 2026-03-20 09:31, Mathieu Desnoyers wrote:
>> On 2026-03-20 09:21, Harry Yoo (Oracle) wrote:
>>> On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
>>>> On 2026-03-20 00:17, Harry Yoo wrote:
>>>> [...]
>>>>>> [1]: https://lore.kernel.org/20260227153730.1556542-4- 
>>>>>> mathieu.desnoyers@efficios.com/
>>>>>
>>>>> @Mathieu: In patch 1/3 description,
>>>>>> Changes since v7:
>>>>>> - Explicitly initialize the subsystem from start_kernel() right
>>>>>>     after mm_core_init() so it is up and running before the 
>>>>>> creation of
>>>>>>     the first mm at boot.
>>>>>
>>>>> But how does this work when someone calls mm_cpumask() on init_mm 
>>>>> early?
>>>>> Looks like it will behave incorrectly because get_rss_stat_items_size()
>>>>> returns zero?
>>>>
>>>> It doesn't work as expected at all. I missed that all users of 
>>>> mm_cpumask()
>>>> end up relying on get_rss_stat_items_size(), which now calls
>>>> percpu_counter_tree_items_size(), which depends on initialization from
>>>> percpu_counter_tree_subsystem_init().
>>>>
>>>> If you add a call to percpu_counter_tree_subsystem_init in
>>>> arch/powerpc/kernel/setup_arch() just before:

Even though powerpc is showing the warning because of VM_WARN_ON_ONCE(),
but this looks more of a generic problem, where use of mm_cpumask()
before and after percpu_counter_tree_items_size() could lead to
different results (as you also pointed above).

Looks like this is causing regressions in linux-next with warnings
similar to what Harry also pointed out. Do we have any solution for
this, or are we planning to hold on to this patch[1] and maybe even
remove it temporarily from linux-next, until this is fixed?

[1]: https://lore.kernel.org/all/20260227153730.1556542-1-mathieu.desnoyers@efficios.com/

[    0.000000] WARNING: arch/powerpc/mm/mmu_context.c:106 at switch_mm_irqs_off+0x1a0/0x1d0, CPU#2: swapper/0
[    0.000000] Modules linked in:
[    0.000000] CPU: 2 UID: 0 PID: 0 Comm: swapper Not tainted 7.0.0-rc4-next-20260317-00008-g5585e414f073 #4 PREEMPTLAZY
[    0.000000] Hardware name: IBM PowerNV (emulated by qemu) POWER10 0x801200 opal:v7.1 PowerNV
[    0.000000] NIP:  c00000000008f3b0 LR: c00000000008f330 CTR: c000000000090e20
[    0.000000] REGS: c000000003cb79b0 TRAP: 0700   Not tainted  (7.0.0-rc4-next-20260317-00008-g5585e414f073)
[    0.000000] MSR:  9000000002021033 <SF,HV,VEC,ME,IR,DR,RI,LE>  CR:24022224  XER: 00000000
<...>
[    0.000000] NIP [c00000000008f3b0] switch_mm_irqs_off+0x1a0/0x1d0
[    0.000000] LR [c00000000008f330] switch_mm_irqs_off+0x120/0x1d0
[    0.000000] Call Trace:
[    0.000000] [c000000003cb7c50] [0500210400000080] 0x500210400000080 (unreliable)
[    0.000000] [c000000003cb7cb0] [c0000000000ad850] start_using_temp_mm+0x34/0xb0
[    0.000000] [c000000003cb7cf0] [c0000000000ae8b8] patch_mem+0x110/0x530
[    0.000000] [c000000003cb7d70] [c000000000077f30] ftrace_modify_code+0x114/0x154
[    0.000000] [c000000003cb7dd0] [c00000000036a690] ftrace_process_locs+0x408/0x810
[    0.000000] [c000000003cb7ec0] [c0000000030584ec] ftrace_init+0x68/0x1c4
[    0.000000] [c000000003cb7f30] [c00000000300d3b8] start_kernel+0x680/0xc44
[    0.000000] [c000000003cb7fe0] [c00000000000e99c] start_here_common+0x1c/0x20

-ritesh

