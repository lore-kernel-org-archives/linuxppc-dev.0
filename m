From: Ryan Nielsen <ran@krazynet.com>
Date: Thu, 26 Aug 1999 23:04:38 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: bug in ioremap/map_page ?
Message-ID: <19990826230438.A2565@gondolin.asf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone looked into this ?
this message is almost a year old and I have the same problem
with ioremap in modules.

Date: Sat, 26 Sep 1998 14:15:11 +0200 (MET DST)
From: Carsten Pluntke <su0289@sx2.hrz.uni-dortmund.de>
To: linux-ppc@meetpoint.mcu.motsps.com
Subject: [linux-ppc] Possible bug in arch/ppc/mm/init.c::map_page ?
Message-ID: <Pine.GSO.4.03.9809261404300.28905-100000@sx2.hrz.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-ppc@meetpoint.mcu.motsps.com
Precedence: bulk


Hi,

I've found a strangeness when using ioremap() on an 8MB block of memory.
When mapping smaller blocks of memory everything works OK, but when a
block crosses a pgd boundary (e.g. from cc3fffff to cc400000) and the new
page has been allocated by map_page(), the kernel usually panics on access
of cc400000.
Tracking down I found out that the page fault (data access) panic only
appears if the new pgd entry is made up by map_page, when vmalloc()ing and
vfree()ing the same amount of memory (8MB) just before the ioremap(),
everything works fine.

-------------------8<---- arch/ppc/mm/init.c::map_page() ----------------
        /* Use upper 10 bits of VA to index the first level map */
        pd = (pmd_t *) (tsk->mm->pgd + (va >> PGDIR_SHIFT));
        if (pmd_none(*pd)) {
#ifndef CONFIG_8xx
                /*
                 * Need to allocate second-level table, but first
                 * check whether this address is already mapped by
                 * the BATs; if so, don't bother allocating the page.
                 */
                for (b = 0; b < 4; ++b) {
                        if (va >= bat_addrs[b].start
                            && va <= bat_addrs[b].limit) {
                                /* XXX should check the phys address
matches */
                                return;
                        }
                }
#endif /* CONFIG_8xx */
                printk("First-level map for 0x%08lX\n",va);
                pg = (pte_t *) MMU_get_page();
                pmd_val(*pd) = (unsigned long) pg;
        }
--------------------------------8<-------------------------------------

The 'printk' (last but four lines) is added by me to show where a new pgd
entry is created, and whenever it shows up with an address, accessing this
address (and the following) proves fatal. The debug line doesn't show up
when the memory area was used at least once using vmalloc().

I think that if this really is a bug it didn't show up because ioremap()
was normally used for small areas and it never had to put up a new pgd
entry.


                                           Carsten

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
