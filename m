Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4196x94fLSzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:39:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 2/6] powerpc/pkeys: Save the pkey registers before fork
In-Reply-To: <1528936144-6696-3-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-3-git-send-email-linuxram@us.ibm.com>
Date: Tue, 19 Jun 2018 22:39:56 +1000
Message-ID: <877emvx84j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> When a thread forks the contents of AMR, IAMR, UAMOR registers in the
> newly forked thread are not inherited.
>
> Save the registers before forking, for content of those
> registers to be automatically copied into the new thread.
>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Again this is an ABI change but we'll call it a bug fix I guess.

I'll add:

  Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
  Cc: stable@vger.kernel.org # v4.16+


cheers

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 9ef4aea..991d097 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -583,6 +583,7 @@ static void save_all(struct task_struct *tsk)
>  		__giveup_spe(tsk);
>  
>  	msr_check_and_clear(msr_all_available);
> +	thread_pkey_regs_save(&tsk->thread);
>  }
>  
>  void flush_all_to_thread(struct task_struct *tsk)
> -- 
> 1.7.1
