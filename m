Return-Path: <markn@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1733B7D0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 09:34:57 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3DNYtrO020391
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 09:34:55 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3DNSSVr1658902
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 09:28:28 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3DNYsbV015668
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 09:34:54 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Track backing pages allocated by
	vmemmap_populate()
Date: Wed, 14 Apr 2010 09:38:46 +1000
References: <201003261812.34095.markn@au1.ibm.com>
	<201004131602.23898.markn@au1.ibm.com>
	<1271157404.13059.102.camel@pasglop>
In-Reply-To: <1271157404.13059.102.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201004140938.46705.markn@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 13 April 2010 21:16:44 Benjamin Herrenschmidt wrote:
> On Tue, 2010-04-13 at 16:02 +1000, Mark Nelson wrote:
> > That's a good question, and one that I probably should have added to
> > the
> > commit message.
> > But, following through, it looks like we end up calling into
> > __remove_section() from mm/memory_hotplug.c and if
> > CONFIG_SPARSEMEM_VMEMMAP is enabled we just return EBUSY as freeing
> > memmap with vmemmap isn't implemented yet.
> > 
> > So for the moment, I'm not sure we have to worry about it.
> 
> We probably don't. IE. The vmemmap will remain for those struct pages,
> which means they won't need to be allocated again if some memory is
> plugged back there. If not, we just waste a bit of memory. Not a big
> deal.
> 
Excellent! That makes sense.

Thanks Ben!

Mark.
