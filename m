Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED35B67B89
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 10:45:40 +1000 (EST)
Subject: Re: On the transfer of data from the uart.c driver to the tty layer...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alejandro C <alexfestss@hotmail.com>
In-Reply-To: <BAY121-F225DA006048FC317F8E97BDB300@phx.gbl>
References: <BAY121-F225DA006048FC317F8E97BDB300@phx.gbl>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 10:45:26 +1000
Message-Id: <1157503526.22705.153.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-05 at 14:56 +0000, Alejandro C wrote:
> Hi all,
> 
> I'm working on a the uart.c driver to add support for SCCs in HDLC mode. The 
> application I'm going to run on top will be sending Ethernet packets 
> encapsulated in the data field of an HDLC frame. The idea was to make the 
> buffer big enough so that a whole Eth. packet (max 1518 octects) could fit 
> in just one buffer. I let the CPM interrupt on a frame basis and the problem 
> I've come across is that the receive buffer in the struct tty_struct, where 
> the tty layer collects the data from the driver 
> (tty_struct.tty_flip_buffer.char_buf), is only 1024 bytes 
> (2*TTY_FLIPBUF_SIZE). The easiest at this stage would be to make those 
> buffers larger, but I don't know what sort of impact this might have... Any 
> tips?
> Any ideas on how to solve it in another fashion?
> 
> Help will be highly appreciated.

You should ask on the linux-kernel mailing list, possibly CC'ing Alan
Cox who seem to have put his hands a lot in the TTY code lately.

Ben.
