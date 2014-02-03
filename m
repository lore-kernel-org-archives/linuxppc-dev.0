Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 100B82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 21:18:28 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 07094-05 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  3 Feb 2014 10:18:23 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Moese' <michael.moese@men.de>, David Hawkins
 <dwh@ovro.caltech.edu>
Subject: RE: PCIe Access - achieve bursts without DMA
Date: Mon, 3 Feb 2014 10:17:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6B774B@AcuExch.aculab.com>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop> <52EC2F46.7000609@ovro.caltech.edu>
 <20140203082050.GB1970@localhost.intra.men.de>
In-Reply-To: <20140203082050.GB1970@localhost.intra.men.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Moese
> Thank you for your help - we might be satisfied with the achieved
> 18 MB/s.

We achieved about twice that using the PEX dma controller.
I found the following comment I wrote:

/* Long transfer requests are cut into smaller DMA requests.
 * Each PCIe request can contain a maximum of 128 bytes, but the
 * dma engine can have multiple PCIe requests outstanding and this
 * speeds things up somewhat (50ns/byte with 128, 24ns/byte with 1024).
 * 1k is somewhere near the point of diminishing returns. */

Those times would include a system call.
The transfers were done through a simple driver that converted pread()
and pwrite() requests into accesses to the boards memory.
The non-dma versions are just copy_to/from_user() directly between
the PCIe and user buffers.

Your 3MB/s for single word transfers is similar to what we saw.
Cycle times that make an ISA bus look fast.

	David
