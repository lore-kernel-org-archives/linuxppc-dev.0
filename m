Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C9C2B7D08
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 02:17:01 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2BFCfLt004258
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:12:41 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2BFGu3j107434
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:16:56 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2BFGts0023919
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 12:16:56 -0300
Message-ID: <4B990966.3060607@austin.ibm.com>
Date: Thu, 11 Mar 2010 09:16:54 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/6] arch/powerpc/platforms/pseries: Use kasprintf
References: <Pine.LNX.4.64.1003102214430.1672@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003102214430.1672@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> kasprintf combines kmalloc and sprintf, and takes care of the size
> calculation itself.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression a,flag;
> expression list args;
> statement S;
> @@
> 
>   a =
> -  \(kmalloc\|kzalloc\)(...,flag)
> +  kasprintf(flag,args)
>   <... when != a
>   if (a == NULL || ...) S
>   ...>
> - sprintf(a,args);
> // </smpl>
> 

Looks good, thanks.

> Signed-off-by: Julia Lawall <julia@diku.dk>
Acked-by: Nathan Fontenot <nfont@austin.ibm.com>

> 
> ---
>  arch/powerpc/platforms/pseries/dlpar.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff -u -p a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -78,13 +78,12 @@ static struct device_node *dlpar_parse_c
>  	 * prepend this to the full_name.
>  	 */
>  	name = (char *)ccwa + ccwa->name_offset;
> -	dn->full_name = kmalloc(strlen(name) + 2, GFP_KERNEL);
> +	dn->full_name = kasprintf(GFP_KERNEL, "/%s", name);
>  	if (!dn->full_name) {
>  		kfree(dn);
>  		return NULL;
>  	}
>  
> -	sprintf(dn->full_name, "/%s", name);
>  	return dn;
>  }
>  
> @@ -409,15 +408,13 @@ static ssize_t dlpar_cpu_probe(const cha
>  	 * directory of the device tree.  CPUs actually live in the
>  	 * cpus directory so we need to fixup the full_name.
>  	 */
> -	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus") + 1,
> -			   GFP_KERNEL);
> +	cpu_name = kasprintf(GFP_KERNEL, "/cpus%s", dn->full_name);
>  	if (!cpu_name) {
>  		dlpar_free_cc_nodes(dn);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
>  
> -	sprintf(cpu_name, "/cpus%s", dn->full_name);
>  	kfree(dn->full_name);
>  	dn->full_name = cpu_name;
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
