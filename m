Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BTPs5SjBzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:36:00 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5LHYTtY091590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 13:35:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jrgeur9f0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 13:35:57 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 21 Jun 2018 18:35:56 +0100
Date: Thu, 21 Jun 2018 10:35:48 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 2/6] powerpc/pkeys: Save the pkey registers before fork
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-3-git-send-email-linuxram@us.ibm.com>
 <877emvx84j.fsf@concordia.ellerman.id.au>
 <20180619142811.GD5294@ram.oc3035372033.ibm.com>
 <87a7rowzd7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <87a7rowzd7.fsf@concordia.ellerman.id.au>
Message-Id: <20180621173548.GK5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 02:13:40PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > On Tue, Jun 19, 2018 at 10:39:56PM +1000, Michael Ellerman wrote:
> >> Ram Pai <linuxram@us.ibm.com> writes:
> >> 
> >> > When a thread forks the contents of AMR, IAMR, UAMOR registers in the
> >> > newly forked thread are not inherited.
> >> >
> >> > Save the registers before forking, for content of those
> >> > registers to be automatically copied into the new thread.
> >> >
> >> > CC: Michael Ellerman <mpe@ellerman.id.au>
> >> > CC: Florian Weimer <fweimer@redhat.com>
> >> > CC: Andy Lutomirski <luto@kernel.org>
> >> > CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >> 
> >> Again this is an ABI change but we'll call it a bug fix I guess.
> >
> > yes. the same defense here too. its a behaviorial change for the better.
> > Single threaded applications will not see any behaviorial change.
> > Multithreaded apps, which were unable to consume, the behavior will now be
> > able to do so.
> 
> Well threads is one thing, but this also affects processes.
> 
> And actually without this fix it's possible that a child process could
> fault on a region protected in the parent, if the value in the AMR in
> the thread struct happens to block access at the time of fork(). The
> value in the thread struct would be whatever was in the AMR the last
> time the parent was scheduled in. I think?

right. Child processes will see stale value of AMR. Technically this
behavior is a bug, since existing applications; if any,  cannot rely on
this stale AMR value.

RP
