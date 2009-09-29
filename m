Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC5EFB7BFF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 06:39:08 +1000 (EST)
In-Reply-To: <20090929120006.78affe3f@lappy.seanm.ca>
References: <20090929120006.78affe3f@lappy.seanm.ca>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5F6DA96-29BC-49D3-A5C6-BBAEFFC7E885@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: warning: allocated section `.data_nosave' not in
	segment
Date: Tue, 29 Sep 2009 22:40:13 +0200
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> We need to align before the output section. Having the align inside
> the output section causes the linker to put some filler in there,
> which makes it a non-empty section, but this section isn't assigned to
> a segment so you get a warning from the linker.
>
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S
> b/arch/powerpc/kernel/vmlinux.lds.S index f564293..e853763 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -236,6 +236,7 @@ SECTIONS
>  		READ_MOSTLY_DATA(L1_CACHE_BYTES)
>  	}
>
> +  	. = ALIGN(PAGE_SIZE);
>  	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
>  		NOSAVE_DATA
>  	}

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

The patch is good and fixes a real problem.  But, I still don't see how
it caused the "warning: allocated section `.data_nosave' not in  
segment",
it would be good if we can find out.


Segher
