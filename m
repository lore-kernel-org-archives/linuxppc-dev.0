Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F369FB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 00:41:46 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id o8KEfdVx020755
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 14:41:39 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o8KEfdTv3276898
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 15:41:39 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o8KEfdTP031708
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 15:41:39 +0100
Date: Mon, 20 Sep 2010 16:41:37 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH 1/2]: Powerpc: Fix EHCA driver on relocatable kernel
Message-ID: <20100920164137.2c86faef@alex-laptop>
In-Reply-To: <20100820040809.GS16505@us.ibm.com>
References: <20100820040809.GS16505@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rdma@vger.kernel.org, fenkes@de.ibm.com,
	linuxppc-dev@lists.ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Aug 2010 23:08:09 -0500
Sonny Rao <sonnyrao@us.ibm.com> wrote:

> Some modules (like eHCA) want to map all of kernel memory, for this to
> work with a relocated kernel, we need to export kernstart_addr so
> modules can use PHYSICAL_START and memstart_addr so they could use
> MEMORY_START.  Note that the 32bit code already exports these symbols.
> 
> Signed-off-By: Sonny Rao <sonnyrao@us.ibm.com>

Acked-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>

> Index: common/arch/powerpc/mm/init_64.c
> ===================================================================
> --- common.orig/arch/powerpc/mm/init_64.c	2010-08-16 02:38:33.000000000 -0500
> +++ common/arch/powerpc/mm/init_64.c	2010-08-16 02:39:25.000000000 -0500
> @@ -79,7 +79,9 @@
>  #endif /* CONFIG_PPC_STD_MMU_64 */
> 
>  phys_addr_t memstart_addr = ~0;
> +EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t kernstart_addr;
> +EXPORT_SYMBOL(kernstart_addr);
> 
>  void free_initmem(void)
>  {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
