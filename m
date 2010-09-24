Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id E07CEB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 17:10:11 +1000 (EST)
Received: by pzk5 with SMTP id 5so746829pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 00:10:09 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 24 Sep 2010 01:10:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
	Device Tree
Message-ID: <20100924071006.GA21318@angua.secretlab.ca>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100916070503.10046C7391@messagerie.si.c-s.fr>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 09:05:03AM +0200, christophe leroy wrote:
> This patch applies to 2.6.34.7 and 2.6.35.4
> It fixes an issue during the probe for CPM1 with definition of parameter ram from DTS
> 
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

I'm sorry, I don't understand the fix from the given description.
What is the problem, and why is cpm_muram_alloc_fixed() the wrong
thing to call on CPM1?  Does CPM2 still need it?

g.

> 
> diff -urN b/drivers/spi/spi_mpc8xxx.c c/drivers/spi/spi_mpc8xxx.c
> --- b/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:43:50.000000000 +0200
> +++ c/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:03.000000000 +0200
> @@ -822,7 +822,7 @@
>  	if (!iprop || size != sizeof(*iprop) * 4)
>  		return -ENOMEM;
>  
> -	spi_base_ofs = cpm_muram_alloc_fixed(iprop[2], 2);
> +	spi_base_ofs = iprop[2];
>  	if (IS_ERR_VALUE(spi_base_ofs))
>  		return -ENOMEM;
>  
> @@ -844,7 +844,6 @@
>  			return spi_base_ofs;
>  	}
>  
> -	cpm_muram_free(spi_base_ofs);
>  	return pram_ofs;
>  }
