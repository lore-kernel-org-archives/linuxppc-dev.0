Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D8C681B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 00:14:42 +1100 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k17DETfA029714
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Feb 2006 14:14:29 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Mike Rapoport <mike@compulab.co.il>
Subject: Re: CPM2 USB driver & MPC8248
Date: Tue, 7 Feb 2006 14:14:28 +0100
References: <200602031210.12603.laurent.pinchart@tbox.biz>
	<43E5BAE8.9000507@compulab.co.il>
In-Reply-To: <43E5BAE8.9000507@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602071414.28551.laurent.pinchart@tbox.biz>
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

> >When I connect a USB 2.0 Mass Storage device, initialization fails when
> > trying to fetch the string descriptors. Here's what USBMon produces (I
> > decoded the USB transactions with the device).
>
> [snip]
>
> I had similar problems with mass storage devices (disk-on-key). I've
> tried to find out what was causing them but I hadn't much success with it.
> I think that problem might be in driver performance because it is very
> far from optimal.

How is the driver development going ? You're not using the sourceforge CVS/SVN 
repository, is there another one somewhere (maybe a git tree) ? Are you 
actively working on performance issues, or is the development currently 
stalled ? What are the major performance issues ? I noticed that the driver 
uses the MPC82xx packet level interface. Why don't you use the transaction 
level interface ?

> Another thing that may cause problems is how storage devices treat SOF
> packets, but I'm not USB expert enough to be sure about that.

That might explain why some devices don't even respond to the first request. I 
noticed that, on my EP8248 board, the controller only sends 990 SOF packets 
per second (or rather 990 SOF interrupts are generated). I might have a time 
base problem somewhere, as I computed the number of interrupts per second 
with a simple

cat /proc/driver/m8xxhci_privateh > sof.1 && sleep 300 && 
cat /proc/driver/m8xxhci_privateh > sof.2

Do you have the same problem ? I'll see if I can get my hands on a USB 
protocol analyzer.

Laurent Pinchart
