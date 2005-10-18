Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21746685E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Oct 2005 18:49:17 +1000 (EST)
Message-ID: <4354B707.6060002@iki.fi>
Date: Tue, 18 Oct 2005 10:49:11 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: "David H. Lynch Jr" <dhlii@comcast.net>
References: <4354AC78.5080206@comcast.net>
In-Reply-To: <4354AC78.5080206@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Need help Understanding initial memory conditions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr wrote:

>    What exactly is the minimal startup system state the Linux 2.6.13 
> Kernel expects ?

It's pretty hard to describe the system state fully, as there are so 
many registers it may depend on. However, I can point out a few things 
from your setup:

1. Put RAM to 0x0000000 and flash to some location it mirrors to your 
boot vector. Linux always expects your physical memory to be at zero. It 
is then mapped to virtual address 0xC0000000.

2. You don't need to have MMU enabled.

3. Make sure your boot arguments are passed properly to the kernel. This 
includes the settings in registers r3 ... r7 and the bd_info structure . 
There are many variants of that structure, make sure you use the same 
ones in the boot loader and in Linux.
