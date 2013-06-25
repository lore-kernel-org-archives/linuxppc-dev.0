Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B97F92C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:00:50 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 14:23:43 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6989F394004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 14:30:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P90m1c25362528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 14:30:49 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P90UIe021756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:00:32 +1000
Message-ID: <51C95C0C.6000905@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 14:29:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/hw_brk: Fix clearing of extraneous IRQ
References: <1372052843-19109-1-git-send-email-mikey@neuling.org>
 <1372052843-19109-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1372052843-19109-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 11:17 AM, Michael Neuling wrote:
> In 9422de3 "powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint
> registers" we changed the way we mark extraneous irqs with this:
> 
> -	info->extraneous_interrupt = !((bp->attr.bp_addr <= dar) &&
> -			(dar - bp->attr.bp_addr < bp->attr.bp_len));
> +	if (!((bp->attr.bp_addr <= dar) &&
> +	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
> +		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
> 
> Unfortunately this is bogus as it never clears extraneous IRQ if it's already
> set.
> 
> This correctly clears extraneous IRQ before possibly setting it.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
