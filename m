Return-Path: <dave@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFC32B70A6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 06:07:28 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7CJnih5000491
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 15:49:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7CK76Mj367754
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 16:07:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7CK75dr017001
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 16:07:06 -0400
Subject: Re: [PATCH 0/8] v5 De-couple sysfs memory directories from memory
	sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20100812120816.e97d8b9e.akpm@linux-foundation.org>
References: <4C60407C.2080608@austin.ibm.com>
	<20100812120816.e97d8b9e.akpm@linux-foundation.org>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Thu, 12 Aug 2010 13:07:03 -0700
Message-ID: <1281643623.6772.78.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-08-12 at 12:08 -0700, Andrew Morton wrote:
> > This set of patches allows for each directory created in sysfs
> > to cover more than one memory section.  The default behavior for
> > sysfs directory creation is the same, in that each directory
> > represents a single memory section.  A new file 'end_phys_index'
> > in each directory contains the physical_id of the last memory
> > section covered by the directory so that users can easily
> > determine the memory section range of a directory.
> 
> What you're proposing appears to be a non-back-compatible
> userspace-visible change.  This is a big issue! 

Nathan, one thought to get around this at the moment would be to bump up
the size that we export in /sys/devices/system/memory/block_size_bytes.
I think you have already done most of the hard work to accomplish
this.  

You can still add the end_phys_index stuff.  But, for now, it would
always be equal to start_phys_index.

-- Dave
