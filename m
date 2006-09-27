Return-Path: <johnrose@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4A34679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 04:29:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8RITRcB029181
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 14:29:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8RISfcw353746
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 12:28:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8RISfJp028995
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 12:28:41 -0600
Subject: Re: iommu hypervisor hypothetical
From: John Rose <johnrose@austin.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060927120723.678eee22@localhost.localdomain>
References: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
	<20060927120723.678eee22@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1159381557.19103.17.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 27 Sep 2006 13:25:57 -0500
Cc: Santiago Leon <saleon@us.ibm.com>, External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So just change the prototype of tce_build
> to return success/failure, and handle it accordingly in iommu_alloc
> (DMA_ERROR_CODE). The error should move on up the stack from there.

I'm thinking of functions like dma_map_single(), which returns the
unsigned type dma_addr_t.  Suppose H_HCE_PUT fails, and this gets
propagated up to the device driver through DMA_ERROR_CODE.  The PAPR
currently defines 2 ways in which this could fail, and we're considering
at least one more.  One error code doesn't seem sufficient.

> Or did I misunderstand your question in the first place? It's sort of
> sparse on details. :-)

You know how it goes :)  I guess my question is whether passing specific
failure conditions up the call chain is permissible/feasible, and
whether the prototypes for the various device driver DMA utilities are
set in stone.

Thanks-
John
