Return-Path: <linuxppc-dev+bounces-27001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAA5C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg9qP2j4Cz2yys;
	Thu, 10 Sep 2026 05:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788982177;
	cv=none; b=W44HC7ceMIo+4iHPnSf9H5ArThKjC6E0gSa3L/bP7cmJAnKXx5u6ATsKUY9nYJ+Owxzd2tToVs6TOuVCGlIliCsaXE6XPGhY0byDMEuFOhZSZnbqRed/hZ6i2sr17eHvQMmTs/S50iZ7eprtKuci7O9KuE+fwEz3VLb7WDPyUnZuvfkIudy3KCecX++nMidCiZYmfjm4GUpLwqTIAK91rZZ33pH4s3Zi6atd7Lp4uQpo0975K0C6kfs3hvY6A+oojYj4O13ZQozcFlcQXu+mGx1YOt31CGT9J0MpQxLH01k1nl5ux4I/EHSOOfwTi4U4Xd2XTtfIZGvL2rZfSg/gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788982177; c=relaxed/relaxed;
	bh=dm9wpz4h++ofzecnaqGunBw1Zr0gciiuIEIuRKgM8Ow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hcp8htAcTMmYWTR3Ztc3YORvUrOr+0MZNHWMOmgacr3hQVYKKCQX9CCEErxQB7EcblzvmY1GiHxM19tZABDYaf3BFHPWztuz0A2oIkrf0r2hoyuIABXVFxLf/ZMz0F2KC8C65td97VgsDKeOSIThHUTYEvIlG7CltakhQCIf/EDgFZizyFARWifAsavVq26jjDnQle4+GKEVVm25CwAwwMouiJtbm+xxtZh3FjWrMn0G/B7ulRXQ77EtDjImUKwnYBNC+/UhS5aGOvF/UGkFlh2bI8fNB4wVx+8rZypHXktwu8dHreq2n1TxlLCI5gJmpF8GmIMjMVYVliZ7VHc0Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026082801 header.b=KGmenuJ4; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026082801 header.b=KGmenuJ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg9qL1nXlz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:29:32 +1000 (AEST)
Received: from ehlo.thunderbird.net ([172.59.162.201])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 689JRcBm234939
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Sep 2026 12:27:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 689JRcBm234939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1788982063;
	bh=dm9wpz4h++ofzecnaqGunBw1Zr0gciiuIEIuRKgM8Ow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KGmenuJ4WDEIJmD1OjtLBCTBIwmOPf5WXdqCO5NhxzNk/PRMxxRdYtCQ/e9LiQrbV
	 5nqhJq3gZmxqektEkouPM43IJ+O+eLEDDnkzku4OU8RnhJdWNoOzbcM86CqUSS8cda
	 TGHj1Sj2JK1rzrE8/0GlItXDBmcjxoplXEs2uNG488VNDWTtxr1RHdwo+/ZC/5FRv+
	 Wy6lT+Qfy6Lh4xU4ePky/daoK1IUOfrPNaz0BFP5rM0ouPsB86TVM+rt/GpXFp601e
	 VoZGbeqZhFA9YU7x21eyffmZrBwUa7PfRZVyvemk05/BdqUB6bb3V5JxF/PsdotOYc
	 tTrjTgSh5/hig==
Date: Wed, 09 Sep 2026 12:27:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_02/24=5D_x86/elf=2C_um/x86/?=
 =?US-ASCII?Q?elf=3A_Move_relocation_constants_to_UAPI?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de> <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de> <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local> <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de> <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local> <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de> <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
Message-ID: <F9786718-8378-443D-A21E-77E057B62BB2@zytor.com>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 9, 2026 7:49:30 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote=
:
>On Wed, Sep 09, 2026 at 07:59:51AM +0200, Thomas Wei=C3=9Fschuh wrote:
>> These names and numbers are defined by the architectures' ELF specifica=
tions=2E
>> They are already cast in stone=2E For example see Table 4=2E9 of [0]=2E
>> Changing them would break compilers, linkers, loaders and more or less =
every
>> existing ELF binary=2E
>
>So?
>
>Your goal is to provide them to tools/=2E You want to provide them to
>*everything*=2E See the discrepance here?
>
>> That is the documentation for the tools UAPI headers=2E
>
>Did you even read that file?
>
>"Why we want a copy of kernel headers in tools?
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>There used to be no copies, with tools/ code using kernel headers
>directly=2E From time to time tools/perf/ broke due to legitimate kernel
>hacking=2E At some point Linus complained about such direct usage=2E Then=
 we
>adopted the current model=2E
>
>The way these headers are used in perf are not restricted to just
>including them to compile something=2E
>=2E=2E=2E"
>
>Just read the damn thing before you reply=2E
>
>> Also we already have other, closely related, ELF constants in the UAPI,
>> see {,tools/}include/uapi/linux/elf{,-em}=2Eh=2E
>
>Srsly?!?
>
>You moved them there:
>
>commit 626fd35278295fbb21f2da331cd8028e9738d965
>Author: Thomas Wei=C3=9Fschuh <thomas=2Eweissschuh@linutronix=2Ede>
>Date:   Wed Feb 26 12:44:46 2025 +0100
>
>    tools/include: Add uapi/linux/elf=2Eh
>   =20
>    It will be used by the vDSO selftests=2E
>
>
>Looking at the rest, it looks like some elf bits got exported, you added =
some
>more and that ship has sailed=2E I still think us providing headers is
>completely unnecessary and it will come to cause conflicts eventually but=
 hey,
>not my problem=2E
>

I do believe there are *some* headers that would be reasonably to export t=
o tools/ beyond what it is in uapi; a major reason for that is that the too=
ls are suffering from a crazy level of internal inconsistency right now=2E=
=20

Basically uapi =E2=8A=82 treewide =E2=8A=82 kernel, but also treewide =E2=
=8A=82 tools common =E2=8A=82 tool-specific=2E=2E=2E

