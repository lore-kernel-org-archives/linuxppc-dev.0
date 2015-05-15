Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 052901A0008
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 03:33:28 +1000 (AEST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Fri, 15 May 2015 18:33:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA6A92190046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:33:02 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4FHXLCH9175358
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 17:33:21 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4FHXJff001993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 11:33:21 -0600
Date: Fri, 15 May 2015 19:33:15 +0200
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
Message-ID: <20150515193315.6d3e82d2@thinkpad-w530>
In-Reply-To: <555613F2.9060204@de.ibm.com>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
 <555613F2.9060204@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: peter.maydell@linaro.org, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter
 Anvin" <hpa@zytor.com>, kvmarm@lists.cs.columbia.edu,
 "open list: S390" <linux-s390@vger.kernel.org>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, agraf@suse.de,
 Gleb Natapov <gleb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 zhichao.huang@linaro.org, jan.kiszka@siemens.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de, drjones@redhat.com,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, marc.zyngier@arm.com,
 r65777@freescale.com, pbonzini@redhat.com,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Eric Farman <farman@linux.vnet.ibm.com>,
 "open list: ABI/API" <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "supporter:S390" <linux390@de.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 christoffer.dall@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Am 15.05.2015 um 16:27 schrieb Alex Benn=C3=A9e:
> > +++ b/arch/s390/include/uapi/asm/kvm.h
> > @@ -114,8 +114,6 @@ struct kvm_fpu {
> >  	__u64 fprs[16];
> >  };
> >=20
> > -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
> [...]
> > +++ b/include/uapi/linux/kvm.h
> [...]
> > +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
> > +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)
>=20
> This is an ABI break for s390, no?
>=20
> David, do you remember why we do not use KVM_GUESTDBG_USE_SW_BP?
>=20

We never had to tell the kernel about software breakpoints as this is all
handled via 4 byte DIAG instructions until now. We don't have to turn this
mechanism on. QEMU can directly insert the desired DIAG instructions and ge=
ts
notified when they are about to get executed.

(But we still have 2 byte breakpoint support todo - still tbd how exactly t=
his
will be realized - could be turned on via such a mechanism)

The problem is, that these bits are arch specific, now Alex wants to unify
them for all archs.

So yes, this is an ABI break for us and breaks hardware breakpoints.(I think
the first version of this patch didn't contain this ABI break when I had a =
look)

I wonder if it wouldn't make more sense to

- introduce new bits in the arch-unspecific section
- rework the existing implementers to accept both bits

Or to simply leave stuff as it is and handle it via arch specific bits.

David
