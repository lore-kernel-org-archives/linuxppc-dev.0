Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B8892C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:17:53 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Fri, 20 Dec 2013 13:17:51 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0783B6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:17:46 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBKIHnne7340458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 18:17:49 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBKIHmMg025263
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:17:48 -0500
Received: from oc3347516403.ibm.com ([9.80.82.166])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rBKIHkir025186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:17:48 -0500
Date: Fri, 20 Dec 2013 12:17:46 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv: eeh: add buffer for P7IOC hub error data
Message-ID: <20131220181746.GB5480@oc3347516403.ibm.com>
References: <20131219231853.GB22418@oc3347516403.ibm.com>
 <20131220014504.GB10795@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131220014504.GB10795@shangw.(null)>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 20, 2013 at 09:45:04AM +0800, Gavin Shan wrote:
> On Thu, Dec 19, 2013 at 05:18:53PM -0600, Brian W Hart wrote:
> >Prevent ioda_eeh_hub_diag() from clobbering itself when called by supplying
> >a buffer for P7IOC hub diagnostic data.  Take care to inform OPAL of the
> >correct size for the buffer.
> >
> >Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
> >---
> >
> >I hope I've understood this correctly.  It looks to me like
> >ioda_eeh_hub_data is effectively asking OPAL to clobber its own
> >text (via 'data') when it makes the call to retrieve the hub data.
> >
> 
> Yeah, we should have used following variable as HUB diag-data instead.
> 
> static char *hub_diag = NULL;
> 
> However, it's not safe to allocate page-sized buffer for "hub_diag".
> 
> >Added a hub diagnostic structure per-phb.  Perhaps the diagnostic
> >structure better belongs in the phb->diag union, but I wasn't sure whether
> >we'd need to carry the hub and PHB diag data at the same time.
> >
> 
> Please put hub diag-data to struct pnv_phb::diag since we don't need
> carry hub and PHB diag-data at same time. With it, please remove
> variable "hub_diag" as well.

Thanks; will send another patch.
