Message-Id: <200002010753.IAA28148@denx.local.net>
To: Ruedi.Hofer@ascom.ch
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RomFS
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Feb 2000 07:55:45 +0100."
             <0FP80082UOL8BN@pmdf-it.hasler.ascom.ch>
Date: Tue, 01 Feb 2000 08:53:42 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0FP80082UOL8BN@pmdf-it.hasler.ascom.ch> you write:
>
> I think i've seen a posting before by a guy alex@signum.se who has written
> a flash file system, you might be able to steal some code from him.
> Search the linuxppc-dev and linuxppc-embedded lists.

Right, but he told me that he does not  maintain  this  code,  and  I
found  several  problems  with it. I fixed those for the systems I am
using (TQM8xxL modules). I  have  both  character  device  and  block
device  drivers  for  the FLASH memory on these systems. It works for
me, YMMV.

If my time permits I am willing to help if anybody is going  to  test
this  code  on  other  systems  as well - it will need a bit of work,
though.

You can find my current code as oatch  against  the  original  2.2.13
kernel  in  the  files  FLASH.patch  (for  the  character device) and
FTL.patch (for the block device) which are included in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz

Not however, that this block device driver  re-uses  the  FTL  (Flash
Translation Layer) code from the PC-Card (PCMCIA) implementation. You
can  use  the charatcer device driver to put a new raw file (with any
filesystem image you like in it) into FLASH memory, but the FTL  code
is  probably  too difficult to include into 8xxrom - and you need it,
since it uses specal formatting of the erase  regions  used  for  the
block device.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Contrary to popular belief, thinking does not cause brain damage.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
