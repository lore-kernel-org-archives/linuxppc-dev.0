Return-Path: <victork@il.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp18.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A3FB2C011F
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Oct 2013 20:00:46 +1100 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Sun, 27 Oct 2013 09:00:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7D0A117D8057
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Oct 2013 09:00:10 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9R90PL362783526
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Oct 2013 09:00:25 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9R90akT006067
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Oct 2013 03:00:37 -0600
In-Reply-To: <20131025173749.GG19466@laptop.lan>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <OF1519E98D.692AF083-ON42257C11.002E693E-42257C11.00317D48@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Sun, 27 Oct 2013 11:00:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-kernel@vger.kernel.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, anton@samba.org,
 Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <peterz@infradead.org> wrote on 10/25/2013 07:37:49 PM:

> I would argue for:
>
>   READ ->data_tail         READ ->data_head
>     smp_rmb()   (A)          smp_rmb()   (C)
>   WRITE $data              READ $data
>     smp_wmb()   (B)          smp_mb()   (D)
>   STORE ->data_head        WRITE ->data_tail
>
> Where A pairs with D, and B pairs with C.

1. I agree. My only concern is that architectures which do use atomic
operations
with memory barriers, will issue two consecutive barriers now, which is
sub-optimal.

2. I think the comment in "include/linux/perf_event.h" describing
"data_head" and
"data_tail" for user space need an update as well. Current version -

        /*
         * Control data for the mmap() data buffer.
         *
         * User-space reading the @data_head value should issue an rmb(),
on
         * SMP capable platforms, after reading this value -- see
         * perf_event_wakeup().
         *
         * When the mapping is PROT_WRITE the @data_tail value should be
         * written by userspace to reflect the last read data. In this case
         * the kernel will not over-write unread data.
         */
        __u64   data_head;              /* head in the data section */
        __u64   data_tail;              /* user-space written tail */

- say nothing about the need of memory barrier before "data_tail" write.

-- Victor
