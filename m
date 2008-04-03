Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18420.31327.633359.619200@cargo.ozlabs.ibm.com>
Date: Thu, 3 Apr 2008 17:34:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
In-Reply-To: <0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
	<0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > For a kdump kernel, at least for 64-bit, the physical address has to
> > be 32MB.  There is no other choice, so there is no possibility of
> > confusion.
> 
> But how do you know a vmlinux image is for kdump or not?

By looking at the ELF headers -- either the first PT_LOAD segment or
the .text section -- and seeing whether the start address is
0xc000000002000000 or not.

> > For 85xx, would it be possible to have the kernel figure out what
> > physical address it has been loaded at, and use that as the base
> > address, rather than having the base address set at compile time?
> 
> Yes, that is what CONFIG_RELOCATABLE is all about.

Is there any reason to have that as an option, rather than just always
doing that?

> > That would solve my objection since it would mean that there would no
> > longer be two things that had to be kept in sync.  You could pass any
> > value to wrapper/mkimage (subject to constraints such as it has to be
> > a multiple of 256M) and it would work.  That value could even come
> > from a config option in the case where wrapper is invoked as part of
> > the kernel build, but that config option shouldn't affect anything at
> > all in the vmlinux.
> 
> Ok, but I still think the issues exists when we config PHYSICAL_START  
> to non-zero and CONFIG_RELOCATABLE=n.  Ideally we get set the phys  
> address the PHDR, but I'm not sure how to get the linker to do that.

If we can do that then the wrapper script can dig it out and pass it
to mkimage, which would solve the problem.

Paul.
