Message-ID: <38FB7B28.9DFFDBE1@amberdata.demon.co.uk>
Date: Mon, 17 Apr 2000 21:59:20 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: prep interrupt routing
References: <Pine.HPX.4.10.10004170952310.6016-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Fri, 14 Apr 2000, David Monro wrote:
>
[..]
> It looks like the output of my residual data dump code :-), and the first
> line shows a bug in my code (harmless, but then I had never found residual
> data which specifies that a device has no interrupt lines).

Yup; I found the commented out call to print_residual_device_info() in
prep_setup.c

>
> >
[..]
>
> Good...
>
> >
> > Of course putting all of the devices on irq 15 doesn't seem like a
> > particularly good idea. Does anybody know a) which chip is responsible
> > for the mapping and b) how to reprogram it?
>
[..]

The PCI-ISA bridge is the "IBM Fire Coral" chip - does anybody actually
have a part number for this chip so I can look it up on IBM's site?
>
> [root@vlab1 linux-test]# lspci -xxxsb.0
> 00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 04)
> [snipped]
> 40: 24 04 00 00 ef ab 78 00 f1 00 00 00 00 33 04 00
>                 ^^^^^
> Or 0xabef in right byte order: meaning routing to IRQs 10/11/14/15,
> although I don't use these any more since the board has an OpenPIC (but
> PPCBUUG disagnostics would be very upset if I changed it).
>
>         Regards,
>         Gabriel.

Output from the above command:
prozac:~# lspci -xxxsb.0
00:0b.0 ISA bridge: IBM Fire Coral (rev 02)
00: 14 10 0a 00 07 00 00 04 02 00 01 06 00 00 00 00
10: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I have no idea what any of this means :-) If I could find the IBM
datasheet I might have half a clue though.

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
