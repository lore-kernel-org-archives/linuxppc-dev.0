Message-ID: <393BBE5D.49B17E9C@embeddededge.com>
Date: Mon, 05 Jun 2000 10:51:09 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel crashes at InstructionTLBMiss
References: <00Jun4.144038est.115228@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu wrote:

> boot the target, I get the following output and nothing more.
>
> loaded at:     00800000 0080B1D8
> relocated to:  00B00000 00B0B1D8
> board data at: 00B00190 00B001B8
> relocated to:  007F0100 007F0128
> zimage at:     00806000 0087C6C1
> initrd at:     0087C6C1 00A53511
> avail ram:     00A54000 02000000

There are several things to watch for.  First, I am surprised you see
this much output.  You have obviously changed link addresses in the
Makefile, which you shouldn't do.  Because of the early kernel
mapping, everything should reside in the lower 8Mbytes of memory.  The
zImage support loader (arch/ppc/mbxboot/...stuff...) should link to
low memory, 0x00100000.  You should load the image either just above
that, at 0x00200000 or in very high ROM addresses ( > 16 Mbyte).

You are also running an 860T at 50 MHz, so you are likely to discover
the "CPU6" silicon errata.  You need all of the patches for this.

Go to the MontaVista ftp site (ftp.mvista.com), /pub/CDK/wip/ppc_8xx/RPMS.
Get the kernel sources/headers from there (along with any other tools
you may want or need).  This is a 2.2.13 kernel with all patches and
the option to include the "CPU6" patch.  Don't apply any other patches
from anywhere.  Just use it and make the minimal changes for your
board.

Using a BDM is more likely to cause trouble than help.  This kernel
has XMON and KGDB options.  Use them instead of BDM.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
