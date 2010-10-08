Return-Path: <timur.tabi@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 4FF161009A6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:28:46 +1100 (EST)
Received: by ywi4 with SMTP id 4so770489ywi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Oct 2010 12:28:44 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 8 Oct 2010 14:28:06 -0500
Message-ID: <AANLkTimRGqcDOeR92m0CQZHTxSNSm=D8sZni0zw-He11@mail.gmail.com>
Subject: Re: [PATCH 03/11] powerpc/fsl-booke: Add PCI device ids for
	P2040/P3041/P5010/P5020 QoirQ chips
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 8, 2010 at 2:06 PM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:

> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.=
c
> index 32012a2..4d0b249 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -417,10 +417,18 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P201=
0E, quirk_fsl_pcie_header);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010, quirk_fsl_pcie_h=
eader);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, quirk_fsl_pcie_=
header);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, quirk_fsl_pcie_h=
eader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040E, quirk_fsl_pcie_he=
ader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040, quirk_fsl_pcie_hea=
der);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041E, quirk_fsl_pcie_he=
ader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041, quirk_fsl_pcie_hea=
der);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040E, quirk_fsl_pcie_=
header);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040, quirk_fsl_pcie_h=
eader);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080E, quirk_fsl_pcie_=
header);
> =A0DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080, quirk_fsl_pcie_h=
eader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010E, quirk_fsl_pcie_he=
ader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010, quirk_fsl_pcie_hea=
der);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020E, quirk_fsl_pcie_he=
ader);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020, quirk_fsl_pcie_hea=
der);

Do we really need to add an entry for each new chip?  This table now
has almost three dozen entries, and they all same the same thing.
Can't we just assume that if the vendor ID is 0x1957, that we should
default to quirk_fsl_pcie_header unless there's another entry
somewhere else?

--=20
Timur Tabi
Linux kernel developer at Freescale
