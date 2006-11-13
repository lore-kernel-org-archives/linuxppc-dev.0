Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 2481267DC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 04:01:18 +1100 (EST)
In-Reply-To: <200611131656.23580.laurent.pinchart@tbox.biz>
References: <200611131656.23580.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: CPM_UART: tcdrain() is broken
Date: Mon, 13 Nov 2006 11:54:36 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
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


On Nov 13, 2006, at 10:56 AM, Laurent Pinchart wrote:

> There is, however, a problem left. The SCC controllers have a 32- 
> byte FIFO
> between the buffer descriptors and the wires. cpm_uart_tx_empty()  
> checks if
> all buffer descriptors have been processed, but doesn't check if  
> the transmit
> FIFO is actually empty.

There is no way to determine if the hardware FIFO is empty.
It's buried under the CPM microcode.

> .....  I can't figure out how to do so from the datasheet.
> Does anyone have an idea ?

The original versions of the SCC UART driver used to have a
timeout based on the maximum depth of this FIFO and baud rate.
After the last BD was empty, it would further wait this amount of
time.  Lots of these little details seem to have been lost over
the years of making a "better" driver :-)


	-- Dan
