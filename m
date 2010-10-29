Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 652EFB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 19:54:30 +1100 (EST)
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net
	[151.189.8.34]) by mx.arcor.de (Postfix) with ESMTP id CAD43AA5BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 10:54:24 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id C5FF93663CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 10:54:24 +0200 (CEST)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net
	[151.189.8.76])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id A4F6710BDB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 10:54:24 +0200 (CEST)
Message-ID: <1490489378.1288342464651.JavaMail.ngmail@webmail18.arcor-online.net>
Date: Fri, 29 Oct 2010 10:54:24 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [MPC5200B] strange data loss on uart reception
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm not sure if this is the right list, so please excuse me if I'm totally
wrong here, or if my question is really dumb...

My platform is a MPC5200B (roughly Icecube) based board with kernel 2.6.32.
>From a PC I try to send data through the MPC5200B's serial port, using the
standard mpc52xx_uart driver.  The reading process is rather slow in
processing the incoming data.  Thus, the uart is configured to use rts/cts
 handshaking.  The port is opened in (O_EXCL | O_RDWR) mode.

Sending large data blocks to the 5200, I noticed that complete chunks of
data are missing in the output read in user space.  This is apparently *not*
a problem on the uart layer; the result of the TIOCGICOUNT ioctl does not
report any errors from the uart, and the serial_icounter_struct.rx field
contains *exactly* the correct number of data bytes I transmitted.  The
data loss seems to occur only if the block is larger than 64 kByte, but I
didn't find a scheme of the actually missing number of bytes.  However, it's
always a larger chunk of several hundred bytes to kBytes.

Am I simply too dumb to use the uart correctly, or is there some issue in
the kernel causing this effect?  I noticed that the function
mpc52xx_uart_int_rx_chars() does not check the return value of
tty_insert_flip_char().  If the system runs out of space (actually, the
maximum buffer size used should be limited, in particular on embedded
systems!), might this be undetected?  This might explain the bigger
"chunks", as the '5200's uart has a rather big fifo.

Any insight would be really appreciated!

Thanks in advance,
Albrecht.
