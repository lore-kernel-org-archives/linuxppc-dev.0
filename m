From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: kernel crashes at InstructionTLBMiss
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00Jun6.135659est.115272@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <00Jun4.144038est.115228@border.alcanet.com.au>
 <393BBE5D.49B17E9C@embeddededge.com>
Date: Tue, 6 Jun 2000 13:56:59 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Dan Malek wrote:

> > boot the target, I get the following output and nothing more.
> >
> > loaded at:     00800000 0080B1D8
> > relocated to:  00B00000 00B0B1D8
> > board data at: 00B00190 00B001B8
> > relocated to:  007F0100 007F0128
> > zimage at:     00806000 0087C6C1
> > initrd at:     0087C6C1 00A53511
> > avail ram:     00A54000 02000000
>
> There are several things to watch for.  First, I am surprised you see
> this much output.  You have obviously changed link addresses in the
> Makefile, which you shouldn't do.  Because of the early kernel
> mapping, everything should reside in the lower 8Mbytes of memory.  The
> zImage support loader (arch/ppc/mbxboot/...stuff...) should link to
> low memory, 0x00100000.  You should load the image either just above
> that, at 0x00200000 or in very high ROM addresses ( > 16 Mbyte).
>

The reason why I changed the address was because my uncompressed kernel is
about 1.3M. This means if I load at 0x100000 (the default), then the board data
gets trashed and I get nothing after the kernel has finished decompressing. I
initially moved the address to 0x200000, but then I was getting other strange
errors so I moved the whole thing higher into memory.

BTW, I found the probelm that caused the crash in InstructionTLBMiss, partly
thanks to Murray Jensen. I did not implement his patches but while reading his
email, and trying to follow it, I realised that the M_TWB was not initialised
properly in the first place! There was some code that was not suppose to be
there - probably introduced while trying to patch the file from various
sources.

I now get further, but unfortunately I'm not there yet. The code stops after
the RAM disk driver inits. Anyway, I'm thinking of starting from scratch with
the kernel and patches at the MontaVista site. Come to think of it, all my
changes are in one file so it should not be too difficult to port. I will let
you know how I go.

>
> You are also running an 860T at 50 MHz, so you are likely to discover
> the "CPU6" silicon errata.  You need all of the patches for this.
>
> Go to the MontaVista ftp site (ftp.mvista.com), /pub/CDK/wip/ppc_8xx/RPMS.
> Get the kernel sources/headers from there (along with any other tools
> you may want or need).  This is a 2.2.13 kernel with all patches and
> the option to include the "CPU6" patch.  Don't apply any other patches
> from anywhere.  Just use it and make the minimal changes for your
> board.
>
> Using a BDM is more likely to cause trouble than help.  This kernel
> has XMON and KGDB options.  Use them instead of BDM.

Unfortunately, if you get no output, BDM is the _only_ option you have - at
least it will give you some details of the registers, although you can't step
through code die to the virtual addresses.

Thanks for everyone suggestions.

Regards,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
