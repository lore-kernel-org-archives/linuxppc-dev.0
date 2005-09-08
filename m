Return-Path: <linas@austin.ibm.com>
Received: from pokfb.esmtp.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64C55681E0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2005 05:31:33 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.esmtp.ibm.com [9.14.4.130])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j88JVTp4009568
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Sep 2005 15:31:30 -0400
Date: Thu, 8 Sep 2005 14:30:53 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050908193053.GO30028@austin.ibm.com>
References: <0C620F0B-92B0-4EBF-BC0C-49FD4D3D4323@freescale.com>
	<ac556638e1f4b4f9786c30ed0debc4a8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac556638e1f4b4f9786c30ed0debc4a8@kernel.crashing.org>
From: linas <linas@austin.ibm.com>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: r13 is non-volatile?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 08, 2005 at 07:01:18PM +0200, Segher Boessenkool was heard to remark:
> >Was looking at merging some code between ppc32 & ppc64 and noticed 
> >that in ppc32 we consider r13 to be part of the non-volatile register 
> >set.  Is this really correct?
> 
> >r13 is suppose to be sdata pointer in ppc32
> 
> sdata pointer is non-volatile by definition...
> 
> >and system thread id in ppc64.
> 
> The 64-bit kernel uses GPR13 as the PACA pointer, so it handles
> it specially 

There's a different value in R13 depending on which cpu you're on,
so one mustn't save R13 on one CPU and attempt to restore it on
another.

Maybe, for ppc32, you can pretend that r13 "is like a paca"? So
that instead of saving/restoring r13 like this, you could set it up
at the same time/instead of setting up the paca r13?

--linas
