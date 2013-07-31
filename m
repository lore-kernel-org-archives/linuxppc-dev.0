Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 760062C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 02:51:56 +1000 (EST)
Date: Wed, 31 Jul 2013 11:50:50 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
To: "Friesen, Christopher" <cbf123@mail.usask.ca>
In-Reply-To: <CFBB0F4944BCD94BAC0398D7DB81D705EAF91D@CAMPUSMB5.usask.ca>
 (from cbf123@mail.usask.ca on Wed Jul 31 11:40:05 2013)
Message-ID: <1375289450.30721.93@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Paul Mackerras <paulus@samba.org>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2013 11:40:05 AM, Friesen, Christopher wrote:
>=20
> From: Scott Wood [scottwood@freescale.com]
> Sent: Monday, July 29, 2013 5:10 PM
> To: Friesen, Christopher
> Cc: Michael Ellerman; kexec@lists.infradead.org; Paul Mackerras; =20
> linuxppc-dev@lists.ozlabs.org; Vivek Goyal
> Subject: Re: visible memory seems wrong in kexec crash dump kernel
>=20
> On 07/13/2013 01:30:50 AM, Chris Friesen wrote:
> > The upshot is that there seems to be a number of things that could =20
> be
> > improved:
> >
> > 1) kexec should accept "/memory" and not just "/memory@"
> > 2) lmb_reserve() should really respect the crashkernel memory limit
> > 3) the freescale stuff really shouldn't assume it can map things
> > wherever it feels like
>=20
> What "board-specific freescale code" are you referring to?
>=20
> -Scott
>=20
>=20
> Sorry for the crappy quoting, I'm using a web outlook portal.
>=20
> I've switched employers so I don't have access to the exact details =20
> any more.  The system in question was a Kontron AM4150 which uses the =20
> P5020.  As I recall, one of the Freescale drivers (I think it was the =20
> buffer or queue manager that the network driver makes use of) was =20
> attempting to call lmb_reserve() with a base address in the 4GB range =20
> even though the recovery kernel was limited to 224MB of memory.

That's not "board specific" code, and it's not even mainline Linux =20
code.  Unfortunately none of the datapath stuff is upstream, still.

> While I've got your attention, the other thing that I found was that =20
> the "dpa" network driver didn't properly work in a kexec'd kernel =20
> even when given lots of memory.  It would work for a little bit and =20
> then hang.

I'm not particularly surprised by this.  It doesn't help that there's =20
no way to do a device reset. :-(

Issues with Freescale SDK code should be reported on =20
https://community.freescale.com/, to support@freescale.com, or to your =20
FAE.

-Scott=
