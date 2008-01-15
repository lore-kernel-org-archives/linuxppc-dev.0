Return-Path: <tlopez@aotek.es>
Received: from smtp-out2b.sarenet.es (smtp-out2b.sarenet.es [194.30.0.43])
	by ozlabs.org (Postfix) with ESMTP id 8F9C7DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 04:07:29 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp-out2b.sarenet.es (Postfix) with ESMTP id 77C624B385
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 17:42:15 +0100 (CET)
Message-ID: <478CE2DC.5040309@aotek.es>
Date: Tue, 15 Jan 2008 17:44:12 +0100
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200B SPI codec error when there is a heavy ethernet traffic. 
Content-Type: multipart/mixed;
	boundary=------------040700080907070409070301
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040700080907070409070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

We have a MPC5200B based custom board running a 2.4.25 Denx linux 
kernel. We use the PSC6 in SPI-codec mode to exchange some bytes 
periodically in full-duplex with a peripheral.

In 'normal' conditions this communication runs fine. But when we start 
sending packets over the Ethernet as a background activity, we see on 
the oscilloscope that one of the SPI transfers is interrupted. Not only 
that the SPI clock stops, something that could happen in the case that 
the transmission Fifo is empty, or the reception Fifo is full, but that 
the chip select actually goes high for an instant, causing the 
peripheral to abort the communication.

We have reproduced the same bug in a Lite5200B using the spi-dev driver 
and a user application, so it seams it's not a problem of our hardware.

The problem only arises if there is some heavy Ethernet traffic (a big 
file ftp transfer or a big file copy by nfs) , so we think  the error is 
related with the Bestcomm activity. We have contacted freescale to check 
if it's a microprocessor bug and they are looking into it. But we think 
it could be also a bug in the Bestcomm programming of the FEC tasks. 
Could be it possible? At this point, we really need some help. Any clue 
will be welcomed.


Best regards,

Txema








--------------040700080907070409070301
Content-Type: text/x-vcard; charset=utf-8;
 name="tlopez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tlopez.vcf"

begin:vcard
fn:Jose Maria Lopez
n:Lopez;Jose Maria
org:Fagor Automation S. Coop.
adr:;;San Andres 19. Apdo. 144;Arrasate-Mondragon;;20500;Spain
email;internet:tlopez@aotek.es
title:Sotware engineer
tel;work:(34) 943719200
tel;fax:(34) 943791712 
x-mozilla-html:FALSE
url:http://www.fagorautomation.es
version:2.1
end:vcard


--------------040700080907070409070301--
