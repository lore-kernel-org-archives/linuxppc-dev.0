Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C98B1A06DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 05:55:58 +1100 (AEDT)
Received: by wgra20 with SMTP id a20so74579139wgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 11:55:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 26 Mar 2015 19:55:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150326185550.GA25547@gmail.com>
References: <20150326141730.GA23060@gmail.com>
 <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
 <7fdae652993cf88bdd633d65e5a8f81c7ad8a1e3.1427390952.git.ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7fdae652993cf88bdd633d65e5a8f81c7ad8a1e3.1427390952.git.ldufour@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> +{
> +	unsigned long vdso_end, vdso_start;
> +
> +	if (!mm->context.vdso_base)
> +		return;
> +	vdso_start = mm->context.vdso_base;
> +
> +#ifdef CONFIG_PPC64
> +	/* Calling is_32bit_task() implies that we are dealing with the
> +	 * current process memory. If there is a call path where mm is not
> +	 * owned by the current task, then we'll have need to store the
> +	 * vDSO size in the mm->context.
> +	 */
> +	BUG_ON(current->mm != mm);
> +	if (is_32bit_task())
> +		vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
> +	else
> +		vdso_end = vdso_start + (vdso64_pages << PAGE_SHIFT);
> +#else
> +	vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
> +#endif
> +	vdso_end += (1<<PAGE_SHIFT); /* data page */
> +
> +	/* Check if the vDSO is in the range of the remapped area */
> +	if ((vdso_start <= old_start && old_start < vdso_end) ||
> +	    (vdso_start < old_end && old_end <= vdso_end)  ||
> +	    (old_start <= vdso_start && vdso_start < old_end)) {
> +		/* Update vdso_base if the vDSO is entirely moved. */
> +		if (old_start == vdso_start && old_end == vdso_end &&
> +		    (old_end - old_start) == (new_end - new_start))
> +			mm->context.vdso_base = new_start;
> +		else
> +			mm->context.vdso_base = 0;
> +	}
> +}

Oh my, that really looks awfully complex, as you predicted, and right 
in every mremap() call.

I'm fine with your original, imperfect, KISS approach. Sorry about 
this detour ...

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
