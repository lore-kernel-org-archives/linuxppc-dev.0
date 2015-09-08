Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 65A9E1A1F44
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 01:10:34 +1000 (AEST)
Date: Tue, 8 Sep 2015 12:10:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
 maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
 paulus@samba.org, scottwood@freescale.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
Message-ID: <20150908151027.GM3475@kernel.org>
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150831201300.GG4423@kernel.org>
 <55E54A4F.6090205@linux.vnet.ibm.com>
 <20150904205145.GB3475@kernel.org>
 <1441602655.12945.5.camel@ellerman.id.au>
 <55EE6A61.3010301@linux.vnet.ibm.com>
 <1441701225.7601.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441701225.7601.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Sep 08, 2015 at 06:33:45PM +1000, Michael Ellerman escreveu:
> On Tue, 2015-09-08 at 10:26 +0530, Hemant Kumar wrote:
> > 
> > On 09/07/2015 10:40 AM, Michael Ellerman wrote:
> > > On Fri, 2015-09-04 at 17:51 -0300, Arnaldo Carvalho de Melo wrote:
> > >> Em Tue, Sep 01, 2015 at 12:18:47PM +0530, Hemant Kumar escreveu:
> > >>>> Should I try to process the 5 together, applying thest two first?
> > >>   
> > >>> Yes, this patchset needs to be applied before applying the other patchset,
> > >>> since there is a direct dependency on these two for the tooling part to
> > >>> work.
> > >>   
> > >>>> I see there are no acks from powerpc arch maintainers, how should we
> > >>>> proceed here? If there are no problems with the arch bits, and if it is
> > >>>> just to enable the tooling part, again, should I process the 5 as just
> > >>>> one series?
> > >>   
> > >>> The reason to split the earlier patchset into two was to separate the
> > >>> tooling/perf/ and arch/powerpc/ side patches, as asked by Michael..
> > >>   
> > >>> Here is the link to that discussion :
> > >>> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg86916.html
> > >>   
> > >>> If Michael is ok with the patches, you can process all the 5 patches
> > >>> together. Michael?
> > >> Michael?
> > > I'm not particularly happy with it.
> > >
> > > Can we at least remove this hunk from the uapi header:
> > >
> > > +/* This is to shut the compiler up */
> > > +#define KVM_ENTRY_TRACE ""
> > > +#define KVM_EXIT_TRACE ""
> > > +#define KVM_EXIT_REASON ""
> > >
> > 
> > Agreed, I didn't like this too, but I kept this because of the generic
> > perf userspace code that looks for KVM_{ENTRY,EXIT}_TRACE and
> > KVM_EXIT_REASON. We can remove this and put this hunk in the
> > userspace side.
> 
> Yes please.
> 
> > Arnaldo,
> > Can we remove the dependency on uapi altogether (also suggested
> > by Scott) because it doesn't seem to fulfill much purpose? Rather,
> > hardcode the events in the userspace completely (since, tracepoint
> > event names are unlikely to change) ? Some of what is being done
> > by x86 already in kvm-stat.c where its defining kvm_events_tp[] and
> > its not using the macros, rather, the tracepoints directly. Macros are
> > only being used in builtin-kvm.c where the tracepoint names are
> > matched with KVM_{ENTRY,EXIT}_TRACE and when we are looking
> > for the key KVM_EXIT_REASON.
> 
> That would certainly make me a lot happier with it.
> 
> Also think about what would happen if the tracepoint names *did* change. The
> perf code would want to try and work with both the old and new names, so at
> that point you'd end up hard coding the names in the perf code anyway.

Yeah, seems like we have a plan :-)

- Arnaldo
