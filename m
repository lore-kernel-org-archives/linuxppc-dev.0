Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rMzv3dVYzDrbS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 16:29:15 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id w19-v6so12380426plq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 23:29:15 -0700 (PDT)
Date: Wed, 23 May 2018 16:29:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 2/3] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523162901.791deea9@roar.ozlabs.ibm.com>
In-Reply-To: <cb0eaf6d-80ab-b503-d797-cadcd60d4c17@c-s.fr>
References: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
 <d37d9ce7b925bc254082cd664e37a062131d04b8.1526995927.git.christophe.leroy@c-s.fr>
 <20180523003801.43070ddc@roar.ozlabs.ibm.com>
 <cb0eaf6d-80ab-b503-d797-cadcd60d4c17@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 May 2018 16:50:55 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 22/05/2018 =C3=A0 16:38, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Tue, 22 May 2018 16:02:56 +0200 (CEST)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
> >> userspace instruction miss") has shown that limiting the read of
> >> faulting instruction to likely cases improves performance.
> >>
> >> This patch goes further into this direction by limiting the read
> >> of the faulting instruction to the only cases where it is likely
> >> needed.
> >>
> >> On an MPC885, with the same benchmark app as in the commit referred
> >> above, we see a reduction of about 3900 dTLB misses (approx 3%):
> >>
> >> Before the patch:
> >>   Performance counter stats for './fault 500' (10 runs):
> >>
> >>           683033312      cpu-cycles                                   =
                 ( +-  0.03% )
> >>              134538      dTLB-load-misses                             =
                 ( +-  0.03% )
> >>               46099      iTLB-load-misses                             =
                 ( +-  0.02% )
> >>               19681      faults                                       =
                 ( +-  0.02% )
> >>
> >>         5.389747878 seconds time elapsed                              =
            ( +-  0.06% )
> >>
> >> With the patch:
> >>
> >>   Performance counter stats for './fault 500' (10 runs):
> >>
> >>           682112862      cpu-cycles                                   =
                 ( +-  0.03% )
> >>              130619      dTLB-load-misses                             =
                 ( +-  0.03% )
> >>               46073      iTLB-load-misses                             =
                 ( +-  0.05% )
> >>               19681      faults                                       =
                 ( +-  0.01% )
> >>
> >>         5.381342641 seconds time elapsed                              =
            ( +-  0.07% )
> >>
> >> The proper work of the huge stack expansion was tested with the
> >> following app:
> >>
> >> int main(int argc, char **argv)
> >> {
> >> 	char buf[1024 * 1025];
> >>
> >> 	sprintf(buf, "Hello world !\n");
> >> 	printf(buf);
> >>
> >> 	exit(0);
> >> }
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   v7: Following comment from Nicholas on v6 on possibility of the page=
 getting removed from the pagetables
