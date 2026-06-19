Return-Path: <linuxppc-dev+bounces-22789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F874CD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 07:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghTkD1x9wz2ySW;
	Fri, 19 Jun 2026 17:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781853638;
	cv=none; b=jQUAjxAnNEXtpoeaIq1YJtNrbUEBi0PjcuitaXmQrbbiVlemlmQCZrZ6+6s9t0mCthFU2TXY7WkgRcgZIxbnqNGqfNDa5SMmQf5qDwxdZzfU7j2asCICxE2LVfxiItObuZMpRPWzSQ39khhure9n7YXv9Ui2uG5shfMGksztzA9QC6AOtk+mbHmBiX7n7ilwJfDxqOJqU+P8/e8iEObvrjkUhBler3Fp/t54gHP0DIavCaUVyX14oyVurnDMOCZzy9moo27xjWmUid7Rc4hU9gTrVQqBqzSjqrydUVg3zwlXSaylh/ORKt86pkTyDBgtMClptLSV7hD/WESq+wTAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781853638; c=relaxed/relaxed;
	bh=44Fxy13MSHLhHlbGbPMHcICK4gvzAmU5tsItGLAL6rE=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:References:Subject:
	 From:In-Reply-To; b=I+rGnSV8mfZvY+MFn9l7HdQXZn6gCI+SZFG2soMLC5pCi81RjDGOmQbyOHfoOiFep5FP1VOtN2XscY1PeHpc4x9m+So5uXD8RbJLuPEqDMr0wqiGoUtd5r+ESlyZE50bzE+aii9pVvM1KiJu5NxQVRufUAqwxxj59BtzfnzaSnqAJTMFtVw3k9NHhvzqZGKvoCn35kb3wJGbtrAvvujj/KOJguxmUtihwc4jNNtOHZL6Fbfw9CZBeIA4AcsYceU3Y5Bx2IKZS44CZny7g6W78RTUyFCWb//q8Plq3Cs9RNzhsECXmgWw/OvykJmBlR6WNBK6jwVqDHoP/vM0OnUS0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/xhMT9K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=gshel054@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/xhMT9K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=gshel054@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghTX50HJHz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 17:20:36 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-91578122305so252155485a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781853634; x=1782458434; darn=lists.ozlabs.org;
        h=in-reply-to:from:content-language:subject:references:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44Fxy13MSHLhHlbGbPMHcICK4gvzAmU5tsItGLAL6rE=;
        b=e/xhMT9KuxcpZ2QzB8FhXJQcUIdn8VEUWUkktjuHJanp+mSz5qLdC5lYTxM6LS8pb4
         PVBUSW5vSwi6ACWRUJndMHljtzLvSMVPwNOHe+tctjXTnMC7rZbPv/QZXkcQ5QSZnTmn
         wKwyX1XkQP34xerYcXvJ3e/J1kZoQmLds9DUTicYnWnmqX/l7OpDkn+JqrQAC8ZkFpnh
         GcqUY6q0DnXoGcF7o7yOX41p4ILmHbGVn25lddtfqb+9FRXP0A6XZBfpJ3m53GWvD65k
         iX3ucsWpM6a/HE/3BSYUIkaEfNcYVVKv/h47mBlEpHJvKpksIYWOC/rd8X3AbinDCGIz
         pj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781853634; x=1782458434;
        h=in-reply-to:from:content-language:subject:references:to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44Fxy13MSHLhHlbGbPMHcICK4gvzAmU5tsItGLAL6rE=;
        b=i3H1XCO42jzFphmAPmSzOe2LgmgMvzdBnYQdAnN/ccbET933Zs/WA9ZhqZFsXrYvAz
         tVwNbtEzuSMcsiZpU5Wa5v97uEn4PjrEQmIXT/utRh0vpuK3LgE9plFksvyfmOpDdrIj
         CLI1BQrXUm9mUgyZI/UgtRRcLpOkFmwmeVU121rBJ6wJLmzpIbqTORDqUblfFo0lCVdF
         iQFA8kXwBLh9WKiQzs9mkhP+M9r4kCAVRa1jLjgOOVvgOUoSF2Qqz6glkID8XY9eVAkV
         cyniFc6+v3MiugUU12jEwcyVQCy9Ftm1xzaz1q2cSHPUIlzECmgCXVWSkP88hSqliogO
         uxgA==
X-Gm-Message-State: AOJu0Yzb+mhRiIFyQlJfRlne990btq/axgsjGBs9WV3lpARFt7dJ1J+r
	NFgpULlSYshjmELsl4BQ5YU+OCVnCvWKGRegPWvAwQe7oi3nUCSZ8ujsduk0a1Li
