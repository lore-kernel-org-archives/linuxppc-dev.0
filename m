From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>,
	Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs 
Date: Sun, 24 Mar 2002 13:22:47 +0100
Message-Id: <20020324122248.27466@smtp.wanadoo.fr>
In-Reply-To: <9477.1016888847@msa.cmst.csiro.au>
References: <9477.1016888847@msa.cmst.csiro.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The beauty of the proposal is that it *is* simple. bi_recs within bi_recs.
>The top level treats the record as one (typeless) chunk of data. I have
>actually requested *more* types (e.g. arrays), and also the saving of
>certain (most?) bi_recs so that loadable modules can consult them later
>(rather than requiring code in the kernel startup to parse the records).
>Cheers!

The kernel startup should stop parsing them. The interface between kernel
& drivers to bi_recs should instead be of the type "find_birec(type)" or
"find_dev_birec(class, id)" for BI_DEVICE ones.

There should be no reason to have to touch the kernel support files when
adding new types of bi_rec nor to have them all parsed in a single
location.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
