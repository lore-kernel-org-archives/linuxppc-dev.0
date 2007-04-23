Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s1.bay0.hotmail.com (bay0-omc2-s1.bay0.hotmail.com
	[65.54.246.137]) by ozlabs.org (Postfix) with ESMTP id 405C1DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 03:54:57 +1000 (EST)
Message-ID: <BAY138-F20D541A0AE13B29D4FD145B24B0@phx.gbl>
In-Reply-To: <20070423030204.GB28805@lixom.net>
From: "Ming Liu" <eemingliu@hotmail.com>
To: olof@lixom.net
Subject: Re: where is the sk_buff allocation
Date: Mon, 23 Apr 2007 17:54:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Olof,
Thanks for your information first.

In fact, my aim is to avoid frequent copying between socket_buffer and my 
reserved memory block. So my idea is to just modify the protocal stack and 
allocate the socket buffer into my reserved memory space which is also 
accessible accessible for user application program, although perhaps it is 
not safe to do that. 

BTW, do you know in which specific file is the socket buffer allocated? 

BR
Ming


>From: olof@lixom.net (Olof Johansson)
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: where is the sk_buff allocation
>Date: Sun, 22 Apr 2007 22:02:04 -0500
>
>On Sun, Apr 22, 2007 at 06:14:18PM +0000, Ming Liu wrote:
> > Dear all,
> > I am reading and understanding the Xilinx Temac device driver. I know 
that
> > hard_start_xmit() is used to transmit the packets. In this function, a
> > pointer skb which points to a sk_buff needs to be passed to show the
> > location of the socket buffer. But where is that sk_buff allocation
> > sentence, and how its address (skb) is passed to the hard_start_xmit()
> > function? I want to change the address of the sk_buff in my system and 
try
> > to fit this socket buffer in a pre-defined location.
>
>The sk_buff is allocated by the network stack and passed down to the
>driver.  If you need the buffer to be located in a specific location
>before transmitting it, then you'll have to copy it there by hand.
>
>
>-Olof

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
