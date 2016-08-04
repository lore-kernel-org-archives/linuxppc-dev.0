Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4lRZ2bhxzDqSB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:45:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
In-Reply-To: <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
Date: Thu, 04 Aug 2016 19:45:28 +1000
Message-ID: <87h9b0g953.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
...
>  /**
>   * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
>   *
> @@ -212,12 +262,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  {
>  	unsigned long size;
>  
> +	/* sets fw_dump.reserve_bootvar */
> +	parse_fadump_reserve_mem();
> +
>  	/*
>  	 * Check if the size is specified through fadump_reserve_mem= cmdline
>  	 * option. If yes, then use that.
>  	 */
>  	if (fw_dump.reserve_bootvar)
>  		return fw_dump.reserve_bootvar;
> +	else
> +		printk(KERN_INFO "fadump: calculating default boot size\n");
>  
>  	/* divide by 20 to get 5% of value */
>  	size = memblock_end_of_DRAM() / 20;

The code already knows how to reserve 5% based on the size of the machine's
memory, as long as no commandline parameter is passed. So why can't we
just use that logic?

cheers
