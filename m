Message-ID: <20000927121938.2547.qmail@dag.newtech.fi>
To: <linuxppc-embedded@lists.linuxppc.org>
cc: dag@newtech.fi
Subject: Crosscompiler broken ?
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Date: Wed, 27 Sep 2000 15:19:38 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again,

tracing down a severe probem I am seeing when
porting Linux to a PPC-board.

The  compilation of the kernel is done with a crosscompiler
on an Intel x86 system and strange things are happening:

This is the part of the code from fs/dcache.c:

==================== Code =============
    do {
        unsigned long tmp;

        nr_hash = (1UL << order) * PAGE_SIZE /
            sizeof(struct list_head);
        d_hash_mask = (nr_hash - 1);

        tmp = nr_hash;
        d_hash_shift = 0;
        while ((tmp >>= 1UL) != 0UL)
            d_hash_shift++;

        dentry_hashtable = (struct list_head *)
            __get_free_pages(GFP_ATOMIC, order);
printk("dentry_hashtable(0.5)(addr = 0x%lx) = 0x%lx\n", &dentry_hashtable,
dentry_hashtable);   /* DEB
UG */
    } while (dentry_hashtable == NULL && --order >= 0);
printk("dentry_hashtable(0.7)(addr = 0x%lx) = 0x%lx\n", &dentry_hashtable,
dentry_hashtable);   /* DEB
UG */

==================== Code  end =============

here is the output:

__get_free_pages(): page = 0xC024A000, page_address = 0xC0240000
&dentry_hashtable = 0xc01cf0d4, stack = 0xc018af68
__get_free_pages(): page = 0xC0274000, page_address = 0xC0CC0000
dentry_hashtable(0.5)(addr = 0xc01cf0d4) = 0xc0cc0000
dentry_hashtable(0.7)(addr = 0xc01cf0d4) = 0x5


The last line is really strange, who the %&¤&%¤/ is messing around
with the contents of dentry_hashtable ?

Compiler bug ?


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
