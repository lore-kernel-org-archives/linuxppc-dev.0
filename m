Return-Path: <ahuja@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D60ADDF28
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:39:08 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBGIc7Ow001427
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 13:38:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBGIctUT1982592
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 13:38:56 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBGIcnCa012409
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 11:38:52 -0700
Message-ID: <4947F5B8.4050500@austin.ibm.com>
Date: Tue, 16 Dec 2008 12:38:48 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Manish Ahuja <mahuja@us.ibm.com>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] [RFC] Pass a valid token to rats_call() in phyp-dump code.
References: <20081216043429.GC14890@ozlabs.org>
In-Reply-To: <20081216043429.GC14890@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes,

That is required. It is in the patches that I sent to Ben, Paul & Brad.

I just waiting to post it with other patches.

Acked-by: Manish Ahuja <mahujam@gmail.com>

Tony Breeds wrote:
> ibm_configure_kernel_dump, is passed as the token to rtas_call() but I
> cannot see where it is initialised.  Set it to something sane?
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/platforms/pseries/phyp_dump.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/phyp_dump.c b/arch/powerpc/platforms/pseries/phyp_dump.c
> index 16e659a..6cf35cd 100644
> --- a/arch/powerpc/platforms/pseries/phyp_dump.c
> +++ b/arch/powerpc/platforms/pseries/phyp_dump.c
> @@ -414,6 +414,8 @@ static int __init phyp_dump_setup(void)
>  		of_node_put(rtas);
>  	}
>  
> +	ibm_configure_kernel_dump = rtas_token("ibm,configure-kernel-dump");
> +
>  	print_dump_header(dump_header);
>  	dump_area_length = init_dump_header(&phdr);
>  	/* align down */


-- 

--
Manish Ahuja
Linux RAS Engineer.
IBM Linux Technology Center
mahuja@us.ibm.com
512-838-1928, t/l 678-1928.
