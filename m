Date: Mon, 28 Jul 2003 22:13:44 +0200
From: Adam Kaczynski <kaczor@dgt-lab.com.pl>
Subject: Re: m8260_cpm_dpfree( )
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: Sanjay Kumar <skumar@giga-stream.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F2583F8.9060300@dgt-lab.com.pl>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
References: <FKEJLMJFECLAHOKCGJFPKEFGCBAA.skumar@giga-stream.de>
 <1059403782.2835.193.camel@zambia.cambridgebroadband.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Zeffertt wrote:
> Sanjay,
>>1. where can I get m8260_cpm_dpfree() function implementation ?
> You could try porting the dpfree function in
> arch/ppc/8xx_io/commproc.c.  However, this function should only really
> be necessary if you wish to rmmod the driver.
>

I had the same problem last year when I was working with the simple ATM
driver
(http://www.dgt-lab.com.pl/Serwis/ATMdrv8260.tar.gz )
and I decided to make a kind of not very nice looking work-around -
simply to grab and later free the block of memory I needed from the top.

This feature was important for us to debug the driver since I was able
to load, test and later rmmod the driver. However this work-around would
work only if the driver is loaded as the last one (from the drivers
using dp_mem).

I think that there is no reason to implement any more robust allocator
for dp memory since it is used only for very special purposes, allocated
  only during drivers initialization and because this resource is so
limited that any normal allocation mechanism (with a pool of memory
blocks) would be inefficient.

Regards,
Adam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
