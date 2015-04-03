Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEDB11A0A05
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 05:29:03 +1100 (AEDT)
Date: Fri, 3 Apr 2015 14:28:52 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150403182852.GI26158@oracle.com>
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



Just want to confirm:

> > + again:
> > +	if (pass == 0 && handle && *handle &&
> > +	    (*handle >= pool->start) && (*handle < pool->end))
> > +		start = *handle;
> > +	else
> > +		start = pool->hint;
> 
> Now this means "handle" might be < pool->hint, in that case you also
> need a lazy flush. Or rather only if the resulting alloc is. My
         :

> > +		} else {
> > +			/* give up */
> > +			n = DMA_ERROR_CODE;
> > +			goto bail;
> > +		}
> > +	}
> 
> Here, make this something like:
> 
> 	} else if (end < pool->hint)
> 		need_flush = true;

you mean 

 	} else if (start < pool->hint)

right?  (so I'm not missing some corner-case that you are thinking
about here)

--Sowmini
 
