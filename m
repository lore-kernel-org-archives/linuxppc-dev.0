Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97221B7CF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 15:58:30 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3D5sbLe009978
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 15:54:37 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3D5wT8w1892464
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 15:58:29 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3D5wTKI015699
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 15:58:29 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH v2] powerpc: Track backing pages allocated by
	vmemmap_populate()
Date: Tue, 13 Apr 2010 16:02:23 +1000
References: <201003261812.34095.markn@au1.ibm.com>
	<201004131416.23941.markn@au1.ibm.com>
	<1271136257.13902.9.camel@concordia>
In-Reply-To: <1271136257.13902.9.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201004131602.23898.markn@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 13 April 2010 15:24:17 Michael Ellerman wrote:
> On Tue, 2010-04-13 at 14:16 +1000, Mark Nelson wrote:
> > We need to keep track of the backing pages that get allocated by
> > vmemmap_populate() so that when we use kdump, the dump-capture kernel knows
> > where these pages are.
> > 
> > We use a linked list of structures that contain the physical address of the
> > backing page and corresponding virtual address to track the backing pages.
> > We can use an hlist to save space, because we never remove nodes.
> 
> What if we remove_memory() ? Or does that not do what I think it does?

That's a good question, and one that I probably should have added to the
commit message.
But, following through, it looks like we end up calling into
__remove_section() from mm/memory_hotplug.c and if
CONFIG_SPARSEMEM_VMEMMAP is enabled we just return EBUSY as freeing
memmap with vmemmap isn't implemented yet.

So for the moment, I'm not sure we have to worry about it.

Thanks!
Mark.
