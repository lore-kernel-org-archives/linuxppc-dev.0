Return-Path: <paulus@ozlabs.org>
Date: Tue, 17 Jan 2012 16:56:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Message-ID: <20120117055654.GB9170@drongo>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
 <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2012 at 02:04:29PM +0100, Alexander Graf wrote:
> 
> On 20.12.2011, at 11:22, Paul Mackerras wrote:

> > @@ -152,6 +152,8 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
> > 	flags &= 7;
> > 	if (flags == 0 || flags == 4)
> 
> This could probably use a new variable name. Also, what do 0 and 4 mean? Constant defines would be nice here.

Those constants are defined in PAPR as being a subfunction code
indicating what sort of area and whether it is to be registered or
unregistered.  I'll make up some names for them.

> [pasted from real source]
> >                 va = kvmppc_pin_guest_page(kvm, vpa, &nb);
> 
> Here you're pinning the page, setting va to that temporarily available address.

Well, it's not just temporarily available, it's available until we
unpin it, since we increment the page count, which inhibits migration.

> > 			len = *(unsigned int *)(va + 4);
> 
> va + 4 isn't really descriptive. Is this a defined struct? Why not actually define one which you can just read data from? Or at least make this a define too. Reading random numbers in code is barely readable.

It's not really a struct, at least not one that is used for anything
else.  PAPR defines that the length of the buffer has to be placed in
the second 32-bit word at registration time.

> 
> > +		free_va = va;
> 
> Now free_va is the temporarily available address.
...
> > +		free_va = tvcpu->arch.next_vpa;
> > +		tvcpu->arch.next_vpa = va;
> 
> Now you're setting next_vpa to this temporarily available address? But next_vpa will be used after va is getting free'd, no? Or is that why you have free_va?

Yes; here we are freeing any previously-set value of next_vpa.  The
idea of free_va is that it is initially set to va so that we correctly
unpin va if any error occurs.  But if there is no error, va gets put
into next_vpa and we free anything that was previously in next_vpa
instead.

> 
> Wouldn't it be easier to just map it every time we actually use it and only shove the GPA around? We could basically save ourselves a lot of the logic here.

There are fields in the VPA that we really want to be able to access
from real mode, for instance the fields that indicate whether we need
to save the FPR and/or VR values.  As far as the DTL is concerned, we
could in fact use copy_to_user to access it, so it doesn't strictly
need to be pinned.  We don't currently use the slb_shadow buffer, but
if we did we would need to access it from real mode, since we would be
reading it in order to set up guest SLB entries.

The other thing is that the VPA registration/unregistration is only
done a few times in the life of the guest, whereas we use the VPAs
constantly while the guest is running.  So it is more efficient to do
more of the work at registration time to make it quicker to access the
VPAs.

I'll send revised patches.  There's a small change I want to make to
patch 2 to avoid putting a very large stolen time value in the first
entry that gets put in after the DTL is registered, which can happen
currently if the DTL gets registered some time after the guest started
running.

Paul.
