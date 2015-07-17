Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 611351A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 19:38:24 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7186A140774
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2015 19:38:22 +1000 (AEST)
Date: Fri, 17 Jul 2015 04:37:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 mpm@selenic.com, hpa@linux.intel.com, keescook@chromium.org
Subject: Re: [PATCH] powerpc: Use hardware RNG for arch_get_random_seed_* not
 arch_get_random_*
Message-ID: <20150717093757.GA15502@gate.crashing.org>
References: <20150717091558.GA5916@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717091558.GA5916@iris.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2015 at 07:15:58PM +1000, Paul Mackerras wrote:
> @@ -7,13 +7,22 @@
>  
>  static inline int arch_get_random_long(unsigned long *v)
>  {
> +	return 0;
> +}
> +
> +static inline int arch_get_random_int(unsigned int *v)
> +{
> +	return 0;
> +}
> +
> +static inline int arch_get_random_seed_long(unsigned long *v)
> +{
>  	if (ppc_md.get_random_long)
>  		return ppc_md.get_random_long(v);

You probably want to change that last name (ppc_md.get_random_long) then?
Pretty confusing like this :-)


Segher
