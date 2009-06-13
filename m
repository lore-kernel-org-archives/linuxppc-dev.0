Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4801CB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 01:40:25 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Jun 2009 09:40:02 -0600
Message-ID: <fa686aa40906130840lfb751a7xc9e24646c860a76d@mail.gmail.com>
Subject: Re: [PATCH] sdhci: Add support for hosts that are only capable of
	1-bit transfers
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Pierre Ossman <pierre@ossman.eu>,
	devicetree-discuss@ozlabs.org, sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 2:15 PM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> Some hosts (hardware configurations, or particular SD/MMC slots) may
> not support 4-bit bus. For example, on MPC8569E-MDS boards we can
> switch between serial (1-bit only) and nibble (4-bit) modes, thought
> we have to disable more peripherals to work in 4-bit mode.
>
> Along with some small core changes, this patch modifies sdhci-of
> driver, so that now it looks for "mode" property in the device-tree.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Pierre, I'm not sure if a quirk would be appropriate here. If so,
> I can redo the patch with FORCE_1_BIT_DATA quirk.
>
> Thanks,
>
> =A0Documentation/powerpc/dts-bindings/fsl/esdhc.txt | =A0 =A02 ++
> =A0drivers/mmc/host/sdhci-of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A07 +++++++
> =A0drivers/mmc/host/sdhci-pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A01 +
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 +-
> =A04 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documenta=
tion/powerpc/dts-bindings/fsl/esdhc.txt
> index 5093ddf..298b865 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -10,6 +10,8 @@ Required properties:
> =A0 - interrupts : should contain eSDHC interrupt.
> =A0 - interrupt-parent : interrupt source phandle.
> =A0 - clock-frequency : specifies eSDHC base clock frequency.
> + =A0- mode : specifies eSDHC mode, valid values are: "1-bit" and "4-bit"=
.
> + =A0 =A0If mode is unspecified, then 4-bit mode is assumed.

In light of Pierre's comment that 4-bit is mandatory and this is a
deviation, perhaps it would be better to define an empty property to
indicate that only 1-bit transfers work.  Maybe something along the
lines of "sdhc-1-bit-only"?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
