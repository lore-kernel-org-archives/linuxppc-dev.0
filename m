Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21033606A330
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYz013lx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS2KC37SPz2xGr;
	Sun, 15 Nov 2026 18:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794726815;
	cv=none; b=A5JJMC62DK5gh4GZyiWZ+qCzpP3cVh5NfgULZ8GAt/QTQfdbZk7/Opa6DaPvm0ar8tI45htlbfgTAN5Lb/DOvfyNQ0BcSRL1Mvx3STg/RMez9kIfc6iEjDjRYuh0LsMb6MfNsEa6G42/QtKTthKxmT1TbzVXuYbOGbEhr82Nbi7xjPPtvFHzQ+Fcxohwb9w0YWWAMlF1wKUSVBBdkMC/zTQbaKE1iWxJCZeuFhT1lolFYT6I25KI4QGYPAF2wlShpu5SQMShe0prfjKHZLNPPbeuaGJZGXeDLHBjIRPuuuyd1gFHIDQx2rSYvcUBLMCvnVU57r7ZC1dPnMspqMH2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794726815; c=relaxed/relaxed;
	bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=bk2TvlP/lROJpSoS0nbUtzicnMECo90ICM1MhcxDCer6uBiS2v+E3+mx9HIgRLPFYo31Kv1foWjm9Uoact9T+PzMIdyVMocFnvN/v3zrGKLhD+oiI1EfmU10ae3KvqLHRTUFgv8KFfgLqMJEGaI/LA+YxMvfbSstavnLM+19wzG54uw7UEEmwcAh9Wpu2Wwo9uqDxPGcxXYB6aNIHDfuLFO63hf6JjqBa30R+p6DpW/A05jsgZBPDjkJorPG3qWjiLkS42ElySqQ0e+ef5q474ghSZKbUUXZW+XNlL4GEJjogDrvrWv35lMcEQ3fJX4uD5xuReJYYBD+TsWThHw7jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYz013lx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYz013lx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS2KB3t4Fz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 18:13:33 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1a2761c69fbso2761583c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726811; x=1795331611; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=GYz013lxTXpn7id/onFt97DbN95FMzBTITmoQq6B30KNyS6F+dzvWpX0m849sVWefg
         ExP/SqZ4T1v/KsdB4UOR6sjGRuBfgXf3AkBsKHqHYUOZHNc7S/Yjq5fdKN1NFX6/OLaT
         KXVvT9Ngkn8pvztJQSIP3PgptRQ20UCPkLPyFR+RRqyl5tRnfJAGbiS8lFS+R/DI/tMZ
         Eby0xEWjI/DRq8JSAGiqjm6oJfOZMErivF4kyfOgt/tdif9Rddg1Fsxenl3q86PGHXAs
         YFaeDCM/8jhRb5VgApklFEduXaWh5PhKsr/G4jbePfdiBhPp71fEXLbhrzQ/hap2hJBM
         OiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726811; x=1795331611;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=ShH+5FSnH5gTufgD0rf/IecY9Mx482JkSehKGLLCcwdm15FuvRDEsNrCBat8SVCyi9
         3Sn7o38XWUm7jdqK2PYRCIos/QMFmHiHZcNEQH/dpYfl1EAbPWVdkOjJ0f+flH5laCd6
         3jY6m3PYQ4wz4YNe+bdxY9fcdkFrLH4EwW1owW9IPb+0mjq8WxF09PVD20gTdX5HXP9E
         Jm1du1jIRBoYOcWKFYYDGFJD76WUVekuhRVPudB5v2M9d1L06q3HlNRFhULfNYMx72RX
         1DN8JhvJ9b13NrY/TVi6GLztJtOS8Pv0H78V+OKi/4KrDXjKR7KLCJbHtrMolrPKtx0c
         Wzeg==
X-Forwarded-Encrypted: i=1; AL+hErGrdqDzQGe3hBmxYSUoQ+JZL9G0FnXpSuB8b8RGX7zE5dHCDz13umUHN2q3pXtSaRPKZRtplRa0g3yR0D0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/2DWRFThH/rBHVcG9b1b1yTUcGk8tth6PyVsIykD9hQVq1bNNN
	GYflTbD+v3BijRDodgbIoX2gHN53mBrOQnUhDEJyEalGeMgQfKXOlhDq
