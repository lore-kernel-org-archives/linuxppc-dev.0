Message-ID: <39C081DC.FEB15486@vas-gmbh.de>
Date: Thu, 14 Sep 2000 09:44:28 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Programming Flash
References: <A3E34B558F5CD211B4980008C7A4A99002423F1B@sparrow.eng.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

"Banks, Kelly" wrote:
>
> There isn't necessarily ANY onboard code required to program FLASH, other
> than the BDM/JTAG drivers onchip directly from Motorola.
>
> The basics of FLASH programming consists of writing command words into
> command addresses and then writing the data into the desired address
> (re:AMD's Am29DL16xC pub#21553 Rev. C 08/23/99)...  I don't see why one
> couldn't use MaCraigor's scripting language within the BDM Commander to
> carry out the entire operation THROUGH the BDM/JTAG keeping all the logic
> over on the host with no bootstrap code & no secondary ports required (Of
> Course, the specifics of your FLASH device may vary).
>
> Kelly

It's indeed possible to program FLASH without any code onboard, just with script
commands. I first used this way to program FLASH (AM29LV160DB) with the MPCBDM
via gdb script. I don't know how the Macraigor communicates while accessing
memory, but I guess this will be real slow. Because you have to access each word
of memory more than once, just for the programming, not included the
communication. So I tried a middle way: I have a gdb script which uses MPCBDM
target commands to setup the board, so that it's possible to execute code in
SDRAM. If I need to program FLASH, I execute another MPCBDM target command,
which downloads a fast FLASHing routine into the MPC controlled SDRAM and let
the MPC doing the FLASH programming itself. That's pretty fast. It's not
programmed nice, but it works fine for me. See
http://www.vas-gmbh.de/software/mpcbdm

hth
  Frank

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
