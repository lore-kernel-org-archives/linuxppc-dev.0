Message-Id: <4.3.2.20000428145304.04030b10@mail.munich.netsurf.de>
Date: Fri, 28 Apr 2000 15:10:19 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: the problem with kernel format
Cc: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10004281340260.13173-100000@opal.biophys.uni
 -duesseldorf.de>
References: <005201bfb0ca$c075ef20$bf0102c8@dell191.sc.mcel.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:42 28.04.00, Michael Schmitz wrote:

> > How I can translate the ELF to BIN( BDX...)????????
> > By the way, the visionPROBE provides a converter , which can
> > only translate the usual ELF to BIN(BDX).
> > But the kernel file is a compressed one(including vmlinux,bootloader,
> > and other initializing code).So the converter can't translate the
> compressed
> > one to BIN(BDX).
>
>There should be a file called 'vmlinux' in the top level directory of your
>kernel source. This is the kernel image, uncompressed, without boot loader
>or decompressor, in ELF format. Seems your converter should like that file
>better than zImage.

Yes, that should work better, the toplevel vmlinux is a pure ELF file with
debug information included. Be careful though that you need the very latest
binutils-2.9.5.0.37, a current snapshot or a cvs checkout of binutils to
generate a 100% (?) valid ELF file, a bug in this area was fixed just
recently. Otherwise the ELF converter/loader may choke on the debug
information. If you use gcc-2.95.2 (which you really should) to compile the
kernel, you can change the debug flag in the CFLAGS from -g to -gdwarf-2 to
get a lot more and very valuable debug information.

<employee hat on>
I shouldn't help you with that "tool" ;-))
<employee hat off>

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
