Message-ID: <3A6C00E4.53D3356D@relog.ch>
Date: Mon, 22 Jan 2001 10:44:04 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jeff Hartmann <jhartmann@valinux.com>, Gareth Hughes <gareth@valinux.com>,
        linuxppc-dev@lists.linuxppc.org, dri-devel@lists.sourceforge.net,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Come on, someone has to know what's going on here... :)

For the Linux/PPC developers: the purpose of this code is to walk a virtual
memory range and look up the page struct for each page. I spent some time on
the train this morning trying to figure out what might be wrong but couldn't
find anything obvious.

> I've narrowed down the problem by modifying the code like this:
>
>         for ( i = entry->handle, j = 0 ; j < pages ; i += PAGE_SIZE, j++ ) {
>                 printk("i: %08lx\n", i);
>                 pgd = pgd_offset_k( i );
>                 printk("pgd: %08lx\n", pgd);
>                 pmd = pmd_offset( pgd, i );
>                 printk("pmd: %08lx\n", pmd);
>                 pte = pte_offset( pmd, i );
>                 printk("pte: %08lx\n", pte);
>
>                 entry->pagelist[j]= pte_page( *pte );
>                 printk("Checkpoint 5\n");
>                 SetPageReserved( entry->pagelist[j] );
>                 printk("Checkpoint 6\n");
>
>                 if ( j < 16 ) {
>                         DRM_DEBUG("0x%08lx (page %lu) => 0x%08lx\n",
>                                   i, j,
>                                   (unsigned
> long)entry->pagelist[j]->virtual);
>                 }
>         }

[...]

> [drm] drm_sg_alloc
> i: ca292000
> pgd: c014dca0
> pmd: c014dca0
> pte: 00000a48
> Oops: kernel access of bad area, sig: 11

Looking at pgd/pmd, pte seems fishy for a pointer. Any reason why this code
shouldn't work on PPC?


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
