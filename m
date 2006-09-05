Return-Path: <alexfestss@hotmail.com>
Received: from bay0-omc1-s39.bay0.hotmail.com (bay0-omc1-s39.bay0.hotmail.com
	[65.54.246.111]) by ozlabs.org (Postfix) with ESMTP id 76E1A67B78
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 01:08:35 +1000 (EST)
Message-ID: <BAY121-F225DA006048FC317F8E97BDB300@phx.gbl>
From: "Alejandro C" <alexfestss@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: On the transfer of data from the uart.c driver to the tty layer...
Date: Tue, 05 Sep 2006 14:56:28 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm working on a the uart.c driver to add support for SCCs in HDLC mode. The 
application I'm going to run on top will be sending Ethernet packets 
encapsulated in the data field of an HDLC frame. The idea was to make the 
buffer big enough so that a whole Eth. packet (max 1518 octects) could fit 
in just one buffer. I let the CPM interrupt on a frame basis and the problem 
I've come across is that the receive buffer in the struct tty_struct, where 
the tty layer collects the data from the driver 
(tty_struct.tty_flip_buffer.char_buf), is only 1024 bytes 
(2*TTY_FLIPBUF_SIZE). The easiest at this stage would be to make those 
buffers larger, but I don't know what sort of impact this might have... Any 
tips?
Any ideas on how to solve it in another fashion?

Help will be highly appreciated.

Regards,

Alejandro

_________________________________________________________________
Acepta el reto MSN Premium: Correos más divertidos con fotos y textos 
increíbles en MSN Premium. Descárgalo y pruébalo 2 meses gratis. 
http://join.msn.com?XAPID=1697&DI=1055&HL=Footer_mailsenviados_correosmasdivertidos
