Message-ID: <3A6CA276.41B316EB@mvista.com>
Date: Mon, 22 Jan 2001 16:13:26 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Michel Dänzer <michdaen@iiic.ethz.ch>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, since I was stupid and couldn't see the forest for the trees,
let's take some giant steps backward and try again.....

Michel Dänzer wrote:

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


I do this:

		pgd = pgd_offset_k(i);
		if (pgd) {
			pmd = pmd_offset(pgd, i);
			if (pmd && pmd_present(*pmd)) {
				pte = pte_offset(pmd, i);
				if (pte && pte_present(*pte)) {
					/* Do your stuff */
				}
			}
		}

> The kernel output is as follows:
>
> [drm] drm_sg_alloc
> i: ca292000
> pgd: c014dca0
> pmd: c014dca0
> pte: 00000a48

Using my code above, the 'if (pmd && pmd_present(*pmd))' would have
been false (the pmd_present would have failed).  Now, the confusing
part is if entry->handle is the result of a vmalloc this shouldn't
happen......So, Roman was right, no pte table.......

What kernel and system are you using?  Where in the course of
system operation (driver init, application open(), etc.) are you
running this code?

I apologize for my confusion.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
