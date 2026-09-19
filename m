Return-Path: <linuxppc-dev+bounces-27782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE08C982CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 07:21:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hn1C775FGz30Ng;
	Sat, 19 Sep 2026 17:21:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789802515;
	cv=none; b=ZBOdT8e5o3srWLY2uuBugVVcnbX0AQt0j7Iwaa/pqNXfKx4M/3V81LF0JCE1kLejZBVDWExQAhkjWscIr2NsX75GvVhE0GkSqwDyaE9vU88PGcVMsUClNsf0rG/uS3kZeeSOHkvulQz7jHYxTRhKPNJwLhC6q4TB5hbTUQY0H5AMHqH3EBkOo9+QDxtlgrXBzseW9DIQeArro+MNA/vahrggafXhrRz3rX3rCWnDIKntfVRDaQ7/1I1DO2J6Oql3TFq9ZtLTf9xYoTlPDMorR7yjfO8Oxc+lcN77Ac4ZsYxBk/h70FKQQQ5P4TO5EZ7mPATRjL7VEDMliTeMJAnhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789802515; c=relaxed/relaxed;
	bh=ji22rS31Wtsj6DidSjKjGSzzURIi+KmCray6A2YY64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw4SR4JN6g3+TZjSX4k55uSb1+Bb95/n4zTja0YC1tiYu08D5JnZnUrBvyb/FQ4EPQfk5zEcPO1TgH7e0XCKvmWsgl3rSdxPPd0cMPWtJ8MfVhtVescMMeNzWnCr1n9qZyzYtnv3htEeQ6HNY0HhZ8NKZrH82A9iIKWC8NEFpHZfXDz+PLq2sRyal6HT3eYqO4eLWOSkMvVsfIDPKMrdnF+GoGTJKZ6kOsiI2ur1BIi4EeBzBLXuGsOSFbcG5n5w6VHsKVN/ZFSiDo8UdSIIIkMFz6FX0ju+/wUDq9jjRGkjFJ1dRhh+eqUH48Uskg9Vvac/L4OCViJjalW55i3Oyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WP6JylCl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=vernon2gm@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WP6JylCl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=vernon2gm@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com [IPv6:2607:f8b0:4864:3b::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hn1C56pJqz30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 17:21:52 +1000 (AEST)
Received: by mail-pz2-x0d.google.com with SMTP id d2e1a72fcca58-8623e5d435cso527427b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789802509; x=1790407309; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ji22rS31Wtsj6DidSjKjGSzzURIi+KmCray6A2YY64U=;
        b=WP6JylClfdDGrZZxqBdcCIdTMS7twaQpWdyEJZBwJNOEucEmJV1xW+W5dZGUv1yjUZ
         pBTeHShxYDmxc8yU9ZHQgsur9Nob216XCBM9F/6XJdyTdGDB03KiMhqHDgtK4WDN4VPe
         Gos6gFInpKdoi9In7O/MqQiNSpX3scBV86r+tYhETUOoAfLcWqweymTol9JeXozhSyEQ
         VdVo0gx9a5vgWOEdUBeA+pE1ALzJ31pmmVppYlpZ8OkNwVdLa1Jge5lGX7sltsRueegA
         JL429FfoDCQmAdWdH6SMnUOmAu6A/oNzdC3/YgK82vfJnvVr3rRAort65w/GCZBhdzt/
         FNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789802509; x=1790407309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ji22rS31Wtsj6DidSjKjGSzzURIi+KmCray6A2YY64U=;
        b=0C1SU36l3NA8CamAciVWcOT0droGiJ+Rkdg+vxNLIkdrQqDLXcnDao0oDc5MGEJ30P
         hCjFVmwG1OkdSqxbyC/2O+Cm3i/rqVjdWIeGjBuQtzYMVNJ0fN+YHm9qVHQdMS7/Gw+Y
         roGzfZPEuRdU/JCb91GQAK6pxJszzPrxeJM5BRLQzLvfjfcEUw73EchxHMomgm+hCi0C
         3OPbGBpnfE7A2kYRsgDxZFSewXYs/bYr+gJpaq7o92PTvw1KVqKIs6QzLX+GSeJebwEP
         1NZfQah8NE0Si5CLjE2kP8AWms8drDdfiH/39maL7gnbs88yqfJ1zIneFbEWufC7UPyw
         12fg==
X-Forwarded-Encrypted: i=1; AKwUvBzJNVBNb5rcjkF8KYApVhh82/C01YOr5o63KoQMkPVSuy1QssU9oC0pspBX+RlUDQAKlrXNVZJWGEoUGqo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mqA9famjXfnrCXUtmnFRXNx0q0Y7mDdPKcpPDcRGGvwbY24/QC
	cyTe7uOqm9CX89E24b77R78p4TbbgpNtQh6sGmsMkC+met1GdgdofyC8
X-Gm-Gg: AYBFou18fxPRDAsscXpjSMN1EzBiQpi/QPFfZ3mCnyU1GAsrW9FOplGAdw0Q+y8nv6T
	XWvDvKXcrJktcDS5Yu41kxV1Qp+4/wQhiQE6hJiG/cQsYoJI6PtXiCpLcwP090N1Vv06SUmLpGH
	cXnKNDNynaIDZ4QG5cQbhZYzI2Sky+m/xDM4JQ1O5p8l8hpLlgJvIa3b7K36rVBIPE7owGtsLMl
	W68mzuh8jjdScGk1X6gL0bZOimcZ/C7GikceycHBNKBbPl96jqkgwO2KZoN0/Me4HoKQ0U/b0i9
	Rckdqg1KhrZ61ldRKgFGZEZ1nILhmruc2f/Jiob/skr4bbNErwSlFGsF1aX86cP6R0/GFxMwUts
	UdZZoX5Gc3zKNC9QoD8tbjYIp1Oe21fQhVmEcUHyHo6pn1M56T6mHOrwCLwld7F8W7js4zx99JE
	cRZAaDxWABaHL2p2P5a/HHWgsDp8WQJss8oAyWyjW04e/KoKjbd8KzSFV6jK2ekAvarHiO4hgq3
	ruxog45kAL4CE4=
X-Received: by 2002:a05:6a00:b94:b0:874:705d:f636 with SMTP id d2e1a72fcca58-874d5e29565mr5203732b3a.16.1789802508998;
        Sat, 19 Sep 2026 00:21:48 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae905fsm742901b3a.3.2026.09.19.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:21:48 -0700 (PDT)
Date: Sat, 19 Sep 2026 15:21:41 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Liam.Howlett@oracle.com
Subject: Re: [linux-next20260917] BUG: Bad page map in process
Message-ID: <b9d78e0b-c301-4910-9b3c-3cace29cced8@gmail.com>
References: <d0d04df2-8d69-4155-81b1-3d3ea2fca14e@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0d04df2-8d69-4155-81b1-3d3ea2fca14e@linux.ibm.com>

On Fri, Sep 18, 2026 at 12:38:29PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
> IBM CI has reported following boot warning on Power11 pseries machine
> running linux-next 7.3.0-rc3-next-20260917.
>
>
> Traces:
>
> [    4.944846] BUG: Bad page map in process rtas_errd pte:c00000001fff0786
> [    4.944850] pgd:8000000064e76009 p4d:8000000064e76009
> pud:8000000064013009 pmd:8000000064011009
> [    4.944858] addr:00003fffa9382000 vm_flags:080000fb
> anon_vma:0000000000000000 mapping:c0000000054443a0 index:1fff0
> [    4.944865] file:mem fault:0x0 mmap:0x0 mmap_prepare: mmap_mem_prepare
> read_folio:0x0
> [    4.944875] CPU: 17 UID: 0 PID: 773 Comm: rtas_errd Not tainted
> 7.3.0-rc3-next-20260917 #1 PREEMPT(lazy)
> [    4.944877] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    4.944879] Call Trace:
> [    4.944879] [c00000001791b4e0] [c00000000135a92c]
> dump_stack_lvl+0x8c/0xf0 (unreliable)
> [    4.944885] [c00000001791b510] [c0000000006708c0]
> print_bad_page_map.part.0.constprop.0+0x18c/0x260
> [    4.944887] [c00000001791b5f0] [c000000000674fa4]
> vm_normal_page+0x140/0x17c
> [    4.944890] [c00000001791b630] [c00000000067648c]
> zap_present_ptes.constprop.0+0x9c/0x9ac
> [    4.944893] [c00000001791b700] [c000000000677038]
> zap_pte_range+0x29c/0x5f4
> [    4.944895] [c00000001791b840] [c000000000677500]
> zap_pmd_range.isra.0+0x170/0x310
> [    4.944898] [c00000001791b8d0] [c000000000677a00]
> __zap_vma_range+0x360/0x4cc
> [    4.944900] [c00000001791b980] [c0000000006780e0] unmap_vmas+0x98/0x1a0
> [    4.944903] [c00000001791ba10] [c0000000006b0f68] unmap_region+0x94/0x108
> [    4.944905] [c00000001791bad0] [c0000000006b1c7c]
> vms_complete_munmap_vmas+0x11c/0x2c8
> [    4.944907] [c00000001791bb60] [c0000000006b273c]
> do_vmi_align_munmap+0x1ac/0x1f8
> [    4.944909] [c00000001791bca0] [c0000000006b52c0] __vm_munmap+0xdc/0x1fc
> [    4.944911] [c00000001791bd60] [c00000000068b154] sys_munmap+0x28/0x3c
> [    4.944913] [c00000001791bd80] [c000000000032150]
> system_call_exception+0x190/0x4b0
> [    4.944916] [c00000001791be50] [c00000000000d05c]
> system_call_vectored_common+0x15c/0x2ec
> [    4.944919] ---- interrupt: 3000 at 0x3fffa9143754
> [    4.944920] NIP:  00003fffa9143754 LR: 00003fffa9143754 CTR:
> 0000000000000000
> [    4.944922] REGS: c00000001791be80 TRAP: 3000   Not tainted
> (7.3.0-rc3-next-20260917)
> [    4.944923] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> 
> CR: 44002408  XER: 00000000
> [    4.944928] IRQMASK: 0
> [    4.944928] GPR00: 000000000000005b 00003fffc0a69a20 00003fffa9237d00
> 00003fffa9382000
> [    4.944928] GPR04: 0000000000001000 0000000000000002 0000000000000000
> 0000000000000001
> [    4.944928] GPR08: 000000000000001b 0000000000000000 0000000000000000
> 0000000000000000
> [    4.944928] GPR12: 0000000000000000 00003fffa937f860 0000000000000000
> 00003fffa9383550
> [    4.944928] GPR16: 0000000000000000 00003fffc0a69cd8 00003fffc0a69ca0
> 68746150706d7544
> [    4.944928] GPR20: 00003fffc0a69c10 0068746150706d75 636170614364656c
> 747365526f747541
> [    4.944928] GPR24: 000000013ad9e130 00003fffc0a6a0d8 6d726f6674616c50
> 00003fffa92f5ee0
> [    4.944928] GPR28: 00003fffa9382000 000000001fff0000 0000000000000009
> 0000000000100000
> [    4.944945] NIP [00003fffa9143754] 0x3fffa9143754
> [    4.944946] LR [00003fffa9143754] 0x3fffa9143754
> [    4.944947] ---- interrupt: 3000

Hi Venkat,

Thanks for reporting this bug. I also reproduced this phenomenon on my
local machine and found that Lorenzo[1] has already fixed the bug, and
Mike[2] also provided a detailed analysis.

[1] https://lore.kernel.org/linux-mm/aq06hcheI4OGi_3A@gremlin/
[2] https://lore.kernel.org/linux-mm/aquz9Z9JrK_H_E0g@kernel.org/

--
Cheers,
Vernon

