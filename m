Return-Path: <consul.kautuk@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C68A0B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 02:59:42 +1100 (EST)
Received: by yenl1 with SMTP id l1so203863yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 08:59:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332252722-3794-1-git-send-email-consul.kautuk@gmail.com>
References: <1332252722-3794-1-git-send-email-consul.kautuk@gmail.com>
Date: Tue, 20 Mar 2012 11:59:39 -0400
Message-ID: <CAFPAmTSYNE4gVu_qJVngBjqcvb=CH04jrvdKnAR-oaiPk-rdDA@mail.gmail.com>
Subject: Re: [PATCH 04/20 v2] powerpc/mm/fault.c: Port OOM changes to
 do_page_fault
From: Kautuk Consul <consul.kautuk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Jimi Xenidis <jimix@pobox.com>, Ingo Molnar <mingo@elte.hu>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Mohd. Faris" <mohdfarisq2010@gmail.com>,
 Kautuk Consul <consul.kautuk@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
Sorry I found one more defect in this patch below.

Im gonna send a v3 for this patch.

On Tue, Mar 20, 2012 at 10:12 AM, Kautuk Consul <consul.kautuk@gmail.com> w=
rote:
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
>
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> Port these changes to powerpc.
>
> Signed-off-by: Mohd. Faris <mohdfarisq2010@gmail.com>
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
> ---
> =A0arch/powerpc/mm/fault.c | =A0 51 +++++++++++++++++++++++++++++++++----=
---------
> =A01 files changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 2f0d1b0..a3b1176 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -129,6 +129,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, uns=
igned long address,
> =A0 =A0 =A0 =A0int is_write =3D 0, ret;
> =A0 =A0 =A0 =A0int trap =3D TRAP(regs);
> =A0 =A0 =A0 =A0int is_exec =3D trap =3D=3D 0x400;
> + =A0 =A0 =A0 unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_=
KILLABLE;
>
> =A0#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> =A0 =A0 =A0 =A0/*
> @@ -212,6 +213,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, uns=
igned long address,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!user_mode(regs) && !search_exception_=
tables(regs->nip))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bad_area_nosemaphore;
>
> +retry:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down_read(&mm->mmap_sem);
> =A0 =A0 =A0 =A0}
>
> @@ -313,6 +315,7 @@ good_area:
> =A0 =A0 =A0 =A0} else if (is_write) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(vma->vm_flags & VM_WRITE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bad_area;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D FAULT_FLAG_WRITE;
> =A0 =A0 =A0 =A0/* a read */
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* protection fault */
> @@ -327,7 +330,11 @@ good_area:
> =A0 =A0 =A0 =A0 * make sure we exit gracefully rather than endlessly redo
> =A0 =A0 =A0 =A0 * the fault.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 ret =3D handle_mm_fault(mm, vma, address, is_write ? FAULT_=
FLAG_WRITE : 0);
> + =A0 =A0 =A0 ret =3D handle_mm_fault(mm, vma, address, flags);
> +
> + =A0 =A0 =A0 if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(curren=
t))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

Incorrect!
This should return 0 or 1.

> +
> =A0 =A0 =A0 =A0if (unlikely(ret & VM_FAULT_ERROR)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret & VM_FAULT_OOM)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_of_memory;
> @@ -335,22 +342,36 @@ good_area:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto do_sigbus;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (ret & VM_FAULT_MAJOR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->maj_flt++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ=
, 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
regs, address);
> -#ifdef CONFIG_PPC_SMLPAR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (firmware_has_feature(FW_FEATURE_CMO)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_disable();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_lppaca()->page_ins +=3D=
 (1 << PAGE_FACTOR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_enable();
> + =A0 =A0 =A0 if (flags & FAULT_FLAG_ALLOW_RETRY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret & VM_FAULT_MAJOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->maj_flt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW=
_PAGE_FAULTS_MAJ, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0regs, address);
> +#ifdef CONFIG_PPC_SMLPAR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (firmware_has_feature(FW=
_FEATURE_CMO)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_dis=
able();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_lppaca(=
)->page_ins +=3D (1 << PAGE_FACTOR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_ena=
ble();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->min_flt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW=
_PAGE_FAULTS_MIN, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0regs, address);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fault & VM_FAULT_RETRY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags &=3D ~FAULT_FLAG_ALLO=
W_RETRY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* No need to up_read(&mm=
->mmap_sem) as we would
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* have already released =
it in __lock_page_or_retry
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in mm/filemap.c.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -#endif
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->min_flt++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN=
, 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
regs, address);
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0up_read(&mm->mmap_sem);
> =A0 =A0 =A0 =A0return 0;
>
> --
> 1.7.5.4
>
