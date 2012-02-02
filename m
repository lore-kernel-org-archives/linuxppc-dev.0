Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2522E104796
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 03:55:14 +1100 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 2 Feb 2012 11:55:08 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 62AF438C8079
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2012 11:48:14 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q12Gm9iM115842
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Feb 2012 11:48:10 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q12Gm5Pk003600
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Feb 2012 14:48:05 -0200
Date: Thu, 2 Feb 2012 22:06:59 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] Implement GET_IP/SET_IP for powerpc architecture.
Message-ID: <20120202163659.GD31984@linux.vnet.ibm.com>
References: <20120202144125.GA6221@linux.vnet.ibm.com>
 <201202021128.49188.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201202021128.49188.vapier@gentoo.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Mike Frysinger <vapier@gentoo.org> [2012-02-02 11:28:46]:

> On Thursday 02 February 2012 09:41:25 Srikar Dronamraju wrote:
> > +#define GET_FP(regs)		(0)
> > +#define SET_FP(regs, val)
> 
> ppc doesn't have a standard FP location ?
> 
> > +#define profile_pc(regs) GET_IP(regs)
> 
> pretty sure you don't need this as asm-generic/ptrace.h already has a 
> definition for you

On ppc64, profile_pc is an extern function if CONFIG_SMP is set. 
else its same as whats defined in asm-generic/ptrace.h

Now if we allow asm-generic/ptrace.h definition to take effect, then
powerpc/time.h (where the actual profile_pc  is defined as an extern
function) fails with an error for redefinition.

Hence our approach was to define profile_pc before asm-generic/ptrace.h
gets included.  One change  that we could do was to define profile_pc
only under CONFIG_SMP. But I think it makes the code less confusing.
Otherwise people might keep wondering why profile_pc is defined only for
CONFIG_SMP case.

-- 
Thanks and Regards
Srikar
