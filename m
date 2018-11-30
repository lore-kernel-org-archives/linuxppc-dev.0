Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A5C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 09:43:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C652145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 09:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpR0gT+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C652145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435qFv3TQhzDqcL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 20:43:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EpR0gT+h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="EpR0gT+h"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435qC15vh7zDrRC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 20:41:00 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id b5so8296053iti.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MG0ShL55h4T0veACiBVErR4OSLIOcHEWNmSannF281w=;
 b=EpR0gT+hyrx8oRWlMPLHRd9JeLHqGYgrTYlgOEO87t+Vfyf8vnLw0fHdwImLPegH1c
 ifRLNWnDmiE+iMIKumRNAfszZCmKcYqep12cLwALBSZe1uPCuVX2A4tpaKszO/U1RS6a
 LaGgzBHN4DUMXJm4iZtruYiPrcJ0lJv+bFZzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MG0ShL55h4T0veACiBVErR4OSLIOcHEWNmSannF281w=;
 b=QOjP2TE8XO0RcHrtM0NwIetb3jyTAhl+kgRXesaiX2RaYRVXmO7j+o1UpxIRPK3Ljh
 PL6oUeVBBGkU93i+AhFXW53nH6MP+uaiL9J8vLKtOiTyI4VrmJ6QeMjXI0ymqX8yQMbW
 q0n6WNcpp4XzXq/5WmRYnE4Vctc59/e9xN5/uyG6LmRgFBJxvM/fNMJLSjoQF1PWp0i8
 6JDsZ8npMVhtmGi82UEq8MI7WxgaQq51NPHM0Pou8iSbQ1Kf2SVfLvUhs0MY/fqDhzcJ
 Kpqjn9sdu2QRUTwJe04HuD9qj8FmN6sfZASTtYZGIWecs4T0qqq9kfVCaV/QqIekKzOo
 4YPg==
X-Gm-Message-State: AA+aEWZ7sPQkP78EjURZAaLfoZeI64T8ocQzirFwGdt5h8sgkpBR8GXy
 uO9hA/AD9Uy7pNEDchRArZ13t+rqe+in4fZhvRUUIQ==
X-Google-Smtp-Source: AFSGD/Xyv5IS2GaeRAISZfcR++7PFKl53dStM9t3dmwde0duCrnNCRNjlsHHWWyh6jV4ceS4Ugm7b6firm3CnOdlmz0=
X-Received: by 2002:a05:660c:a45:: with SMTP id
 j5mr4512483itl.83.1543570858325; 
 Fri, 30 Nov 2018 01:40:58 -0800 (PST)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <20181129063453.GA29271@sathnaga86.in.ibm.com>
 <CALxhOnho7Ad5mzTV-G12inKZbsteN-b706aFQiM9Di6j=6UgYQ@mail.gmail.com>
 <20181130070158.GA7014@sathnaga86.in.ibm.com>
In-Reply-To: <20181130070158.GA7014@sathnaga86.in.ibm.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 30 Nov 2018 15:10:46 +0530
Message-ID: <CALxhOnisFiyE7vXNs4bR5A3jPgcR1sHywMQVbEs3B1w3b+T1_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] System call table generation support
To: sathnaga@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Paul Mackerras <paulus@samba.org>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Breno Leitao <leitao@debian.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Satheesh,

