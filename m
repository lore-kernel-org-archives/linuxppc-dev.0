Date: Fri, 12 Nov 1999 07:46:16 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.27 on CHRP Longtrail
In-Reply-To: <Pine.LNX.4.05.9911121430470.444-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.9911120738300.4566-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 12 Nov 1999, Geert Uytterhoeven wrote:

> The problem is in free_all_bootmem(): we have MAX_DMA_ADDRESS == 0xffffffff
> and virt_to_phys() subtracts KERNELBASE from it. I don't understand (yet)
> what's all that bootmem stuff doing...

	this is interesting because I recently had a problem sorta like
this on pmacs with some recent 2.3's.  in do_init_bootmem() a call to
remove_mem_piece() uses boot_mapsize as the "size", this locks up on old
non-b&w/imac/g4 powermacs, but I changed the size to boot_mapsize+start
and it fixed it.  I didn't bother debugging remove_mem_piece() since i got
it working, perhaps i'll switch it back adn see where it dies.
	also on a side note, boot_mapsize is initialized through an
init_bootmem() call wich uses __pa(), i recently saw a post from linus
saying that __pa/__va should not ever be used in "real" code as they are
only used in the headers for internal stuff, and he's considering removing
them.  think this is a problem?



ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
