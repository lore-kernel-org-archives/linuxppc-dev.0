Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Prabhakar Kalasani" <kalasani@sena.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PCMCIA modem card is not responding 
Date: Tue, 10 Feb 2004 13:47:21 +0900
Message-ID: <NCEHKHHDAHEBBGFMCFHCMEJBCAAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040209174524.D024CC108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

We have got the kernel from MontaVista (linux-2.4.2_hhl20) , I think it
might be a modified kernel source.
I could run some other card called "Billiontin 56 KBPS FAX/MODEM card" for
same kernel and same Target board.
I'm getting problem with this specific card(3CXM556 Megahertz Cellular Modem
PC Card) only.
My card is detected by the kernel and kernel could assign irq 9. The problem
is when I send modem string through Minicom it's not responging.

what could be the problem ?

Best regards,
Prabhakar

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Tuesday, February 10, 2004 2:45 AM
To: Prabhakar Kalasani
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA modem card is not responding



In message <NCEHKHHDAHEBBGFMCFHCEEHPCAAA.kalasani@sena.com> you wrote:
>
> I'm working with MPC855T Processor based target board, I'm trying to
support
> 3CXM556 Megahertz Cellular Modem PC Card , I could able to detetect the
card
> like...
...
> But I couldn't communicate with the card, If i send Modem string from
> Minicom I'm not getting any responce from the target , Do i need to change
> anything related to MPC855T .

This will not work with unmodified kernel sources; for the modem  you
need  the standard serial driver which cannot coexist with the MPC8xx
serial driver (they use the same major numbers).

We implemented this some time ago; see the linux-2.4  module  on  our
CVS server and search "drivers/char/serial.c" for "MPC8xx_UART".

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Inside every old person is a young person wondering what happened.
                              - Terry Pratchett, _Moving Pictures_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
