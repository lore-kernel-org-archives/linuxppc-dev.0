Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434251A0A3A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 08:07:05 +1100 (AEDT)
Message-ID: <1428095210.20500.291.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 04 Apr 2015 08:06:50 +1100
In-Reply-To: <20150403182852.GI26158@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150403182852.GI26158@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2015-04-03 at 14:28 -0400, Sowmini Varadhan wrote:
> 
> Just want to confirm:
> 
> > > + again:
> > > +	if (pass == 0 && handle && *handle &&
> > > +	    (*handle >= pool->start) && (*handle < pool->end))
> > > +		start = *handle;
> > > +	else
> > > +		start = pool->hint;
> > 
> > Now this means "handle" might be < pool->hint, in that case you also
> > need a lazy flush. Or rather only if the resulting alloc is. My
>          :
> 
> > > +		} else {
> > > +			/* give up */
> > > +			n = DMA_ERROR_CODE;
> > > +			goto bail;
> > > +		}
> > > +	}
> > 
> > Here, make this something like:
> > 
> > 	} else if (end < pool->hint)
> > 		need_flush = true;
> 
> you mean 
> 
>  	} else if (start < pool->hint)
> 
> right?  (so I'm not missing some corner-case that you are thinking
> about here)

No, I meant "n < pool->hint", ie, the start of the newly allocated
block.

"end" hasn't been adjusted yet at that point but we don't want to
compare "end" anyway (which will be n + npages), we really want n, ie if
the *beginning* of the newly allocated chunk is before the end of the
previous one (after all they may even overlap if the previous one has
been freed).

Ben.

> --Sowmini
>  
