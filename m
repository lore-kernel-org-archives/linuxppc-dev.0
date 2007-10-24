Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52069DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 09:33:28 +1000 (EST)
Date: Wed, 24 Oct 2007 16:33:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] taskstats scaled time cleanup
Message-Id: <20071024163305.14b9bfba.akpm@linux-foundation.org>
In-Reply-To: <8789.1193208897@neuling.org>
References: <8789.1193208897@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Oct 2007 16:54:57 +1000
Michael Neuling <mikey@neuling.org> wrote:

> +/* Estimate the scaled cputime by scaling the real cputime based on
> + * the last scaled to real ratio */
> +static inline cputime_t cputime_to_scaled(const cputime_t ct)
> +{
> +	if (cpu_has_feature(CPU_FTR_SPURR) &&
> +	    per_cpu(cputime_last_delta, smp_processor_id()))
> +		return ct *
> +			per_cpu(cputime_scaled_last_delta, smp_processor_id())/
> +			per_cpu(cputime_last_delta, smp_processor_id());
> +	return ct;
> +}

This looks far too large to be inlined.