X-Gm-Gg: AfdE7cnS6cEqKZPpNXbwTatHhIhO9x4C643xK+yxgG3F376eCfgw6j3vioK0KMjhfEd
	eywEv3vnnk+oXU1LcLsoWH0t7ZITY2C0MNxe8cTEbvEHjxtM5DK2m3w93tMB1vKf7XQyyFc/6o7
	0Uo/SJXGtnVQdzA3AgM9Y7x1XcPySqKyUwia3wIWW4PUWVQ4srTLmlCHWF4KpFPZfxrMexTD3N1
	VIuoB+t4m9vZyJI/BwbFpVMwrsz3xxAI4FfLT5qrsWkPpAvPtMRbQh1PQLQeUkG7MlgJ0UzNtSq
	U1ChUP43hsNIfrU9CKfZctknvx6WVpeZqK+DaOp5EByy8qgXiEGgZfuDfkpLpB70lZwL232Sdee
	qF5dGDfhcm4BohTTUyxaZrS+LYGSDBGjQKPa+2fnFddQZkIlY+L96cgJ+7T970YI1Kt0G0tsk6X
	y6Oq+rHr+ZpeIaU+i42fA0NJ0DjOvk7EZygCRAr0M1yes+15v9fbEV/8hMqmpvemg=
X-Received: by 2002:a05:620a:4386:b0:915:89d4:df17 with SMTP id af79cd13be357-92091497ad2mr342253085a.33.1781853634107;
        Fri, 19 Jun 2026 00:20:34 -0700 (PDT)
