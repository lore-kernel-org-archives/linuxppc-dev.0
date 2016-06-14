Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTJZV00nJzDqhD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 15:47:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E5i3R9103011
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 01:47:27 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23geqnsr6j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 01:47:27 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 15:46:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DB2A52BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 15:46:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5E5kTvD66060510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 15:46:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5E5kSu0027002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 15:46:29 +1000
Date: Tue, 14 Jun 2016 11:16:15 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au,
 nfont@linux.vnet.ibm.com, aik@au1.ibm.com
Subject: Re: [FIX PATCH v2 0/2] Fix powerpc,numa: Fix memory_hotplug_max()
Reply-To: bharata@linux.vnet.ibm.com
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20160614044651.GB5916@in.ibm.com>
 <1465881567.17785.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465881567.17785.2.camel@ellerman.id.au>
Message-Id: <20160614054615.GA7022@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2016 at 03:19:27PM +1000, Michael Ellerman wrote:
> On Tue, 2016-06-14 at 10:16 +0530, Bharata B Rao wrote:
> > On Thu, May 12, 2016 at 07:04:13PM +0530, Bharata B Rao wrote:
> > > This patchset fixes memory_hotplug_max() routine to return correct
> > > value of maximum hotpluggable address.
> > > 
> > > In this version, whitespace fixes are separated into a different patch.
> > > 
> > > v2: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg103342.html
> > > 
> > > Bharata B Rao (2):
> > >   powerpc,numa: Fix whitespace in hot_add_drconf_memory_max()
> > >   powerpc,numa: Fix memory_hotplug_max()
> > > 
> > >  arch/powerpc/mm/numa.c | 36 ++++++++++++++++++++++++++----------
> > >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > Can this fix be considered for inclusion ? Should I be posting this against
> > latest git now ?
> 
> No that's fine, it still applies cleanly.
> 
> Have you tested this on PowerVM ?

No. Let me grab a PowerVM box, test and get back.

> 
> Has this always been broken, or did we break it in a particular commit? If the
> latter can you tell me which commit.

memory_hotplug_max() got introduced in cd34206e9 and has been buggy since then.
Just that it got exposed by memory hotplug and DDW features on PowerKVM.

> 
> Should we be sending this to stable?

I am not sure as only PowerKVM is affected with the introducion of DDW feature
in yet-to-be-released QEMU-2.7. Even there, we are working around the problem
within QEMU itself, but better to fix this in the kernel once.

Regards,
Bharata.
