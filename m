Date: Mon, 21 Dec 1998 13:41:13 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>,
        Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: preploader, works on MTX, not on BlackHawk
In-Reply-To: <Pine.LNX.4.04.9812181941460.13860-100000@narn.local.drgw.net>
Message-ID: <Pine.HPP.3.96.981221124848.18639D-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Dec 1998, Troy Benjegerdes wrote:

> > > Please please please someone do this? Then I can remove the ugly hack I
> > > have in matroxfb to remap the PCI registers to something sane.
> > 
> > Did you try my preploader. It attempts to remap all the PCI resources to
> > something sane and even includes a black list for devices who lie about
> > their requirement (S3). For the latest version I've got success reports on
> > quite a lot of Motorola boards: 
> > 
> > 	MVME230x, 2300SC, 2400, 260x, 2700, 3600, MTX and MPC750
> 
> First of all, can I get the patches for OpenPIC support? I'd like to try
> to merge them with Corey Minyard's changes and add SMP support for MTX.

Yes, see later, I'm leaving soon until January 7th so I can't do much
more right now. The ftp server will be switched off end of this week
(it's my development PPC indeed, should do something about it). 

> Along those lines, since there are at least four people doing development
> on Motorola embedded (PowerPlus?) boards, I have considered setting up a
> CVS archive for development kernel work. I was thinking of giving most
> everyone working on this write access. The theory is that this will make
> it more convenient, since one doesnt' have to worry so much about breaking
> the Vger cvs and can submit more experimental code. This would also
> hopefully reduce duplicated work, such as the restructing which Corey did
> (which I had also started, but never got as far). Comments/Flames anyone?

Good idea.

> I just tried the zimage-2.1.130 on vcorr1.iram.es, and got one moderate
> success, and one failure. My MTX booted quite happily, however, there was
> no vgacon support (I'm guessing), so I had no console. I've also included
> the log from a boot with the video card removed.

Where ? 

The image has support for text mode VGA and serial console. Nothing else
for now. 

> My BlackHawk system came up, but the video card initialization failed and
> filled the screen with a bunch of flashing characters. I could see
> 'linuxppc load' through the mess, but it seemed like the kernel never
> booted. Is there any way to force loader to use serial? This would help
> debugging.

Unplug the keyboard, it should automatically fall back to serial console.
This means there are still bug in the x86 emulator. For now it works fine
on several kinds of S3 boards (your Cirrus board had an Intel BIOS on it,
hopefully, otherwise maybe the emulator tries to execute garbage). 

Note that there is a version of the emulator which can be run from user
mode in em86_user.tgz. The interface has a lot of rough edges, however... 
But if you're courageous (being able to read x86 code in hex without an
opcode table helps but is not a prerequisite), you can step through the
BIOS, set a breakpoint... and see where it fails.

> Also, My matrox card's second PCI address got realocated to somethign
> sane, but the first address (the control registers) stayed at 0. Will this
> need a blacklist of some sort?

No, the problem is that I tried to be smart :-), in pci.c you have:

	if((((r->type&PCI_BASE_ADDRESS_SPACE)==PCI_BASE_ADDRESS_SPACE_MEMORY)
	     &&(r->base<0x1000000)) ||
	    (r->base<0x10000) ||
	    !(r->size & 0x1fffffff)){
	  	sfree(r);
		return;
	}

which means that I don't try to reallocate I/O areas below 64k and MMIO
below the 16Mb boundary, because there mighht be valid reasons to put them
there (valid ISA addresses). Also, a value of zero means that the
corresponding address decoder is disabled (although many devices are buggy
wrt to this PCI specification), perhaps because the firmware had a good
reason to do it: for example the I/O base of the OpenPIC in the Raven is
set to 0 so that it is only accessed through MMIO, no need to take 256 KB
of PCI I/O space. 

I have changed the code to remap MMIO addresses which are explicitly set
to zero (disabled), but I don't dare to do it to ISA mapped ones (this
allows me to avoid dealing with the problem of the 20 bit address type: if
the firmware has done it right, it should work, if not, the result after
the allocator runs can't be worse). I don't know what the correct solution
will be in the end, however. 

> 
> I also had an unexplained crash with the video card in. Gabriel, you might
> want to look at your system.map. This occured about 2 or 3 minutes after
> booting. ( I was logged in via the serial port at the time)
> 
> 
> ----- 
> [root@kalmia pci]# page fault in interrupt handler, addr=8
> NIP: C00A2194 XER: 20000000 LR: C009E4D4 REGS: c741dce0 TRAP: 0300
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c741c000[264] 'rc5des' mm->pgd c760b000 Last syscall: 13
> last math c741c000

I think the code is not the same anymore. This would be in vc_disallocate
in my current kernel :-(. Anyway I've put an updated zImage, a new 
preploader.tgz and my arch/ppc/kernel/*.[chS] on the ftp server. 

The last one is for the OpenPIC. Please decompress this one in a different
directory and compare the files with your current tree, my access to the
CVS tree is too slow to do anything else during the week (unless it's
between 3 a.m. and 5 a.m.). Also this might break many machines.

I'm trying to get the preploader as machine independant as possible
however, and I've now got a fair number of success reports. So the next
step will be to create a prepboot directory based on the patches I've
received. 

	Regards,
	Gabriel. 

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
