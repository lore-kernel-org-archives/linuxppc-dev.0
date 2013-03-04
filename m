Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEB3A2C0321
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 10:45:57 +1100 (EST)
Date: Mon, 4 Mar 2013 17:45:44 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Stuart Yoder <b08248@gmail.com>
In-Reply-To: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 (from b08248@gmail.com on Mon Mar  4 10:16:10 2013)
Message-ID: <1362440744.16575.6@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/2013 10:16:10 AM, Stuart Yoder wrote:
> On Mon, Mar 4, 2013 at 2:40 AM, Jia Hongtao <B38951@freescale.com> =20
> wrote:
> > A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> > goes down. when the link goes down, Non-posted transactions issued
> > via the ATMU requiring completion result in an instruction stall.
> > At the same time a machine-check exception is generated to the core
> > to allow further processing by the handler. We implements the =20
> handler
> > which skips the instruction caused the stall.
>=20
> Can you explain at a high level how just skipping an instruction =20
> solves
> anything?   If you just skip a load/store and continue like nothing is
> wrong, isn't your system possibly in a really bad state.

If the instruction was a load, we probably at least want to fill the =20
destination register with 0xffffffff or similar.

> And if the core is already hung, due to the PCI link going down, isn't
> it too late?   How does skipping help?

Maybe the machine check unhangs the core?

Is there an erratum number for this?

-Scott=
