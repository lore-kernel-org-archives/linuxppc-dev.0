Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: WRITE_THRU  on 8xx missing
Date: Thu, 5 Sep 2002 09:28:19 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLGEDDFGAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3D76BD7D.8060102@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Joakim Tjernlund wrote:
>
> > I just noticed that _PAGE_WRITETHRU is defined in the linuxppc_2_4 tree but not in
> > the linuxppc_2_4_devel tree, which is the one I am using :-(. Has this "function" been removed ,
> > never to return or is the devel tree in a flux now for mpc8xx?
>
> I don't know what we will do.  We always seems to be running out of control bits
> in the PTE, so this is the first one to go if we need one for something else.
> The writethrough mode is also a pain to support dynamically because it requires
> special code in the tlb miss exception to load/clear bits in the PMD/L1 descriptor.
> Adding this code nearly doubles the size of the exception handler, when you want
> minimal instructions, for a feature (almost) no one uses.  At best, the writethrough
> mode may return when I finish the large pages someday, and will be a special case
> that covers a modulo 4M space on a 4M boundary (which I don't yet know how we
> would allocate).

I see, I can live with that. If you do impl. this
4M space on a 4M boundary is fine by me. My flashes are much bigger.

>
> For burst flash, I suggest you read the archives for a discussion where you
> double map the cache into a copyback mode space read and an uncached space
> for write.  You will then invalidate during a write operation.  This would
> maximize performance and require no VM or cache management changes.

Yes I known, but I was hoping to avoid that.

>
>
> >>I want to use this mapping to do burst reads but single writes for a flash device.
>
> Are you sure writethough mode will do this?  I don't think it will as I believe
> any cache enabled mode will burst.  To prevent burst you have to run with
> caches disabled or have it inhibited in the memory controller.  Check it out.

Well, the 860 User's Manual chapter 6.3 say so(In my opinion) and I asked Motorola
also and they confirmed that. If you think about it is the only way to operate since
the write needs to update the memory immediatly.

BTW, Motorola informs me that if you set the GUARD bit, I/O will be ordered. That way you can
avoid using mb() or wmb().

>
> Thanks.
>
   Thanks for your reply

           Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
