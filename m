Return-Path: <xenidis@gmail.com>
Received: from mail-gx0-f171.google.com (mail-gx0-f171.google.com
	[209.85.161.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEE84B71CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 23:09:52 +1000 (EST)
Received: by gxk22 with SMTP id 22so3025805gxk.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 06:09:49 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH] powerpc: Fix deadlock in icswx code
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <20110915054315.5e5ae062@kryten>
Date: Thu, 15 Sep 2011 08:09:47 -0500
Message-Id: <743CC253-C7B7-473E-84A2-B9A2A956D4D3@pobox.com>
References: <20110915052313.7127520d@kryten> <20110915054315.5e5ae062@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 14, 2011, at 2:43 PM, Anton Blanchard wrote:


Hi Anton,
It would really help me a lot if you could review and maybe merge this =
with my earlier patch that splits this file.
  <http://patchwork.ozlabs.org/patch/109103/>
All it does is split.. I promise.
You don't have to take the other stuff.. yet :)

-JX


>=20
> The icswx code introduced an A-B B-A deadlock:
>=20
>     CPU0                    CPU1
>     ----                    ----
> lock(&anon_vma->mutex);
>                             lock(&mm->mmap_sem);
>                             lock(&anon_vma->mutex);
> lock(&mm->mmap_sem);
>=20
> Instead of using the mmap_sem to keep mm_users constant, take the
> page table spinlock.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: <stable@kernel.org>
> ---
>=20
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c =
b/arch/powerpc/mm/mmu_context_hash64.c
> index 3bafc3d..4ff587e 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -136,8 +136,8 @@ int use_cop(unsigned long acop, struct mm_struct =
*mm)
> 	if (!mm || !acop)
> 		return -EINVAL;
>=20
> -	/* We need to make sure mm_users doesn't change */
> -	down_read(&mm->mmap_sem);
> +	/* The page_table_lock ensures mm_users won't change under us */
> +	spin_lock(&mm->page_table_lock);
> 	spin_lock(mm->context.cop_lockp);
>=20
> 	if (mm->context.cop_pid =3D=3D COP_PID_NONE) {
> @@ -164,7 +164,7 @@ int use_cop(unsigned long acop, struct mm_struct =
*mm)
>=20
> out:
> 	spin_unlock(mm->context.cop_lockp);
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->page_table_lock);
>=20
> 	return ret;
> }
> @@ -185,8 +185,8 @@ void drop_cop(unsigned long acop, struct mm_struct =
*mm)
> 	if (WARN_ON_ONCE(!mm))
> 		return;
>=20
> -	/* We need to make sure mm_users doesn't change */
> -	down_read(&mm->mmap_sem);
> +	/* The page_table_lock ensures mm_users won't change under us */
> +	spin_lock(&mm->page_table_lock);
> 	spin_lock(mm->context.cop_lockp);
>=20
> 	mm->context.acop &=3D ~acop;
> @@ -213,7 +213,7 @@ void drop_cop(unsigned long acop, struct mm_struct =
*mm)
> 	}
>=20
> 	spin_unlock(mm->context.cop_lockp);
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->page_table_lock);
> }
> EXPORT_SYMBOL_GPL(drop_cop);
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
