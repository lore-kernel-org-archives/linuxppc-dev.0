Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CFA48B7D9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 19:54:53 +1000 (EST)
Date: Fri, 16 Apr 2010 11:25:30 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
Message-ID: <20100416092530.GA26506@iram.es>
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
	<4BC70E47.9010408@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201004151553.53426.roman.fietze@telemotive.de>
Cc: Bill Gatliff <bgat@billgatliff.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 15, 2010 at 03:53:53PM +0200, Roman Fietze wrote:
> Hello Bill,
> 
> On Thursday 15 April 2010 15:01:59 Bill Gatliff wrote:
> 
> > Are you talking about this code here?
> > 
> >     void
> >     shadowUpdatePacked (ScreenPtr pScreen,
> >                         shadowBufPtr pBuf)
> >     {
> >     ...
> >                     while (i--)
> >                         *win++ = *sha++;
> 
> Yes. I added a routine like
> 
> /* Swap frame buffer bytes in 32 bit value.  */
> static __inline unsigned int
> fbbits_swap32(unsigned int __bsx)
> {
>     return ((((__bsx) & 0xff000000) >> 8) | (((__bsx) & 0x00ff0000) << 8) |
> 	    (((__bsx) & 0x0000ff00) >> 8) | (((__bsx) & 0x000000ff) << 8));
> }

I don't see the difference with:

	return (((__bsx & 0xff00ff00)>> 8) | ((__bsx & 0x00ff00ff) << 8));

for which the compiler (GCC 4.3.2) generates better code (GCC 4.3.2) as shown.

In the first case:

.L3:
        lwzx 9,3,8
        rlwinm 0,9,8,0,7
        rlwinm 11,9,24,8,15
        rlwinm 10,9,24,24,31
        or 0,0,11
        or 0,0,10
        rlwinm 9,9,8,16,23
        or 0,0,9
        stwx 0,4,8
        addi 8,8,4
        bdnz .L3

in the second:

.L9:
        lwzx 0,3,11
        and 9,0,10
        and 0,0,8
        slwi 0,0,8
        srwi 9,9,8
        or 0,0,9
        stwx 0,4,11
        addi 11,11,4
        bdnz .L9

saving 2 instructions. AFAIR the MPC5200 is based on a 603e core, 
so the integer instructions have to go to the single integer unit that
can handle them (the second IU can only handle add and cmp), so the
mimimum is 5 clocks/iteration versus 7. Even with two IU (or 3), the 
second code has better latency.

	Gabriel
