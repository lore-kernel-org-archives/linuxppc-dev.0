From: phandel@cise.ufl.edu
Date: Fri, 22 Oct 1999 12:34:02 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Questions about rsync "linux-devel" -
Message-ID: <Pine.LNX.4.10.9910221220520.18946-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm interested in spending some time with the linux kernel, and I've got
some questions about samba.anu.edu.au::linux-pmac-devel - 

1) Is there a web page that indicates changes? (when made, what they were,
etc.?)
2) Is there a standard .config that the maintainer (Paul?) uses?  I
haven't gotten it to compile lately, even using the .config rsync fetches.
3) What is the best way to contribute to this project?  I often make small
patches to get it to compile further, but I'd like to help out rather
than make these one-off changes.

Here are some issues with the latest version I fetched late last night:

in /usr/src/linux-2.3.devel/include/asm-ppc/keyboard.h, around line 35:

	if ( ppc_md.kbd_setkeycode )
		return ppc_md.kbd_setkeycode(scancode, keycode);
	else
		retureycode )
		return ppc_md.kbd_setkeycode(scancode, keycode);
	else
		return 0;
}

Looks like everything between "retureycode )" and the second "else" should
be removed?

...and further down, line #69 looks mangled:  "ppc_md.kbd_ledt_hw )" so I
removed it and it compiled fine.

Finally, after everything compiles, the linker chokes on these functions:

[snip]
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `nvram_read_byte':
arch/ppc/kernel/kernel.o(.text+0xa3a0): undefined reference to
`pmu_request'
arch/ppc/kernel/kernel.o(.text+0xa3b0): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o: In function `nvram_write_byte':
arch/ppc/kernel/kernel.o(.text+0xa47c): undefined reference to
`pmu_request'
arch/ppc/kernel/kernel.o(.text+0xa494): undefined reference to `pmu_poll'
make: *** [vmlinux] Error 1


Thanks for your time,
Pete

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
