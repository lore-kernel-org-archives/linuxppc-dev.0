Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZlZW1FxCzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 22:21:07 +1100 (AEDT)
Message-ID: <1459336866.23987.8.camel@ellerman.id.au>
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Date: Wed, 30 Mar 2016 22:21:06 +1100
In-Reply-To: <56FB7CB8.1010801@linux.vnet.ibm.com>
References: <3qZT2T1R7fz9sDC@ozlabs.org> <56FB7CB8.1010801@linux.vnet.ibm.com>
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

On Wed, 2016-03-30 at 12:44 +0530, Hari Bathini wrote:
> On 03/30/2016 05:55 AM, Michael Ellerman wrote:
> > On Tue, 2016-29-03 at 18:34:37 UTC, Hari Bathini wrote:
> > > @@ -1244,6 +1235,16 @@ __end_handlers:
> > >   	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
> > >   	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
> > >
> > > +	/* FIXME: For now, let us move the __end_interrupts marker down past
> > Why is it FIXME?
> >
> > In general I don't want to merge code that adds a FIXME unless there is some
> > very good reason.
> >
> > AFAICS this is a permanent solution isn't it?
>
> Except for a few short interrupt vectors like 0x4f00, 04f20, etc., all other
> vectors defined till __end_interrupts marker ensure that LOAD_HANDLER() is
> used for branching to labels like system_call_entry, data_access_common,
> etc. that are currently not copied to real 0 in relocation case.
>
> So, we are forced to move the __end_interrupts marker down only to handle
> space constraint in the short vectors. So, I added the FIXME to remind the
> scope for improvement in the code. But after thinking over again now, moving
> the marker down makes us copy an additional 1~2 KB along with the 21~22 KB
> that we are copying already. So, not much of an improvement to lose
> sleep over or to add a FIXME, I guess. Your thoughts?

OK, that makes sense. I still wouldn't add a FIXME unless you have a plan to
fix it "properly" in the medium term. And I don't think we really do.

So if we merge it with a FIXME there's a good chance the FIXME will be there in
10 years, which is not really helpful. A comment saying "we only need this here
because of xx, and we could move it to y if z happened" is helpful.

As far as the size of the copy, that doesn't really concern me at all. What I
want is a solution that's robust into the future. This has been badly broken
for quite a while and we didn't notice :/

cheers
