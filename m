Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25ED3B7CF3
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 06:52:37 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2MJoSPk013774
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 06:50:28 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2MJqaqI1507442
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 06:52:36 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2MJqaDG009653
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 06:52:36 +1100
Date: Tue, 23 Mar 2010 01:22:23 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v2] powerpc: export data from new hcall H_EM_GET_PARMS
Message-ID: <20100322195223.GA22770@dirshya.in.ibm.com>
References: <20100310121925.GB15046@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100310121925.GB15046@dirshya.in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2010-03-10 17:49:25]:

> Hi Ben,
> 
> I have cleaned up the code from the previous post:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080630.html
> 
> Changes from v1:
> * Removed redundant return statements and rearranged code
> 
> Description:
> 
> A new hcall H_EM_GET_PARMS as been added to obtain power mode data
> from the platform.  This data can be used by user space administrative
> tools for better power management.
> 
> The following patch add data from this new hcall into the lparcfg
> driver and exports to user space along with other existing lpar data
> in /proc/powerpc/lparcfg
> 
> Please review and include in powerpc -next tree.

Hi Ben,

Looks like you have not opened the -next tree after the merge window
yet.  The current git tree status is same as -merge.  Please review
and include in powerpc next tree.  

Thanks,
Vaidy

> ---
> 	powerpc: export data from new hcall H_EM_GET_PARMS
> 
> 	Add support for H_EM_GET_PARMS hcall that will return data
> 	related to power modes from the platform.  Export the data
> 	directly to user space for administrative tools to interpret
> 	and use.
> 
> 	cat /proc/powerpc/lparcfg will export power mode data
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hvcall.h |    1 +
>  arch/powerpc/kernel/lparcfg.c     |   12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index f027581..ebe7493 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -228,6 +228,7 @@
>  #define H_JOIN			0x298
>  #define H_VASI_STATE            0x2A4
>  #define H_ENABLE_CRQ		0x2B0
> +#define H_GET_EM_PARMS		0x2B8
>  #define H_SET_MPP		0x2D0
>  #define H_GET_MPP		0x2D4
>  #define MAX_HCALL_OPCODE	H_GET_MPP
> diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
> index d09d1c6..ff698fb 100644
> --- a/arch/powerpc/kernel/lparcfg.c
> +++ b/arch/powerpc/kernel/lparcfg.c
> @@ -37,7 +37,7 @@
>  #include <asm/vio.h>
>  #include <asm/mmu.h>
> 
> -#define MODULE_VERS "1.8"
> +#define MODULE_VERS "1.9"
>  #define MODULE_NAME "lparcfg"
> 
>  /* #define LPARCFG_DEBUG */
> @@ -486,6 +486,14 @@ static void splpar_dispatch_data(struct seq_file *m)
>  	seq_printf(m, "dispatch_dispersions=%lu\n", dispatch_dispersions);
>  }
> 
> +static void parse_em_data(struct seq_file *m)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +
> +	if (plpar_hcall(H_GET_EM_PARMS, retbuf) == H_SUCCESS)
> +		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
> +}
> +
>  static int pseries_lparcfg_data(struct seq_file *m, void *v)
>  {
>  	int partition_potential_processors;
> @@ -540,6 +548,8 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
> 
>  	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
> 
> +	parse_em_data(m);
> +
>  	return 0;
>  }
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
