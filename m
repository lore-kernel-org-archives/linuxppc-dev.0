From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14956.50865.856754.439761@diego.linuxcare.com.au>
Date: Tue, 23 Jan 2001 10:48:01 +1100 (EST)
To: Michel Ddnzer <michdaen@iiic.ethz.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A691166.DC6DCD81@iiic.ethz.ch>
References: <3A686DFE.9030308@valinux.com>
	<19341214104258.22601@mailhost.mipsys.com>
	<3A68FC06.7BEEA13D@iiic.ethz.ch>
	<3A691166.DC6DCD81@iiic.ethz.ch>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel =?iso-8859-1?Q?D=81=E4nzer?= writes:

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
[snip]
> The kernel output is as follows:
>
> [drm] drm_sg_alloc
> i: ca292000
> pgd: c014dca0
> pmd: c014dca0
> pte: 00000a48

Which means that *pgd == 0, which is very odd indeed, unless of course
you have run off the end of the vmalloc'd area (I assume you haven't).
What is the value of the symbol swapper_pg_dir in this kernel?
Have you tried accessing the vmalloc'd area?  Where did you get the
kernel source?

I hope to get to have a good look at the drm code myself shortly.

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
