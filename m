Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 7EEEB67B98
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 12:34:57 +1000 (EST)
In-Reply-To: <BAY121-F225DA006048FC317F8E97BDB300@phx.gbl>
References: <BAY121-F225DA006048FC317F8E97BDB300@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64398AF8-B8B0-4FA4-8205-C5A8A00E1E49@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: On the transfer of data from the uart.c driver to the tty layer...
Date: Tue, 5 Sep 2006 22:28:15 -0400
To: "Alejandro C" <alexfestss@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2006, at 10:56 AM, Alejandro C wrote:

> I'm working on a the uart.c driver to add support for SCCs in HDLC  
> mode.

Write a driver that does HDLC, please don't "update"
(complicate) the existing uart.c driver by adding
these features.  The uart.c is a UART driver, not
an SCC driver to be modified to your wishes.
Add another, configurable driver to do this.

> I've come across is that the receive buffer in the struct  
> tty_struct, where
> the tty layer collects the data from the driver
> (tty_struct.tty_flip_buffer.char_buf), is only 1024 bytes

Write a driver specific to your requirements that
has the proper sized buffers and management.

> (2*TTY_FLIPBUF_SIZE). The easiest at this stage would be to make those
> buffers larger, but I don't know what sort of impact this might  
> have... Any
> tips?

Yes, don't do this.  Those buffers are allocated from
a fairly small pool specific to the needs of the uart
driver.  Making these larger may quickly cause the
CPM drivers to run out of space.

> Any ideas on how to solve it in another fashion?

Write a driver specific to your requirements with the
proper buffer management for these sizes.

Thanks.

	-- Dan
