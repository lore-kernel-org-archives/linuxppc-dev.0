Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C66392C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 07:49:39 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373394562.8183.197@snotra>
Date: Tue, 9 Jul 2013 23:49:32 +0200
Message-Id: <822D94B1-6E7E-4416-9F34-72E3BEAF6B8F@suse.de>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
 <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
 <1C2B7183-EF0F-4D97-9287-1068C9E97471@suse.de> <1373390162.8183.195@snotra>
 <51DC4C78.5080808@suse.de> <1373394562.8183.197@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.07.2013, at 20:29, Scott Wood wrote:

> On 07/09/2013 12:46:32 PM, Alexander Graf wrote:
>> On 07/09/2013 07:16 PM, Scott Wood wrote:
>>> On 07/08/2013 01:45:58 PM, Alexander Graf wrote:
>>>> On 03.07.2013, at 15:30, Mihai Caraman wrote:
>>>> > Some guests are making use of return from machine check =
instruction
>>>> > to do crazy things even though the 64-bit kernel doesn't handle =
yet
>>>> > this interrupt. Emulate MCSRR0/1 SPR and rfmci instruction =
accordingly.
>>>> >
>>>> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>>> > ---
>>>> > arch/powerpc/include/asm/kvm_host.h |    1 +
>>>> > arch/powerpc/kvm/booke_emulate.c    |   25 =
+++++++++++++++++++++++++
>>>> > arch/powerpc/kvm/timing.c           |    1 +
>>>> > 3 files changed, 27 insertions(+), 0 deletions(-)
>>>> >
>>>> > diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
>>>> > index af326cd..0466789 100644
>>>> > --- a/arch/powerpc/include/asm/kvm_host.h
>>>> > +++ b/arch/powerpc/include/asm/kvm_host.h
>>>> > @@ -148,6 +148,7 @@ enum kvm_exit_types {
>>>> >     EMULATED_TLBWE_EXITS,
>>>> >     EMULATED_RFI_EXITS,
>>>> >     EMULATED_RFCI_EXITS,
>>>> > +    EMULATED_RFMCI_EXITS,
>>>> I would quite frankly prefer to see us abandon the whole exit =
timing framework in the kernel and instead use trace points. Then we =
don't have to maintain all of this randomly exercised code.
>>> Would this map well to tracepoints?  We're not trying to track =
discrete events, so much as accumulated time spent in different areas.
>> I think so. We'd just have to emit tracepoints as soon as we enter =
handle_exit and in prepare_to_enter. Then a user space program should =
have everything it needs to create statistics out of that. It would =
certainly simplify the entry/exit path.
>=20
> I was hoping that wasn't going to be your answer. :-)
>=20
> Such a change would introduce a new dependency, more complexity, and =
the possibility for bad totals to result from a ring buffer filling =
faster than userspace can drain it.

Well, at least it would allow for optional tracing :). Today you have to =
change a compile flag to enable / disable timing stats.

>=20
> I also don't see how it would simplify entry/exit, since we'd still =
need to take timestamps in the same places, in order to record a final =
event that says how long a particular event took.

Not sure I understand. What the timing stats do is that they measure the =
time between [exit ... entry], right? We'd do the same thing, just all =
in C code. That means we would become slightly less accurate, but gain =
dynamic enabling of the traces and get rid of all the timing stat asm =
code.


Alex