Received: from [192.168.1.13] (c-73-215-216-70.hsd1.nj.comcast.net. [73.215.216.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de6251002fsm14453836d6.33.2026.06.19.00.20.33
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 00:20:33 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------DZNm905eZcQgALKaFsTEjiub"
Message-ID: <91106504-499e-41a8-ab5e-6539cd7b1b7b@gmail.com>
Date: Fri, 19 Jun 2026 03:20:32 -0400
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
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org
References: <CAC1vu625FvXPJMXqtSdoAD4c4070nxVsktSvAM=U1QxFHM_aEg@mail.gmail.com>
Subject: Re: libspe2:test_context_create_error on 4.12-rc1 and 4.2-rc2
Content-Language: en-US
From: Gary <gshel054@gmail.com>
In-Reply-To: <CAC1vu625FvXPJMXqtSdoAD4c4070nxVsktSvAM=U1QxFHM_aEg@mail.gmail.com>

This is a multi-part message in MIME format.
--------------DZNm905eZcQgALKaFsTEjiub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear* Sombat Tragolgosol, *

*My name is Gary and I noticed your post on ozlabs.org about running the 
libspe2 testsuite under modern kernels and getting some failures. I was 
wondering if you ever found a solution for this issue. I run a custom 
Linux on my PS3 (basically the latest ppc64 fedora with a PS3 compatible 
kernel). I'm currently running on kernel 6.6.142. I've built a ppu-gcc 
and a spu-gcc from gcc 8.3.0 and now I'm trying to package a working 
libspe2-2.3.0.*

*On testing, the first test failure I see is 
test_single_gang_context.elf which causes a segfault. If you could help 
me analyze the trace and point me in the right direction, I would 
appreciate it so much.*

*dmesg returns:*

*[10814.901983] BUG: Kernel NULL pointer dereference on read at 0x00000038
[10814.902009] Faulting instruction address: 0xc000000000299bb8
[10814.902031] Oops: Kernel access of bad area, sig: 11 [#4]
[10814.902048] BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 NUMA PS3
[10814.902068] Modules linked in: snd_ps3 snd_seq snd_seq_device snd_pcm 
snd_timer snd soundcore ps3vram
[10814.902173] CPU: 0 PID: 1206 Comm: scratch Tainted: G      D W        
   6.6.142-10.PS3_1.ppc64 #1
[10814.902196] Hardware name: SonyPS3 Cell Broadband Engine 0x701000 PS3
[10814.902212] NIP:  c000000000299bb8 LR: c000000000299b84 CTR: 
c000000000295750
[10814.902228] REGS: c0000000035b39d0 TRAP: 0300   Tainted: G   D W      
      (6.6.142-10.PS3_1.ppc64)
[10814.902247] MSR:  8000000000008032 <SF,EE,IR,DR,RI> CR: 22000822  
XER: 20000000
[10814.902335] DAR: 0000000000000038 DSISR: 40000000 IRQMASK: 0
                GPR00: c000000000299b84 c0000000035b3c70 
c000000000b72000 c00000000220b0c0
                GPR04: c000000001972900 c000000001fc7798 
0000000000000008 0000000000000000
                GPR08: 0000000000000000 0000000000000000 
0000000000000010 c000000001bb5a80
                GPR12: c000000008551900 c000000000d6c000 
00000001064cb110 00000001063b9710
                GPR16: 00000001063b9714
[10814.910166] systemd-journald[93]: /dev/kmsg buffer overrun, some 
messages lost.
[10814.913614] 00000001063b9788 0000000106351408 000000004822228a
                GPR20: 00000001063bd558 00000001064f6700 
00000001063e0210 00000001063baf84
                GPR24: 0000000000000000 0000000000000000 
00003fffe4e70798 c0000000032f0290
                GPR28: c00000000220b0c0 c000000003516e20 
00000000000a801d c000000001fc7700
[10815.241151] Call Trace:
[10815.241169] [c0000000035b3c70] [c000000000299b84] 0xc000000000299b84 
(unreliable)
[10815.241207] [c0000000035b3d10] [c000000000295790] 0xc000000000295790
[10815.241231] [c0000000035b3d90] [c00000000001ca94] 0xc00000000001ca94
[10815.241257] [c0000000035b3e10] [c00000000000b354] 0xc00000000000b354
[10815.241284] --- interrupt: c00 at 0x00003fff9f0dd3d8
[10815.241299] NIP:  00003fff9f0dd3d8 LR: 00003fff9f0dd3a4 CTR: 
0000000000000000
[10815.241317] REGS: c0000000035b3e80 TRAP: 0c00   Tainted: G   D W      
      (6.6.142-10.PS3_1.ppc64)
[10815.241338] MSR:  800000000200e032 <SF,VEC,EE,PR,FP,IR,DR,RI>  CR: 
22000822  XER: 00000000
[10815.241452] IRQMASK: 0
                GPR00: 0000000000000006 00003fffe4e6ffd0 
00003fff9f109f00 0000000000000003
                GPR04: 0000000010021c20 0000000000000004 
000000000000001f 00003fff9f196b98
                GPR08: 0000000000000002 0000000000000000 
0000000000000000 0000000000000000
                GPR12: 0000000000000000 00003fff9f19e200 
00000001064cb110 00000001063b9710
                GPR16: 00000001063b9714 00000001063b9788 
0000000106351408 000000004822228a
                GPR20: 00000001063bd558 00000001064f6700 
00000001063e0210 00000001063baf84
                GPR24: 0000000000000000 0000000000000000 
00003fffe4e70798 0000000000000001
                GPR28: 0000000010002948 0000000010002510 
0000000000000000 0000000000000003
[10815.314808] --- interrupt: c00
[10815.317969] Code: 813f0014 39400008 71280002 41820194 5528044a 
55080163 40820054 75290200 38bf0098 408202a4 e8650008 e9030030 
<e9280038> e9290440 2fa90000 419e0030
[10815.321344] ---[ end trace 0000000000000000 ]---*

*Unfortunately I have much to learn when it comes to this level of 
debugging. I do know that de-referencing a NULL pointer is a big time 
catastrophe though.*

*I've been writing little dummy programs just to test out functions like 
spe_context_create and spe_gang_context_create but haven't been able to 
reproduce the segfault yet...*

*Anyway hope you are well. Thanks for your consideration!*

*Gary*

*(https://ps3linux.net admin)*

--------------DZNm905eZcQgALKaFsTEjiub
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Dear<b> Sombat Tragolgosol, </b></p>
    <p><b>My name is Gary and I noticed your post on ozlabs.org about
        running the libspe2 testsuite under modern kernels and getting
        some failures. I was wondering if you ever found a solution for
        this issue. I run a custom Linux on my PS3 (basically the latest
        ppc64 fedora with a PS3 compatible kernel). I'm currently
        running on kernel 6.6.142. I've built a ppu-gcc and a spu-gcc
        from gcc 8.3.0 and now I'm trying to package a working
        libspe2-2.3.0.</b></p>
    <p><b>On testing, the first test failure I see is
        test_single_gang_context.elf which causes a segfault. If you
        could help me analyze the trace and point me in the right
        direction, I would appreciate it so much.</b></p>
    <p><b>dmesg returns:</b></p>
    <p><b>[10814.901983] BUG: Kernel NULL pointer dereference on read at
        0x00000038<br>
        [10814.902009] Faulting instruction address: 0xc000000000299bb8<br>
        [10814.902031] Oops: Kernel access of bad area, sig: 11 [#4]<br>
        [10814.902048] BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 NUMA PS3<br>
        [10814.902068] Modules linked in: snd_ps3 snd_seq snd_seq_device
        snd_pcm snd_timer snd soundcore ps3vram<br>
        [10814.902173] CPU: 0 PID: 1206 Comm: scratch Tainted: G      D
        W          6.6.142-10.PS3_1.ppc64 #1<br>
        [10814.902196] Hardware name: SonyPS3 Cell Broadband Engine
        0x701000 PS3<br>
        [10814.902212] NIP:  c000000000299bb8 LR: c000000000299b84 CTR:
        c000000000295750<br>
        [10814.902228] REGS: c0000000035b39d0 TRAP: 0300   Tainted: G   
          D W           (6.6.142-10.PS3_1.ppc64)<br>
        [10814.902247] MSR:  8000000000008032 &lt;SF,EE,IR,DR,RI&gt; 
        CR: 22000822  XER: 20000000<br>
        [10814.902335] DAR: 0000000000000038 DSISR: 40000000 IRQMASK: 0 <br>
                       GPR00: c000000000299b84 c0000000035b3c70
        c000000000b72000 c00000000220b0c0 <br>
                       GPR04: c000000001972900 c000000001fc7798
        0000000000000008 0000000000000000 <br>
                       GPR08: 0000000000000000 0000000000000000
        0000000000000010 c000000001bb5a80 <br>
                       GPR12: c000000008551900 c000000000d6c000
        00000001064cb110 00000001063b9710 <br>
                       GPR16: 00000001063b9714 <br>
        [10814.910166] systemd-journald[93]: /dev/kmsg buffer overrun,
        some messages lost.<br>
        [10814.913614] 00000001063b9788 0000000106351408
        000000004822228a <br>
                       GPR20: 00000001063bd558 00000001064f6700
        00000001063e0210 00000001063baf84 <br>
                       GPR24: 0000000000000000 0000000000000000
        00003fffe4e70798 c0000000032f0290 <br>
                       GPR28: c00000000220b0c0 c000000003516e20
        00000000000a801d c000000001fc7700 <br>
        [10815.241151] Call Trace:<br>
        [10815.241169] [c0000000035b3c70] [c000000000299b84]
        0xc000000000299b84 (unreliable)<br>
        [10815.241207] [c0000000035b3d10] [c000000000295790]
        0xc000000000295790<br>
        [10815.241231] [c0000000035b3d90] [c00000000001ca94]
        0xc00000000001ca94<br>
        [10815.241257] [c0000000035b3e10] [c00000000000b354]
        0xc00000000000b354<br>
        [10815.241284] --- interrupt: c00 at 0x00003fff9f0dd3d8<br>
        [10815.241299] NIP:  00003fff9f0dd3d8 LR: 00003fff9f0dd3a4 CTR:
        0000000000000000<br>
        [10815.241317] REGS: c0000000035b3e80 TRAP: 0c00   Tainted: G   
          D W           (6.6.142-10.PS3_1.ppc64)<br>
        [10815.241338] MSR:  800000000200e032
        &lt;SF,VEC,EE,PR,FP,IR,DR,RI&gt;  CR: 22000822  XER: 00000000<br>
        [10815.241452] IRQMASK: 0 <br>
                       GPR00: 0000000000000006 00003fffe4e6ffd0
        00003fff9f109f00 0000000000000003 <br>
                       GPR04: 0000000010021c20 0000000000000004
        000000000000001f 00003fff9f196b98 <br>
                       GPR08: 0000000000000002 0000000000000000
        0000000000000000 0000000000000000 <br>
                       GPR12: 0000000000000000 00003fff9f19e200
        00000001064cb110 00000001063b9710 <br>
                       GPR16: 00000001063b9714 00000001063b9788
        0000000106351408 000000004822228a <br>
                       GPR20: 00000001063bd558 00000001064f6700
        00000001063e0210 00000001063baf84 <br>
                       GPR24: 0000000000000000 0000000000000000
        00003fffe4e70798 0000000000000001 <br>
                       GPR28: 0000000010002948 0000000010002510
        0000000000000000 0000000000000003 <br>
        [10815.314808] --- interrupt: c00<br>
        [10815.317969] Code: 813f0014 39400008 71280002 41820194
        5528044a 55080163 40820054 75290200 38bf0098 408202a4 e8650008
        e9030030 &lt;e9280038&gt; e9290440 2fa90000 419e0030 <br>
        [10815.321344] ---[ end trace 0000000000000000 ]---</b></p>
    <p><b>Unfortunately I have much to learn when it comes to this level
        of debugging. I do know that de-referencing a NULL pointer is a
        big time catastrophe though.</b></p>
    <p><b>I've been writing little dummy programs just to test out
        functions like spe_context_create and spe_gang_context_create
        but haven't been able to reproduce the segfault yet...</b></p>
    <p><b>Anyway hope you are well. Thanks for your consideration!</b></p>
    <p><b>Gary</b></p>
    <p><b>(<a class="moz-txt-link-freetext" href="https://ps3linux.net">https://ps3linux.net</a> admin)</b></p>
  </body>
</html>

--------------DZNm905eZcQgALKaFsTEjiub--

