Subject: User buffers and cache flushing.
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Fri, 10 Mar 2000 12:02:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000310010235.6B0D3355C8@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

Following the other thread on USB. The driver I am writing for an
MPC855T embedded board, I create a character device that a user
can 'write (2)' to. I then need to DMA this data directly to our
device. I now realise that I will need to be calling
flush_dcache_range prior to kicking of the IDMA transfer. Since I
am not wanting to be double handling this data, and the data will
most likely be fragmented in memory, it looks like I will need to
resolve kernel addresses and sizes for each memory fragment of the
users data buffer (something like a scatter/gather list, I guess)
and call flush_dcache_range on each of these fragments.

Is this reasoning correct?
Have I overlooked anything? (other than the lack of support for IDMA
currently in the MPC8xx kernel)

Thanks.

Greg.

--
+----------------------------------------------------+
| Do you want to know more?                          |
|               --== Greg Johnson ==--               |
| HW/SW Engineer      gjohnson@research.canon.com.au |
| Canon   Information  Systems   Research  Australia |
| 1 Thomas Holt Dr, North Ryde, NSW, 2113, Australia |
| "I FLEXed my BISON and it went YACC!" - me.        |
+----------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
