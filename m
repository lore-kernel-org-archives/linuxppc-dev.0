To: Amit.Lubovsky@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot on mbx860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Sep 2003 11:02:07 +0200."
             <AD2F581BD7340A4C908AF1AFB066EA3B0E4831@ntah901e.savan.com>
Date: Tue, 30 Sep 2003 23:46:49 +0200
Message-Id: <20030930214654.CAE32C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Amit,

in message <AD2F581BD7340A4C908AF1AFB066EA3B0E4831@ntah901e.savan.com> you wrote:
>
> I have compiled u-boot for mbx860, created uImage (using the sources from
> denx site) but have
> a problem when I try to run the uImge on the board, follows what I get:
...
> => bootm 0x20000
> ## Booting image at 00020000 ...
>    Image Name:   Linux-2.4.20
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    842305 Bytes = 822.6 kB

Compressed size is 800+ kB, so uncompressed size will be around 2+ MB.

>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... Error: inflate() returned -3

You load the image at 0x20000 = 128 kB. It will overwrite itself when
it starts to uncompress and load the kernel.

Use a higher download address, like 0x200000.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"We don't have to protect the environment -- the Second Coming is  at
hand."                                                   - James Watt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
