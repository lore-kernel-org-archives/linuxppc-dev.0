Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C711A0B9E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 05:17:31 +1000 (AEST)
Date: Sun, 5 Apr 2015 15:17:06 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv9 RFC 1/3] Break up monolithic iommu table/lock into
 finer graularity pools and lock
Message-ID: <20150405191706.GA19554@oracle.com>
References: <cover.1428181553.git.sowmini.varadhan@oracle.com>
 <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
 <1428236761.20500.315.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428236761.20500.315.camel@kernel.crashing.org>
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

On (04/05/15 22:26), Benjamin Herrenschmidt wrote:
> 
> So you decided to keep the logic here that updates the hint instead of
> just getting rid of need_flush alltogether ?
> 
> Out of curiosity, what's the rationale ? Did you find a reason why
> resetting the hint in those two cases (rather than just setting "start"
> appropriately) is actually useful ?

To be honest, I actually did not want to poke at this too much, given
that both ppc and sparc seem to have essentially the same
logic.

But my gut feeling is that if the pool->hint hasn't resulted
in a succesful area_alloc, we might as well reset it for the next
iommu*range_alloc-er, because it's likely that the next alloc
will also need to  wrap and search anyway..

--Sowmini
