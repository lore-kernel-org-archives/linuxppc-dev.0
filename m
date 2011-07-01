Return-Path: <jdmason@kudzu.us>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6567B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 01:24:11 +1000 (EST)
Received: by eyg5 with SMTP id 5so1118708eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Jul 2011 08:24:06 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 1 Jul 2011 10:24:05 -0500
Message-ID: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
Subject: pci_pcie_cap invalid on AER/EEH enabled PPC?
From: Jon Mason <jdmason@kudzu.us>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Richard Lary <rlary@us.ibm.com>, James Smart <james.smart@emulex.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I recently sent out a number of patches to migrate drivers calling
`pci_find_capability(pdef, PCI_CAP_ID_EXP)` to pci_pcie_cap.  This
function takes uses a PCI-E capability offset that was determined by
calling pci_find_capability during the PCI bus walking.  In response
to one of the patches, James Smart posted:

"The reason is due to an issue on PPC platforms whereby use of
"pdev->is_pcie" and pci_is_pcie() will erroneously fail under some
conditions, but explicit search for the capability struct via
pci_find_capability() is always successful.   I expect this to be due
a shadowing of pci config space in the hal/platform that isn't
sufficiently built up.  We detected this issue while testing AER/EEH,
and are functional only if the pci_find_capability() option is used."

See http://marc.info/?l=linux-scsi&m=130946649427828&w=2 for the whole post.

Based on his description above pci_pcie_cap
andpci_find_capability(pdef, PCI_CAP_ID_EXP) should be functionally
equivalent.  If this is not safe, then the PCI bus walking code is
most likely busted on EEH enabled PPC systems (and that is a BIG
problem).  Can anyone confirm this is still an issue?

Thanks,
Jon
