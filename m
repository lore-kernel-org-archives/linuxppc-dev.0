Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 792382C00A1
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2012 00:41:30 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Fri, 3 Aug 2012 10:41:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E650B6E8059
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2012 10:40:57 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q73Eeu41331964
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2012 10:40:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q73EeuV2017715
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2012 11:40:56 -0300
Message-ID: <501BE2F6.5080506@linux.vnet.ibm.com>
Date: Fri, 03 Aug 2012 09:40:54 -0500
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/crypto: Remove virt_to_abs() usage in nx-842.c
References: <1343960595-30232-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343960595-30232-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2012 09:23 PM, Michael Ellerman wrote:
> virt_to_abs() is just a wrapper around __pa(), use __pa() directly.
> 
> We should be including <asm/page.h> to get __pa(). abs_addr.h will be
> removed shortly so drop that.
> 
> We were getting of.h via abs_addr.h so we need to include that directly.
> 
> Having done all that, clean up the ordering of the includes.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  drivers/crypto/nx/nx-842.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)

Looks good here.  Thanks for doing this!

Acked-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
