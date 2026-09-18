Return-Path: <linuxppc-dev+bounces-27737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F403CC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 12:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmXcl68Nkz2y7r;
	Fri, 18 Sep 2026 22:53:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789736039;
	cv=none; b=OTjufTl+khE9ZzS77BnP/QFOd1CDxTy9QJllPHnqh+COoGRg8nwlaM++gECtdQ0dqg8DW7oj2UEvsgA8SXI/uQGkPG8Wm53RPx7QplYYVW7Osqg339jTqRhzD3nEJA4sikVWUstInzjbqjIZC8Gl+UcX6/EEv7IPjEhDphsSc5y8PHUVLNGlrxph9cvKakIhSm5aWJ1JRUM+lzd8/Z3evczI9MXpl8gsAOlGQC5R8g1xkoVo6Gx5izjkEJR6tQtzvv0aJaEhL9V7hxDe+cnpZMdfX41bWKKgK2bY1ciazYPJslYfXDYhA4YV7QbyjVoy+ZZcaue3pI383wwDYMnuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789736039; c=relaxed/relaxed;
	bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVKlYuF8BOQQ5ugSH7PImcluswNIXN11Pm2Os+Q8YiEDzcgqw5ZZ9wogEHO4sLwbw8lXRkMXQOfyCbmNGFjVvq/Jgf2Euqj56Jo7wnUmFlTsCjTJBidCNOzl8QrZdKg4emdhjmCRu21OQFFUsPkG3zzJ0kmFQbq161Nm/ayq0ll6Oc3F0zydi41gMNGPZxB0+D6RoABNZR7OQEQyqYV4VwS/ZjSvK94IzZQmsEde96yb5ad72oH6GxF/0hPGxhOR7zn6Iw9cEFNe6yg04HImZsoaNpAY5MnKpbkfKTA0Yj5ccV0xcvjKLY/c1C6MV2do9HWKlVzBe+uXMsjp2zAq0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPwnStxl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPwnStxl; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPwnStxl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPwnStxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=rrobaina@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmXck3rFTz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 22:53:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789736033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
	b=QPwnStxl9MGc3H7r4nnRmMQgxDE/CdEZKl7hKHNkAa6OQdmrxt11jpOTvOqHTSXmsfKhzS
	7D2lAWHVdoXLm72Xjsa2Y/VNmwE2Ym0C0Y3qkwery/q31YxGxE1+r/QNOhEfR0qHGwiy8x
	FZS2eOcx9PFEhQtFszE5QqbgOgxmbYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789736033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
	b=QPwnStxl9MGc3H7r4nnRmMQgxDE/CdEZKl7hKHNkAa6OQdmrxt11jpOTvOqHTSXmsfKhzS
	7D2lAWHVdoXLm72Xjsa2Y/VNmwE2Ym0C0Y3qkwery/q31YxGxE1+r/QNOhEfR0qHGwiy8x
	FZS2eOcx9PFEhQtFszE5QqbgOgxmbYs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-vpYSPEgtNqqZrRXN5tNHAw-1; Fri, 18 Sep 2026 08:53:41 -0400
X-MC-Unique: vpYSPEgtNqqZrRXN5tNHAw-1
X-Mimecast-MFC-AGG-ID: vpYSPEgtNqqZrRXN5tNHAw_1789736020
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29476212f1so67928666b.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 05:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736020; x=1790340820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
        b=VuxIqaFab9x1su4aLhQvouXAsTKa+r/pyaI07n72LtkOFwaup96zvhZ0A6KlzlLgNv
         MVBpRC35oDjMF3Y6TOQnBPc2rxOwd3COUcsVjESs+ZO1yRC/7eajI0vG31lW7HCZgbig
         zD7HeHgLiqN2WWRgAAx4+lsRZNxKRoIHv4nmPd+VHV5eid5CRbWpuKHVTL3oF0ND9G3i
         9ilrI3U3+rt3jhEr6M2JjbGtRpUma3+woOZMBVO7H4T64Sm+R7iZBVaeAlDux89irUOD
         60wsCPGge24qFKZCg5H0TE4B6Pf3sfti9YDroSvL0ERVcB4QMuyLmebAeaO0LYh7xiOs
         vJ6g==
