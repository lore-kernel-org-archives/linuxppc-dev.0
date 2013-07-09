Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 826912C0340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 07:55:06 +1000 (EST)
Date: Tue, 9 Jul 2013 16:54:51 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
To: Alexander Graf <agraf@suse.de>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
 <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
 <1C2B7183-EF0F-4D97-9287-1068C9E97471@suse.de> <1373390162.8183.195@snotra>
 <51DC4C78.5080808@suse.de> <1373394562.8183.197@snotra>
 <822D94B1-6E7E-4416-9F34-72E3BEAF6B8F@suse.de>
In-Reply-To: <822D94B1-6E7E-4416-9F34-72E3BEAF6B8F@suse.de> (from
 agraf@suse.de on Tue Jul  9 16:49:32 2013)
Message-ID: <1373406891.8183.207@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 07/09/2013 04:49:32 PM, Alexander Graf wrote:
>=20
> On 09.07.2013, at 20:29, Scott Wood wrote:
>=20
> > On 07/09/2013 12:46:32 PM, Alexander Graf wrote:
> >> On 07/09/2013 07:16 PM, Scott Wood wrote:
> >>> On 07/08/2013 01:45:58 PM, Alexander Graf wrote:
> >>>> On 03.07.2013, at 15:30, Mihai Caraman wrote:
> >>>> > Some guests are making use of return from machine check =20
> instruction
> >>>> > to do crazy things even though the 64-bit kernel doesn't =20
> handle yet
> >>>> > this interrupt. Emulate MCSRR0/1 SPR and rfmci instruction =20
> accordingly.
> >>>> >
> >>>> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> >>>> > ---
> >>>> > arch/powerpc/include/asm/kvm_host.h |    1 +
> >>>> > arch/powerpc/kvm/booke_emulate.c    |   25 =20
> +++++++++++++++++++++++++
> >>>> > arch/powerpc/kvm/timing.c           |    1 +
> >>>> > 3 files changed, 27 insertions(+), 0 deletions(-)
> >>>> >
> >>>> > diff --git a/arch/powerpc/include/asm/kvm_host.h =20
> b/arch/powerpc/include/asm/kvm_host.h
> >>>> > index af326cd..0466789 100644
> >>>> > --- a/arch/powerpc/include/asm/kvm_host.h
> >>>> > +++ b/arch/powerpc/include/asm/kvm_host.h
> >>>> > @@ -148,6 +148,7 @@ enum kvm_exit_types {
> >>>> >     EMULATED_TLBWE_EXITS,
> >>>> >     EMULATED_RFI_EXITS,
> >>>> >     EMULATED_RFCI_EXITS,
> >>>> > +    EMULATED_RFMCI_EXITS,
> >>>> I would quite frankly prefer to see us abandon the whole exit =20
> timing framework in the kernel and instead use trace points. Then we =20
> don't have to maintain all of this randomly exercised code.
> >>> Would this map well to tracepoints?  We're not trying to track =20
> discrete events, so much as accumulated time spent in different areas.
> >> I think so. We'd just have to emit tracepoints as soon as we enter =20
> handle_exit and in prepare_to_enter. Then a user space program should =20
> have everything it needs to create statistics out of that. It would =20
> certainly simplify the entry/exit path.
> >
> > I was hoping that wasn't going to be your answer. :-)
> >
> > Such a change would introduce a new dependency, more complexity, =20
> and the possibility for bad totals to result from a ring buffer =20
> filling faster than userspace can drain it.
>=20
> Well, at least it would allow for optional tracing :). Today you have =20
> to change a compile flag to enable / disable timing stats.
>=20
> >
> > I also don't see how it would simplify entry/exit, since we'd still =20
> need to take timestamps in the same places, in order to record a =20
> final event that says how long a particular event took.
>=20
> Not sure I understand. What the timing stats do is that they measure =20
> the time between [exit ... entry], right? We'd do the same thing, =20
> just all in C code. That means we would become slightly less =20
> accurate, but gain dynamic enabling of the traces and get rid of all =20
> the timing stat asm code.

Compile-time enabling bothers me less than a loss of accuracy (not just =20
a small loss by moving into C code, but a potential for a large loss if =20
we overflow the buffer) and a dependency on a userspace tool (both in =20
terms of the tool needing to be written, and in the hassle of ensuring =20
that it's present in the root filesystem of whatever system I'm =20
testing).  And the whole mechanism will be more complicated.

Lots of debug options are enabled at build time; why must this be =20
different?

-Scott=
