Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWSPs2FCHzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 22:49:04 +1100 (AEDT)
Date: Tue, 7 Nov 2017 12:49:00 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][0692229e] next-20171106 fails to boot on Power 7
Message-ID: <20171107114900.7zdpgfatbmg3xugg@dhcp22.suse.cz>
References: <1510048229.12079.7.camel@abdul.in.ibm.com>
 <20171107102854.vylrtaodla63kc57@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107102854.vylrtaodla63kc57@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 07-11-17 11:28:54, Michal Hocko wrote:
> On Tue 07-11-17 15:20:29, Abdul Haleem wrote:
> > Hi,
> > 
> > Today's next kernel fails to boot on Power 7 Machine with below errors
> > in boot log messages.
> > 
> > 'Uhuuh, elf segement at 0000000010040000 requested but the memory is
> > mapped already'
> > 
> > It was introduced with commit:
> > 
> > 0692229e : fs/binfmt_elf.c: drop MAP_FIXED usage from elf_map
> 
> Weird. Clashes shouldn't really happen. Maybe power is doing something
> different from other platforms. Could you apply the following debugging
> patch to see what is going on there?

I have checked the ppc arch_get_unmapped_area and somethig I wouldn't be
surprised if we triped over
	if (!fixed && addr) {
		addr = _ALIGN_UP(addr, 1ul << pshift);
		slice_dbg(" aligned addr=%lx\n", addr);
		/* Ignore hint if it's too large or overlaps a VMA */
		if (addr > mm->task_size - len ||
		    !slice_area_is_free(mm, addr, len))
			addr = 0;
	}

I do not pretend to understand why this is needed or what this actually
does but if the debugging check simply shows that there is no
overlapping VMA then we simply have to come up with a ppc specific code
to handle this...
-- 
Michal Hocko
SUSE Labs
