Date: Tue, 9 Nov 1999 11:48:35 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: iweiny@pacbell.net
cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __module_kernel_version <= what is this?
In-Reply-To: <199911091712.JAA01251@batcave2.localdomain>
Message-ID: <Pine.LNX.3.96.991109114610.16045C-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




In all but one of the source files that make up the module add the
following define at the top of the file: 

#define __NO_VERSION__

The variable that's causing you trouble is used as part of the
CONFIG_MODVERSIONS stuff.

-Mark

On Tue, 9 Nov 1999 iweiny@pacbell.net wrote:

> 
> I am getting the following error when compiling the new USB modules
> against the 2.2.12 kernel.  I have been unable to find this symbol
> in either the assembly or preprocessed outputs?  What is this?
> 
> details
> 2.3.26 USB code compiled against the 2.2.12 stable Pmac tree.
> While linking usb.o usb-debug.o ohci.o ohci-debug.o together...
> 
> ohci.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
> usb.o(.modinfo+0x0): first defined here
> gmake: *** [usb-card-driver.o] Error 1
> 
> Where is this defined and how can I make it defined in only one file?
> I would like just one object for the "card-driver" which worked with
> the cvs USB source from ppc.kernel.org.
> 
> Ira Weiny
> iweiny@acm.org
> 
> PS. The main goal of this is to get USB support working for my DC265
> Kodak camera.  Once that is up I am going to try and get the OpenDis
> driver to work and I should have FAST jpeg downloads from my camera.
> The 2.3.26 source from kernel.org has a dc2xx driver in it which is 
> supposed to work but I was hoping to still use the 2.2.12 stable
> kernel that I have...
> 
> PPS this work should extend to the DC260 and DC290 and DC280 Kodaks
> if anyone has them.  (And maybe other USB equiped cameras but I don't
> know too much about the driver itself.)
> 
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
