Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyyBR4nRWzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:30:06 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Balbir Singh' <bsingharora@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v5 2/7] powerpc/vmlinux.lds: Align __init_begin to 16M
Date: Thu, 29 Jun 2017 11:29:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD002D97F@AcuExch.aculab.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
 <20170628170411.28864-3-bsingharora@gmail.com>
In-Reply-To: <20170628170411.28864-3-bsingharora@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh
> Sent: 28 June 2017 18:04
> For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M.
> We use 16M since its the larger of 2M on radix and 16M
> on hash for our linear mapping. The plan is to have
> .text, .rodata and everything upto __init_begin marked
> as RX. Note we still have executable read only data.
> We could further align rodata to another 16M boundary.
> I've used keeping text plus rodata as read-only-executable
> as a trade-off to doing read-only-executable for text and
> read-only for rodata.
...

Doesn't this go against 'address space randomisation'?
(Yes I realise a PIC kernel is probably non-trivial to compile
and load.)

	David
