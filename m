Message-ID: <3A691166.DC6DCD81@iiic.ethz.ch>
Date: Sat, 20 Jan 2001 05:17:42 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jeff Hartmann <jhartmann@valinux.com>, Gareth Hughes <gareth@valinux.com>,
        linuxppc-dev@lists.linuxppc.org, dri-devel@lists.sourceforge.net,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

> xmon might really be helpful, but the crash is after the X server blanks the
> display, so I wonder if xmon output would be visible?

Doesn't look like. I realized that when I thought the machine seems dead, it
is in fact at the xmon prompt, but the display is black. Hitting 'x' makes it
continue.

I've narrowed down the problem by modifying the code like this:

        for ( i = entry->handle, j = 0 ; j < pages ; i += PAGE_SIZE, j++ ) {
                printk("i: %08lx\n", i);
                pgd = pgd_offset_k( i );
                printk("pgd: %08lx\n", pgd);
                pmd = pmd_offset( pgd, i );
                printk("pmd: %08lx\n", pmd);
                pte = pte_offset( pmd, i );
                printk("pte: %08lx\n", pte);

                if (!pte)
                {
                        printk("D'oh!\n");
                        return -ENOMEM;
                }

                entry->pagelist[j]= pte_page( *pte );
                printk("Checkpoint 5\n");
                SetPageReserved( entry->pagelist[j] );
                printk("Checkpoint 6\n");

                if ( j < 16 ) {
                        DRM_DEBUG("0x%08lx (page %lu) => 0x%08lx\n",
                                  i, j,
                                  (unsigned long)entry->pagelist[j]->virtual);
                }
        }


The kernel output is as follows:

[drm] drm_sg_alloc
i: ca292000
pgd: c014dca0
pmd: c014dca0
pte: 00000a48
Oops: kernel access of bad area, sig: 11
NIP: C981EE58 XER: 20000000 LR: C981EE50 SP: C5857DD0 REGS: c5857d20 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000A48, DSISR: 40000000
TASK = c5856000[227] 'XFree86' Last syscall: 54
last math c784e000 last altivec 00000000
GPR00: C981EE50 C5857DD0 C5856000 0000000E 00001032 00000001 C0190000 00000000
GPR08: 00000001 C0150000 00000000 C5857D10 20822824 101D5EAC 00000000 C01503DC
GPR16: C0190000 C9820000 C9820000 C9825BD4 C5857DE0 C9820000 7FFFFA58 00000800
GPR24: 00000000 C5EA1C40 00000000 C014E000 00000000 00000A48 00000A48 CA292000
Call backtrace:
C981EE50 C980ECD0 C004D7DC C000411C 00000007 1005449C 10320D8C
106226EC 106231A8 1061D474 1008D098 10025B68 1008C5B4 0FE6FCC8
00000000


So it's not the __vmalloc indeed. I hope this rings any bells...


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
