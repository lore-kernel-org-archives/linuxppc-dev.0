Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5FAA62C0535
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:08:32 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372871232.8183.131@snotra>
Date: Wed, 3 Jul 2013 19:08:30 +0200
Message-Id: <8290EA52-349A-43D1-B98A-8555C38C04A3@suse.de>
References: <1372871232.8183.131@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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


On 03.07.2013, at 19:07, Scott Wood wrote:

> On 07/03/2013 10:11:50 AM, Alexander Graf wrote:
>> On 03.07.2013, at 15:55, Caraman Mihai Claudiu-B02008 wrote:
>> >> -----Original Message-----
>> >> From: Alexander Graf [mailto:agraf@suse.de]
>> >> Sent: Wednesday, July 03, 2013 4:45 PM
>> >> To: Caraman Mihai Claudiu-B02008
>> >> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> >> dev@lists.ozlabs.org
>> >> Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
>> >>
>> >>
>> >> On 03.07.2013, at 14:42, Mihai Caraman wrote:
>> >>
>> >>> Increase FPU laziness by calling kvmppc_load_guest_fp() just =
before
>> >>> returning to guest instead of each sched in. Without this =
improvement
>> >>> an interrupt may also claim floting point corrupting guest state.
>> >>
>> >> Not sure I follow. Could you please describe exactly what's =
happening?
>> >
>> > This was already discussed on the list, I will forward you the =
thread.
>> The only thing I've seen in that thread was some pathetic theoretical =
case where an interrupt handler would enable fp and clobber state =
carelessly. That's not something I'm worried about.
>=20
> On x86 floating point registers can be used for memcpy(), which can be =
used in interrupt handlers.  Just because it doesn't happen on PPC today =
doesn't make it a "pathetic theoretical case" that we should ignore and =
leave a landmine buried in the KVM code.  Even power7 is using something =
similar for copyuser (which isn't called from interrupt context, but =
it's not a huge leap from that to doing it in memcpy).
>=20
> It also doesn't seem *that* farfetched that some driver for unusual =
hardware could decide it needs FP in its interrupt handler, and call the =
function that is specifically meant to ensure that.  It's frowned upon, =
but that doesn't mean nobody will ever do it.

Oh, sure. But in that case I would strongly hope that the driver first =
saves off the current FPU state to the thread struct before it goes off =
and uses them for itself. Otherwise it would break user space, no?


Alex
