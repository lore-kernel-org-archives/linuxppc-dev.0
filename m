Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C673C0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 11:45:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63812082E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 11:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63812082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42nHFP21f5zF36T
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 22:45:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nod.at
 (client-ip=195.201.40.130; helo=lithops.sigma-star.at;
 envelope-from=richard@nod.at; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=nod.at
X-Greylist: delayed 578 seconds by postgrey-1.36 at bilbo;
 Sat, 03 Nov 2018 20:25:06 AEDT
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42nD760X1jzF35t
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 20:25:05 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 0885C606D487;
 Sat,  3 Nov 2018 10:15:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id POaZfqxv8zrK; Sat,  3 Nov 2018 10:15:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 81CD7606C48C;
 Sat,  3 Nov 2018 10:15:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6U7XB2Wlq2pf; Sat,  3 Nov 2018 10:15:14 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at
 [213.47.184.186])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 440E1609F82F;
 Sat,  3 Nov 2018 10:15:12 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Date: Sat, 03 Nov 2018 10:15:11 +0100
Message-ID: <6886607.O3ZT5bM3Cy@blindfold>
In-Reply-To: <20181103040041.7085-1-joelaf@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 03 Nov 2018 22:41:25 +1100
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
Cc: Joel Fernandes <joelaf@google.com>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-ia64@vge,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 kvmarm@lists.cs.columbia.edu, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 r.kernel.org@lithops.sigma-star.at, hughd@google.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 anton.ivanov@kot-begemot.co.uk, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 pantin@google.com, linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel,

Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
> Hi,
> Here is the latest "fast mremap" series. This just a repost with Kirill's
> Acked-bys added. I would like this to be considered for linux -next.  I a=
lso
> dropped the CONFIG enablement patch for arm64 since I am yet to test it w=
ith
> the new TLB flushing code that is in very recent kernel releases. (None o=
f my
> arm64 devices run mainline right now.) so I will post the arm64 enablemen=
t once
> I get to that. The performance numbers in the series are for x86.
>=20
> List of patches in series:
>=20
> (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
>=20
> (2) mm: speed up mremap by 20x on large regions (v4)
> v1->v2: Added support for per-arch enablement (Kirill Shutemov)
> v2->v3: Updated commit message to state the optimization may also
> 	run for non-thp type of systems (Daniel Col).
> v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
> 	Rebased ontop of Linus's master, updated perf results based
>         on x86 testing. Added Kirill's Acks.
>=20
> (3) mm: treewide: remove unused address argument from pte_alloc functions=
 (v2)
> v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
>         update changelog with manual fixups for m68k and microblaze.
>=20
> not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
>     This patch is dropped since last posting pending further performance
>     testing on arm64 with new TLB gather updates. See notes in patch
>     titled "mm: speed up mremap by 500x on large regions" for more
>     details.
>=20

This breaks UML build:
  CC      mm/mremap.o
mm/mremap.c: In function =E2=80=98move_normal_pmd=E2=80=99:
mm/mremap.c:229:2: error: implicit declaration of function =E2=80=98set_pmd=
_at=E2=80=99; did you mean =E2=80=98set_pte_at=E2=80=99? [-Werror=3Dimplici=
t-function-declaration]
  set_pmd_at(mm, new_addr, new_pmd, pmd);
  ^~~~~~~~~~
  set_pte_at
  CC      crypto/rng.o
  CC      fs/direct-io.o
cc1: some warnings being treated as errors

To test yourself, just run on a x86 box:
$ make defconfig ARCH=3Dum
$ make linux ARCH=3Dum

Thanks,
//richard


