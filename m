Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 5435EB7139
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2011 02:04:25 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 05889-02 for <linuxppc-dev@ozlabs.org>;
	Tue, 25 Jan 2011 15:04:21 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: FSL DMA engine transfer to PCI memory
Date: Tue, 25 Jan 2011 15:02:12 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC28@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> memcpy_toio() works fine, the data is written correctly. After
> DMA, the correct data appears at offsets 0xC, 0x1C, 0x2C, etc.
> of the destination buffer. I have 12 bytes of junk, 4 bytes of
> correct data, then again 12 bytes of junk and so on.

Does your Avalon MM slave decode the 4 byte enables?
The slave always sees 2 Avalon MM writes, one of which
will have no byte enables asserted.

(Actually it is a 64bit Avalon transfer - and a bus width adapter
gets inserted for you.)

Internal M9K memory blocks get this right...

	David
