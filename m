Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17844.35747.788753.2804@cargo.ozlabs.ibm.com>
Date: Mon, 22 Jan 2007 21:02:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 2/5] [POWERPC] cpm_uart: OF-related fix for arch/powerpc
In-Reply-To: <20070113004207.1224.82053.stgit@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<20070113004207.1224.82053.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

>  		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
> +#ifdef CONFIG_PPC_MERGE
> +		dma_addr = (u32)cpm_dpram_phys(mem_addr);
> +#else
>  		dma_addr = (u32)mem_addr;
> +#endif

Please define a cpm_dpram_phys() function in include/asm-ppc/fs_pd.h
rather than having ifdefs in code.  And please also try to avoid
unnecessary casts.

Actually, I notice that cpm_dpram_phys doesn't currently appear
anywhere in the kernel tree, and your patch sequence doesn't create
it.  So how come this change won't cause a compile error?

Paul.
