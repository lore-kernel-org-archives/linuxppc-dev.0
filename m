Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D6966804D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 15:35:46 +1000 (EST)
Date: Thu, 11 Aug 2005 02:30:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050811053032.GF5665@dmt.cnet>
References: <42FA3636.7010804@ru.mvista.com> <42FA3D7B.8040200@ru.mvista.com>
	<42FA4108.9090808@ru.mvista.com>
	<4BA092C9-1517-416E-9C98-90F9D8F41857@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BA092C9-1517-416E-9C98-90F9D8F41857@freescale.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
	final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2005 at 02:16:57PM -0500, Kumar Gala wrote:
> +static int __init find_chip_by_name_and_id(char *name, u32 id)
> +{
> +    int ret = -1;
> +    unsigned int i = 0;
> +    unsigned int j = 0;
> +    unsigned int dups = 0;
> +
> +    unsigned int matched[count_sys_specs()];
> 
> Is is legit in the kernel to use dynamically sized array?

kmalloc() is certainly safer - why not use it? 

> +
> +    while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {
> +        if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
> +            matched[j++] = i;
> +        i++;
> +    }
> +    if (j != 0) {
> +        for (i = 0; i < j; i++) {
> +            if ((ppc_sys_specs[matched[i]].mask & id) ==
> +                ppc_sys_specs[matched[i]].value) {
> +                ret = matched[i];
> +                dups++;
> +            }
> +        }
> +        ret = (dups == 1) ? ret : (-1 * dups);
> +    }
> +    return ret;
> +}
> 
> On Aug 10, 2005, at 1:01 PM, Vitaly Bordug wrote:
> 
> >Finally correct indentation style.
> >
> >Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> >> >-- 
> >Sincerely,
> >Vitaly
> >
> ><ppc_sys_add.patch>
> ><ATT87954.txt>
> >
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
