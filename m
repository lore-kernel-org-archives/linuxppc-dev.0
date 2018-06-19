Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4199LK4V7VzF0lh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 00:28:25 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JEOFUo049072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 10:28:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq0av1cj5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 10:28:23 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Jun 2018 15:28:19 +0100
Date: Tue, 19 Jun 2018 07:28:11 -0700
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
MIME-Version: 1.0
In-Reply-To: <877emvx84j.fsf@concordia.ellerman.id.au>
Message-Id: <20180619142811.GD5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:39:56PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > When a thread forks the contents of AMR, IAMR, UAMOR registers in the
> > newly forked thread are not inherited.
> >
> > Save the registers before forking, for content of those
> > registers to be automatically copied into the new thread.
> >
> > CC: Michael Ellerman <mpe@ellerman.id.au>
> > CC: Florian Weimer <fweimer@redhat.com>
> > CC: Andy Lutomirski <luto@kernel.org>
> > CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> 
> Again this is an ABI change but we'll call it a bug fix I guess.

yes. the same defense here too. its a behaviorial change for the better.
Single threaded applications will not see any behaviorial change.
Multithreaded apps, which were unable to consume, the behavior will now be
able to do so.

> 
> I'll add:
> 
>   Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
>   Cc: stable@vger.kernel.org # v4.16+

yes.  Thanks
RP