X-Forwarded-Encrypted: i=1; AKwUvBxLkDSqevg30G1t9dTR0pgSmAP2jSMT2LFoebFULmYq8PqPXudyP9KKcpt5pio0b4VGsgg6gZwoG/sqGm0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mfsn/yiGIWGwyblhAig3PPQ2LB1RNpTjzNbf0V40rB0K9dNeCY
	3tPZE+pcaBbLG7Phe/KcmxALxDnXOmQrkgGLFv5yqYK4iojh11x2xl1IhNEDhcj7DR2s992VtUn
	TmE++AvDWudJ+7jOROOA2+x5CAYGJyTc4EB6pr9TjIOE3DI4fugdNSWo6DzrIOheNwt4meDast2
	incM+5Q6OtqaCMMCci6Xr8qCjm3jHAanA4nEh2grkVWQ==
X-Gm-Gg: AYBFou0eU5ge4P4FXVXg/lgyUSd34TaaI637D8ZtTzIFSMbLwu21kONQuE4sqAABzqq
	Dbrv5HmTHVs0Phlg4cZG6Qyh6PFW4TKAEGZtntcXfGLnqWIz2n2hyQYgkBEYK4Zvy9t64SCmLtX
	ePT1aSZEoJo5yNht+BAtuToAhisvQzNngKAyrUkA7YbVrw46kwWvlh9uP0jrm1L4wn0UhqrTUMl
	gDaTPy3QzFa99rDrGrFbql29i9AwC57epBZSoY3d4gWS2Lbw8JjiHgJ8jWzi+WXZp/B0NLvg9k4
	s9c=
X-Received: by 2002:a17:907:72cc:b0:c25:8c74:71e6 with SMTP id a640c23a62f3a-c2a1569a530mr277251266b.10.1789736020314;
        Fri, 18 Sep 2026 05:53:40 -0700 (PDT)
X-Received: by 2002:a17:907:72cc:b0:c25:8c74:71e6 with SMTP id
 a640c23a62f3a-c2a1569a530mr277247366b.10.1789736019888; Fri, 18 Sep 2026
 05:53:39 -0700 (PDT)
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
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net> <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1a0b021e330.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com> <D5655235-89A8-43EF-8DC4-9DCE6FBC387C@linux.ibm.com>
In-Reply-To: <D5655235-89A8-43EF-8DC4-9DCE6FBC387C@linux.ibm.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 18 Sep 2026 09:53:28 -0300
X-Gm-Features: AcwNN1WCd2sEcqEKVCjkhdhtXdMEs14eyYo-vHbnVxc45osvsgf1ffcS0sP15O8
Message-ID: <CAABTaaB4j+Gr2-7vti6unCqKoRfYa9Cs22NH3HpxJo14r5jKcA@mail.gmail.com>
Subject: Re: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995
 (__audit_syscall_entry) during BPF kselftests (test_progs)
To: Venkat <venkat88@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, audit@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, andrii@kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	yonghong.song@linux.dev, tglx@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iqxCrRgNdM7DxqhElZkcn56W5r2lB01Z6HsuI7ixCL8_1789736020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 4:42=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
> Hi Daniel, Paul
>
> Hope all is well with your family, Paul, please take care.
>
> > On 17 Sep 2026, at 9:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> >
> > [NOTE: correcting the audit mailing list address to audit@vger ...]
> >
> > On September 17, 2026 12:06:18 PM Paul Moore <paul@paul-moore.com> wrot=
e:
> >> On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
> >>> Hi Venkat,
> >>>
> >>> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
> >>>> Hi all,
> >>>>
> >>>> IBM CI has reported a kernel warning triggered in __audit_syscall_en=
try()
> >>>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running=
 the
