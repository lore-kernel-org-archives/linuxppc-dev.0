Message-Id: <5.1.0.14.2.20030220085208.02608ba8@falcon.si.com>
Date: Thu, 20 Feb 2003 08:55:00 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: RE: about filesize when copy from flash to ram
In-Reply-To: <00012747.C22236@embeddedplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are copying flash over top of your interrupt vectors, overwriting
active code and crashing your system.  Don't do that.  Getting a load into
the bottom of RAM (e.g. loading linux) is a delicate dance that u-boot does
well, so use that function.  You are not going to be able to do it with the
"cp" command.  Read the README file for a lot more information.

gvb


>From: okisoftxman [mailto:okisoftxman@hotmail.com]
>Sent: Wednesday, February 19, 2003 6:04 PM
>To: linux-emb
>Subject: about filesize when copy from flash to ram
>
>
>
>First thank you for your help.
>
>Useing my MBX860 board's u-boot,I try to copy some files from flash to
>ram.The files in this address "fe600000" in the flash.
>I find a problem when I use this command"cp.b fe000000 00000000 filesize",if
>the filesize<=900sbit(hex),the
>file can copy from flash to ram.but if the filesize>=900sbit(hex),the system
>will reset.e.g."cp.b fe000000 00000000 1000"will reset the system and fail
>to copy to ram,why?
>
>The critical value of filesize is between 900~1000,about 2Kbytes,why?
>
>Thank you
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
