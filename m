Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F33B9B71B8
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 08:24:04 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 2 Feb 2012 21:16:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q12LJ3uB2928804
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Feb 2012 08:19:03 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q12LNsTc029533
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Feb 2012 08:23:55 +1100
Message-ID: <1328217833.5776.7.camel@pasglop>
Subject: Re: [PATCH] Implement GET_IP/SET_IP for powerpc architecture.
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 03 Feb 2012 08:23:53 +1100
In-Reply-To: <201202021128.49188.vapier@gentoo.org>
References: <20120202144125.GA6221@linux.vnet.ibm.com>
 <201202021128.49188.vapier@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-02 at 11:28 -0500, Mike Frysinger wrote:
> On Thursday 02 February 2012 09:41:25 Srikar Dronamraju wrote:
> > +#define GET_FP(regs)		(0)
> > +#define SET_FP(regs, val)
> 
> ppc doesn't have a standard FP location ?

Not really no, it's the sp (r1). r31 might be considered a "frame
pointer" under some circumstances but there isn't much you can do with
it, it's really r1 that gives you the ability to backtrace (each stack
frame contains a pointer to the next one).

> > +#define profile_pc(regs) GET_IP(regs)
> 
> pretty sure you don't need this as asm-generic/ptrace.h already has a 
> definition for you
> -mike

Cheers,
Ben.
