Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 332101A0EA7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 16:29:29 +1100 (AEDT)
Message-ID: <1421904568.4598.5.camel@ellerman.id.au>
Subject: Re: offlining cpus breakage
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 22 Jan 2015 16:29:28 +1100
In-Reply-To: <54B8D56D.3070904@linux.vnet.ibm.com>
References: <54ACFE6D.3070308@ozlabs.ru>
 <54B7BEF9.8090603@linux.vnet.ibm.com> <54B85B3C.1030000@ozlabs.ru>
 <1421377482.18166.5.camel@ellerman.id.au>
 <54B8D228.4000407@linux.vnet.ibm.com> <54B8D56D.3070904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-16 at 14:40 +0530, Preeti U Murthy wrote:
> On 01/16/2015 02:26 PM, Preeti U Murthy wrote:
> > On 01/16/2015 08:34 AM, Michael Ellerman wrote:
> >> On Fri, 2015-01-16 at 13:28 +1300, Alexey Kardashevskiy wrote:
> >>> On 01/16/2015 02:22 AM, Preeti U Murthy wrote:
> >>>> Hi Alexey,
> >>>>
> >>>> Can you let me know if the following patch fixes the issue for you ?
> >>>> It did for us on one of our machines that we were investigating on.
> >>>
> >>> This fixes the issue for me as well, thanks!
> >>>
> >>> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>	
> >>
> >> OK, that's great.
> >>
> >> But, I really don't think we can ask upstream to merge this patch to generic
> >> code when we don't have a good explanation for why it's necessary. At least I'm
> >> not going to ask anyone to do that :)
> >>
> >> So Pretti can you either write a 100% convincing explanation of why this patch
> >> is correct in the general case, or (preferably) do some more investigating to
> >> work out what Alexey's bug actually is.
> > 
> > Yes will do so. Its better to investigate where precisely is the bug.
> > This patch helped me narrow down on the buggy scenario.
> 
> On a side note, while I was tracking the race condition, I noticed that
> in the final stage of the cpu offline path, after the state of the
> hotplugged cpu is set to CPU_DEAD, we check if there were interrupts
> delivered during the soft disabled state and service them if there were.
> It makes sense to check for pending interrupts in the idle path. In the
> offline path however, this did not look right to me at first glance. Am
> I missing something ?

That does sound a bit fishy.

I guess we're just assuming that all interrupts have been migrated away prior
to the offline?

cheers
