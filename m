Date: Mon, 22 Jan 2001 22:58:38 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CA276.41B316EB@mvista.com>
Message-ID: <Pine.GSO.4.10.10101222255090.25705-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Dan Malek wrote:

> I do this:
>
> 		pgd = pgd_offset_k(i);
> 		if (pgd) {
> 			pmd = pmd_offset(pgd, i);
> 			if (pmd && pmd_present(*pmd)) {
> 				pte = pte_offset(pmd, i);
> 				if (pte && pte_present(*pte)) {
> 					/* Do your stuff */
> 				}
> 			}
> 		}

There is no need to test the pointers and you forgot a pgd_present(),
otherwise you might get a problem on architectures with 3-level mmus.
Anyway to get to the page struct, this should do it:

        pgd = pgd_offset_k(addr);
        if (!pgd_present(*pgd))
                return NULL;
        pmd = pmd_offset(pgd, addr);
        if (!pmd_present(*pmd))
                return NULL;
        pte = pte_offset(pmd, addr);
        if (!pte_present(*pte))
                return NULL;
        return pte_page(*pte);

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
