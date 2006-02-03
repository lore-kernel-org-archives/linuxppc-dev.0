Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.4.202])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48C3A689D9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 22:10:34 +1100 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k13BAGgA027475
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 12:10:18 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: mike@compulab.co.il
Subject: CPM2 USB driver & MPC8248
MIME-Version: 1.0
Date: Fri, 3 Feb 2006 12:10:12 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602031210.12603.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mike,

I'm having trouble using your CPM2 USB host controller driver on an Embedded 
Planet EP8248 board with Linux 2.6.15.

The driver didn't compiler with 2.6.15 but the required changes were minor 
(the root hub doesn't have to be registered by the host controller driver 
anymore, and a few functions have been renamed). I modified the board setup 
function according to my hardware (different BCSR registers) and the driver 
loads properly.

When I connect a USB 2.0 Mass Storage device, initialization fails when trying 
to fetch the string descriptors. Here's what USBMon produces (I decoded the 
USB transactions with the device).

/* Initialization */
c054a860 62948014 C Ii:001:01 0 1 D
c054a860 62948089 S Ii:001:01 -115 2 D
c04500e0 62948126 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 62948134 C Ci:001:00 0 4 = 01010100
c04500e0 62948146 S Co:001:00 s 23 01 0010 0001 0000 0
c04500e0 62948151 C Co:001:00 0 0
c04500e0 62948158 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 62948163 C Ci:001:00 0 4 = 01010000
c04500e0 62980027 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 62980045 C Ci:001:00 0 4 = 01010000
c04500e0 63012025 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 63012042 C Ci:001:00 0 4 = 01010000
c04500e0 63044025 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 63044042 C Ci:001:00 0 4 = 01010000
c04500e0 63076025 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 63076043 C Ci:001:00 0 4 = 01010000
c04500e0 63076088 S Co:001:00 s 23 03 0004 0001 0000 0
c04500e0 63172013 C Co:001:00 0 0
c04500e0 63228024 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 63228042 C Ci:001:00 0 4 = 03010000
c04500e0 63284035 S Co:001:00 s 23 01 0014 0001 0000 0
c04500e0 63284052 C Co:001:00 0 0
c04500e0 63456779 S Ci:000:00 s 80 06 0100 0000 0040 64 <
c04500e0 63457301 C Ci:000:00 0 18 = 12010002 00000040 81075051 20000102 0301
c04500e0 63457338 S Co:001:00 s 23 03 0004 0001 0000 0
c04500e0 63552013 C Co:001:00 0 0
c04500e0 63608025 S Ci:001:00 s a3 00 0000 0001 0004 4 <
c04500e0 63608043 C Ci:001:00 0 4 = 03010000
c04500e0 63664025 S Co:001:00 s 23 01 0014 0001 0000 0
c04500e0 63664042 C Co:001:00 0 0
c04500e0 63664055 S Co:000:00 s 00 05 0002 0000 0000 0
c04500e0 63664590 C Co:000:00 0 0

/* GET_DESCRIPTOR DEVICE 0x12 bytes */
c04500e0 63680039 S Ci:002:00 s 80 06 0100 0000 0012 18 <
c04500e0 63680781 C Ci:002:00 0 18 = 12010002 00000040 81075051 20000102 0301

/* GET_DESCRIPTOR CONFIGURATION 0x09 bytes */
c04500e0 63680825 S Ci:002:00 s 80 06 0200 0000 0009 9 <
c04500e0 63681795 C Ci:002:00 0 9 = 09022000 01010080 32

/* GET_DESCRIPTOR CONFIGURATION 0x20 bytes */
c04500e0 63681832 S Ci:002:00 s 80 06 0200 0000 0020 32 <
c04500e0 63682820 C Ci:002:00 0 32 = 09022000 01010080 32090400 00020806 
50000705 81024000 00070501 02400000

/* GET_DESCRIPTOR STRING 0xff bytes */
c0450140 63682877 S Ci:002:00 s 80 06 0300 0000 00ff 255 <
c0450140 68680032 C Ci:002:00 -104 0
/* GET_DESCRIPTOR STRING 0x02 bytes */
c0450140 68680075 S Ci:002:00 s 80 06 0300 0000 0002 2 <
c0450140 73680032 C Ci:002:00 -104 0
/* GET_DESCRIPTOR STRING 0xff bytes */
c0450140 73725213 S Ci:002:00 s 80 06 0300 0000 00ff 255 <
c0450140 78724036 C Ci:002:00 -104 0
/* GET_DESCRIPTOR STRING 0x02 bytes */
c0450140 78724141 S Ci:002:00 s 80 06 0300 0000 0002 2 <
c0450140 83724019 C Ci:002:00 -104 0
/* GET_DESCRIPTOR STRING 0xff bytes */
c0450140 83769592 S Ci:002:00 s 80 06 0300 0000 00ff 255 <
c0450140 88768017 C Ci:002:00 -104 0
/* GET_DESCRIPTOR STRING 0x02 bytes */
c0450140 88768053 S Ci:002:00 s 80 06 0300 0000 0002 2 <
c0450140 93768016 C Ci:002:00 -104 0

/* SET_CONFIGURATION 1 */
c0450140 93814145 S Co:002:00 s 00 09 0001 0000 0000 0
c0450140 98812017 C Co:002:00 -104 0

As you can see, the devices sends its device and configuration descriptors, 
but something goes wrong with the string descriptors. I modified the core USB 
code to request 0x40 bytes (which is the value of bMaxPacketSize0) or even 
0x20 bytes, but the same problem occurs (same USBMon traces with 0xff 
replaced by 0x40).

Could you help me ? Kernel coding is not a problem, so I can make experiments 
if you point me to some direction. I'm also quite familiar with the USB specs 
down to the various types of transfers (control, interrupt, bulk and 
isochronous) but not with the lower-level protocol (frames, tokens, ...). I 
can learn if needed.

Laurent Pinchart
