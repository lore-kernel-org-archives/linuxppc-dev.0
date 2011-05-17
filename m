Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DB97B6EE9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 21:35:55 +1000 (EST)
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104656.GN2837@brick.ozlabs.ibm.com>
	<F90D2118-7694-4AB0-9C17-8B449D14B9DF@suse.de>
	<20110517104422.GB7924@brick.ozlabs.ibm.com>
In-Reply-To: <20110517104422.GB7924@brick.ozlabs.ibm.com>
Mime-Version: 1.0 (iPad Mail 8H7)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <9A23FF37-0369-4DF7-89F7-62E6EA54C97F@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/13] kvm/powerpc: Allow book3s_hv guests to use SMT
	processor modes
Date: Tue, 17 May 2011 13:36:26 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 17.05.2011 um 12:44 schrieb Paul Mackerras <paulus@samba.org>:

> On Tue, May 17, 2011 at 10:21:56AM +0200, Alexander Graf wrote:
>>=20
>> On 11.05.2011, at 12:46, Paul Mackerras wrote:
>>=20
>>> -#define KVM_MAX_VCPUS 1
>>> +#define KVM_MAX_VCPUS        NR_CPUS
>>> +#define KVM_THREADS_PER_CORE    4
>>=20
>> So what if POWER8 (or whatever it will be called) comes along with 8
>> threads per core? Would that change the userspace interface?
>=20
> The idea is that userspace queries the KVM_CAP_PPC_SMT capability and
> the value it gets back is the number of vcpus per vcore.  It then
> allocates vcpu numbers based on that.
>=20
> If a CPU came along with more than 4 threads per core then we'd have
> to change that define in the kernel, but that won't affect the
> userspace API.

Ah, I see :). Tht's exactly why documentation is so important - with proper d=
ocumentation you wouldn't need to explain those things to me :)

>=20
>>> +    /* wait for secondary threads to get back to nap mode */
>>> +    spin_lock(&vc->lock);
>>> +    if (vc->nap_count < vc->n_woken)
>>> +        kvmppc_wait_for_nap(vc);
>>=20
>> So you're taking the vcore wide lock and wait for other CPUs to set
>> themselves to nap? Not sure I fully understand this. Why would
>> another thread want to go to nap mode when it's 100% busy?
>=20
> It's more about waiting for the other hardware threads to have
> finished writing their vcpu state to memory.  Currently those threads
> then go to nap mode, but they could in fact poll instead for a bit,
> so that name is possible a bit misleading, I agree.

Just so I understand the scheme: One vcpu needs to go to MMU mode in KVM, it=
 then sends IPIs to stop the other threads and finally we return from this w=
ait here?

>=20
>>> +    cmpwi    r12,0x980
>>> +    beq    40f
>>> +    cmpwi    r3,0x100
>>=20
>> good old use define comment :)
>=20
> Yep, OK. :)
>=20
>> Maybe I also missed the point here, but how does this correlate with
>> Linux threads? Is each vcpu running in its own Linux thread? How
>> does the scheduling happen? IIUC the host only sees a single thread
>> per core and then distributes the vcpus to the respective host
>> threads.
>=20
> Each vcpu has its own Linux thread, but while the vcore is running,
> all but one of them are sleeping.  The thing is that since the host is
> running with each core single-threaded, one Linux thread is enough to
> run 4 vcpus.  So when we decide we can run the vcore, the vcpu thread
> that discovered that we can now run the vcore takes the responsibility
> to run it.  That involves sending an IPI to the other hardware threads
> to wake them up and get them to each run a vcpu.  Then the vcpu thread
> that is running the vcore dives into the guest switch code itself.  It
> synchronizes with the other threads and does the partition switch, and
> then they all enter the guest.
>=20
> We thought about various schemes to cope with the hardware restriction
> that all hardware threads in a core have to be in the same partition
> (at least whenever the MMU is on).  This is the least messy scheme we
> could come up with.  I'd be happy to discuss the alternatives if you
> like.

Oh, I'm certainly fine with the scheme :). I would just like to understand i=
t and see it documented somewhere, as it's slightly unintuitive.

Also, this scheme might confuse the host scheduler for a bit, as it might mi=
grate threads to other host CPUs while it would prove beneficial for cache u=
sage to keep them local. But since the scheduler doesn't know about the corr=
elation between the threads, it can't be clever about it.

Alex

>=20
