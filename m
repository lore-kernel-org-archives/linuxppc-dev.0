To: bhavin <bhavinp@einfochips.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with PM826 card 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Sep 2003 10:25:47 +0530."
             <3F56C5D3.9080202@einfochips.com>
Date: Thu, 04 Sep 2003 14:40:06 +0200
Message-Id: <20030904124011.4A3ADC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bhavin,

in message <3F56C5D3.9080202@einfochips.com> you wrote:
>
>     I am using a PM826 card with our own developed carrier extension
> board. I have build the ppcboot image. I am booting the image from flash

Please upgrade. PPCBoot is pretty old, and  a  lot  of  modifications
have been added lately. Please use a recent version of U-Boot instead
(0.4.7).

> and through serial communication SCC and I have configured the correct
> serial channel number from our card's schematics. Now, the ppcboot works
> but, when I try to write something in flash through ppcboot (either
> 'loadb' command or 'nm' command) the flash contents are not getting

Neither the "loadb" nor "nm" commands can operate directly  on  flash
memory.  please  download to RAM (or modify the RAM contents) and use
the "cp" command to write to flash.

> changed. All other functionality of ppcboot works like erase, read, etc.
> but all the functionality related to 'write to flash' is not working.

I think all these things are working fine, you are  just  using  them
wrong.

> Can any one please suggest me what could be the possible reason??

Read the documentation; see
http://www.denx.de/twiki/bin/view/DULG/Manual

> Also, I have one separate program which, I downloaded from somewhere
> which does some read/write operation to the PM826 card's flash. Through
> that program the writing is working perfect.

It's working perfectly in PPCBoot and U-Boot, too. Just remember that
the  command  to  write  to  flash  is  "cp"   (and   it's   variants
"cp.{l|w|b}").

> Has it something to do with ppcboot configuration or the addressing mode?

No, it is a user error.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Software suppliers are trying to make their  software  packages  more
``user-friendly''.  .  .  .  Their best approach, so far, has been to
take all the old brochures, and stamp the words, ``user-friendly'' on
the cover.                                               - Bill Gates

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
