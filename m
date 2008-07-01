Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id 56125DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 15:26:37 +1000 (EST)
Date: Mon, 30 Jun 2008 22:26:32 -0700
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
From: Grant Erickson <gerickson@nuovations.com>
To: Stefan Roese <sr@denx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <C48F0E18.101F1%gerickson@nuovations.com>
In-Reply-To: <1214352498-12527-1-git-send-email-gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/24/08 5:08 PM, Grant Erickson wrote:
> Various instances of the EMAC core have varying: 1) number of address
> match slots, 2) width of the registers for handling address match slots,
> 3) number of registers for handling address match slots and 4) base
> offset for those registers.
> 
> As the driver stands today, it assumes that all EMACs have 4 IAHT and
> GAHT 32-bit registers, starting at offset 0x30 from the register base,
> with only 16-bits of each used for a total of 64 match slots.
> 
> The 405EX(r) and 460 now use the EMAC4SYNC core rather than the EMAC4
> core. This core has 8 IAHT and GAHT registers, starting at offset 0x80
> from the register base, with ALL 32-bits of each used for a total of
> 256 match slots.
> 
> This adds macros and inlines for handling these differences based on
> three parameters parsed from the device tree:
> 
> xaht-slots-shift
> xaht-width-shift
> xaht-base-offset
> 
> and reworks the code, where appropriate to use those macros and inlines.
> EMAC/EMAC4 values are defaulted for these keys if missing, resulting in
> a driver that works as today's does for all cores.
> 
> In addition the register size passed to ioremap is now taken from the
> device tree:
> 
> c0 for EMAC4SYNC cores
> 74 for EMAC4 cores
> 70 for EMAC cores
> 
> rathaer than sizeof (emac_regs).
> 
> Finally, the device trees have been updated with the appropriate xaht-*
> keys and values.
> 
> This has been tested on an AMCC Haleakala board such that: 1) inbound
> ICMP requests to 'haleakala.local' via MDNS from both Mac OS X 10.4.11
> and Ubuntu 8.04 systems as well as 2) outbound ICMP requests from
> 'haleakala.local' to those same systems in the '.local' domain via MDNS
> now work.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> ---
>  arch/powerpc/boot/dts/bamboo.dts      |    6 +++
>  arch/powerpc/boot/dts/canyonlands.dts |   10 ++++-
>  arch/powerpc/boot/dts/ebony.dts       |    6 +++
>  arch/powerpc/boot/dts/ep405.dts       |    3 ++
>  arch/powerpc/boot/dts/glacier.dts     |   20 +++++++++--
>  arch/powerpc/boot/dts/haleakala.dts   |    5 ++-
>  arch/powerpc/boot/dts/katmai.dts      |    5 ++-
>  arch/powerpc/boot/dts/kilauea.dts     |   10 ++++-
>  arch/powerpc/boot/dts/makalu.dts      |   10 ++++-
>  arch/powerpc/boot/dts/rainier.dts     |   10 ++++-
>  arch/powerpc/boot/dts/sequoia.dts     |   10 ++++-
>  arch/powerpc/boot/dts/taishan.dts     |   20 +++++++++--
>  arch/powerpc/boot/dts/walnut.dts      |    3 ++
>  arch/powerpc/boot/dts/warp.dts        |    3 ++
>  drivers/net/ibm_newemac/core.c        |   55 +++++++++++++++++++----------
>  drivers/net/ibm_newemac/core.h        |   61
> +++++++++++++++++++++++++++++++++
>  drivers/net/ibm_newemac/debug.c       |   32 +++++++++++------
>  drivers/net/ibm_newemac/emac.h        |   15 +-------
>  18 files changed, 219 insertions(+), 65 deletions(-)

Stefan and/or Ben:

Any thoughts on this?

Regards,

Grant
