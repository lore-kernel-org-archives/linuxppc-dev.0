Message-ID: <3A896367.95BE7CF4@mvista.com>
Date: Tue, 13 Feb 2001 08:40:07 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Joe Dery <jedery@mtu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org, frowand@mvista.com
Subject: Re: Walnut user-space software problem
References: <3A88F528.1408.4CC7B04@localhost>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joe Dery wrote:
>
> My senior design group is working with a IBM Walnut board
> with the 200 MHz 405GP r3.  We have the linux kernel and
> target filesystem taken from the Nov. 26, 2000 sources.
> The board boots Linux from NFS flawlessly after compilation
> using the CDK 1.0 8xx toolkit.
>
> Our project objectives include  compiling the ITU-T G.723.1
> (Voice over IP) standard C source code.  We are (again) using
> the powerpc-linux-gcc included with the MV CDK 1.0 tools for
> PowerPC 8xx-based machines.
>
> I understand that an updated devkit is available, but since
> our budget cannot touch the subscription fees needed to
> obtain the MontaVista toolkit for the 405GP.

I have put the 405GP tool chain (compiler, linker, etc) and a
stripped down set of files for the target system out on
the MontaVista ftp site, but haven't had time to update my
web page to point to them and document their usage.  If you are
willing to put up with the pain of this lack of documentation,
here is the basic info...

  The files are on ftp.mvista.com (login as "ftp") in the
  pub/CDK/1.0/latest/ppc_4xx/ directory.  The files are
  actually from the 1.2 CDK, but I didn't update the
  documentation to reflect that fact, or to note which
  RPMs I included and which I excluded.

  Since you are using a Rev C Walnut, you need to uninstall
  a few RPMS

    rpm -e hhl-ppc_4xx-walnut-lsp-2.4.0-test2-1.2.1-1
    rpm -e hhl-ppc_4xx-walnut-lsp-binaries-2.4.0-test2
    rpm -e --nodeps hhl-ppc_4xx-glibc-2.1.3-2

  and install a replacement

    rpm -ivh hhl-ppc_4xx-glibc-2.1.3-2_PPC405RevC.noarch.rpm

> Enough background already.  The problem arises in that
> when we compile the VoIP source code and run it on the
> PowerPC, the output of the encoder and decoder is wrong.
> When the same code is compiled for our host machine
> (using i386 gcc) the output is ok.  This C code involves a
> lot of speed-oriented fixed-point mathematics - that is, a lot
> of multiplies and shifts (to avoid divides)  Just searching for
> the >> and << operators in the kernel source doesn't bring
> up much.  So to me this may be the culprit.  Sorry to make
> this so vague - I am just hoping that someone has seen problems
> with math/DSP oriented programs before and can suggest
> something!
>
> Also, I wanted to verify the size of the variable types in the
> gcc compiler for the PowerPC.  Please correct me if I'm
> wrong.
>
> int             - 32 bit signed integer
> short   - 16 bit signed integer
>
> I am also curious if this could be caused by the Revision C
> errata.  However, I am not sure of that errata's nature or the
> methods of work-around.

You really want to move forward to the rev D 405GP.  The workarounds
in the kernel for the rev C are not 100% effective.


> Thanks for any help you can provide in advance!
> Joe Dery
> jedery@mtu.edu
>


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
