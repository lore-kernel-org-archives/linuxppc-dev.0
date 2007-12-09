Return-Path: <jsamch@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 64E69DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 04:32:13 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2994826wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 09 Dec 2007 09:32:12 -0800 (PST)
Message-ID: <169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
Date: Sun, 9 Dec 2007 12:32:12 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
In-Reply-To: <fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Dec 9, 2007 1:18 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 12/8/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> > Thanks to the valuable information provided by this discussion group an=
d
> > particularly by Grant Likely from Secret Lab Technologies, I was able t=
o
> > setup and run Linux 2.6 on my ML-310 development platform.
>
> Congratulations.  If you had to make any changes to get it to work
> then please send me your patches.

Thank you for the quick reply.

I will directly update Secret Lab's Wiki pages.  Those pages are the
ones that got me going really quickly, so I will add a few of my
observations directly on your pages so everyone can benefit.

I ended up using Secret Lab's GIT tree as my source archive, so I'll
let you know if I need to fix some code.

> You'll have to go back into the mailing list archives to find a patch
> for adding PCI support for a Virtex platform.  I don't have any of
> that in my tree.  It probably only exists for the 2.4 kernel.  You'll
> need to port forward to use it on 2.6 (I'm more than willing to help
> you with this)

Hmmm... I'm not really ready to invest that much time into the PCI for ML-3=
10.

My real target is the control FPGA on a BEE2 box
(http://bee2.eecs.berkeley.edu) and on that particular setup, the
control FPGA is directly connected to an LXT971A Ethernet PHY, so I'll
use the ethernet MAC from Xilinx.

I use the ML-310 as a stepping stone for quickly prototyping some of
my FPGA changes since the VirtexII-Pro in the ML-310 is much smaller
and doesn't eat up all my workstation resources when re-compiling the
FPGA.

> However, word of warning.  The Xilinx PCI bridge is badly broken.
> Xilinx is not supporting the PCI core and it is missing the ability to
> do certain types of transfers.  Last I heard, Xilinx has no plans to
> fix their PCI core either.

Ok, its nice to know the status of that module.  Too bad Xilinx is
dropping the support for it.

In that case, it would probably be more beneficial for all to adapt an
"open core" project such as this PCI bridge:
http://www.opencores.org/projects.cgi/web/pci/home

Along with the help of an OPB to Wishbone wrapper like that one:
http://www.opencores.org/projects.cgi/web/opb_wb_wrapper/overview

With some work (and ideally some PCI expertise) one could get an open
implementation of a PCI bridge that can integrate in the Xilinx EDK
flow and could be repaired or adapted as time goes...  I am a complete
newbie to PCI, so I'll leave that to some willing "hacker".

I'll continue on my quest to run Linux 2.6 on the BEE2 control FPGA.
There is no PCI bus involved in that architecture.  Just raw buses and
a sea of FPGA logic.

Regards,

Jean-Samuel
--=20
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
