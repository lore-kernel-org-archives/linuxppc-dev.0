Date: Fri, 14 Feb 2003 16:13:12 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <IGEFJKJNHJDCBKALBJLLKECPFKAA.joakim.tjernlund@lumentis.se>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEEJFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have checked the links above it looks like it's solved. As far as I can
> tell alternative:
>   0. change alloc_skb()/skb_add_mtu() to force the allocated size to be a
>      cache line multiple.
> has been impl. in the kernel:
>  - skb_add_mtu() does not exist anymore.
>  - alloc_skb() does L1 cache align the size:
>        size = requested_size + 16;
>        size = SKB_DATA_ALIGN(size); /* this does L1 cache alignment */
>        data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
>    This makes the skb_shared_info to always start on a new cache line.
>    There is no risk that it is invalidated by dma_cache_inv() call.
>
>  Jocke

Dan, any doubts still?

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
