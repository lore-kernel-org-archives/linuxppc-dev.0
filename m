Subject: RE: ?Loading and debugging a linux kernel on a walnut board with a BDI2000 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 3 Jul 2001 13:14:05 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C4971FEF19@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"ibm405gp" <ibm405.linux@laposte.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's not difficult to use a BDI2000 with a treeboot image on
a Walnut, if that's what you want to do.  Here are the steps:

1)  Build the image.
2)  Reset the Walnut using the BDI2000.
3)  Type "go" at the BDI2000 prompt.
4)  Type "halt" at the BDI2000 prompt.  (I'm not sure what happens
    with the code from the ROM, but you need to run it before you
    boot your image.)
5)  Load the image (BDI "LOAD" command).
6)  Type "go" at the BDI2000 prompt.

The trick is to set up your BDI2000 configuration file properly.
(Some of this I got from Abatron customer service, some of it I
worked out.)  The treeboot image file is simply the runnable image
with a 32-byte header stuck onto the front of it.  The runnable
image is loaded at 0x400000.  So you need these lines in the config
file:

FORMAT      BIN 0x3FFFE0
START       0x400000

in addition to the "FILE" line that specifies the image.  I think you
must reboot the BDI to get it to reread its config file.

If you want to stop the kernel right after it's gone into virtual
mode, you can set a hardware breakpoint at start_kernel.

  -- David Wright



> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Tuesday, July 03, 2001 10:28 AM
> To: ibm405gp
> Cc: Scott Anderson; 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Re: ?Loading and debugging a linux kernel on a walnut board
> with a BDI2000
>
>
>
> In message <3B41F1F8.C88E0460@laposte.net> you wrote:
> >
> > but the boot sequence fails, the zImage is not extracted
> > In arch/ppc/boot/tree/main.c, i put some debug printf, and i have
> > "Memcopy Done " instead of "gunzip done"
> > What means the condition "if (im[0] == 0x1f && im[1] == 0x8b) " ?
>
> Seems it checks for the magic number which  gzip  inserts  into  it's
> compressed files.
>
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> If you hear an onion ring, answer it.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
