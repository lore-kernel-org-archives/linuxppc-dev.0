Return-Path: <aschmidt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 37A0CB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jun 2011 21:28:25 +1000 (EST)
From: Atlant Schmidt <aschmidt@dekaresearch.com>
To: 'Mike Hench' <mhench@elutions.com>, Scott Wood <scottwood@freescale.com>,
	"Matthew L. Creech" <mlcreech@gmail.com>
Date: Mon, 20 Jun 2011 07:22:26 -0400
Subject: RE: NAND BBT corruption on MPC83xx
Message-ID: <0A40042D85E7C84DB443060EC44B3FD32A7208F91B@dekaexchange07.deka.local>
References: <20110617163442.204348a0@schlenkerla.am.freescale.net>
	<F87D23B7E1F84E4AB52E4FA4A55F85DC0259E343@tpamail.elutions.com>
In-Reply-To: <F87D23B7E1F84E4AB52E4FA4A55F85DC0259E343@tpamail.elutions.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike:

> It is not a permanent damage thing.

  A "read disturb" does no permanent damage to the chip
  but if the read disturb event involves more bits than
  can be corrected by your ECC code, it can do permanent
  damage to the *DATA* you've stored in that block.

  For this reason, a good flash management system manages
  to at least occasionally read through *ALL* of the in-use
  blocks in the device so that single-bit errors can be
  scrubbed out (read and successfully corrected) before
  an adjacent bit in the block also fails (which would
  eventually lead to a multi-bit error that might be
  beyond the ability to be corrected by the ECC).

  As far as I know (and I'm sure the list will correct
  me if I'm wrong! ;-) ), neither UBI nor UBIFS nor any
  Linux layer provides this routine scrubbing; you have
  to code it up yourself, probably by accessing the
  device at the UBI (underlying block device/LEB) layer.

                        Atlant

-----Original Message-----
From: linux-mtd-bounces@lists.infradead.org [mailto:linux-mtd-bounces@lists=
.infradead.org] On Behalf Of Mike Hench
Sent: Saturday, June 18, 2011 13:55
To: Scott Wood; Matthew L. Creech
Cc: linuxppc-dev@lists.ozlabs.org; linux-mtd@lists.infradead.org
Subject: RE: NAND BBT corruption on MPC83xx

Scott Wood wrote:
> As for the corruption, could it be degradation from repeated reads of
that
> one page?

Read Disturb. I Did not know SLC did that.
It just takes 10x as long as MLC, on the order of a million reads.
Supposedly erasing the block fixes it.
It is not a permanent damage thing.
I was seeing ~9 hours before failure with heavy writes.
~4GByte/hour =3D 2M pages, total ~18 million reads before errors in that
last block showed up.

Cool. Now we know.
Thanks.

Mike Hench



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
