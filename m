Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 reorder and invalidate dcache
Date: Fri, 16 Aug 2002 17:50:42 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <45B36A38D959B44CB032DA427A6E10640167D022@cceexc18.americas.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I wonder if the MPC860 really can reorder I/O memory accesses?

I am using JFFS2 FS on Intel Strata flash. I remap the flash with
ioremap_nocache(flash_start, flash_size) and use the resulting address
to access the flash. Whenever a write is performed to the flash I do a
wmb() to enforce ordered writes and that affects performance somewhat.
Is the wmb() required or can I skip it?


Invalidate Data Cache
------------------------
I have noticed that invalidate_dcache_range() performs a 'sync' just before it returns. Why?
Is it not enough to execute 'dcbi' on the affected address space?

Is there a faster way to invalidate the dcache for a big(256KB) area than using invalidate_dcache_range().
The area is PAGE aligned.

 Regards
           Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
