To: Val Henson <val@nmt.edu>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
In-reply-to: Your message of "Fri, 22 Mar 2002 21:01:03 -0700"
             <20020322210103.C3363@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 24 Mar 2002 00:07:27 +1100
Message-ID: <9477.1016888847@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Mar 2002 21:01:03 -0700, Val Henson <val@nmt.edu> writes:
>while (rec->tag != BI_LAST) {
>  /* fiddle with each individual record */
>  rec = (struct bi_record *)((ulong)rec + rec->size);
>}

Won't this code still work with benh's proposal? The "fiddle" part above
may delve into the structure, but at the top level the record is still
treated exactly like above.

>The simplicity of this system is valuable - I don't want to give it up
>unless we get lots and lots of added functionality in return.

I agree with this. In fact, we shouldn't give up simplicity for any reason.

>Dan
>Malek's comments suggest that bi_recs should only be used for only a
>small, simple class of information.  In this context, I don't see what
>structures buy us.

That's because he sees no value in having a lot of data passed in from the
boot loader. On the other hand, I believe that if the kernel can learn
something from the boot loader, it should - rather than duplicate the code
that is already in the boot loader, or hard-wire configuration information -
and if this ends up being a lot of data and/or with a complicated structure
(this isn't automatically the case btw), then so be it. This can be achieved
with "simple" bi_recs, if they are defined in the right way.

>I have to admit, bi_rec structures are a really cool idea, but I
>prefer simplicity over coolness. :)

The beauty of the proposal is that it *is* simple. bi_recs within bi_recs.
The top level treats the record as one (typeless) chunk of data. I have
actually requested *more* types (e.g. arrays), and also the saving of
certain (most?) bi_recs so that loadable modules can consult them later
(rather than requiring code in the kernel startup to parse the records).
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
