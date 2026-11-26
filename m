Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA977606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKvj7DKr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZjdM6XW6z2yDD;
	Thu, 26 Nov 2026 15:05:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795665943;
	cv=none; b=iNeXX0/YP0Ec8Lzow50OhZCV+2pV+Erxw06j+i2FvIurWVcAVCIKxbzBnftQNxmaE16C0/9mgfdjpfgxL+DrbcYopxlkjGUZIKTV8oS/s9lKjEKqBQAppj+5oQnDMrD4sKfuaWxZ+2A8IcfFhQa7igXVYQVwY7UAcBEcgZCXy3+5I6Q9X8ninXWn1TnRnmHovTAq9UKvOhZwHsUPcE6WmLa7XIv3XTt08plZtonGHl8VeEnUHLR2sjhq6B74/i11QtLD02ywJuzHkay5PGdYa/vDTQ/EPh2UnzbJKCEg4yYDxVz6Xy8bhGHYUF8OnWgffXScKLWhvirpG7mSyd3hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795665943; c=relaxed/relaxed;
	bh=tmTgOf0vdOyBS8Bx1fFfxvDmlxtGeAtHUM/fN8kwt08=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=H/428GFYIyTyO9wRwyuZbUCY0da++tItu2L7zFZgXso9ByPlEdg/cEBqksV1QM1Olqb8N2jLChyuHQKoAFR/uI46ciAUhrgMahiNTqbA06IoKwChV1qA8R4DdSNDqaOjYujqLc05r36b4cRrNHScFslqtOs9TcgnBkn9XA6CsflTGpNX4lsJ+f7ij4PtcUOmWkAL/flCP3Z9J6xZtO2NH0czAg8prcrC0XflF70gG1oJY6Z7aX9UoK9Txi+W3JygF4vZoAaz1gl25hFVci79UDXxt6ZIfFxVCtvvJom6q7u4WlITPuap0LCu9stq4FZLEr5jmLhcvO3Dixv+TT5yAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKvj7DKr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKvj7DKr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZjdL2vMLz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:05:41 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-170135e43c7so10199835c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795665939; x=1796270739; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmTgOf0vdOyBS8Bx1fFfxvDmlxtGeAtHUM/fN8kwt08=;
        b=kKvj7DKr+vBduPt9EQrF/+Cci4rO4yt76eSJaiRy1wbouSbjj2L35nG1IKsx5SCrMw
         OR+84f/3zTjQtaAnGhF9QwkgZbcdjF4EfJ7BaI2kDhZXQDzK3+IP35tA19zPPXmSNwCT
         63airKRPVRJB2DTaaryAcsbVCystErSaB28j9jVHSS+SIPlWciaGx3SrzpRHOarozpaM
         oPtivtErVb5F9so3IFac4+cdm/BIex8XBG905/fgNPEAwG9BDIAZZH72xiBDAXBDgtjt
         USLv2RSTwi7dcwVN2OZ2QJ3JQRUixXUULqUWdGHHZCKnGkIOYv3oqZ6jzh225AJqCzQ1
         EmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665939; x=1796270739;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmTgOf0vdOyBS8Bx1fFfxvDmlxtGeAtHUM/fN8kwt08=;
        b=NT+RdPI6pqT/2RuIHEvT6f09cLSUJiomWLQeLFKHSisIvpexaNMfElOyensEa/rRIH
         5e5LClCPySbr+c7wX8UsJJPSpXtLu2oysEcEdIecYW/MkA2KkhS6XdRJRH/w5z19fR/F
         nLow4abWQ/uLOhdjLZ6mKDheFQaO3JZljynp6SyLUFuI8MvNBGNxM6YkIzSizrZ8X9f3
         r5VkytCVftx/YaJiMKnQZL+U2XrF0obY0Xc0b1E68SkI2RXyPx+SQVXaRZdFHCjq5Mrt
         8mgHcLhjRg+cQQGw3cKvhVzrCgKq1clpVAeN32VIziDhiUd5AWJbmLeDTIA8yEKeJo5Q
         H6Aw==
X-Forwarded-Encrypted: i=1; AL+hErGwN8i2UtR7IDpneCG1gDpZf2P49bJjwONhqEhsFSAnof2NdDAzUEmrtbcqrkT7KdkWJiy1+niURFCSWok=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/7/qLUBQPfFgzcbBmhpmIgBCeY+vZz0oQAXXAXmYUOHLi6zddy
	9Zx8Od4zRETYvcOferyv0Dqay1gVJkzBjeILPaOzpbA8ryy2KSgDGIEx
X-Gm-Gg: AZFdTZfnUheZS/0jS6MIH/f2nnTs/8CTUFA/6KSDIAtPetCk0fghWWgNWsj3EbqN2M2
	/lvrf0Qcqf0FyM02XT4XbifwPT4ZtLiu7g/LWaOd02VU6+A50fxwsuCwcxz8b+zcB+wwc4f7yUt
	X8N2UOiqz9XEN9hnp7uTSXUdFhCGF6VjX+JI/v8UrWbgzzvaE3yui2XsJclxgJmK5ysOXjtJlTG
	AT4MGiURZsMeCJzlA4a2ZbkqqzMaV96rA8/tC7au2gg1CFOwggtZlyIkIXGVpsfIKGhndbSUksZ
	JVvHYh9XpdHTYzoCnN7V+qw/GQFU7c1U4XTqqkDhp1s0JJf/ucATHuUJAZgd7PTRgRg9AoWWD8E
	VxaCyxFBzF3MCPacIpBGDWPlgN71zd8UV97TAJudecmLlETOQswEzWV811k6TGxTG+hPpWU/20O
	d59w2nTaWHHr8D88mtCHQvhzf/7QLvXXjXL7NHjn1JSYMxXRdI7bGSYTuzNjEKozfc9eBoLdDX3
	UE9atveCCZlKL927zal35B8M8r12fgYP4JeN1T5P3TafDP+uqz6xV1GPwmzDjcI6CZUv1LKYN0h
	CwTUMpQSE9ScriDsWhgt5gBOk+0=
