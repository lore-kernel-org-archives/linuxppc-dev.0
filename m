To: "Prabhakar Kalasani" <kalasani@sena.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA modem card is not responding 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Feb 2004 14:16:16 +0900."
             <NCEHKHHDAHEBBGFMCFHCEEHPCAAA.kalasani@sena.com>
Date: Mon, 09 Feb 2004 18:45:19 +0100
Message-Id: <20040209174524.D024CC108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NCEHKHHDAHEBBGFMCFHCEEHPCAAA.kalasani@sena.com> you wrote:
>
> I'm working with MPC855T Processor based target board, I'm trying to support
> 3CXM556 Megahertz Cellular Modem PC Card , I could able to detetect the card
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
