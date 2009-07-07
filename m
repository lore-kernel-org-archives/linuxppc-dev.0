Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07C49B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 07:25:22 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A71B4DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 07:25:19 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 07 Jul 2009 23:25:14 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090707212514.244120@gmx.net>
MIME-Version: 1.0
Subject: How to correctly reassign PCI BARs
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to implement some PCI quirks for the AmigaOne, as the
firmware puts PCI devices with 16 bit BARs too high in the PCI I/O
space (above 64k). Currently I'm just writing new values to the BARs
before the PCI layer actually probes and allocates them:

static void quirk_vt82c686_sound_iobases(struct pci_dev *dev)
{
	if (!machine_is(amigaone))
		return;

	pci_write_config_dword(dev, 0x10, 0x0000dc00);
	pci_write_config_dword(dev, 0x14, 0x0000e000);
	pci_write_config_dword(dev, 0x18, 0x00000330);
}
DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_vt82c686_sound_iobases);

I wonder, if there is a better way to reassign PCI resources. Using
ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC) seems to be an alternative,
but it also relocates the BARs of the IDE controller, which operates
in compatible mode (I would like to keep it in this mode).
Is there a way to take out some PCI devices from the reassignment?

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
