Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 9125C474C5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Sep 2008 22:22:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: direct access to Flash from userland
Date: Thu, 4 Sep 2008 14:22:35 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38369@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Dave Littell" <littelld@verizon.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dave Littell wrote:
>I have a CFI Flash device which has some non-CFI commands I need to
>issue from userland.  I've tried mmap() of the mtdblock device, but
that
>only yielded a corrupted Flash as my non-CFI command sequences were
>simply written to Flash.  An attempted mmap() of the character mtd
>device fails the mmap() call.

You should mmap() the /dev/mem device at the physical base address
of your Flash chip. Don't forget to pass O_SYNC to open(), in order
to have a guarded/non cached mapping.

http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace

>Is there a way for a userland application to issue non-CFI commands
>directly to a Flash device?  (This is a 2.6.18-based kernel on a AMCC
>PPC440EPx platform.)

I don't know whether there's specific ioctl for such purpose.
Have you tried to read the mtd source? You may also hack the mtd
layer to add your command. Definitely a question for=20
http://www.linux-mtd.infradead.org/mail.html

Regards
--=20
Stephane
