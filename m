Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AD59DDED0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:09:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA3K8avJ026887
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:08:36 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA3K95PT079162
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:09:05 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA3K94ZP019177
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:09:04 -0700
Date: Mon, 3 Nov 2008 15:09:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] powerpc/44x: declare tlb_44x_index for use in C code
Message-ID: <20081103150900.121e7086@zod.rchland.ibm.com>
In-Reply-To: <59bd162a744af080479f.1225479792@localhost.localdomain>
References: <59bd162a744af080479f.1225479792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Oct 2008 14:03:12 -0500
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> # HG changeset patch
> # User Hollis Blanchard <hollisb@us.ibm.com>
> # Date 1225479768 18000
> # Node ID 59bd162a744af080479fedffa97d01e26dceee6a
> # Parent  635f3f74befc230d93f79dc3198c509394247ee8
> powerpc/44x: declare tlb_44x_index for use in C code
> 
> KVM currently ignores the host's round robin TLB eviction selection, instead
> maintaining its own TLB state and its own round robin index. However, by
> participating in the normal 44x TLB selection, we can drop the alternate TLB
> processing in KVM. This results in a significant performance improvement,
> since that processing currently must be done on *every* guest exit.
> 
> Accordingly, KVM needs to be able to access and increment tlb_44x_index.
> (KVM on 440 cannot be a module, so there is no need to export this symbol.)
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

> 
> ---
> 
> Josh, can I get your ack? I'll submit through the KVM tree as usual.
> 
> diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
> --- a/arch/powerpc/include/asm/mmu-44x.h
> +++ b/arch/powerpc/include/asm/mmu-44x.h
> @@ -54,6 +54,7 @@
>  #ifndef __ASSEMBLY__
> 
>  extern unsigned int tlb_44x_hwater;
> +extern unsigned int tlb_44x_index;
> 
>  typedef struct {
>  	unsigned long id;
