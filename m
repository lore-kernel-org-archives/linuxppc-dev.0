Return-Path: <SRS0=xixs=JR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75272C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 06:19:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BA4613B2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 06:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BA4613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPYSM6T6gz2yj0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 16:19:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=aZSJaNW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12c;
 helo=mail-lf1-x12c.google.com; envelope-from=alexei.starovoitov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aZSJaNW8; dkim-atps=neutral
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FPTgM5TxGz2xZL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 13:29:01 +1000 (AEST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so19801000lfp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sjA5c4MI/V/Us5khupc3zlEWJtPk9Lba1kHWIn9xqrM=;
 b=aZSJaNW84mZRYAHIY5t88erflreGTdYjaH3FYtF1qHJPn6VWs0jryZT46tcKmPEGha
 /og/FC8vcGojrzKljv51Y7lWbKJNsViPSNua0KzzWTeHQBaA77mtr8NCMQ4THd2QTzcC
 W4NX+bAwjkGszUu3wkPlccw0aoYiZjMS+T4JTPsVHoVH+R4TOOISLvGTXFbJ16T+Dgur
 kbNEKiwtz58pU2SAt4AjUcSxyUGvQb0yQueu6ghHyatn+Cc/mNZXXrnsQvXgxCwKXuNp
 sZTyXkoz02r+DOAERoaXyqJHUX8rL4MjlDqKs+1CuVe940UruGYC9kE+b/nNTgV9xhkG
 purg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sjA5c4MI/V/Us5khupc3zlEWJtPk9Lba1kHWIn9xqrM=;
 b=Vztq3RHzSXX2W0MQ5gfOefy/pKwk/FY+T2qnyC270B3ruheuvfjSKVUeUHak2SI2FC
 PPVvWpA8/soFFscOpkXSTRh5KvNTXxJeEiKdRVLKCn3siybsgx1CIUVy5yw56mUd2QQ8
 GHRNNxC+TBW9LApR1+F8NqC4kTG4hwK54c5vWW5wFA2dSCRWdFkbyFUUBN+MWuUlTEVD
 zJpH0Ly75/GIvpvQ84OfBwn+TEwX81wzLp62GBwcTsvwiS/Rh1wjKjYMh+DRRhI0HDl1
 RZ9BryzQ6EAcIw6Im9zesYwq1ZWvKaAXfLJ8DLIR65WptI7BmlK+sBIlNbNxZCaP+2Gg
 mI4A==
X-Gm-Message-State: AOAM530CuALBNRRzIxnm1hhaS7tJJ6BbDvVrtyLLoBQBQJmqlhySydKT
 W/6NOtTPRitBmeUHQ1hDixgsVRe54KZ0ehdP2Iw=
X-Google-Smtp-Source: ABdhPJxtNTC6hNyk2mAr0jYIRtC3Pnw65n4y2IU2BFaZPz0SzJ5eF0gkFi6YsfR4xYcNBc9nZPkqaJatjNPZ02gYJpQ=
X-Received: by 2002:ac2:510d:: with SMTP id q13mr13835296lfb.75.1618889332453; 
 Mon, 19 Apr 2021 20:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093250.3391257-1-Jianlin.Lv@arm.com>
 <9c4a78d2-f73c-832a-e6e2-4b4daa729e07@iogearbox.net>
 <d3949501-8f7d-57c4-b3fe-bcc3b24c09d8@isovalent.com>
 <CAADnVQJ2oHbYfgY9jqM_JMxUsoZxaNrxKSVFYfgCXuHVpDehpQ@mail.gmail.com>
 <0dea05ba-9467-0d84-4515-b8766f60318e@csgroup.eu>
In-Reply-To: <0dea05ba-9467-0d84-4515-b8766f60318e@csgroup.eu>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Apr 2021 20:28:41 -0700
Message-ID: <CAADnVQ+oQT6C7Qv7P5TV-x7im54omKoCYYKtYhcnhb1Uv3LPMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Remove bpf_jit_enable=2 debugging mode
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Apr 2021 16:19:21 +1000
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
Cc: Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Zi Shen Lim <zlim.lnx@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Paul Mackerras <paulus@samba.org>, Sandipan Das <sandipan@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Shubham Bansal <illusionist.neo@gmail.com>,
 Mahesh Bandewar <maheshb@google.com>, Will Deacon <will@kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 paulburton@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, X86 ML <x86@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Quentin Monnet <quentin@isovalent.com>, Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Tobias Klauser <tklauser@distanz.ch>,
 grantseltzer@gmail.com, Xi Wang <xi.wang@gmail.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Luke Nelson <luke.r.nels@gmail.com>,
 Heiko Carstens <hca@linux.ibm.com>, KP Singh <kpsingh@kernel.org>,
 iecedge@gmail.com, Simon Horman <horms@verge.net.au>,
 Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Jianlin Lv <Jianlin.Lv@arm.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Wang YanQing <udknight@gmail.com>, tsbogend@alpha.franken.de,
 Daniel Borkmann <daniel@iogearbox.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
 linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yonghong Song <yhs@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 bpf <bpf@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 17, 2021 at 1:16 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 16/04/2021 =C3=A0 01:49, Alexei Starovoitov a =C3=A9crit :
> > On Thu, Apr 15, 2021 at 8:41 AM Quentin Monnet <quentin@isovalent.com> =
wrote:
> >>
> >> 2021-04-15 16:37 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> >>> On 4/15/21 11:32 AM, Jianlin Lv wrote:
> >>>> For debugging JITs, dumping the JITed image to kernel log is discour=
aged,
> >>>> "bpftool prog dump jited" is much better way to examine JITed dumps.
> >>>> This patch get rid of the code related to bpf_jit_enable=3D2 mode an=
d
> >>>> update the proc handler of bpf_jit_enable, also added auxiliary
> >>>> information to explain how to use bpf_jit_disasm tool after this cha=
nge.
> >>>>
> >>>> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> >>
> >> Hello,
> >>
> >> For what it's worth, I have already seen people dump the JIT image in
> >> kernel logs in Qemu VMs running with just a busybox, not for kernel
> >> development, but in a context where buiding/using bpftool was not
> >> possible.
> >
> > If building/using bpftool is not possible then majority of selftests wo=
n't
> > be exercised. I don't think such environment is suitable for any kind
> > of bpf development. Much so for JIT debugging.
> > While bpf_jit_enable=3D2 is nothing but the debugging tool for JIT deve=
lopers.
> > I'd rather nuke that code instead of carrying it from kernel to kernel.
> >
>
> When I implemented JIT for PPC32, it was extremely helpfull.
>
> As far as I understand, for the time being bpftool is not usable in my en=
vironment because it
> doesn't support cross compilation when the target's endianess differs fro=
m the building host
> endianess, see discussion at
> https://lore.kernel.org/bpf/21e66a09-514f-f426-b9e2-13baab0b938b@csgroup.=
eu/
>
> That's right that selftests can't be exercised because they don't build.
>
> The question might be candid as I didn't investigate much about the repla=
cement of "bpf_jit_enable=3D2
> debugging mode" by bpftool, how do we use bpftool exactly for that ? Espe=
cially when using the BPF
> test module ?

the kernel developers can add any amount of printk and dumps to debug
their code,
but such debugging aid should not be part of the production kernel.
That sysctl was two things at once: debugging tool for kernel devs and
introspection for users.
bpftool jit dump solves the 2nd part. It provides JIT introspection to user=
s.
Debugging of the kernel can be done with any amount of auxiliary code
including calling print_hex_dump() during jiting.
