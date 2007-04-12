Return-Path: <mohan@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34EAADDF62
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 18:17:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3C8HObL003783
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:17:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3C8HNpi185102
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 02:17:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3C8HNOJ026513
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 02:17:23 -0600
Date: Thu, 12 Apr 2007 13:47:16 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH kexec-tools] ppc64: correct @ha relocation
Message-ID: <20070412081716.GE4281@in.ibm.com>
References: <boot-4-00.miltonm@bga.com> <boot-4-kexec-02.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-4-kexec-02.miltonm@bga.com>
Cc: Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@in.ibm.com>,
	fastboot@lists.osdl.org, linuxppc-dev@ozlabs.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2007 at 03:30:00AM -0500, Milton Miller wrote:
> 
> The @ha relocation is supposed to account for the @l relocation being
> a signed quantity by adding 1 if the msb of @l is set.
> 
> The trick of adding 0x8000 stolen from the linux kernel file
> arch/powerpc/kernel/module_64.c which credits binutils.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
>
Acked-by: Mohan Kumar M <mohan@in.ibm.com>


Cross checked with PPC64 ELF ABI also.
 
> --- 
> This relocation is used in v2wrap.S to hold and release the slave cpus.
> Without this fix the memory location may be 64k off the initialized variable
> which is checked against 0.
> 
> 
> --- kexec-tools-testing/kexec/arch/ppc64/kexec-elf-rel-ppc64.c.orig	2007-04-10 22:29:59.000000000 -0500
> +++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2007-04-10 22:29:59.000000000 -0500
> @@ -97,7 +97,7 @@ void machine_apply_elf_rel(struct mem_eh
>  		break;
> 
>  	case R_PPC64_ADDR16_HA:
> -		*(uint16_t *)location = ((value>>16)  & 0xffff);
> +		*(uint16_t *)location = (((value+0x8000)>>16)  & 0xffff);
>  		break;
> 
>  	case R_PPC64_ADDR16_HIGHEST:
