To: "Etienne van der Linde" <evdl@ananzi.co.za>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel oops, sig: 7 at last init / modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Mar 2004 19:33:44 +0200."
             <web-18194238@mail01.ananzi.co.za>
Date: Wed, 10 Mar 2004 18:55:04 +0100
Message-Id: <20040310175509.77D5FC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Etienne,

in message <web-18194238@mail01.ananzi.co.za> you wrote:
>
> We are using an MPC8260 on a custom board with 16MB RAM,
> 16MB FLASH, DS1558W RTC, LAN83C183 PHY etc. I use Denx's
> U-Boot 0.4.0 for the boot loader, and then their PPC82xx
> embedded linux from their ELDK.

You should use a more recent version of both the U-Boot  sources  and
especially the Linux kernel.

> For me it seems that the problem comes from executing a
> module on the file system (either on NFS or Ramdisk).

Normally no modules are used at all.

> Caused by (from SRR1=49030): Transfer error ack signal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Check this!

> Call backtrace:
> C00401C8 C0033434 C0003B7C 00000000 0FF1A05C 0FF4FBF8
> 0FF4EA04
> 0FF4F858 0FF4C4C8 0FF85B60 0FF85998 10015108 0FEE67B8
> 0FECFF74

Decode the backtrace (see ftp://ftp.denx.de/pub/tools/backtrace)

> Furthermore, if I cross-compile my own simple program (that
> opens devices etc) I am able to run it flawlessly for a
> long time by passing an init=/tmp/myprogram argument to the
> kernel - no oops generated there...?

To me it seems that you should check your memory  map.  For  example,
where  is  the  IMMR  mapped? Did you make sure to put it at a "high"
address?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Time is a drug. Too much of it kills you.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
