Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 22BE52C0212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 21:02:13 +1100 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 07/10] KVM: PPC: BOOK3S: PR: Emulate facility status
 and control register
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20140130060000.GB10611@iris.ozlabs.ibm.com>
Date: Thu, 30 Jan 2014 11:02:05 +0100
Message-Id: <88E81C6E-7DE9-484F-A9CD-55318068F766@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140130060000.GB10611@iris.ozlabs.ibm.com>
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



> Am 30.01.2014 um 07:00 schrieb Paul Mackerras <paulus@samba.org>:
>=20
>> On Tue, Jan 28, 2014 at 10:14:12PM +0530, Aneesh Kumar K.V wrote:
>> We allow priv-mode update of this. The guest value is saved in fscr,
>> and the value actually used is saved in shadow_fscr. shadow_fscr
>> only contains values that are allowed by the host. On
>> facility unavailable interrupt, if the facility is allowed by fscr
>> but disabled in shadow_fscr we need to emulate the support. Currently
>> all but EBB is disabled. We still don't support performance monitoring
>> in PR guest.
>=20
> ...
>=20
>> +    /*
>> +     * Save the current fscr in shadow fscr
>> +     */
>> +    mfspr r3,SPRN_FSCR
>> +    PPC_STL r3, VCPU_SHADOW_FSCR(r7)
>=20
> I don't think you need to do this.  What could possibly have changed
> FSCR since we loaded it on the way into the guest?

The interrupt cause is part of fscr. But yes, we only meed to store that on a=
n fscr interrupt.

Do we use anything from fscr inside the kernel? Could we switch it lazily on=
 vcpu_load/put?

Alex

>=20
> Paul.
