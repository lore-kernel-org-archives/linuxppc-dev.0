Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id A9452B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 17:19:08 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
In-Reply-To: <07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
To: Alexander Graf <agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
	<4C270876.2050806%40redhat.com>
Date: Mon, 28 Jun 2010 02:18:51 -0500
Message-ID: <1277709531_13308@mail4.comsite.net>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Avi Kivity <avi@redhat.com>,
	kvm-ppc@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun Jun 27 around 19:33:52 EST 2010 Alexander Graf wrote:
> Am 27.06.2010 um 10:14 schrieb Avi Kivity <avi at redhat.com>:
> > On 06/26/2010 02:25 AM, Alexander Graf wrote:

> > > +
> > > +PPC hypercalls
> > > +==============
> > > +
> > > +The only viable ways to reliably get from guest context to host  
> > > context are:
> > > +
> > > +    1) Call an invalid instruction
> > > +    2) Call the "sc" instruction with a parameter to "sc"
> > > +    3) Call the "sc" instruction with parameters in GPRs
> > > +
> > > +Method 1 is always a bad idea. Invalid instructions can be  
> > > replaced later on
> > > +by valid instructions, rendering the interface broken.
> > > +
> > > +Method 2 also has downfalls. If the parameter to "sc" is != 0 the  
> > > spec is
> > > +rather unclear if the sc is targeted directly for the hypervisor  
> > > or the
> > > +supervisor. It would also require that we read the syscall issuing  
> > > instruction
> > > +every time a syscall is issued, slowing down guest syscalls.
> > > +

It goes to the hypervisor, and it would require the hypervisor to
return to the supervisor, but I believe it just returns to the user with
permission denied.

> > > +Method 3 is what KVM uses. We pass magic constants  
> > > (KVM_SC_MAGIC_R3 and
> > > +KVM_SC_MAGIC_R4) in r3 and r4 respectively. If a syscall  
> > > instruction with these
> > > +magic values arrives from the guest's kernel mode, we take the  
> > > syscall as a
> > > +hypercall.
> > >
> >
> > Is there any chance a normal syscall will have those values in r3  
> > and r4?
> 
> r3 is the syscall number. So as long as the guest doesn't reuse that  
> value, we're safe. Since in general syscall numbers are not randomly  
> scattered throughout the number range, we should be ok here.
> 

No, r0 has the system call number.  Registers 3 and 4 are the first
2 args in c abi (or first 64 bit arg in 32 bit c abi), but the linux
syscall abi special.  (In addition, it returns success or failure in
cr0).

> >
> > If so, maybe it's better to use pc as they key for hypercalls.  Let  
> > the guest designate one instruction address as the hypercall call  
> > point; kvm can easily check it and reflect it back to the guest if  
> > it doesn't match.
> >
> 
> You mean the guest would tell the hv where the hypercall lies? That  
> would require a hypercall, no? Defining it statically is tricky. I  
> want to PV'nize osx using a kernel module later, so I don't have  
> control over the physical layout.
> 
> > Is it valid and useful to issue sc from privileged mode anyway,  
> > except for calling the hypervisor?
> 
> Same as a syscall on x86 really. The kernel can and does issue  
> syscalls within itself.
> 
> 

I don't believe we support the kernel actually doing a syscall to itself
anymore, at least on powerpc.  The callers call the underlying system
call function, or kernel_thread.

That said, I would suggest we allocate a syscall number for this, as it
would document the usage.  (In additon to 0..nr_syscalls - 1 we have
0x1ebe in use).

Also, is there any desire to nest such emulation?

milton
