Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 149302C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 01:11:55 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A38B0@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 3 Jul 2013 17:11:50 +0200
Message-Id: <C4820C32-33E6-4E34-A24C-C49BD7CC8307@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A38B0@039-SN2MPN1-013.039d.mgd.msft.net>
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


On 03.07.2013, at 15:55, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Wednesday, July 03, 2013 4:45 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
>>=20
>>=20
>> On 03.07.2013, at 14:42, Mihai Caraman wrote:
>>=20
>>> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
>>> returning to guest instead of each sched in. Without this =
improvement
>>> an interrupt may also claim floting point corrupting guest state.
>>=20
>> Not sure I follow. Could you please describe exactly what's =
happening?
>=20
> This was already discussed on the list, I will forward you the thread.

The only thing I've seen in that thread was some pathetic theoretical =
case where an interrupt handler would enable fp and clobber state =
carelessly. That's not something I'm worried about.

I really don't see where this patch improves anything tbh. It certainly =
makes the code flow more awkward.


Alex
