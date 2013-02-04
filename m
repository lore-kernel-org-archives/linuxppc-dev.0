Return-Path: <michael@ellerman.id.au>
Message-ID: <1359949100.25414.20.camel@concordia>
Subject: Re: [PATCH 2/2] pseries/iommu: remove DDW on kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 14:38:20 +1100
In-Reply-To: <20130129203346.GA7664@linux.vnet.ibm.com>
References: <20130129020245.GA12156@linux.vnet.ibm.com>
 <20130129020357.GB12156@linux.vnet.ibm.com>
 <1359457108.26096.7.camel@concordia>
 <20130129203346.GA7664@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: miltonm@bga.com, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-01-29 at 12:33 -0800, Nishanth Aravamudan wrote:
> Hi Michael,
> 
> On 29.01.2013 [21:58:28 +1100], Michael Ellerman wrote:
> > On Mon, 2013-01-28 at 18:03 -0800, Nishanth Aravamudan wrote:
> > > pseries/iommu: remove DDW on kexec
> > >  ...
> > >     
> > > I believe the simplest, easiest-to-maintain fix is to just change our
> > > initcall to, rather than detecting and updating the new kernel's DDW
> > > knowledge, just remove all DDW configurations. When the drivers
> > > re-initialize, we will set everything back up as it was before.
> > 
> > I don't know this code at all, but this sounds like it will also work
> > for kdump, right? ie. when the original kernel has crashed the 2nd
> > kernel will tear the DDW down and set it back up.
> 
> Yes, my actual test-case (and what was reported as broken) was kdump.
> From my relatively vague (but now growing) understanding of that
> process, kdump does use kexec under the covers to switch to the crash
> kernel, and so does get the same benefit from this change.

OK good. Yeah kdump is basically equivalent to kexec with one major
difference, which is that before a kexec the first kernel is shutdown
more or less normally - as if it was about to reboot.

kdump on the other hand is invoked in the panic path, so nothing is
shutdown in the first kernel (almost, see ehea). So to accommodate kdump
you want any logic to be in the startup path of the 2nd kernel.

> Another datapoint, though, is that it might make sense to recommend (and
> I'm working on figuring this out for the distros, etc) to use
> disable_ddw anyways for the kdump kernel command-line, as DDW isn't
> 'free' and it's unclear if performance is a huge concern for the crash
> kernel (sort of varies with where your storage is, and how much you need
> to dump, which for kdump generally doesn't seem like that much?).

The kdump kernel /should/ just be creating a crash dump and then
rebooting. That may involve writing all of RAM out to disk/nw, which
could be a lot of I/O. So performance may be a concern, but correctness
is much much much more important.

Some folks have talked about having the kdump kernel just come up and
pretend it is back in production, but that is madness for various
reasons and I don't think anyone ever did it. 

cheers
