Return-Path: <dave@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F559B7106
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 01:20:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8MFG2gI014549
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 09:16:02 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o8MFK2rO244326
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 09:20:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8MFK1KT008374
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 09:20:02 -0600
Subject: Re: [PATCH 0/8] De-couple sysfs memory directories from memory
	sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C9A0F8F.2030409@austin.ibm.com>
References: <4C9A0F8F.2030409@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Wed, 22 Sep 2010 08:20:00 -0700
Message-ID: <1285168800.3292.5228.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-22 at 09:15 -0500, Nathan Fontenot wrote:
> For architectures that define their own version of this routine,
> as is done for powerpc in this patchset, the view in userspace
> would change such that each memoryXXX directory would span
> multiple memory sections.  The number of sections spanned would
> depend on the value reported by memory_block_size_bytes.
> 
> In both cases a new file 'end_phys_index' is created in each
> memoryXXX directory.  This file will contain the physical id
> of the last memory section covered by the sysfs directory.  For
> the default case, the value in 'end_phys_index' will be the same
> as in the existing 'phys_index' file.

Hi Nathan,

There's one bit missing here, I think.

"block_size_bytes" today means two things today:
1. the SECTION_SIZE from sparsemem
2. the size covered by each memoryXXXX directory

SECTION_SIZE isn't exposed to userspace, but the memoryXXXX directories
are.  You've done all of the heavy lifting here to make sure that the
memory directories are no longer bound to SECTION_SIZE, but you've also
broken the assumption that _each_ directory covers "block_size_bytes".

I think it's fairly simple to fix.  block_size_bytes() needs to return
memory_block_size_bytes(), and phys_index's calculation needs to be:

	mem->start_phys_index * SECTION_SIZE / memory_block_size_bytes()

That way, to userspace, it just looks like before, but with a larger
SECTION_SIZE.  Doing that preserves the ABI pretty nicely, I believe.

-- Dave
