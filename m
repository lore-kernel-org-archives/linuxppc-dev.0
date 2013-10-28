Return-Path: <victork@il.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29B8E2C008E
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 23:38:43 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Mon, 28 Oct 2013 12:38:40 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9544D17D8062
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 12:38:09 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9SCcNII65077356
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 12:38:24 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9SCcZxc005874
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 06:38:36 -0600
In-Reply-To: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
References: <12083.1382486094@ale.ozlabs.ibm.com>	<20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: Frederic Weisbecker <fweisbec@gmail.com>
Message-ID: <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Mon, 28 Oct 2013 14:38:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Frederic Weisbecker <fweisbec@gmail.com>
>
> 2013/10/25 Peter Zijlstra <peterz@infradead.org>:
> > On Wed, Oct 23, 2013 at 03:19:51PM +0100, Frederic Weisbecker wrote:
> > I would argue for
> >
> >   READ ->data_tail                      READ ->data_head
> >   smp_rmb()     (A)                     smp_rmb()       (C)
> >   WRITE $data                           READ $data
> >   smp_wmb()     (B)                     smp_mb()        (D)
> >   STORE ->data_head                     WRITE ->data_tail
> >
> > Where A pairs with D, and B pairs with C.
> >
> > I don't think A needs to be a full barrier because we won't in fact
> > write data until we see the store from userspace. So we simply don't
> > issue the data WRITE until we observe it.
> >
> > OTOH, D needs to be a full barrier since it separates the data READ
from
> > the tail WRITE.
> >
> > For B a WMB is sufficient since it separates two WRITEs, and for C an
> > RMB is sufficient since it separates two READs.
>
> Hmm, I need to defer on you for that, I'm not yet comfortable with
> picking specific barrier flavours when both write and read are
> involved in a same side :)

I think you have a point :) IMO, memory barrier (A) is superfluous.
At producer side we need to ensure that "WRITE $data" is not committed to
memory
before "READ ->data_tail" had seen a new value and if the old one indicated
that
there is no enough space for a new entry. All this is already guaranteed by
control flow dependancy on single CPU - writes will not be committed to the
memory
if read value of "data_tail" doesn't specify enough free space in the ring
buffer.

Likewise, on consumer side, we can make use of natural data dependency and
memory ordering guarantee for single CPU and try to replace "smp_mb" by
a more light-weight "smp_rmb":

READ ->data_tail                      READ ->data_head
// ...                                smp_rmb()       (C)
WRITE $data                           READ $data
smp_wmb()     (B)                     smp_rmb()       (D)
						  READ $header_size
STORE ->data_head                     WRITE ->data_tail = $old_data_tail +
$header_size

We ensure that all $data is read before "data_tail" is written by doing
"READ $header_size" after
all other data is read and we rely on natural data dependancy between
"data_tail" write
and "header_size" read.

-- Victor
