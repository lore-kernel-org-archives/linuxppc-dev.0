Date: Tue, 16 Oct 2001 17:49:35 -0600
From: Val Henson <val@nmt.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011016174929.B1467@boardwalk>
References: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Oct 12, 2001 at 05:32:34PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gemini:
	zImage.gemini loaded with Smon

We already have a zImage wrapper to translate things between Smon
format and the current kernel format.  No constraints to freedom on
Gemini's account.

Sorry for the late response.

-VAL

On Fri, Oct 12, 2001 at 05:32:34PM +1000, Paul Mackerras wrote:
>
> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:
>
> Powermac:
> 	vmlinux loaded with BootX
> 	vmlinux loaded with quik
> 	vmlinux loaded with yaboot
> 	vmlinux.coff loaded via OF netboot
> 	vmlinux.elf-pmac loaded via OF (disk or net boot)
>
> RS/6000 CHRP:
> 	vmlinux loaded with yaboot
> 	zImage.chrp-rs6k loaded via OF netboot
>
> RS/6000 43p-140:
> 	zImage.prep loaded via OF (floppy or hard disk)
>
> Can others contribute entries to this list please?
>
> I am particularly interested in the cases where the kernel vmlinux
> binary is loaded directly from some external software, because those
> are the cases that constrain our freedom to choose how information
> gets passed in to the kernel.  From a long-term maintainability
> viewpoint, it would be better if we could say that we always have a
> zImage-style wrapper, because then we could change the interface
> between the wrapper and the kernel at will without breaking anything.
> It would then be up to the wrapper to do any translation needed
> between what the external software passed in to it and what the kernel
> is expecting.
>
> Along those lines, I have been thinking that it would be good if the
> wrapper built a data structure describing the hardware in the system,
> particularly things like:
>
> - the amount of RAM and any holes
> - type and register addresses for PCI host bus adaptors
> - ditto for interrupt controllers
> - interrupt mapping
>
> The open firmware device tree does a good job of describing things
> like this, so I would suggest it as the structure.  Whatever structure
> we use needs to be flexible and open-ended rather than only describing
> a fixed set of things, as well as being easy to traverse and
> interpret (so I don't think prep-style residual data is an option).
>
> Thoughts?
>
> Paul.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
