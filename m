Return-Path: <amwang@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id F3B5AB6F92
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 21:13:57 +1100 (EST)
Message-ID: <4EBBA36E.7040705@redhat.com>
Date: Thu, 10 Nov 2011 18:11:58 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 06/10] fadump: Add PT_NOTE program header for
 vmcoreinfo
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
 <20111107095603.1997.39898.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095603.1997.39898.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2011年11月07日 17:56, Mahesh J Salgaonkar 写道:
> From: Mahesh Salgaonkar<mahesh@linux.vnet.ibm.com>
>
> Introduce a PT_NOTE program header that points to physical address of
> vmcoreinfo_note buffer declared in kernel/kexec.c. The vmcoreinfo
> note buffer is populated during crash_fadump() at the time of system
> crash.
>
> Signed-off-by: Mahesh Salgaonkar<mahesh@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/fadump.c |   29 +++++++++++++++++++++++++++++
>   1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 70d6287..e68ee3a 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -816,6 +816,19 @@ static void setup_crash_memory_ranges(void)
>   	}
>   }
>
> +/*
> + * If the given physical address falls within the boot memory region then
> + * return the relocated address that points to the dump region reserved
> + * for saving initial boot memory contents.
> + */
> +static inline unsigned long relocate(unsigned long paddr)
> +{
> +	if (paddr>  RMR_START&&  paddr<  fw_dump.boot_memory_size)
> +		return fdm.rmr_region.destination_address + paddr;
> +	else
> +		return paddr;
> +}

Although they are static functions, it is still better to name them
with "fadump_" prefix...

Thanks.
