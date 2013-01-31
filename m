Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AA2F2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 01:58:26 +1100 (EST)
Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
 initialization earlier
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF2F7733@039-SN2MPN1-012.039d.mgd.msft.net>
Date: Thu, 31 Jan 2013 15:58:15 +0100
Message-Id: <6E880F7F-4EA9-44CF-8C8A-E1963988ACCD@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-2-git-send-email-mihai.caraman@freescale.com>
 <FE5499BE-EC13-47EA-806C-345F7135B677@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF2F7733@039-SN2MPN1-012.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.01.2013, at 15:56, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, January 31, 2013 3:21 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
>> initialization earlier
>>=20
>>=20
>> On 30.01.2013, at 14:29, Mihai Caraman wrote:
>>=20
>>> VCPU's MMUCFG register initialization should not depend on
>> KVM_CAP_SW_TLB
>>> ioctl call. Move it earlier into tlb initalization phase.
>>=20
>> Quite the contrary. The fact that there is an mfspr() in e500_mmu.c
>> already tells us that the code is broken. The TLB guest code should =
only
>> depend on input from the SW_TLB configuration. It's completely =
orthogonal
>> to the host capabilities.
>=20
> Then we have the same issue for TLBnCFG registers which need to be =
configured
> via SW_TLB ioctl. What is the purpose of guest tlb initalization in =
e500_mmu.c
> if we rely on SW_TLB?

It's to provide a fallback to user space that doesn't implement SW_TLB =
configuration yet.


Alex