> >>       between the fault and the read, I have reworked the patch in ord=
er to do the get_user() in
> >>       __do_page_fault() directly in order to reduce complexity compare=
d to version v5 =20
> >=20
> > This is looking better, thanks.
> >  =20
> >> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> >> index fcbb34431da2..dc64b8e06477 100644
> >> --- a/arch/powerpc/mm/fault.c
> >> +++ b/arch/powerpc/mm/fault.c
> >> @@ -450,9 +450,6 @@ static int __do_page_fault(struct pt_regs *regs, u=
nsigned long address,
> >>   	 * can result in fault, which will cause a deadlock when called with
> >>   	 * mmap_sem held
> >>   	 */
> >> -	if (is_write && is_user)
> >> -		get_user(inst, (unsigned int __user *)regs->nip);
> >> -
> >>   	if (is_user)
> >>   		flags |=3D FAULT_FLAG_USER;
> >>   	if (is_write)
> >> @@ -498,6 +495,26 @@ static int __do_page_fault(struct pt_regs *regs, =
unsigned long address,
> >>   	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
> >>   		return bad_area(regs, address);
> >>  =20
> >> +	if (unlikely(is_write && is_user && address + 0x100000 < vma->vm_end=
 &&
> >> +		     !inst)) {
> >> +		unsigned int __user *nip =3D (unsigned int __user *)regs->nip;
> >> +
> >> +		if (likely(access_ok(VERIFY_READ, nip, sizeof(inst)))) {
> >> +			int res;
> >> +
> >> +			pagefault_disable();
> >> +			res =3D __get_user_inatomic(inst, nip);
> >> +			pagefault_enable();
> >> +			if (unlikely(res)) {
> >> +				up_read(&mm->mmap_sem);
> >> +				res =3D __get_user(inst, nip);
> >> +				if (!res && inst)
> >> +					goto retry; =20
> >=20
> > You're handling error here but the previous code did not? =20
>=20
> The previous code did in store_updates_sp()
>=20
> When I moved get_user() out of that function in preceeding patch, I did=20
> consider that if get_user() fails, inst will remain 0, which means that=20
> store_updates_sp() will return false if ever called.

Well it handles it just by saying no the store does not update SP.
Yours now segfaults it, doesn't it?

I don't think that's a bad idea, I think it should go in a patch by
itself though. In theory we can have execute but not read, I guess
that's not really going to work here either way and I don't know if
Linux exposes it ever.

>=20
> Now, as the semaphore has been released, we really need to do something,=
=20
> because if we goto retry inconditionally, we may end up in an infinite=20
> loop, and we can't let it continue either as the semaphore is not held=20
> anymore.
>
> >  =20
> >> +				return bad_area_nosemaphore(regs, address);
> >> +			}
> >> +		}
> >> +	} =20
> >=20
> > Would it be nicer to move all this up into bad_stack_expansion().
> > It would need a way to handle the retry and insn, but I think it
> > would still look better. =20
>=20
> That's what I did in v5 indeed, but it looked too complex to me at the=20
> end. Can you have a look at it=20
> (https://patchwork.ozlabs.org/patch/799053/) and tell me if you feel it=20
> better than v7, or if you have any suggestion to improve based on v5=20
> and/or v7 ?

Yeah I'm kind of liking that direction a bit more. I took your code
and hacked on it a bit more... Completely untested but I wonder what
you think?

We can put almost all the checking logic out of the main fault
path, and the retry stuff can fit into the unlikely failure
path. Also we only get_user at the last minute.

It does use fault_in_pages_readable which in theory means you might
repeat the loop if the page gets faulted out between retry, but that
same pattern exists in places in the filesystem code. Basically it
would be edge case trashing and if it persists then the system is
already finished. So I think it's okay. Just makes the retry loop a
bit simpler.

Any thoughts?

Thanks,
Nick


diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..f0d36ec949b3 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -69,12 +69,8 @@ static inline bool notify_page_fault(struct pt_regs *reg=
s)
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
  */
-static bool store_updates_sp(struct pt_regs *regs)
+static bool store_updates_sp(unsigned int inst)
 {
-	unsigned int inst;
-
-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return false;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) !=3D 1)
 		return false;
@@ -233,10 +229,23 @@ static bool bad_kernel_fault(bool is_exec, unsigned l=
ong error_code,
 	return is_exec || (address >=3D TASK_SIZE);
 }
=20
-static bool bad_stack_expansion(struct pt_regs *regs, unsigned long addres=
s,
+static bool bad_stack_expand(struct pt_regs *regs, unsigned long address,
 				struct vm_area_struct *vma,
-				bool store_update_sp)
+				bool *retry)
 {
+	unsigned int __user *nip =3D (unsigned int __user *)regs->nip;
+	struct pt_regs *uregs =3D current->thread.regs;
+	unsigned int inst;
+	int res;
+
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held
+	 */
+	if (is_write && is_user)
+		store_update_sp =3D store_updates_sp(regs);
+
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
 	 * 288 bytes below the stack pointer.
@@ -246,26 +255,46 @@ static bool bad_stack_expansion(struct pt_regs *regs,=
 unsigned long address,
 	 * before setting the user r1.  Thus we allow the stack to
 	 * expand to 1MB without further checks.
 	 */
-	if (address + 0x100000 < vma->vm_end) {
-		/* get user regs even if this fault is in kernel mode */
-		struct pt_regs *uregs =3D current->thread.regs;
-		if (uregs =3D=3D NULL)
-			return true;
+	if (address + 0x100000 >=3D vma->vm_end)
+		return false;
=20
-		/*
-		 * A user-mode access to an address a long way below
-		 * the stack pointer is only valid if the instruction
-		 * is one which would update the stack pointer to the
-		 * address accessed if the instruction completed,
-		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
-		 * (or the byte, halfword, float or double forms).
-		 *
-		 * If we don't check this then any write to the area
-		 * between the last mapped region and the stack will
-		 * expand the stack rather than segfaulting.
-		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
-			return true;
+	/* get user regs even if this fault is in kernel mode */
+	if (unlikely(uregs =3D=3D NULL)) {
+		*must_retry =3D false;
+		return true;
+	}
+
+	/*
+	 * A user-mode access to an address a long way below
+	 * the stack pointer is only valid if the instruction
+	 * is one which would update the stack pointer to the
+	 * address accessed if the instruction completed,
+	 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
+	 * (or the byte, halfword, float or double forms).
+	 *
+	 * If we don't check this then any write to the area
+	 * between the last mapped region and the stack will
+	 * expand the stack rather than segfaulting.
+	 */
+	if (address + 2048 >=3D uregs->gpr[1])
+		return false;
+
+	if (unlikely(!access_ok(VERIFY_READ, nip, sizeof(inst)))) {
+		*must_retry =3D true;
+		return true;
+	}
+
+	pagefault_disable();
+	res =3D __get_user_inatomic(inst, nip);
+	pagefault_enable();
+	if (unlikely(res)) {
+		*must_retry =3D true;
+		return true;
+	}
+
+	if (!store_updates_sp(inst)) {
+		*must_retry =3D true;
+		return true;
 	}
 	return false;
 }
@@ -403,7 +432,7 @@ static int __do_page_fault(struct pt_regs *regs, unsign=
ed long address,
 	int is_user =3D user_mode(regs);
 	int is_write =3D page_fault_is_write(error_code);
 	int fault, major =3D 0;
-	bool store_update_sp =3D false;
+	bool must_retry;
=20
 	if (notify_page_fault(regs))
 		return 0;
@@ -449,14 +478,6 @@ static int __do_page_fault(struct pt_regs *regs, unsig=
ned long address,
 		return bad_key_fault_exception(regs, address,
 					       get_mm_addr_key(mm, address));
=20
-	/*
-	 * We want to do this outside mmap_sem, because reading code around nip
-	 * can result in fault, which will cause a deadlock when called with
-	 * mmap_sem held
-	 */
-	if (is_write && is_user)
-		store_update_sp =3D store_updates_sp(regs);
-
 	if (is_user)
 		flags |=3D FAULT_FLAG_USER;
 	if (is_write)
@@ -503,8 +524,17 @@ static int __do_page_fault(struct pt_regs *regs, unsig=
ned long address,
 		return bad_area(regs, address);
=20
 	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
+	if (unlikely(bad_stack_expand(regs, address, vma, &must_retry))) {
+		if (must_retry) {
+			up_read(&mm->mmap_sem);
+			if (fault_in_pages_readable(address, sizeof(unsigned int)))
+				return bad_area_nosemaphore(regs, address);
+			goto retry;
+		}
+
 		return bad_area(regs, address);
+	}
+
=20
 	/* Try to expand it */
 	if (unlikely(expand_stack(vma, address)))
