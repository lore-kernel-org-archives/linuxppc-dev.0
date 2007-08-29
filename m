Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id 1652CDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 18:41:34 +1000 (EST)
Date: Wed, 29 Aug 2007 10:41:33 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708280828h408ce7damf04b31a2048d40c4@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708290947560.2407-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

	My zImage.elf has 1.1 MB and uImage 968 KB.
Could you tell me please how to hook up GDB to debug u-boot?

I have examined the file in u-boot which does the bootelf:
cat common/cmd_elf.c:

int do_bootelf (cmd_tbl_t *cmdtp, int flag, int argc, char *argv[])
:
:
:
:
        addr = load_elf_image (addr);

        printf ("## Starting application at 0x%08lx ...\n", addr);

        /*
         * QNX images require the data cache is disabled.
         * Data cache is already flushed, so just turn it off.
         */
        if (dcache_status ())
                dcache_disable ();
     
        /*
         * pass address parameter as argv[0] (aka command name),
         * and all remaining args
         */
        rc = ((ulong (*)(int, char *[])) addr) (--argc, &argv[1]);
:
:
}

and I have determined that the system hangs just after the command:
rc = ((ulong (*)(int, char *[])) addr) (--argc, &argv[1]);

This command starts executing the linux image from the location:
0x00400000 

On the console it is printed the following stuff:
loaded at:     00400000 004F3138
board data at: 004F1120 004F1138
relocated to:  004040B4 004040CC
zimage at:     00404E59 004F003D
avail ram:     004F4000 01FFFFFF

Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw 
nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp  
ip=::::virtex4-mirek:eth0:dhcp panic=1
Uncompressing Linux...

It seems to be that it is the Linux kernel which does the uncompression 
and it hangs. The question remain why?


Maybe it is not enough space in RAM or the address in RAM where the
uncompression is done is wrong.

When I load the u-boot to ram via jtag it is placed under the address:
0x800000 as follows:

        section, .text: 0x00800000-0x0081513c
        section, .resetvec: 0x0081513c-0x00815140
        section, .rodata: 0x00815140-0x00817ce0
        section, .reloc: 0x00817d00-0x00818674
        section, .data: 0x00818674-0x00818b08
        section, .data.rel: 0x00818b08-0x00818b34
        section, .data.rel.local: 0x00818b34-0x00818f6c
        section, .u_boot_cmd: 0x00818f6c-0x008191dc
        section, .bss: 0x00819200-0x0081dd04

Than I load the zImage.elf via tftp to the memory location
0xf00000.

When I issue the command bootelf 0xf00000  the zImage.elf is placed in the 
memory:

0x400000 as follows:

        section, .text: 0x00400000-0x004036cc
        section, .data: 0x00404000-0x004f7000
        section, .bss: 0x004f7000-0x004f9138

After that uncompression of zImage.elf starts. I am just wandering which 
memory location is involved for that?

My evaluation board has 32 MB of SDRAM address range:
  (0x00000000-0x01ffffff) DDR_SDRAM_1   plb  


Any Idea?

Best Regards

Mirek







On Tue, 28 Aug 2007, Grant Likely wrote:

> On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > This buffer refers to the kernel which I boot straight from jtag but not
> > u-boot.
> 
> /me remembers something....
> 
> How big is your kernel image?  Seems to me I've had problems with
> kernel images that were too large not being uncompressed properly.
> Can you hook up GDB and debug u-boot?  Find out where it is hanging?
> 
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
