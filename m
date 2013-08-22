Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73D532C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 08:55:36 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 18:55:32 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AA6136E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:55:24 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7MMtUHT15401168
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 22:55:30 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7MMtTX8024065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:55:29 -0300
Received: from suka2 (suka2.usor.ibm.com [9.70.94.91])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r7MMtTug024057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:55:29 -0300
Date: Thu, 22 Aug 2013 15:55:26 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Detecting LD/ST instruction
Message-ID: <20130822225525.GA5214@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am working on implementing the 'perf mem' command for Power
systems. This would for instance, let us know where in the memory
hierarchy (L1, L2, Local RAM etc) the data for a load/store
instruction was found (hit).

On Power7, if the mcmcra[DCACHE_MISS] is clear _and_ the
instruction is a load/store, then it implies a L1-hit.

Unlike on Power8, the Power7 event vector has no indication
if the instruction was load/store.

In the context of a PMU interrupt, is there any way to determine
if an instruction is a load/store ?

Sukadev
