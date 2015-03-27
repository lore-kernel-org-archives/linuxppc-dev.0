Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DB971A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 22:02:24 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 11:02:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A6EE17D8068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 11:02:46 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2RB2IK44719088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 11:02:18 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2RB2Gj4007685
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 05:02:17 -0600
Message-ID: <551538B5.2030507@linux.vnet.ibm.com>
Date: Fri, 27 Mar 2015 12:02:13 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 2/2] powerpc/mm: Tracking vDSO remap
References: <20150326141730.GA23060@gmail.com>
 <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
 <7fdae652993cf88bdd633d65e5a8f81c7ad8a1e3.1427390952.git.ldufour@linux.vnet.ibm.com>
 <20150326185550.GA25547@gmail.com>
In-Reply-To: <20150326185550.GA25547@gmail.com>
Content-Type: text/plain; charset=windows-1252
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

On 26/03/2015 19:55, Ingo Molnar wrote:
> 
> * Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> +{
>> +	unsigned long vdso_end, vdso_start;
>> +
>> +	if (!mm->context.vdso_base)
>> +		return;
>> +	vdso_start = mm->context.vdso_base;
>> +
>> +#ifdef CONFIG_PPC64
>> +	/* Calling is_32bit_task() implies that we are dealing with the
>> +	 * current process memory. If there is a call path where mm is not
>> +	 * owned by the current task, then we'll have need to store the
>> +	 * vDSO size in the mm->context.
>> +	 */
>> +	BUG_ON(current->mm != mm);
>> +	if (is_32bit_task())
>> +		vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
>> +	else
>> +		vdso_end = vdso_start + (vdso64_pages << PAGE_SHIFT);
>> +#else
>> +	vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
>> +#endif
>> +	vdso_end += (1<<PAGE_SHIFT); /* data page */
>> +
>> +	/* Check if the vDSO is in the range of the remapped area */
>> +	if ((vdso_start <= old_start && old_start < vdso_end) ||
>> +	    (vdso_start < old_end && old_end <= vdso_end)  ||
>> +	    (old_start <= vdso_start && vdso_start < old_end)) {
>> +		/* Update vdso_base if the vDSO is entirely moved. */
>> +		if (old_start == vdso_start && old_end == vdso_end &&
>> +		    (old_end - old_start) == (new_end - new_start))
>> +			mm->context.vdso_base = new_start;
>> +		else
>> +			mm->context.vdso_base = 0;
>> +	}
>> +}
> 
> Oh my, that really looks awfully complex, as you predicted, and right 
> in every mremap() call.

I do agree, that's awfully complex ;)

> I'm fine with your original, imperfect, KISS approach. Sorry about 
> this detour ...
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

No problem, so let's stay on the v3 version of the patch.
Thanks for Reviewed-by statement which, I guess, applied to the v3 too.
Should I resend the v3 ?

Thanks,
Laurent.
