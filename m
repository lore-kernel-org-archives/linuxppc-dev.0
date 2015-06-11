Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83C421A07C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 07:28:13 +1000 (AEST)
Message-ID: <1434058075.2477.178.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc: support sizes greater than an unsigned long
From: Scott Wood <scottwood@freescale.com>
To: Cristian Stoica <cristian.stoica@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <horia.geanta@freescale.com>
Date: Thu, 11 Jun 2015 16:27:55 -0500
In-Reply-To: <5579B2FC.4010008@freescale.com>
References: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
 <1431683064-29584-1-git-send-email-cristian.stoica@freescale.com>
 <55799E38.1000004@freescale.com> <20150611153835.GB5058@kroah.com>
 <5579B2FC.4010008@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-06-11 at 19:10 +0300, Cristian Stoica wrote:
> On 06/11/2015 06:38 PM, Greg KH wrote:
> > On Thu, Jun 11, 2015 at 05:42:00PM +0300, Cristian Stoica wrote:
> > 
> > Why?
> > 
> 
> This patch matches the input argument "size" of ioremap() with the 
> output of request_mem_region() (which is
> resource_size_t).
> Since the latter is used as input to the former, the types should 
> match (even though mapping more than 4G is not usually
> expected). There are a lot of such differences in the code and this 
> is an attempt to reduce that.

Dropping the upper bits of the size harms the ability to detect error 
scenarios where unmappably large -- but not power-of-two -- regions 
are requested to be mapped.

However, this patch doesn't fix that.  It just postpones the loss of 
the upper 32 bits until __ioremap_caller() calls get_vm_area_caller().

There's also no error checking at all for the size of ioremap() done 
during early boot (!slab_is_available()).

Don't just blindly turn static analyzer reports into patches -- and 
why didn't the analyzer complain about the call to 
get_vm_area_caller() after this patch?

-Scott
