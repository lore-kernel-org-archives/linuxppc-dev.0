Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D700C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 10:22:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62BA21881
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 10:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62BA21881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MR3g3gwDzDqZD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 20:22:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MR1T0DB0zDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 20:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46MR1Q5Y9pz9s7T;
 Mon,  2 Sep 2019 20:20:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, kbuild test robot
 <lkp@intel.com>
Subject: Re: [PATCH v2 4/4] powerpc/64: system call implement the bulk of the
 logic in C
In-Reply-To: <20190830220451.74183fa0@kitsune.suse.cz>
References: <20190827135548.21457-5-npiggin@gmail.com>
 <201908310210.jvudTAn4%lkp@intel.com>
 <20190830220451.74183fa0@kitsune.suse.cz>
Date: Mon, 02 Sep 2019 20:20:37 +1000
Message-ID: <8736hft2x6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Sat, 31 Aug 2019 02:48:26 +0800
> kbuild test robot <lkp@intel.com> wrote:
>
>> Hi Nicholas,
>>=20
>> I love your patch! Yet something to improve:
>>=20
>> [auto build test ERROR on linus/master]
>> [cannot apply to v5.3-rc6 next-20190830]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o help improve the system]
>>=20
>> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc=
-64-syscalls-in-C/20190828-064221
>> config: powerpc64-defconfig (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 7.4.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dpowerpc64=20
>>=20
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>=20
>> All errors (new ones prefixed by >>):
>>=20
>>    powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker =
stubs' being placed in section `.gnu.hash'.
>>    arch/powerpc/kernel/syscall_64.o: In function `.system_call_exception=
':
>> >> syscall_64.c:(.text+0x180): undefined reference to `.tabort_syscall'=
=20=20
>
> Interestingly it builds and boots for me. Is this something about
> dotted vs dotless symbols depending on some config options?

It's the big endian build that fails, which is ELFv1, and the linker is
saying it can't find a function called `.tabort_syscall` - which is
understandable because there isn't one. There's a text address called
`tabort_syscall` but it has no function descriptor so you can't call it
normally from C.

> I see there is _GLOBAL(ret_from_fork) just below so maybe we need
> _GLOBAL(tabort_syscall) instead of .globl tabort_syscall as well.

Yes, on ELFv1 the _GLOBAL macros creates a function descriptor for you.

This fixes it for me:

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 82bcb9a68172..8f2735da205d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -170,8 +170,7 @@ _ASM_NOKPROBE_SYMBOL(system_call_common);
 	b	.Lsyscall_restore_regs_cont
=20
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	.globl tabort_syscall
-tabort_syscall:
+_GLOBAL(tabort_syscall)
 	/* Firstly we need to enable TM in the kernel */
 	mfmsr	r10
 	li	r9, 1


cheers
