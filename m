Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2300C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:50:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2985420657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2985420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kLDt5PZNzF0xF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 03:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kLBt1xnKzDrRP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 03:48:21 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9TGiUCS085490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 12:48:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ne337jd2u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 12:48:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 29 Oct 2018 16:48:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 29 Oct 2018 16:48:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9TGmDBS61669578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Oct 2018 16:48:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B99011C052;
 Mon, 29 Oct 2018 16:48:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60C0611C04C;
 Mon, 29 Oct 2018 16:48:10 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.178.19])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Oct 2018 16:48:10 +0000 (GMT)
Date: Mon, 29 Oct 2018 09:48:06 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18102916-4275-0000-0000-000002D5DA3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102916-4276-0000-0000-000037E1F932
Message-Id: <20181029164806.GA5494@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-29_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290154
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Cc: Will Drewry <wad@chromium.org>, Linux API <linux-api@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@amacapital.net>, Michael Sammler <msammler@mpi-sws.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 09:25:15AM -0700, Kees Cook wrote:
> On Mon, Oct 29, 2018 at 4:23 AM, Michael Sammler <msammler@mpi-sws.org> wrote:
> > Add the current value of an architecture specific protection keys
> > register (currently PKRU on x86) to data available for seccomp-bpf
> > programs to work on. This allows filters based on the currently
> > enabled protection keys.
> >
> > Support for protection keys on the POWER architecture is not part of
> > this patch since I do not have access to a PowerPC, but adding support
> > for it can be achieved by setting sd->pkeys to the AMR register in
> > populate_seccomp_data.

Maybe you can use a generic read_pkey() function, and each arch can
provide their own implementation.  In the case of powerpc it is
mfspr(SPRN_AMR);

something like the code below might help?

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 92a9962..d79efe3 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -89,6 +89,11 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
 #define __mm_pkey_is_reserved(pkey) (reserved_allocation_mask & \
 				       pkey_alloc_mask(pkey))
 
