Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E31B2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 21:04:51 +1100 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 02/10] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20140130054913.GA10611@iris.ozlabs.ibm.com>
Date: Thu, 30 Jan 2014 11:04:41 +0100
Message-Id: <6CF8EBA6-D5F6-47C7-8C40-18905D7034E9@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140130054913.GA10611@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 30.01.2014 um 06:49 schrieb Paul Mackerras <paulus@samba.org>:
>=20
>> On Tue, Jan 28, 2014 at 10:14:07PM +0530, Aneesh Kumar K.V wrote:
>> virtual time base register is a per vm register and need to saved
>> and restored on vm exit and entry. Writing to VTB is not allowed
>> in the privileged mode.
> ...
>=20
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +#define mfvtb()        ({unsigned long rval;                \
>> +            asm volatile("mfspr %0, %1" :            \
>> +                     "=3Dr" (rval) : "i" (SPRN_VTB)); rval;})
>=20
> The mfspr will be a no-op on anything before POWER8, meaning the
> result will be whatever value was in the destination GPR before the
> mfspr.  I suppose that may not matter if the result is only ever used
> when we're running on a POWER8 host, but I would feel more comfortable
> if we had explicit feature tests to make sure of that, rather than
> possibly doing computations with unpredictable values.
>=20
> With your patch, a guest on a POWER7 or a PPC970 could do a read from
> VTB and get garbage -- first, there is nothing to stop userspace from
> requesting POWER8 emulation on an older machine, and secondly, even if
> the virtual machine is a PPC970 (say) you don't implement
> unimplemented SPR semantics for VTB (no-op if PR=3D0, illegal
> instruction interrupt if PR=3D1).
>=20
> On the whole I think it is reasonable to reject an attempt to set the
> virtual PVR to a POWER8 PVR value if we are not running on a POWER8
> host, because emulating all the new POWER8 features in software
> (particularly transactional memory) would not be feasible.  Alex may
> disagree. :)

We don't have a good feature flag indicator that tells kvm what the guest cp=
u is capable of. So yes, I think it's reasonable to just not expose p8 regis=
ters on p8 for now.

In theory it's of course possible to emulate a lot of p8 features on pre-p8 h=
ardware, but I'm not sure it's worth the effort. If anyone wants to spend th=
e time to work on it I'd be happy to tale patches though ;)

Alex

>=20
> Paul.
