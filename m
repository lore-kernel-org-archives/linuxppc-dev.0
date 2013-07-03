Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 343242C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:07:22 +1000 (EST)
Date: Wed, 3 Jul 2013 12:07:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <C4820C32-33E6-4E34-A24C-C49BD7CC8307@suse.de> (from
 agraf@suse.de on Wed Jul  3 10:11:50 2013)
Message-ID: <1372871232.8183.131@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 07/03/2013 10:11:50 AM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 15:55, Caraman Mihai Claudiu-B02008 wrote:
>=20
> >> -----Original Message-----
> >> From: Alexander Graf [mailto:agraf@suse.de]
> >> Sent: Wednesday, July 03, 2013 4:45 PM
> >> To: Caraman Mihai Claudiu-B02008
> >> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> >> dev@lists.ozlabs.org
> >> Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
> >>
> >>
> >> On 03.07.2013, at 14:42, Mihai Caraman wrote:
> >>
> >>> Increase FPU laziness by calling kvmppc_load_guest_fp() just =20
> before
> >>> returning to guest instead of each sched in. Without this =20
> improvement
> >>> an interrupt may also claim floting point corrupting guest state.
> >>
> >> Not sure I follow. Could you please describe exactly what's =20
> happening?
> >
> > This was already discussed on the list, I will forward you the =20
> thread.
>=20
> The only thing I've seen in that thread was some pathetic theoretical =20
> case where an interrupt handler would enable fp and clobber state =20
> carelessly. That's not something I'm worried about.

On x86 floating point registers can be used for memcpy(), which can be =20
used in interrupt handlers.  Just because it doesn't happen on PPC =20
today doesn't make it a "pathetic theoretical case" that we should =20
ignore and leave a landmine buried in the KVM code.  Even power7 is =20
using something similar for copyuser (which isn't called from interrupt =20
context, but it's not a huge leap from that to doing it in memcpy).

It also doesn't seem *that* farfetched that some driver for unusual =20
hardware could decide it needs FP in its interrupt handler, and call =20
the function that is specifically meant to ensure that.  It's frowned =20
upon, but that doesn't mean nobody will ever do it.

-Scott=
