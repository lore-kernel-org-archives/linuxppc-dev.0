Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40chQs2mlBzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 16:08:37 +1000 (AEST)
Message-ID: <1525414108.2560.3.camel@russell.cc>
Subject: Re: [PATCH 02/13] powerpc/eeh: Add final message for successful
 recovery
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, Sam Bobroff
 <sbobroff@linux.ibm.com>,  linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 16:08:28 +1000
In-Reply-To: <874ljo9ljl.fsf@concordia.ellerman.id.au>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e2cc8562dcce1d8bc38084bc45414c048b5a441d.1525242772.git.sbobroff@linux.ibm.com>
 <874ljo9ljl.fsf@concordia.ellerman.id.au>
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

On Fri, 2018-05-04 at 12:55 +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
> 
> > Add a single log line at the end of successful EEH recovery, so
> > that
> > it's clear that event processing has finished.
> > 
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/eeh_driver.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/kernel/eeh_driver.c
> > b/arch/powerpc/kernel/eeh_driver.c
> > index 56a60b9eb397..07e0a42035ce 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -910,6 +910,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
> >  	pr_info("EEH: Notify device driver to resume\n");
> >  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
> >  
> > +	pr_info("EEH: Recovery successful.\n");
> Is it possible for recovery for multiple devices to be interleaved?
> 
> Should that message include the device?

Pretty sure EEH will only process a single error at a time so this
*should* always let you infer from context, but PHB and PE should
probably be included anyway.  It'd be cool to move pe_{err/warn/info}()
out of powernv for messages like this.

- Russell

> 
> cheers
