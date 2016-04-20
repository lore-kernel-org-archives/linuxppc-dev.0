Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqRY63gjZzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:03:54 +1000 (AEST)
Message-ID: <1461121434.13404.1.camel@ellerman.id.au>
Subject: Re: [PATCH V2 01/68] powerpc/cxl: Use REGION_ID instead of opencoding
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>,  Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>
Date: Wed, 20 Apr 2016 13:03:54 +1000
In-Reply-To: <87mvoy9ql8.fsf@skywalker.in.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87mvoy9ql8.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-13 at 08:12 +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> > Also note that the `~` operation is wrong.
> > 
> > Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > ---
> >  drivers/misc/cxl/fault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> > index 9a8650bcb042..9a236543da23 100644
> > --- a/drivers/misc/cxl/fault.c
> > +++ b/drivers/misc/cxl/fault.c
> > @@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
> >  	access = _PAGE_PRESENT;
> >  	if (dsisr & CXL_PSL_DSISR_An_S)
> >  		access |= _PAGE_RW;
> > -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> > +	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
> >  		access |= _PAGE_USER;
> > 
> >  	if (dsisr & DSISR_NOHPTE)
> 
> Posted an updated version of this patch alone with improved commit
> message here
> 
> http://mid.gmane.org/1460482475-20782-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

I never saw it. And that link is empty?

cheers
