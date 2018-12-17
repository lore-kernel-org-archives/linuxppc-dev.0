Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F35C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B23B2133F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B23B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JHYD0wkRzDqf0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 21:33:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JHVx5qWjzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 21:31:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JHVv44stz9sBh;
 Mon, 17 Dec 2018 21:31:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
 <20181217080846.GA28424@sathnaga86.in.ibm.com>
Date: Mon, 17 Dec 2018 21:30:58 +1100
Message-ID: <877eg8v40t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 Boqun Feng <boqun.feng@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 marcin.juszkiewicz@linaro.org, Breno Leitao <leitao@debian.org>,
 Paul Mackerras <paulus@samba.org>, deepa.kernel@gmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:
> Hi Firoz,
>
> On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
>> The purpose of this patch series is, we can easily
>> add/modify/delete system call table support by cha-
>> nging entry in syscall.tbl file instead of manually
>> changing many files. The other goal is to unify the 
>> system call table generation support implementation 
>> across all the architectures. 
>> 
>> The system call tables are in different format in 
>> all architecture. It will be difficult to manually
>> add, modify or delete the system calls in the resp-
>> ective files manually. To make it easy by keeping a 
>> script and which'll generate uapi header file and 
>> syscall table file.
>> 
>> syscall.tbl contains the list of available system 
>> calls along with system call number and correspond-
>> ing entry point. Add a new system call in this arch-
>> itecture will be possible by adding new entry in 
>> the syscall.tbl file.
>> 
>> Adding a new table entry consisting of:
>>         - System call number.
>>         - ABI.
>>         - System call name.
>>         - Entry point name.
>> 	- Compat entry name, if required.
>> 	- spu entry name, if required.
>> 
>> ARM, s390 and x86 architecuture does exist the sim-
>> ilar support. I leverage their implementation to 
>> come up with a generic solution.
>> 
>> I have done the same support for work for alpha, 
>> ia64, m68k, microblaze, mips, parisc, sh, sparc, 
>> and xtensa. Below mentioned git repository contains
>> more details about the workflow.
>> 
>> https://github.com/frzkhn/system_call_table_generator/
>> 
>> Finally, this is the ground work to solve the Y2038
>> issue. We need to add two dozen of system calls to 
>> solve Y2038 issue. So this patch series will help to
>> add new system calls easily by adding new entry in the
>> syscall.tbl.
>> 
>> Changes since v4:
>>  - DOTSYM macro removed for ppc32, which was causing
>>    the compilation error.
>> 
>> Changes since v3:
>>  - split compat syscall table out from native table.
>>  - modified the script to add new line in the generated
>>    file.
>> 
>> Changes since v2:
>>  - modified/optimized the syscall.tbl to avoid duplicate
>>    for the spu entries.
>>  - updated the syscalltbl.sh to meet the above point.
>> 
>> Changes since v1:
>>  - optimized/updated the syscall table generation 
>>    scripts.
>>  - fixed all mixed indentation issues in syscall.tbl.
>>  - added "comments" in syscall_*.tbl.
>>  - changed from generic-y to generated-y in Kbuild.
>> 
>> Firoz Khan (5):
>>   powerpc: add __NR_syscalls along with NR_syscalls
>>   powerpc: move macro definition from asm/systbl.h
>>   powerpc: add system call table generation support
>>   powerpc: split compat syscall table out from native table
>>   powerpc: generate uapi header and system call table files
>
> Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
> both failed to apply series.
>
> # git am mbox
> Applying: powerpc: add __NR_syscalls along with NR_syscalls
> Applying: powerpc: move macro definition from asm/systbl.h
> Applying: powerpc: add system call table generation support
> Applying: powerpc: split compat syscall table out from native table
> Applying: powerpc: generate uapi header and system call table files
> error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
> error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
> Patch failed at 0005 powerpc: generate uapi header and system call table files
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
> patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.
>
> # uname -r
> 4.20.0-rc2-gdd2690d2c
>
> Looks like patch series needs a rebase against the latest kernel versions.

No it's fine if it applies on next.

I can also fix up minor merge conflicts if there are any.

cheers
