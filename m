Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B833@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: No bash prompt
Date: Fri, 14 Apr 2000 13:01:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I finally got Linux running on my board, thanks to Wolfgang.

My problem was that I placed the internal memory map at 0x1F00000, and that
won't work.
Here is Wolfgang's explanation why:

This will not work. You will have to change your address map so IMMR
is above 0xD0000000; usually 0xFFF00000 is a good value to use.

The reason for that is that the IMMR / DPRAM area needs to be  mapped
as physical memory prior to the kernel VM initialization, the mapping
being  virtual to physical. This happens in mm/init.c for things like
the IMMR and some  other  board  control  registers.  In  this  case,
mapping  below  something  like  0xD0000000  causes  problems with VM
collision in kernel or user process space.

Thank you.

Kim Jorgensen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