X-Received: by 2002:a05:701b:204a:10b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1b5568c0e83mr22286570c88.19.1795665938757;
        Wed, 25 Nov 2026 20:05:38 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm45343201eec.1.2026.11.25.20.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:05:38 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCHv3 2/4] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
In-Reply-To: <92b40ffa-c9bd-4d1c-b60b-f27e89102f9d@kernel.org>
Date: Thu, 26 Nov 2026 08:53:37 +0530
Message-ID: <ld6gjmx2.ritesh.list@gmail.com>
References: <cover.1795625038.git.ritesh.list@gmail.com> <128398ae7491112604572d94778c938bf1e306c3.1795625038.git.ritesh.list@gmail.com> <92b40ffa-c9bd-4d1c-b60b-f27e89102f9d@kernel.org>
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

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Hi Ritesh,
>
> There is a problem with the subject of most of your patches: the space 
> between "PATCH" and "v3" is missing, therefore patchwork doesn't fully 
> understand and it doesn't remove the PATCH word as it does when the 
> space is there. I have not checked whether b4 understands it.
>

Thanks so much for pointing that out. Ealier I used to have a space
between PATCH and vxx, however once a kernel release manager of a
different area, told me that their script is missing my changes, though
he fixed his internal script - but later I decided maybe to remove that
space.

Looking at this a bit more closer, I agree, I should keep that space.
Seems like Sashiko is also unhappy when we don't have that. Looks like
w/o a space, it doesn't mark it as a series and rather consider the
series as individual patches.

> Le 25/11/2026 à 17:52, Ritesh Harjani (IBM) a écrit :
>> On book3s/32, a kprobe on an instruction that can't be emulated and has
>> to be single stepped out of line, crashes the kernel. For e.g. with the
>> following cmds...
>>      ~> echo 9 > /proc/sys/kernel/printk
>>      ~> mount -t debugfs debugfs /sys/kernel/debug
>>      ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
>>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
>>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>> 
>> ...we can see the following crash:
>>      kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
>>      BUG: Unable to handle kernel instruction fetch
>>      Faulting instruction address: 0xc02b919c
>>      Vector: 400 (Instruction Access) at [f19a9d60]
>>          pc: c02b919c: filldir64+0xb8/0x2dc
>>          lr: c02b9148: filldir64+0x64/0x2dc
>>          sp: f19a9e20
>>         msr: 10029032
>>        current = 0xc112e900
>>          pid   = 102, comm = ls
>>      enter ? for help
>>      [f19a9e20] c1a8d420 (unreliable)
>>      [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
>>      [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
>>      [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
>>      [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
>>      [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
>>      ---- Exception: c00 (System Call) at a7596164
>>      SP (af802310) is in userspace
>> 
>> This happens because on book3s/32 the exec permission is per segment
>> (256MB), not per page. The page tables have no hardware exec bit, only
>> the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
>> sets N on all the kernel segments except the ones of the modules area.
>> So nothing in the vmalloc area can be executed, even when the page is
>> mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
>> a software only bit there and the segment's N bit is what the MMU
>> enforces.
>> 
>> Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
>> allocations"), the kprobes insn pages came from module_alloc(). That
>> commit moved them to the whole of the vmalloc space, on the grounds
>> that kprobes use a breakpoint and don't need to be near the kernel
>> text. That is fine on platforms where the exec permission is per page,
>> as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
>> It is not on book3s/32, where the modules area is not only close to
>> the kernel text but is also the only page-mapped area whose segment is
>> left executable. So the insn pages must keep coming from there.
>> 
>> Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
>
> The patch is now correct as it now if #ifdef MODULES_VADDR block, but 
> the description is incomplete.
>
> The description misses the 8xx for the reason explained here: 
> https://lore.kernel.org/all/f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org/
>
> And that reason also applies to book3s/32, as reminded here by yourself: 
> https://lore.kernel.org/all/zev77i3i.ritesh.list@gmail.com/
>

I remember updating the commit msg somewhere, however seems like I might
have overwrote it and lost that change.

let me fix that up in v4 like this -


This happens because on book3s/32 the exec permission is per segment
(256MB), not per page. The page tables have no hardware exec bit, only
the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
sets N on all the kernel segments except the ones of the modules area.
So nothing in the vmalloc area can be executed, even when the page is
mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
a software only bit there and the segment's N bit is what the MMU
enforces.

8xx and 603 (which is book3s/32) have one more problem. Their iTLB miss
handlers walk only the current task's PGD, whose kernel entries are
copied from swapper_pg_dir in pgd_alloc(). Only kernel text and the
modules area are sure to be in that copy, the modules area because
prealloc_execmem_pgtable() creates its page tables at boot. Unlike the
dTLB path, nothing fixes up a missing entry on an iTLB miss. So an insn
page in a vmalloc area mapped after the task's PGD was allocated can't
be executed.

Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
allocations"), the kprobes insn pages came from module_alloc(). That
commit moved them to the whole of the vmalloc space, on the grounds that
kprobes use a breakpoint and don't need to be near the kernel text. 
That is fine on platforms where the exec permission is per page,
as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
It is not on book3s/32 and 8xx, where the modules area is not only close to
the kernel text but is also the only page-mapped area whose segment is
left executable. So the insn pages must keep coming from there.

MODULES_VADDR is only defined on book3s/32 and 8xx, so use the modules
area for EXECMEM_KPROBES whenever it is defined.


-ritesh





