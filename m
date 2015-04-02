Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 598D81A078D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 08:55:07 +1100 (AEDT)
Date: Thu, 2 Apr 2015 17:54:53 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150402215453.GB15680@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428008044.20500.272.camel@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the other question that comes to my mind is: the whole lazy_flush
optimization probably works best when there is exactly one pool,
and no large pools. In most other cases, we'd end up doing a lazy_flush
when we wrap within our pool itself, losing the benefit of that 
optimization. 

Given that the lazy_flush is mostly there to avoid regressions for 
the older sun4u architectures (which have other hardware bottlenecks 
anyway), and this code is rapidly getting messy, does it make sense
to constrain the lazy_flush check to only apply for the 1-pool, 
no-large-pool case?
