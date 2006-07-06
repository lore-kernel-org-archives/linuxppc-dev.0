Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id CB261679FD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 02:06:30 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id C4E848069786
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 11:34:29 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19837-01 for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 11:34:28 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id C6B248069788
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 11:34:27 -0400 (EDT)
Subject: RE: rs232 endianness on PPC
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <200607021210.19130.antonio.dibacco@aruba.it>
References: <200607021210.19130.antonio.dibacco@aruba.it>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 11:31:36 -0400
Message-Id: <1152199896.17767.12.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 2006-07-02 at 12:10 +0200, Antonio Di Bacco wrote:
> PowerPC is neither byte swapped nor bit swapped.
> When transmitting on a network card the most significant byte is transmitted 
> first, and, inside the byte, the most significant bit is sent first.

FYI, the *bit*-order on a network actually depends on the layer 2
network standard that you happen to be communicating over.  Ethernet /
IEEE 802.3 is *least significant* bit first on the wire.  SLIP and
asynchronous PPP (since they go over RS232) are also least-significant
bit first.  IBM Token-Ring / IEEE 802.5 was most-significant bit first
on the wire.

IETF protocols such as IP, TCP, UDP, etc., etc., etc., only specify the
*byte* order, which is most-significant *byte* first.

Generally speaking, a network device driver programmer need only worry
about getting the *byte* order correct.  The network interface hardware
generally takes care of the *bit* order.  (An exception to this can be
drivers and interface hardware for some low-speed "networks" such as I2C
or Dallas 1-Wire.  These may be very primitive and require software
"bit-banging" where the driver software must explicitly shift bits out
of a byte and transmit them one bit at a time.  Clearly in these cases,
the driver must transmit the bits in the correct order based on the
appropriate standard (e.g. I2C, Dallas 1-Wire, etc.).)



Cheers,

Walt Wimer
TimeSys Corporation
