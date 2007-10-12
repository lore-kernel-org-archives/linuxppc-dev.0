Return-Path: <Thomas.Hommel@gefanuc.com>
Received: from ext-ch1gw-1.online-age.net (ext-ch1gw-1.online-age.net
	[216.34.191.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3A86ADDDD6
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:10:27 +1000 (EST)
Received: from int-ch1gw-3.online-age.net (int-ch1gw-3 [3.159.232.67])
	by ext-ch1gw-1.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id l9CAm35x009535
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:48:03 -0400 (EDT)
Received: from cinmlef11.e2k.ad.ge.com (int-ch1gw-3 [3.159.232.67])
	by int-ch1gw-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l9CAm29h010743
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:48:02 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Set up device tree for PCI bus
Date: Fri, 12 Oct 2007 12:48:03 +0200
Message-ID: <62DDBB9E5E23CC4A929EE46F9427CEAF3682BB@BUDMLVEM04.e2k.ad.ge.com>
From: "Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I'm wondering how to set up a proper device tree for a PCI bus. The bus
has a tree-like structure with several bridges and can be extended
dynamically (by adding PMC/XMC modules).

The structure looks like this:

                           ----------------------
                           |      MPC8641       |
                           |                    |
                           |     BDF 0:0:0      |
                           ----------------------
                                      |
                                      |Bus #1
                                      |PCIe 8x
                                      |
                -----------------------------------------------
                | PCIe switch         |                       |
                |               -------------                 |
                |               | BDF 1:0:0 |                 |  =20
                |               -------------                 |
                |                     |Bus #2                 |
                |       -----------------------------         |
                |       |             |             |         |
                |  -----------  ------------   -----------    |
                |  |BDF 2:1:0|  |BDF 2:2:0 |   |BDF 2:3:0|    |
                |  -----------  ------------   -----------    |
                |       |Bus #3       |Bus #5       |Bus #6   |
                |       |PCIe 4x      |PCIe 2x      |PCIe 2x  |
                -----------------------------------------------
                        |             |             |
                   -----------  ------------   -----------   =20
                   |Bridge   |  |Expansion |   |SATA     |   =20
                   |BDF 3:0:0|  |Slot      |   |BDF 6:0:0|   =20
                   -----------  ------------   -----------   =20
                        |
                        |Bus #4
                        |PCI-X
             ----------------------
             |                    |
        ------------         ------------=20
        |VME Bridge|         |PMC Slot  |    =20
        |BDF 4:e:0 |         |BDF 4:c:0 |    =20
        ------------         ------------    =20

A problem is that the modules in the Expansion/PMC slot can contain more
bridges and therefore the bus numbering isn't fixed. For example, if the
PMC adds one more bus, #5 becomes #6 and #6 becomes #7.
Can I assign fixed resources for all the bridge parts of the system?

Thanks
Thomas