X-Gm-Gg: AYBFou2r0oGSpSQ0E6oRhTc5JxtVQabq2iL2GG5GbD8Kmu5eN2AkeEfDvzidsOm7ln9
	L68TW8XbvxfVPzGNIozhyGeEQ15+A2uh1x/uqdCJ6f0p1K2FloTt4Lt9iIL1rel8kZe40Z6o6xF
	Dj/7ogZSeHccgdbwRMV5cyFq2H1BYIkMjsbYEBX9IRXIscX3JCy8V8RqRiQlBoJY+AneFIp0wqr
	gh96dQeKKBTQoT7I/0Eho2bX369caHZ2QEfhLi3NUW6J1jSG/AroQ7Vy93hnebd7gowG+EGqPE/
	ULHVuUKsZFxCO4QSbe1xMpmqeGiToN3F6lydcbDsUX450spdq8fo7G0b03WpQC2/YnNhtjDh5+/
	z/vkbuMecO6buBRbZESGsgApm/9qF42Z3QWri40EymhwfaKjNsvLaKyyWQ5js7gXEoWHIGUSwgX
	0DVed/Q8JXlLr5xuzD9ckAyc926Tav3gt+TUdjXhu74+pMup43ej+0YStqozDbrqlRpbzqYO/La
	8lDGvTqUGIr8hjn9T3W0YGcfaPZdtEjXtu/Esowu3grvUwju6vxWNGNvMGMrDXwdABnFntpF3Xe
	uJVFqgHFkektAf6IrROzd2N6ecQ=
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-37967dd7e1dmr11471490eec.34.1794726811302;
        Sat, 14 Nov 2026 23:13:31 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm27441185eec.27.2026.11.14.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:13:30 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald
 Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Liviu Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit
 <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Peter
 Zijlstra <peterz@infradead.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell
 King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for kprobes allocations
In-Reply-To: <avlTdlK9ErlqVRYl@kernel.org>
Date: Sun, 15 Nov 2026 12:33:31 +0530
Message-ID: <4idi8tks.ritesh.list@gmail.com>
References: <20240505160628.2323363-1-rppt@kernel.org> <20240505160628.2323363-12-rppt@kernel.org> <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org> <avlTdlK9ErlqVRYl@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mike Rapoport <rppt@kernel.org> writes:

> Hi Christophe,
>
> On Fri, Nov 13, 2026 at 03:36:01PM +0100, Christophe Leroy (CS GROUP) wro=
te:
>> Hi Mike,
>>=20
>> Looks like I missed this change ...
>>=20

I didn't initially get what Christophe meant here. Then I came across this
reply of from him[1]. So looks like somehow between v3 to v8, something got
changed?=20

    On powerpc book3s/32, vmalloc space is not executable. Only modules=20
    space is executable. X/NX cannot be set on a per page basis, it can onl=
y=20
    be set on a 256 Mbytes segment basis.

    See commit c49643319715 ("powerpc/32s: Only leave NX unset on segments=
=20
    used for modules") and 6ca055322da8 ("powerpc/32s: Use dedicated segmen=
t=20
    for modules with STRICT_KERNEL_RWX") and 7bee31ad8e2f ("powerpc/32s: Fi=
x=20
    is_module_segment() when MODULES_VADDR is defined").

    So if your intention is still to have an executable kprobes, then you=20
    can't use vmalloc address space.

[1]: https://lore.kernel.org/all/1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgro=
up.eu/

>> Le 05/05/2024 =C3=A0 18:06, Mike Rapoport a =C3=A9crit=C2=A0:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> >=20
>> > powerpc overrides kprobes::alloc_insn_page() to remove writable
>> > permissions when STRICT_MODULE_RWX is on.
>> >=20
>> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
>> > generic kprobes::alloc_insn_page() with the desired permissions.
>> >=20
>> > As powerpc uses breakpoint instructions to inject kprobes, it does not
>> > need to constrain kprobe allocations to the modules area and can use t=
he
>> > entire vmalloc address space.
>>=20
>> Using breakpoint means the segment must still be executable.
>> On book3s/32 VMALLOC segment is not executable, while module segment is.
>>=20
>> See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules
>> with STRICT_KERNEL_RWX")
>>=20
>> See report and fix at https://lore.kernel.org/all/ed03d290d440d579a81ae0=
b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/
>
> I'll take a look, thanks!
>=20=20

Thanks Mike for taking a look. Sorry, I should have ccd'd you there, I
guess I missed it. However, the changes are these one here [2][3]

[2]: https://lore.kernel.org/linuxppc-dev/82c4973addebd82923c460cb44221f5b7=
6146afe.1794572365.git.ritesh.list@gmail.com/
[3]: https://lore.kernel.org/linuxppc-dev/f75f2cf97f44375fd2c8820e0caeab703=
cdb371c.1794572365.git.ritesh.list@gmail.com/

-ritesh


