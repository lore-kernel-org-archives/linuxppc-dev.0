From: "LEROY Christophe" <christophe.leroy@c-s.fr>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel BOOT (kernel 2.4.16)
Date: Sat, 22 Dec 2001 20:59:46 +0100
Message-ID: <7746B3AB173A.AAA45B0@hermes17.si.c-s.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:
>LEROY Christophe wrote:
>
>
>> Can someone help me ?
>> io_block_mapping(IMAP_ADDR,...) fails because mem_pieces_find() can find

>> any piece.
>
>What code are you looking at?	The io_block_mapping is simply going to
>force a map_page() operation and update the PTE tables.  How do you see
>mem_pieces_find() involved in this path?
>
>Thanks.
>

map_page() calls pte_alloc()
pte_alloc() calls pte_alloc_one()
pte_alloc_one() calls early_get_page()
early_get_page() calls mem_pieces_find()
I'm sure that it come here because when I add a call to m8xx_restart() just
before the panic() call in mem_pieces_find(), the board restarts.

Thanks.

C.Leroy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
