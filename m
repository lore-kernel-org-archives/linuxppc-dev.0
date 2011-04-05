Return-Path: <walken@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10211100A27
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:43:00 +1000 (EST)
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com
	[172.25.149.6]) by smtp-out.google.com with ESMTP id p356gtmo010521
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Apr 2011 23:42:55 -0700
Received: from qyj19 (qyj19.prod.google.com [10.241.83.83])
	by hpaq6.eem.corp.google.com with ESMTP id p356gSRf025298
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Apr 2011 23:42:54 -0700
Received: by qyj19 with SMTP id 19so1415959qyj.9
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Apr 2011 23:42:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c4f5166f98cb703742191eb74f583bb8011f9cdf.1301984663.git.michael@ellerman.id.au>
References: <c4f5166f98cb703742191eb74f583bb8011f9cdf.1301984663.git.michael@ellerman.id.au>
Date: Mon, 4 Apr 2011 23:42:54 -0700
Message-ID: <BANLkTi=RJ2GHvHQ3mZiQ-L-MTVUQH-V-eA@mail.gmail.com>
Subject: Re: [PATCH] mm: Check we have the right vma in access_process_vm()
From: Michel Lespinasse <walken@google.com>
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: aarcange@redhat.com, Andrew Morton <akpm@osdl.org>, riel@redhat.com,
	linuxppc-dev@ozlabs.org, hughd@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 4, 2011 at 11:24 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> In access_process_vm() we need to check that we have found the right
> vma, not the following vma, before we try to access it. Otherwise
> we might call the vma's access routine with an address which does
> not fall inside the vma.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Please note that the code has moved into __access_remote_vm() in
current linus tree. Also, should len be truncated before calling
vma->vm_ops->access() so that we can guarantee it won't overflow past
the end of the vma ?

> diff --git a/mm/memory.c b/mm/memory.c
> index 5823698..7e6f17b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3619,7 +3619,7 @@ int access_process_vm(struct task_struct *tsk, unsi=
gned long addr, void *buf, in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0#ifdef CONFIG_HAVE_IOREMAP_PROT
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vma =3D find_vma(mm, addr)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vma || vma->vm_start >=
 addr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (vma->vm_ops && vma->vm=
_ops->access)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D vm=
a->vm_ops->access(vma, addr, buf,
> --
> 1.7.1

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
