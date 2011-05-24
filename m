Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B98CB6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:55:23 +1000 (EST)
Received: by iym7 with SMTP id 7so5766292iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 21:55:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTi=bs31L=C+XWGeXG49xuFVzt+omgA@mail.gmail.com>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
	<BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
	<BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
	<BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
	<1305846751.7481.55.camel@pasglop>
	<BANLkTi=bs31L=C+XWGeXG49xuFVzt+omgA@mail.gmail.com>
Date: Tue, 24 May 2011 10:25:19 +0530
Message-ID: <BANLkTi=J5EFvs3nHDQXNQfyd0EejWJvzcQ@mail.gmail.com>
Subject: Re: Kernel cannot see PCI device
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, May 20, 2011 at 4:49 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 19, 2011 at 5:12 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Thu, 2011-05-19 at 11:58 -0600, Bjorn Helgaas wrote:
>>> The scan below PCIX0 (bus 0001:00) doesn't find anything. =A0You really
>>> need a powerpc expert to help here, but in their absence, my guess
>>> would be something's wrong with config space access, so I would start
>>> by just adding some printks to ppc4xx_probe_pcix_bridge() to see if
>>> the rsrc_cfg address looks reasonable. =A0You might need a chip spec or
>>> maybe you can compare it to the device tree (I have no idea what the
>>> relation between the device tree and OF is).
>>>
>>> You mentioned the u-boot "pci 2" command earlier. =A0It found a device
>>> on bus 2, which means there must be at least one P2P bridge to get you
>>> from bus 0 to bus 2. =A0So the output of "pci 0", "pci 1", "pci 80", an=
d
>>> "pci 81" (to compare with what Linux found) would be interesting.
>>
>> Well, if it's PCIe, there's the "virtual" P2P bridge of the root
>> complex.
>>
>> The question is on what PCIe is his device connected, the one that we
>> see or the one that's disabled in the device-tree.
>
> I *think* the device Prashant is looking for ("02.00.00 =A0 0x1000
> 0x0072 =A0 =A0 Mass storage controller 0x00") is below the PCI-X bridge;
> at least the canyonlands.dts he posted says that PCIX0 leads to buses
> 0-3f.
>

Fixed the problem by soft resetting the PCIe port in the function
ppc460ex_pciex_port_init_hw().
Is it a right thing to do?
Following is the patch for kernel 2.6.38.4:
---------------------------------------------------------------------------=
-----------
--- linux-2.6.38.4/arch/powerpc/sysdev/ppc4xx_pci.c.orig	2011-05-24
10:02:38.000000000 +0530
+++ linux-2.6.38.4/arch/powerpc/sysdev/ppc4xx_pci.c	2011-05-24
10:07:17.000000000 +0530
@@ -876,6 +876,20 @@
 	u32 val;
 	u32 utlset1;

+	switch (port->index)
+	{
+		case 0:
+			mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST, 0x0);
+			mdelay(10);
+			break;
+		case 1:
+			mtdcri(SDR0, PESDR1_460EX_PHY_CTL_RST, 0x0);
+			mdelay(10);
+			break;
+		default:
+			break;
+	}
+
 	if (port->endpoint)
 		val =3D PTYPE_LEGACY_ENDPOINT << 20;
 	else
---------------------------------------------------------------------------=
-----------



- Prashant