> >>>> BPF kselftest suite (test_progs).
> >>>>
> >>>> Environment:
> >>>>
> >>>>
> >>>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
> >>>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
> >>>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
> >>>>
> >>>>
> >>>> Problem Description:
> >>>>
> >>>>
> >>>> During syscall entry processing (system_call_exception ->
> >>>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit
> >>>> WARN_ON(context->context !=3D AUDIT_CTX_UNUSED) at kernel/auditsc.c:=
1995,
> >>>> indicating that the task's audit context was not reset to AUDIT_CTX_=
UNUSED
> >>>> prior to entering the new syscall.
> >>>
> >>> Hm, based on the trace feels somewhat unrelated to bpf, but were you =
able
> >>> to bisect in
> >>> case it can be reliably reproduced? Which tree is this, linux-next or
> >>> bpf/bpf-next?
>
> This was tested on the mainline Linux tree (Linus' tree, commit 238650ef6=
c7c).
>
> Regarding bisection and reproducibility: the warning does not reproduce w=
hen running individual tests in isolation (e.g. running kfunc_module_order =
alone is clean). It is only observed intermittently during the full BPF sel=
ftests suite run (test_progs / test_progs-no_alu32), so I haven't been able=
 to bisect it to a specific commit yet.
>
> >>
> >> Thanks for the report Venkat.
> >>
> >> Unfortunately due to some unexpected family medical issues I'm not abl=
e to
> >> look into this very closely at the moment (triaging mail on my phone),=
 but
> >> the related audit code has been fairly stable lately so it seems a bit=
 odd.
> >>
> >> I do know that Thomas Gleixner (CC'd) did some work recently on the sy=
scall
> >> entry code (audit related commit below), perhaps that may be a place t=
o start?
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D6f25517010ddd3f8080d7e06b9b1cb1b64b73772
> >>
> >> FWIW, I haven't seen this in any of my testing on x86 or ARM, have you=
 seen
> >> this on other arches besides Power? Also, as Daniel already mentioned,=
 more
> >> information on the tree would be helpful.
>
> We have only tested and observed this on PowerPC (ppc64le, POWER9 pSeries=
 guest).
>
> Attached is the .config file.
>
>
> Regards,
> Venkat.
> >>
> >> While I don't have access to a Power system, I'm CC'ing Ricardo Robain=
a who
> >> also works at IBM/RH and has experience with the audit kernel code. If=
 this
> >> appears to be specific to Power, he might be a good resource to help
> >> diagnose and develop a patch.
> >>
> >>>
> >>>> Trace:
> >>>>
> >>>>
> >>>> [ 1371.387510] ------------[ cut here ]------------
> >>>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at
> >>>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
> >>>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solo=
mon(E)
> >>>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) ll=
c(E)
> >>>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E)
> >>>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
> >>>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E)
> >>>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E)
> >>>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(=
E)
> >>>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E)
> >>>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mo=
d(E)
> >>>> [last unloaded: bpf_test_modorder_x(OE)]
> >>>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G
> >>>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
> >>>> [ 1371.387616] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [K]=
=3DLIVEPATCH
> >>>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e=
0202
> >>>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> >>>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR:
> >>>> c00000000000cf00
> >>>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      O=
E K
> >>>> (7.3.0-rc3-g238650ef6c7c)
> >>>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48=
002824
> >>>> XER: 20040084
> >>>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
> >>>>      GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000=
000345f4800
> >>>>      GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 00000=
00000000000
> >>>>      GPR08: 0000000000000000 0000000000000001 0000000000000001 00000=
000000000dd
> >>>>      GPR12: 0000000000000000 c00000002e99b300 0000000000000000 00000=
00000000000
> >>>>      GPR16: 0000000000000000 0000000000000000 0000000000000000 00000=
00000000000
> >>>>      GPR20: 0000000000000000 0000000000000000 0000000000000000 00000=
00000000000
> >>>>      GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000=
000345f4800
> >>>>      GPR28: 0000000000000000 00000000000000dd 00000000000000dd c0000=
00138e0c000
> >>>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1=
b0
> >>>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
> >>>> [ 1371.387722] Call Trace:
> >>>> [ 1371.387725] [c00000000beafd40] [c000000000937050]
> >>>> selinux_task_getpgid+0x80/0xa0 (unreliable)
> >>>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beaf=
de0
> >>>> [ 1371.387741] [c00000000beafe00] [c000000000034958]
> >>>> system_call_exception+0x448/0x480
> >>>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c]
> >>>> system_call_vectored_common+0x15c/0x2ec
> >>>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
> >>>>
> >>>>
> >>>> Please let me know if additional logs, config, or repro details are =
needed.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Venkat.
> >
> > --
> > paul-moore.com
> >
> >
> >
>
Hello eveyone!

Thanks for looping me in, Paul and for sharing more details, Venkat.

At first glance it seems that the audit_context, for some reason, has
not been cleared. I'll reserve a ppc64le machine and look into this
over the next week.

-Ricardo


