Date: Wed, 20 Sep 2000 22:22:54 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C8FDDC.29AEDE52@mvista.com>
Message-ID: <Pine.GSO.4.10.10009202211270.12066-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 20 Sep 2000, Dan Malek wrote:

> None of the embedded PowerPCs use a hash table, and the Book E
> processors don't either.  We avoid using the hash table when given
> the option, like 603s.  The "hardware assist" and subsequent hash
> table is a PITA for Linux VM, and Cort has documented the performance
> benefits of not using it.

Oh, I forgot about that part. On m68k we have special init functions for
that, which use alloc_bootmem_low_pages(). It maybe should be splitted for
ppc too, so that we have a special (and very simple) remap function, that
is only used during very early initialization and all the mem_init_done
checks could be removed.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
