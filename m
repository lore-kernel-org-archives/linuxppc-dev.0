Message-ID: <3972D5F0.617E9E6F@pop.agri.ch>
Date: Mon, 17 Jul 2000 11:46:25 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Alain RICHARD <alain.richard@equation.fr>
CC: Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MacSerial and Serial driver cohabitation
References: <Pine.GSO.4.10.10007150057110.4812-100000@unix1.wm.edu>
	 <20000715082955.6590@192.168.1.10> <p04320400b59877f5cc70@[192.168.240.10]>
Content-Type: multipart/mixed;
 boundary="------------33C9223FC6A030020F14F963"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------33C9223FC6A030020F14F963
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alain RICHARD wrote:
> There is a long waiting problem in making the two serial drivers
> (legacy serial driver named serial.o and macintosh serial driver
> named macserial.o). The problem is that the two drivers thinks there
> are the legacy one and numbers each serial port found from ttyS0 to
> ttySn. So if you try to load them simultaneously, you'll get a kernel
> fault.
>
> There are several workarounds, either :
>
> - compiles only macserial and disable legacy serial.
> - compiles the two drivers as modules and load only one (by adding
> "alias char-major-4 macserial" and "alias char-major-5 macserial" in
> your /etc/conf.modules file).

I do it this way, the macserial is built in, the serial as a module.
When you do build the serial into the kernel you get a build error:

multiple definition of `serial_console_init'


>
> This is just a hack, but the problem is worst : macserial is a serial
> driver for Z8530 chipsets and serial is a serial driver for 16x50
> UARTs. There are several cases where you may need the two drivers :
>
> a) in a powerbook when using a pcmcia modem : most, if not all, modem
> cards are based on a 16x50 UART and do need the serial.o driver.
> b) most PCI serial cards are using 16x50 UARTs
>
> Powerbooks kernels compiled by Paul Mackerras have a quick fix in the
> serial driver in order to make it skip the first 2 ttyS entries when
> compiled on PMAC architecture. This fix works but was never included
> in the main kernel because it is just a simple hack.

It's not only the skipping, there is some more needed. When you build the serial
and start the kernel then it panics since the autoconfig in serial.c is not
working on PPC.

Attached my suggestion. Here it works on a wallstreet I, which has 2 heathrow's,
that's why the offset is 4 and not 2 as mentioned above.

Andreas
--------------33C9223FC6A030020F14F963
Content-Type: application/x-gzip;
 name="cb-serial2217.patch.gz"
Content-Disposition: inline;
 filename="cb-serial2217.patch.gz"
Content-Transfer-Encoding: base64

H4sICBh1cTkAA2NiLXNlcmlhbDIyMTcucGF0Y2gAnVVtc+I2EP4Mv2InN8kANmAbwqWhd5OU
kA53F0gNd03mmtEYW4AaR6KynAnt3H/vSjINCSR3Uz5YtvZ5tKtnX6jX65Aynj80E8nuqcya
8SKSzYxKFqWNuCEkm5fGOYeLaAWBD15w7PnHQRsCz/PKjuO8xjbED3kKfgd877h1dNwKLPHk
BOr+oed2wNGLH8DJSRneMB6neULh5yi7a06ZEsussXj/3FAcrw1l5w2bJXQGvdHwfPAruTjt
kXE/HJx+QgvuM07BfpOz/hcyOj8f9yelNhppmtHXMJ7G8ITNyo72b5wUqMHw02DYx92CXGwQ
YBzFoGiwRH3Jlt/y3Lfg4NrBVd+yZOMnVrKGXQiP7ii8gz1r3Otu4dYApVbjHea76E8h0T6Z
XKMKH0Zht1x/DmFcSJKpSCoEdtrdsvMdBDjbyuyILL9D9DAkl6NwMt62q9WSFpGdhYMv/ZBM
ri/7RZ624Vk+LRiFb4MejsILjbai/tR2fR9VxWJy/baVtYRxK1p/z2KRc9WYSSvY091lJJla
4bbX3aYIdC+xZJ+TpvJ2iyH/wi18kjjiXHAWRyn7m1YezdWuKU6+UZ2Xl71SswZXV1dQa+rD
2Awq8YLGt0TSORN8TV8KqdyjalVjSrHgCnuMdteMAjRLo3kGB3A6vh72yC+j0YScfp6MtC9L
jHIlkDxjc0sxEdnShNK370bXrOEDanBGFY0VqAWFQfgbCJ6u8BFToCjXCnSswDIsfqYwiyyj
iWuJUxpHeUYhE5gIv9M+9CARwIUCSTOKJwrwzLEXvRC0AJnC9NsMB35HD4dWEByu26YE9rep
ETzq7W5AcixgYq/+tUDokroxTVTtFtdfSyGpyiU3+f2GI8X67xy5QaADeGtenlaYSX5idCHG
F+78pzEgcikZV7eVj/1wiNPhfGTadt8LEogUeA/7XvsBKvaY/aSq5YtgP/uD77nYtU/vqUeK
+/KlnR3wXW37yhHwo7LV11Jt+NJDZHv3hcGh5YV7wRLI+TrhxHZ/BQXT/yUUa/cfDCnnGZtz
mkAq+BxMrZuJpmSOxVhMDOMRanZ5BwcyIyqapvSrPujGzLcfx++K+camM4vuKTExVMzTlFCc
sop52ehJxmcCDg5g4xM1VCvTkLiSRcTn+bKyZTdj8FFyDE4PU/J5+HE4+n2ob/5ySeU8FVFC
E10+m0nQ/f4/aLt0MPFh1yoht4TQSf0XcnJwxUcIAAA=
--------------33C9223FC6A030020F14F963--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
