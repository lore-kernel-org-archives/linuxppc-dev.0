Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2FBF9DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 12:43:00 +1000 (EST)
Date: Sun, 22 Apr 2007 22:02:04 -0500
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: where is the sk_buff allocation
Message-ID: <20070423030204.GB28805@lixom.net>
References: <BAY138-F10BA8CB23D5BDA5802D8F3B2540@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY138-F10BA8CB23D5BDA5802D8F3B2540@phx.gbl>
From: olof@lixom.net (Olof Johansson)
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

On Sun, Apr 22, 2007 at 06:14:18PM +0000, Ming Liu wrote:
> Dear all,
> I am reading and understanding the Xilinx Temac device driver. I know that 
> hard_start_xmit() is used to transmit the packets. In this function, a 
> pointer skb which points to a sk_buff needs to be passed to show the 
> location of the socket buffer. But where is that sk_buff allocation 
> sentence, and how its address (skb) is passed to the hard_start_xmit() 
> function? I want to change the address of the sk_buff in my system and try 
> to fit this socket buffer in a pre-defined location.

The sk_buff is allocated by the network stack and passed down to the
driver.  If you need the buffer to be located in a specific location
before transmitting it, then you'll have to copy it there by hand.


-Olof
