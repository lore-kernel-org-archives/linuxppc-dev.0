Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb58T4C15zDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 20:35:05 +1100 (AEDT)
Date: Mon, 13 Nov 2017 09:34:23 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Michal Hocko <mhocko@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: Tree for Nov 7
Message-ID: <20171113093423.GI12318@n2100.armlinux.org.uk>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 13, 2017 at 10:20:06AM +0100, Michal Hocko wrote:
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
> aligning for shared vmas. We do not do that for MAP_FIXED.  Powepc,
> reported earlier [1] seems to suffer from the similar problem.
> slice_get_unmapped_area alignes to slices, whatever that means.
> 
> I can see two possible ways around that. Either we explicitly request
> non-aligned mappings via a special MAP_$FOO (e.g. MAP_FIXED_SAFE) or
> simply opt out from the MAP_FIXED protection via ifdefs. The first
> option sounds more generic to me but also more tricky to not introduce
> other user visible effects. The later is quite straightforward. What do
> you think about the following on top of the previous patch?
> 
> It is rather terse and disables the MAP_FIXED protection for arm
> comletely because I couldn't find a way to make it conditional on
> CACHEID_VIPT_ALIASING. But this can be always handled later. I find the
> protection for other archtectures useful enough to have this working for
> most architectures now and handle others specially.

Can someone provide the background information for this please?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