+static inline u64 read_pkey()
+{
+        return mfspr(SPRN_AMR);
+}
+
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
 	if (pkey < 0 || pkey >= arch_max_pkey())
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 19b137f..feea114 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -9,6 +9,11 @@
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
+static inline u64 read_pkey()
+{
+        return read_pkru();
+}
+
 static inline bool arch_pkeys_enabled(void)
 {
 	return boot_cpu_has(X86_FEATURE_OSPKE);
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba97..f1538c7 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -13,6 +13,11 @@
 #define PKEY_DEDICATED_EXECUTE_ONLY 0
 #define ARCH_VM_PKEY_FLAGS 0
 
+static inline u64 read_pkey()
+{
+	return 0;
+}
+
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
 	return 0;

RP

> >
> > One use case for this patch is disabling unnecessary system calls for a
> > library (e.g. network i/o for a crypto library) while the library runs
> > without disabling the system calls for the whole program (by changing
> > the protection keys before and after the library executes). Using this
> > one could ensure that the library behaves a expected (e.g. the crypto
> > library not sending private keys to a malicious server).
> >
> > This patch also enables lightweight sandboxing of untrusted code using
> > memory protection keys: Protection keys provide memory isolation but
> > for a sandbox system call isolation is needed as well. This patch
> > allows writing a seccomp filter to prevent system calls by the
> > untrusted code while still allowing system calls for the trusted code.
> 
> Isn't PKU instruction based? Couldn't a malicious library just change
> the state of the MPK registers? This seems like an easy way to bypass
> any filters that used PKU. I'm not convinced this is a meaningful
> barrier that should be enforced by seccomp.
> 
> This can also be done with a signal handler with SECCOMP_RET_TRAP and
> check instruction pointer vs PKU state.
> 
> -Kees
> 
> >
> > An alternative design would be to extend (c)BPF with a new instruction
> > to read the state of a protection key. This alternate design would
> > provide a simpler interface to the user space since the BPF program
> > would not need to deal with the architecture specific pkeys field in
> > seccomp_data, but the question is, how much of an advantage this would
> > be as the nr field in seccomp_data is already architecture specific.
> > Adding a new instruction for BPF programs is more complicated than
> > this patch and might be a breaking change.
> >
> > Results of selftests/seccomp_benchmark.c on a x86 machine with pkeys
> > support:
> >
> > With patch:
> > Benchmarking 33554432 samples...
> > 28.019505558 - 18.676858522 = 9342647036
> > getpid native: 278 ns
> > 42.279109885 - 28.019657031 = 14259452854
> > getpid RET_ALLOW: 424 ns
> > Estimated seccomp overhead per syscall: 146 ns
> >
> > Without patch:
> > Benchmarking 33554432 samples...
> > 28.059619466 - 18.706769155 = 9352850311
> > getpid native: 278 ns
> > 42.299228279 - 28.059761804 = 14239466475
> > getpid RET_ALLOW: 424 ns
> > Estimated seccomp overhead per syscall: 146 ns
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Ram Pai <linuxram@us.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-api@vger.kernel.org
> > Signed-off-by: Michael Sammler <msammler@mpi-sws.org>
> > ---
> > Changes to the previous version:
> > - added motivation, notes about POWER, alternative design and benchmark results to the commit log
> > - renamed pkru field in seccomp_data to pkeys
> > - changed size of pkru field to __u64 and removed reserved field
> > - added test for x86
> >
> >  arch/mips/kernel/ptrace.c                     |   1 +
> >  arch/x86/entry/common.c                       |   1 +
> >  include/uapi/linux/seccomp.h                  |   3 +
> >  kernel/seccomp.c                              |   1 +
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 107 +++++++++++++++++++++++++-
> >  5 files changed, 112 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> > index e5ba56c0..a58dd04d 100644
> > --- a/arch/mips/kernel/ptrace.c
> > +++ b/arch/mips/kernel/ptrace.c
> > @@ -1277,6 +1277,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
> >                 for (i = 0; i < 6; i++)
> >                         sd.args[i] = args[i];
> >                 sd.instruction_pointer = KSTK_EIP(current);
> > +               sd.pkeys = 0;
> >
> >                 ret = __secure_computing(&sd);
> >                 if (ret == -1)
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 3b2490b8..20c51bf2 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -98,6 +98,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
> >                 sd.arch = arch;
> >                 sd.nr = regs->orig_ax;
> >                 sd.instruction_pointer = regs->ip;
> > +               sd.pkeys = read_pkru();
> >  #ifdef CONFIG_X86_64
> >                 if (arch == AUDIT_ARCH_X86_64) {
> >                         sd.args[0] = regs->di;
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index 9efc0e73..3aa2d934 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -52,12 +52,15 @@
> >   * @instruction_pointer: at the time of the system call.
> >   * @args: up to 6 system call arguments always stored as 64-bit values
> >   *        regardless of the architecture.
> > + * @pkeys: value of an architecture specific protection keys register
> > + *         (currently PKRU on x86)
> >   */
> >  struct seccomp_data {
> >         int nr;
> >         __u32 arch;
> >         __u64 instruction_pointer;
> >         __u64 args[6];
> > +       __u64 pkeys;
> >  };
> >
> >  #endif /* _UAPI_LINUX_SECCOMP_H */
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index fd023ac2..dfb8b0d6 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -91,6 +91,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
> >         sd->args[4] = args[4];
> >         sd->args[5] = args[5];
> >         sd->instruction_pointer = KSTK_EIP(task);
> > +       sd->pkeys = 0;
> >  }
> >
> >  /**
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index e1473234..f7f8fa6f 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -82,6 +82,7 @@ struct seccomp_data {
> >         __u32 arch;
> >         __u64 instruction_pointer;
> >         __u64 args[6];
> > +       __u64 pkeys;
> >  };
> >  #endif
> >
> > @@ -732,7 +733,9 @@ TEST(KILL_process)
> >  TEST(arg_out_of_range)
> >  {
> >         struct sock_filter filter[] = {
> > -               BPF_STMT(BPF_LD|BPF_W|BPF_ABS, syscall_arg(6)),
> > +               BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > +                       offsetof(struct seccomp_data, pkeys)
> > +                               + sizeof(__u64)),
> >                 BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> >         };
> >         struct sock_fprog prog = {
> > @@ -2933,6 +2936,108 @@ skip:
> >         ASSERT_EQ(0, kill(pid, SIGKILL));
> >  }
> >
> > +#if defined(__i386__) || defined(__x86_64__)
> > +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> > +               unsigned int *ecx, unsigned int *edx)
> > +{
> > +       /* ecx is often an input as well as an output. */
> > +       asm volatile(
> > +               "cpuid;"
> > +               : "=a" (*eax),
> > +                 "=b" (*ebx),
> > +                 "=c" (*ecx),
> > +                 "=d" (*edx)
> > +               : "0" (*eax), "2" (*ecx));
> > +}
> > +
> > +/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
> > +#define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
> > +#define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
> > +
> > +static inline int cpu_has_pku(void)
> > +{
> > +       unsigned int eax;
> > +       unsigned int ebx;
> > +       unsigned int ecx;
> > +       unsigned int edx;
> > +
> > +       eax = 0x7;
> > +       ecx = 0x0;
> > +       __cpuid(&eax, &ebx, &ecx, &edx);
> > +
> > +       if (!(ecx & X86_FEATURE_PKU))
> > +               return 0;
> > +       if (!(ecx & X86_FEATURE_OSPKE))
> > +               return 0;
> > +       return 1;
> > +}
> > +
> > +static inline __u32 read_pkru(void)
> > +{
> > +       if (!cpu_has_pku())
> > +               return 0;
> > +
> > +       __u32 ecx = 0;
> > +       __u32 edx, pkru;
> > +
> > +       /*
> > +        * "rdpkru" instruction.  Places PKRU contents in to EAX,
> > +        * clears EDX and requires that ecx=0.
> > +        */
> > +       asm volatile(".byte 0x0f,0x01,0xee\n\t"
> > +                    : "=a" (pkru), "=d" (edx)
> > +                    : "c" (ecx));
> > +       return pkru;
> > +}
> > +
> > +static inline void write_pkru(__u32 pkru)
> > +{
> > +       if (!cpu_has_pku())
> > +               return;
> > +
> > +       __u32 ecx = 0, edx = 0;
> > +
> > +       /*
> > +        * "wrpkru" instruction.  Loads contents in EAX to PKRU,
> > +        * requires that ecx = edx = 0.
> > +        */
> > +       asm volatile(".byte 0x0f,0x01,0xef\n\t"
> > +                    : : "a" (pkru), "c"(ecx), "d"(edx));
> > +}
> > +
> > +#define TEST_PKRU 0x55555550
> > +
> > +TEST_SIGNAL(pkeys_set, SIGSYS)
> > +{
> > +       write_pkru(TEST_PKRU);
> > +       /* read back the written value because pkru might not be supported */
> > +       __u32 pkru = read_pkru();
> > +
> > +       struct sock_filter filter[] = {
> > +               BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > +                       offsetof(struct seccomp_data, pkeys)),
> > +               BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, pkru, 1, 0),
> > +               BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> > +               BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> > +       };
> > +       struct sock_fprog prog = {
> > +               .len = (unsigned short)ARRAY_SIZE(filter),
> > +               .filter = filter,
> > +       };
> > +       long ret;
> > +
> > +       ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > +       ASSERT_EQ(0, ret);
> > +
> > +       ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
> > +       ASSERT_EQ(0, ret);
> > +
> > +       /* should never return. */
> > +       EXPECT_EQ(0, syscall(__NR_getpid));
> > +}
> > +#endif
> > +
> > +
> >  /*
> >   * TODO:
> >   * - add microbenchmarks
> > --
> > 2.11.0
> 
> 
> 
> -- 
> Kees Cook

-- 
Ram Pai

