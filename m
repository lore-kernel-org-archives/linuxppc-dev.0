Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 964192C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 18:49:01 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 14:11:58 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E5A471258051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 14:17:55 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P8nAKf10420380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 14:19:10 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P8mp47003458
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 18:48:51 +1000
Message-ID: <51C95950.2030304@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 14:18:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/hw_brk: Fix setting of length for exact mode
 breakpoints
References: <1372052843-19109-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1372052843-19109-1-git-send-email-mikey@neuling.org>
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
> The smallest match region for both the DABR and DAWR is 8 bytes, so the
> kernel needs to filter matches when users want to look at regions smaller than
> this.
> 
> Currently we set the length of PPC_BREAKPOINT_MODE_EXACT breakpoints to 8.
> This is wrong as in exact mode we should only match on 1 address, hence the
> length should be 1.
> 
> This ensures that the kernel will filter out any exact mode hardware breakpoint
> matches on any addresses other than the requested one.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
