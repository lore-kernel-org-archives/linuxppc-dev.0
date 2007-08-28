Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id 599FFDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 01:00:36 +1000 (EST)
Date: Tue, 28 Aug 2007 17:00:34 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708280650t41046711g4161cc0c5be05d16@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708281642520.4960-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

	I have did as you suggested:

1. I have started u-boot
2. I have loaded zImage.elf to the memory 0xf00000
3. I have typed: bootelf 0xf00000

Linux has hanged during uncompressing

4. I have stopped the system and reloaded u-boot to examine __log_buf
   ( address 0x20f0c4)

Unfortunately all the bytes were set just to zero.

5. I have stopped the system
6. I have downloaded via jtag the zImage.elf and started it
   the system has started properly
7. I have stopped the system and reloaded u-boot to examine the memory
8. I have typed: md 0x20f0c4 100 and it showed me the buffer:

0020f0c4: 3c353e5b 20202020 302e3030 30303030    <5>[    0.000000
0020f0d4: 5d204c69 6e757820 76657273 696f6e20    ] Linux version 
0020f0e4: 322e362e 32312d72 63362028 726f6f74    2.6.21-rc6 (root
0020f0f4: 40706335 32313529 20286763 63207665    @pc5215) (gcc ve
0020f104: 7273696f 6e20342e 302e3229 20233136    rsion 4.0.2) #16
0020f114: 204d6f6e 20417567 20323720 31323a33     Mon Aug 27 12:3
0020f124: 373a3038 20434553 54203230 30370a3c    7:08 CEST 2007.<
0020f134: 363e5b20 20202030 2e303030 3030305d    6>[    0.000000]
0020f144: 2058696c 696e7820 4d4c3430 33205265     Xilinx ML403 Re
0020f154: 66657265 6e636520 53797374 656d2028    ference System (
0020f164: 56697274 65782d34 20465829 0a3c373e    Virtex-4 FX).<7>
0020f174: 5b202020 20302e30 30303030 305d2045    [    0.000000] E
0020f184: 6e746572 696e6720 6164645f 61637469    ntering add_acti
0020f194: 76655f72 616e6765 28302c20 302c2038    ve_range(0, 0, 8
0020f1a4: 31393129 20302065 6e747269 6573206f    191) 0 entries o
0020f1b4: 66203235 36207573 65640a3c 343e5b20    f 256 used.<4>[ 
0020f1c4: 20202030 2e303030 3030305d 205a6f6e       0.000000] Zon
0020f1d4: 65205046 4e207261 6e676573 3a0a3c34    e PFN ranges:.<4

So it seams to be that the address points to the __log_buf (I hope).

Does it mean that when I try to start zImage kernel from u-boot 
it hangs during uncompressing the image and it does even start booting?

Best Regards

Mirek  


On Tue, 28 Aug 2007, Grant Likely wrote:

> On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > Hi Grant,
> >
> >         Thanks for your answer.
> > I have found in the System.map :
> > c020f0c4 b __log_buf
> >
> > Is the address c020f0c4 relative to the .data segment?
> 
> 0xc0000000 are virtual kernel addresses; not physical addresses.  If
> the MMU is still on, then you need to use the virtual address to
> examine memory.  If the MMU is off (such as after reloading u-boot),
> then you need to change 0xCxxxxxxx to 0x0xxxxxxxx.
> 
> > I understand that when the system hangs I should type in the XMD window
> > stop.
> >
> > Is there anyway to examine the memory from the XMD window? or should I
> > reload the u-boot and examine the memory from u-boot?
> 
> I don't know; I've never used XMD.  Read the XMD documentation.  You
> can do it from u-boot too.
> 
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
