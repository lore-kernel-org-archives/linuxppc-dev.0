Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0948467B60
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:00:14 +1000 (EST)
Date: Thu, 31 Aug 2006 11:59:43 +1000
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: IPSec kernel oops on ppc64
Message-ID: <20060831015942.GA27423@gondor.apana.org.au>
References: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
From: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jmorris@redhat.com, netdev@vger.kernel.org, anton@au1.ibm.com,
	linuxppc-dev@ozlabs.org, gcwilson@us.ibm.com, paulus@au1.ibm.com,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2006 at 11:36:26AM -0500, Joy Latten wrote:
> 
> I tried the patch on the following:
> linux-2.6.17 + patch-2.6.18-rc1
> 
> The good news is that the pings worked great!
> So perhaps ESP is working ok with ICMP.
> 
> But when I tried to do sftp, I still got the oops.
> I don't think TCP and ESP are working.

Interesting.  We were previously off by 28 bytes, now we're off by 8 :)

Could you please do a test by deleting the defines for
__HAVE_ARCH_MEMMOVE and __HAVE_ARCH_MEMCPY from include/asm-powerpc
to see if using the generic routines help?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
