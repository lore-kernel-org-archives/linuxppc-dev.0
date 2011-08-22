Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36B9FB6F72
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 02:21:44 +1000 (EST)
Message-ID: <4E52819C.8080204@freescale.com>
Date: Mon, 22 Aug 2011 11:19:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
	<4E527E0F.1010500@freescale.com> <4E528036.5070801@parrot.com>
In-Reply-To: <4E528036.5070801@parrot.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem Bityutskiy <dedekind1@gmail.com>, LiuShuo <b35362@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Ivan Djelic <ivan.djelic@parrot.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2011 11:13 AM, Matthieu CASTET wrote:
> Scott Wood a =C3=A9crit :
>> To eliminate it we'd need to do an extra data transfer without reissui=
ng
>> the command, which Shuo was unable to get to work.
>>
> That's weird because our controller seems quite flexible [1].
>=20
> Something like that should work ?
>=20
>             out_be32(&lbc->fir,
>                      (FIR_OP_CM2 << FIR_OP0_SHIFT) |
>                      (FIR_OP_CA  << FIR_OP1_SHIFT) |
>                      (FIR_OP_PA  << FIR_OP2_SHIFT) |
>                      (FIR_OP_WB  << FIR_OP3_SHIFT));
> refill FCM buffer with next 2k data
>=20
>             out_be32(&lbc->fir,
>                      (FIR_OP_WB  << FIR_OP3_SHIFT) |
>                      (FIR_OP_CM3 << FIR_OP4_SHIFT) |
>                      (FIR_OP_CW1 << FIR_OP5_SHIFT) |
>                      (FIR_OP_RS  << FIR_OP6_SHIFT));

Something like that is what I originally suggested, but Shuo said it
didn't work (even in theory, it requires a CE-don't-care NAND chip,
since bus atomicity is broken).

Shuo, what specifically did you try, and what did you see happen?

-Scott
