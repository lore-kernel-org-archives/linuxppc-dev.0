Message-ID: <37E13540.1A410F5C@broadlink.com>
Date: Thu, 16 Sep 1999 18:21:52 +0000
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross compilation for MPC860
References: <19990916125231.12806.rocketmail@web601.yahoomail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sébastien tadéoni wrote:
...
> 
> During the make zImage I get the following errors:
> 
> ppc_ksyms.c:71:'isa_io_base' undeclared here (not in a fonction)
> 
> ppc_ksyms.c:71:'initializer element for '--ksymtab_isa_io_base.value'
> is not constant,
> 
> And the same thing with the variable pci_dram_offset.
> 
> Perhaps is there a configuration problem or I didn't install correctly
> the powerpc-linux environment for cross development?
> 

Your cross-compile environment is good for building kernels.  This is a kernel
configuration issue.  I got the same isa_io_base error building on a PowerMac 
(which doesn't have ISA) until I enabled SCSI support (?!?!?).  For my MPC850 build 
I commented out EXPORT_SYMBOL(isa_io_base); and also isa_mem_base and pci_dram_offset
in arch/ppc/kernel/ppc_ksyms.c and I was able to successfully build a kernel without SCSI.
Note that the 2.2.5-embedded kernel compiles in ADB support whether you configured for
it or not (correct me if I'm wrong, but that has been my experience so far), so I 
commented out L_OBJS and LX_OBJS in drivers/macintosh/Makefile and it builds without ADB.  

> On top of that the /usr/local/powerpc_linux/include directory is empty
> so that I can't make the ln -s with the include/linux and include/asm
> directories(in my linux sources directory) before I want to build the
> LibC.
> 

Mine is empty too, and I can build kernels fine, but I get lots of errors trying
to build anything else.  Instead of fussing with it (I don't know _why_ the builds 
fail anyway) I got a PowerMac, loaded YellowDog Linux, and all is well :-)

> I will appreciate any suggestions and help  from you on this subject.
> 
> Thanks in advance.
> Have a good day.
> 
> Sébastien.

-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
