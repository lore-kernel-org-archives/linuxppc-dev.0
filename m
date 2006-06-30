Return-Path: <hlrprasad@tataelxsi.co.in>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(Client CN "myname.my.domain",
	Issuer "www.mirapoint.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CADE467A3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 22:50:46 +1000 (EST)
From: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem in PCI with MPC5200B
Date: Fri, 30 Jun 2006 18:21:05 +0530
Message-ID: <001c01c69c43$da626060$4129320a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20060607120252.qjekdh5yzyrs4s0g@webmail.bluenox.com>
Reply-To: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,
	we are using a customized board based on the reference design of lite5200B.
The PCI bus heirarchy in the board is as follows:
											     |---------> DM642(TMS320C642)
	OnChip-Host-Bridge(MPC5200B) ----> PCI-to-PCI Bridge (TI2250) ---|
											     |---------> Empty Slot
                                                                       |

|---------> Empty Slot

	The linux kernel used is 2.6.11.7. with u-boot-1.1.3. The problem we are
facing is that
I'm able to access the PCI Memory and I/O Region of DM642 from my Host
(MPC5200B) ie.upstream.
But when it comes to other way around ie. with Host Bridge being the PCI
slave and DM642 being the
master, the transaction is failing to complete. But not getting any
exceptions like master abort
and target abort. The BAR Configuration is as follows

Host (MPC5200B):

	BAR0 -- 0x41000000 (256MB) Non prefetchable
	BAR1 -- 0x00000000 (1GB)   prefetchable

PCI-PCI Bridge (TI2250):
	BAR0 -- 0x00000000  {Both are defaulted to 0's and are Read Only}
	BAR1 -- 0x00000000

DM642:
	BAR0 -- 0x40000000 (4MB) 	prefetchable
	BAR1 -- 0x40800000 (8MB) 	Non prefetchable
	BAR2 -- 0x00fff001 (16 bytes) I/O

	If anyone can provide pointers and suggestions to overcome this problem, it
will be of great help, as
we are stuck up with it since long time.

thanks and regards,
Ramprasad H L

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s)and may contain confidential or privileged information. If you are not the intended recipient, please notify the sender or administrator@tataelxsi.co.in