On Fri, 30 Nov 2018 at 12:32, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> On Thu, Nov 29, 2018 at 01:48:16PM +0530, Firoz Khan wrote:
> > Hi Sathish,
> >
> > Thanks for your email.
> >
> > On Thu, 29 Nov 2018 at 12:05, Satheesh Rajendran
> > <sathnaga@linux.vnet.ibm.com> wrote:
> > >
> > > On Fri, Sep 14, 2018 at 02:02:57PM +0530, Firoz Khan wrote:
> > > > The purpose of this patch series is:
> > > > 1. We can easily add/modify/delete system call by changing entry
> > > > in syscall.tbl file. No need to manually edit many files.
> > > >
> > > > 2. It is easy to unify the system call implementation across all
> > > > the architectures.
> > > >
> > > > The system call tables are in different format in all architecture
> > > > and it will be difficult to manually add or modify the system calls
> > > > in the respective files manually. To make it easy by keeping a script
> > > > and which'll generate the header file and syscall table file so this
> > > > change will unify them across all architectures.
> > > >
> > > > syscall.tbl contains the list of available system calls along with
> > > > system call number and corresponding entry point. Add a new system
> > > > call in this architecture will be possible by adding new entry in
> > > > the syscall.tbl file.
> > > >
> > > > Adding a new table entry consisting of:
> > > >         - System call number.
> > > >         - ABI.
> > > >         - System call name.
> > > >         - Entry point name.
> > > >         - Compat entry name, if required.
> > > >
> > > > ARM, s390 and x86 architecuture does exist the similar support. I
> > > > leverage their implementation to come up with a generic solution.
> > > >
> > > > I have done the same support for work for alpha, m68k, microblaze,
> > > > ia64, mips, parisc, sh, sparc, and xtensa. But I started sending
> > > > the patch for one architecuture for review. Below mentioned git
> > > > repository contains more details.
> > > > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> > > >
> > > > Finally, this is the ground work for solving the Y2038 issue. We
> > > > need to add/change two dozen of system calls to solve Y2038 issue.
> > > > So this patch series will help to easily modify from existing
> > > > system call to Y2038 compatible system calls.
> > > >
> > > > I started working system call table generation on 4.17-rc1. I used
> > > > marcin's script - https://github.com/hrw/syscalls-table to generate
> > > > the syscall.tbl file. And this will be the input to the system call
> > > > table generation script. But there are couple system call got add
> > > > in the latest rc release. If run Marcin's script on latest release,
> > > > It will generate a new syscall.tbl. But I still use the old file -
> > > > syscall.tbl and once all review got over I'll update syscall.tbl
> > > > alone w.r.to the tip of the kernel. The impact of this thing, few
> > > > of the system call won't work.
> > > >
> > > > Firoz Khan (3):
> > > >   powerpc: Replace NR_syscalls macro from asm/unistd.h
> > > >   powerpc: Add system call table generation support
> > > >   powerpc: uapi header and system call table file generation
> > > >
> > > >  arch/powerpc/Makefile                       |   3 +
> > > >  arch/powerpc/include/asm/Kbuild             |   3 +
> > > >  arch/powerpc/include/asm/unistd.h           |   3 +-
> > > >  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
> > > >  arch/powerpc/include/uapi/asm/unistd.h      | 391 +---------------------------
> > > >  arch/powerpc/kernel/Makefile                |   3 +-
> > > >  arch/powerpc/kernel/syscall_table_32.S      |   9 +
> > > >  arch/powerpc/kernel/syscall_table_64.S      |  17 ++
> > > >  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
> > > >  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 +++++++++++++++++++++++++++
> > > >  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 ++++++++++++++++++++++++++
> > > >  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
> > > >  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
> > > >  arch/powerpc/kernel/systbl.S                |  50 ----
> > > >  14 files changed, 916 insertions(+), 441 deletions(-)
> > > >  create mode 100644 arch/powerpc/kernel/syscall_table_32.S
> > > >  create mode 100644 arch/powerpc/kernel/syscall_table_64.S
> > > >  create mode 100644 arch/powerpc/kernel/syscalls/Makefile
> > > >  create mode 100644 arch/powerpc/kernel/syscalls/syscall_32.tbl
> > > >  create mode 100644 arch/powerpc/kernel/syscalls/syscall_64.tbl
> > > >  create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
> > > >  create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
> > > >  delete mode 100644 arch/powerpc/kernel/systbl.S
> > >
> > > Hi,
> > >
> > > This patch series failed to boot in IBM Power8 box with below base commit and built with ppc64le_defconfig,
> > > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=183cbf93be88d1a4fb572e27b1e08aa0ad85
> >
> > I think you are applied some old patch series. Could you please
> > perform the boot test on powerpc v3 which I have sent few hour before.
>
> Hi Firoz,
>
> Looks like I chose a wrong mail to reply, but did test with v3 series itself.

Thanks for the update. I'll have look into it and update you asap.

Firoz

>
> _v3,4_4__powerpc_generate_uapi_header_and_system_call_table_files_mbox_merge
>
> Thanks,
> -Satheesh.
> >
> > Thanks
> > Firoz
> >
> > >
> > > Complete boot log attached.
> > >
> > >
> > > [    1.577383] SGI XFS with ACLs, security attributes, no debug enabled
> > > [    1.581550] Bad kernel stack pointer 6e690000 at c000000000e2ceec
> > > [    1.581558] Oops: Bad kernel stack pointer, sig: 6 [#1]
> > > [    1.581562] LE SMP NR_CPUS=2048 NUMA PowerNV
> > > [    1.581567] Modules linked in:
> > > [    1.581572] CPU: 3 PID: 1937 Comm: modprobe Not tainted 4.20.0-rc4-gd35c78239 #1
> > > [    1.581577] NIP:  c000000000e2ceec LR: c00000000000b9e4 CTR: c000000000e2cee0
> > > [    1.581582] REGS: c0000007ffe77d30 TRAP: 0e40   Not tainted  (4.20.0-rc4-gd35c78239)
> > > [    1.581586] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48024488  XER: 00000000
> > > [    1.5815
> > > 94] CFAR: c00000000000b9e0 IRQMASK: c0000000014d1bd8
> > > [    1.581594] GPR00: 00000000000011e0 000000006e690000 c000000001498900 ffffffffffffff9c
> > > [    1.581594] GPR04: c00000006ecb0ff8 0000000000080000 0000000000000000 7f7f7f7f7f7f7f7f
> > > [    1.581594] GPR08: 0000000000000000 c000001e5104fe90 0000000000000000 c000000000c30ff8
> > > [    1.581594] GPR12: c000000000e2cee0 c0000007ffffd800 4f4c5f4543415254 00007fffb55927d0
> > > [    1.581594] GPR16: 00007fffb55bfbf0 00007fffc087b160 c000000065b70ff8 00007fffc087b5c8
> > > [    1.581594] GPR20: 000000000000000d 0000000000000000 0000000000000000 000000000000
> > > 0000
> > > [    1.581594] GPR24: 000000012b660d79 0000000000000000 00007fffb55c0000 0000000000000000
> > > [    1.581594] GPR28: 00007fffb55c1110 0000000000000001 00007fffb55c1050 00007fffc087a880
> > > [    1.58
> > > 1637] NIP [c000000000e2ceec] str_spec.65753+0x147da0/0x1f1c5c
> > > [    1.581643] LR [c00000000000b9e4] system_call+0x5c/0x70
> > > [    1.581646] Call Trace:
> > > [    1.581648] Instruction dump:
> > > [    1.581652]
> > > XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> > > [    1.581657] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> > > [    1.581664] ---[ end trace 37e56b4
> > > 4979b6992 ]---
> > > [    1.582355]
> > >
> > > Regards,
> > > -Satheesh.
> > > >
> > > > --
> > > > 1.9.1
> > > >
> >
>
