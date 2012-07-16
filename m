Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB8B12C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 05:06:25 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Mon, 16 Jul 2012 16:06:19 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A11DC1DC004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 15:06:15 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6GJ2uPo1929382
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 16:02:56 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6GH641Q001527
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 14:06:04 -0300
Date: Mon, 16 Jul 2012 16:06:12 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Rick Jones <rick.jones2@hp.com>
Subject: Re: [PATCH] mlx4_en: map entire pages to increase throughput
Message-ID: <20120716190611.GA1023@oc1711230544.ibm.com>
References: <1342458113-10384-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <50044F1D.6000703@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50044F1D.6000703@hp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>,
 "amirv@mellanox.com" <amirv@mellanox.com>,
 "yevgenyp@mellanox.co.il" <yevgenyp@mellanox.co.il>,
 "klebers@linux.vnet.ibm.com" <klebers@linux.vnet.ibm.com>, anton@samba.org,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>, linuxppc-dev@lists.ozlabs.org,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 10:27:57AM -0700, Rick Jones wrote:
> On 07/16/2012 10:01 AM, Thadeu Lima de Souza Cascardo wrote:
> >In its receive path, mlx4_en driver maps each page chunk that it pushes
> >to the hardware and unmaps it when pushing it up the stack. This limits
> >throughput to about 3Gbps on a Power7 8-core machine.
> 
> That seems rather extraordinarily low - Power7 is supposed to be a
> rather high performance CPU.  The last time I noticed O(3Gbit/s) on
> 10G for bulk transfer was before the advent of LRO/GRO - that was in
> the x86 space though.  Is mapping really that expensive with Power7?
> 

Copying linuxppc-dev and Anton here. But I can tell you that we have
lock contention when doing the mapping on the same adapter (map table
per device). Anton has sent some patches that improves that *a lot*.

However, for 1500 MTU, mlx4_en was doing two unmaps and two maps per
packet. The problem is not the CPU power needed to do the mappings, but
that we find the lock contention and end up with the CPUs more than 30%
of the time spent on spin locking.

> 
> >One solution is to map the entire allocated page at once. However, this
> >requires that we keep track of every page fragment we give to a
> >descriptor. We also need to work with the discipline that all fragments will
> >be released (in the sense that it will not be reused by the driver
> >anymore) in the order they are allocated to the driver.
> >
> >This requires that we don't reuse any fragments, every single one of
> >them must be reallocated. We do that by releasing all the fragments that
> >are processed and only after finished processing the descriptors, we
> >start the refill.
> >
> >We also must somehow guarantee that we either refill all fragments in a
> >descriptor or none at all, without resorting to giving up a page
> >fragment that we would have already given. Otherwise, we would break the
> >discipline of only releasing the fragments in the order they were
> >allocated.
> >
> >This has passed page allocation fault injections (restricted to the
> >driver by using required-start and required-end) and device hotplug
> >while 16 TCP streams were able to deliver more than 9Gbps.
> 
> What is the effect on packet-per-second performance?  (eg aggregate,
> burst-mode netperf TCP_RR with TCP_NODELAY set or perhaps UDP_RR)
> 

I used uperf with TCP_NODELAY and 16 threads sending from another
machine 64000-sized writes for 60 seconds.

I get 5898op/s (3.02Gb/s) without the patch against 18022ops/s
(9.23Gb/s) with the patch.

Best regards.
Cascardo.


> rick jones
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
