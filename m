To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem Programming Flash using BDI2000 on MPC8260ADS board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 15 Aug 2003 09:59:30 BST."
             <DEF39A0710293E489D45B10E06645CBD021EA386@dub-msx1.spectelcorp.com>
Date: Fri, 15 Aug 2003 19:17:01 +0200
Message-Id: <20030815171706.1B0BDC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD021EA386@dub-msx1.spectelcorp.com> you wrote:
>
> ### Problem #1
> Again after erasing the whole flash, the prog command (see below) shows
> progress and returns a valid response

This doesn't sound like a problem to me :-)

> BDI>prog 0xff800000 u-boot.srec SREC
> Programming u-boot.srec , please wait ....
> Programming flash passed
>
> however, when reading back the flash the contents of the flash still
> display all FF's

Note that the "prog" command does not list a  load  address,  but  an
OFFSET.  The  u-boot.srec file already contains a load address, which
matches the TEXT_BASE defined in your board/*/config.mk file - if you
add a offset of  0xff800000  you  are  programming  the  image  to  a
different location than you expect.

Also, I don;t think that 0xff800000 is where you  want  to  burn  the
image  to.  For the MPC8260ADS board, TEXT_BASE is set to 0xFFF00000,
so this is what you should try.

Finally, it makes little sense to waste your  time  with  a  S-Record
file - programming a binary image will be much faster.

So try:

	prog 0xFFF00000 u-boot.bin BIN

[untested, as I don't have such a board]


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'm a programmer: I don't buy software, I write it.
                                                  -- Tom Christiansen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
