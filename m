Return-Path: <brking@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 228A4B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:38:19 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA8C5DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 00:38:18 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FEa4eq006307
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 08:36:04 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FEcBif179316
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 08:38:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FEcBEK032294
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 08:38:11 -0600
Message-ID: <4AAFA6D0.9060604@linux.vnet.ibm.com>
Date: Tue, 15 Sep 2009 09:38:08 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/5] move of_drconf_cell definition to prom.h
References: <4AAABC55.4070207@austin.ibm.com> <4AAABD37.2050205@austin.ibm.com>
In-Reply-To: <4AAABD37.2050205@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot wrote:
> Move the definition of the of_drconf_cell struct from numa.c to prom.h. 
> This
> is needed so that we can parse the ibm,dynamic-memory device-tree property
> when DLPAR adding and removing memory.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
> 
> Index: powerpc/arch/powerpc/include/asm/prom.h
> ===================================================================
> --- powerpc.orig/arch/powerpc/include/asm/prom.h    2009-09-11
> 12:43:39.000000000 -0500
> +++ powerpc/arch/powerpc/include/asm/prom.h    2009-09-11
> 12:52:11.000000000 -0500
> @@ -349,6 +349,18 @@
>  */
> extern void __iomem *of_iomap(struct device_node *device, int index);
> 
> +struct of_drconf_cell {
> +    u64    base_addr;
> +    u32    drc_index;
> +    u32    reserved;
> +    u32    aa_index;
> +    u32    flags;
> +};

Might as well fix this up to use a tab instead of spaces for the indentation
if you are moving it.

> +
> +#define DRCONF_MEM_ASSIGNED    0x00000008
> +#define DRCONF_MEM_AI_INVALID    0x00000040
> +#define DRCONF_MEM_RESERVED    0x00000080
> +
> /*
>  * NB:  This is here while we transition from using asm/prom.h
>  * to linux/of.h
> Index: powerpc/arch/powerpc/mm/numa.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/mm/numa.c    2009-09-11 12:43:39.000000000
> -0500
> +++ powerpc/arch/powerpc/mm/numa.c    2009-09-11 12:52:11.000000000 -0500
> @@ -296,18 +296,6 @@
>     return result;
> }
> 
> -struct of_drconf_cell {
> -    u64    base_addr;
> -    u32    drc_index;
> -    u32    reserved;
> -    u32    aa_index;
> -    u32    flags;
> -};
> -
> -#define DRCONF_MEM_ASSIGNED    0x00000008
> -#define DRCONF_MEM_AI_INVALID    0x00000040
> -#define DRCONF_MEM_RESERVED    0x00000080
> -
> /*
>  * Read the next lmb list entry from the ibm,dynamic-memory property
>  * and return the information in the provided of_drconf_cell structure.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
