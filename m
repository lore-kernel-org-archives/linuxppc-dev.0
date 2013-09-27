Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 357302C0342
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Sep 2013 00:16:59 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 19:46:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 79FE61258055
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Sep 2013 19:47:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8REJCZv31850520
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Sep 2013 19:49:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8REGq7Y018479
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Sep 2013 19:46:53 +0530
Message-ID: <52459311.4010104@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 19:45:45 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, herbert@gondor.apana.org.au, gleb@redhat.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org, mpm@selenic.com,
 pbonzini@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2013 12:01 PM, Michael Ellerman wrote:
> +int powernv_hwrng_present(void)
> +{
> +	return __raw_get_cpu_var(powernv_rng) != NULL;
> +}
> +
>  static unsigned long rng_whiten(struct powernv_rng *rng, unsigned long val)
>  {
>  	unsigned long parity;
> @@ -42,6 +48,17 @@ static unsigned long rng_whiten(struct powernv_rng *rng, unsigned long val)
>  	return val;
>  }
> 
> +int powernv_get_random_real_mode(unsigned long *v)
> +{
> +	struct powernv_rng *rng;
> +
> +	rng = __raw_get_cpu_var(powernv_rng);
> +
> +	*v = rng_whiten(rng, in_rm64(rng->regs_real));
> +

Will it be in_be64() instead of in_rm64() ? Its failing the build here. Except this
all individual patches build correctly.

Regards
Anshuman
