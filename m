Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D10F42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:18:25 +1000 (EST)
Date: Fri, 14 Jun 2013 15:18:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/pci: Fix setup of Freescale PCI / PCIe
 controllers
To: Rojhalat Ibrahim <imr@rtschenk.de>
In-Reply-To: <2819373.IXRuYOYOkX@pcimr> (from imr@rtschenk.de on Fri Jun 14
 04:05:34 2013)
Message-ID: <1371241083.2996.7@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 04:05:34 AM, Rojhalat Ibrahim wrote:
> Commit 50d8f87d2b3 (powerpc/fsl-pci Make PCIe hotplug work with =20
> Freescale
> PCIe controllers) does not handle non-PCIe controllers properly, =20
> which causes
> a panic during boot for certain configurations.
> This patch fixes the issue by calling setup_indirect_pci for all =20
> device types.
> fsl_indirect_read_config is now only used for booke/86xx PCIe =20
> controllers.
>=20
> Reported-by: Michael Guntsche <mike@it-loops.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> ---
> v2: Make it more consistent.
>=20
>  arch/powerpc/sysdev/fsl_pci.c |   20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =20
> b/arch/powerpc/sysdev/fsl_pci.c
> index 028ac1f..5682c8a 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -97,20 +97,12 @@ static int fsl_indirect_read_config(struct =20
> pci_bus *bus,
> unsigned int devfn,
>  	return indirect_read_config(bus, devfn, offset, len, val);
>  }
>=20
> -static struct pci_ops fsl_indirect_pci_ops =3D
> +static struct pci_ops fsl_indirect_pcie_ops =3D
>  {
>  	.read =3D fsl_indirect_read_config,
>  	.write =3D indirect_write_config,
>  };

On 83xx:
cc1: warnings being treated as errors
/home/scott/fsl/git/linux/upstream/arch/powerpc/sysdev/fsl_pci.c:100:23: =20
error: 'fsl_indirect_pcie_ops' defined but not used
make[2]: *** [arch/powerpc/sysdev/fsl_pci.o] Error 1
make[2]: *** Waiting for unfinished jobs....

I can fix this when applying, but this makes me wonder how you tested =20
it, given that the whole point is to fix 83xx...  Did you fix this and =20
then accidentally sent a stale version?

Also, please be careful that the patch doesn't get line wrapped -- I =20
had to manually unwrap a couple places.  Use git send-email if you =20
can't get KMail to cooperate.

-Scott=
