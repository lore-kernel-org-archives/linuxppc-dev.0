Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A5EFFB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 10:53:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] ibm_newemac: Add Support for MAL Interrupt Coalescing
Date: Mon, 21 Sep 2009 17:53:44 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606FFE81A@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1253579943.7103.194.camel@pasglop>
References: <1253573245-1867-1-git-send-email-phazarika@amcc.com>
	<1253576514.7103.165.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D606FFE802@SDCEXCHANGE01.ad.amcc.com>
	<1253578361.7103.180.camel@pasglop>
	<49c0ff980909211728s2d39e356p6900d047c6918826@mail.gmail.com>
	<1253579943.7103.194.camel@pasglop>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"prodyut hazarika" <prodyuth@gmail.com>
Cc: Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>,
	netdev@vger.kernel.org, lada.podivin@gmail.com,
	Loc Ho <lho@amcc.com>, bhutchings@solarflare.com,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> Well... the above is a HW limitation :-) IE. I was suggesting you fix
> the HW, but in the case where you already did and the current MAL in
> your SoC can indeed mask the interrupt per-channel, then that's great
> and we should definitely look into having the driver go back to a more
> standard NAPI model on MALs that have that capability.

In the newer revs of 460EX/GT and 405EX, we have Interrupt coalescing
both on Tx and Rx per channel (physical not virtual), which can be
enabled/disabled per channel via UIC. The Tx/Rx Coalesce mappings are
defined in the dts file. But in the older revs, there is only a global
EOP_Int_Enable in the MAL configuration register. There can be a
possible way even for older SoCs if we use the MAL descriptor I bit and
not the global EOP_Int_Enable. But to turn on/off the channel, we will
have to go and set/clear the I bit in whole of MAL descriptor ring for
that channel. That might be really inefficient.

What would you suggest?

Thanks
Prodyut
