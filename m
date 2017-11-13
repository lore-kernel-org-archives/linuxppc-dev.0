Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybCHk3mcnzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 01:11:45 +1100 (AEDT)
Date: Mon, 13 Nov 2017 15:11:40 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: Tree for Nov 7
Message-ID: <20171113141140.cns5fxt5jg4zdedb@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 13-11-17 10:20:06, Michal Hocko wrote:
> [Cc arm and ppc maintainers]
> 
> Thanks a lot for testing!
> 
> On Sun 12-11-17 11:38:02, Joel Stanley wrote:
> > On Fri, Nov 10, 2017 at 11:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > Hi Joel,
> > >
> > > On Wed 08-11-17 15:20:50, Michal Hocko wrote:
> > > [...]
> > >> > There are a lot of messages on the way up that look like this:
> > >> >
> > >> > [    2.527460] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.540160] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.546153] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> >
> > >> > And then trying to run userspace looks like this:
> > >>
> > >> Could you please run with debugging patch posted
> > >> http://lkml.kernel.org/r/20171107102854.vylrtaodla63kc57@dhcp22.suse.cz
> > >
> > > Did you have chance to test with this debugging patch, please?
> > 
> > Lots of this:
> > 
> > [    1.177266] Uhuuh, elf segement at 000d9000 requested but the  memory is mapped already, got 000dd000
> > [    1.177555] Clashing vma [dd000, de000] flags:100873 name:(null)
> 
> This smells like the problem I've expected that mmap with hint doesn't
> respect the hint even though there is no clashing mapping. The above
> basically says that we didn't map at 0xd9000 but it has placed it at
> 0xdd000. The nearest (clashing) vma is at 0xdd000 so this is our new
> mapping. find_vma returns the closest vma (with addr < vm_end) for the
> given address 0xd9000 so this address cannot be mapped by any other vma.
> 
> Now that I am looking at arm's arch_get_unmapped_area it does perform
> aligning for shared vmas.

Sorry for confusion here. These are not shared mappings as pointed out
by Russell in a private email. I got confused by the above flags which I
have misinterpreted as bit 0 set => MAP_SHARED. These are vm_flags
obviously so the bit 0 is VM_READ. Sorry about the confusion. The real
reason we are doing the alignment is that we do a file mapping
	/*
	 * We only need to do colour alignment if either the I or D
	 * caches alias.
	 */
	if (aliasing)
		do_align = filp || (flags & MAP_SHARED);

I am not really familiar with this architecture to understand why do we
need aliasing for file mappings, though.
-- 
Michal Hocko
SUSE Labs
