Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7C6CC1400A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 03:23:26 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 12:23:23 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BAE7438C8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:23:19 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PGNJdx2949550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 16:23:19 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PGNIP6014026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:23:19 -0400
Date: Tue, 25 Mar 2014 09:23:03 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
Message-ID: <20140325162303.GA29977@linux.vnet.ibm.com>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1403251116490.16557@nuc>
Cc: linux-mm@kvack.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25.03.2014 [11:17:57 -0500], Christoph Lameter wrote:
> On Mon, 24 Mar 2014, Nishanth Aravamudan wrote:
> 
> > Anyone have any ideas here?
> 
> Dont do that? Check on boot to not allow exhausting a node with huge
> pages?

Gigantic hugepages are allocated by the hypervisor (not the Linux VM),
and we don't control where the allocation occurs. Yes, ideally, they
would be interleaved to avoid this situation, but I can also see reasons
for having them all be from one node so that tasks can be affinitized
and get the guarantee of the 16GB pagesize benefit.

Thanks,
Nish
