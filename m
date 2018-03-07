Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx5Zm106NzF1Z6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 18:57:03 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w277uhep038812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 02:57:01 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gjaankxg9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 02:57:01 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 07:56:59 -0000
Date: Wed, 7 Mar 2018 13:26:53 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, stable@vger.kernel.org
Subject: Re: [RESEND][PATCH] cpuidle/powernv : Restore different PSSCR for
 idle and hotplug
Reply-To: svaidy@linux.vnet.ibm.com
References: <1519846389-29414-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1519854022.2520.12.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1519854022.2520.12.camel@au1.ibm.com>
Message-Id: <20180307075653.GB26738@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@au1.ibm.com> [2018-03-01 08:40:22]:

> On Thu, 2018-03-01 at 01:03 +0530, Akshay Adiga wrote:
> > commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> > states via stop API.") uses stop-api provided by the firmware to restore
> > PSSCR. PSSCR restore is required for handling special wakeup. When special
> > wakeup is completed, the core enters stop state based on restored PSSCR.
> > 
> > Currently PSSCR is restored to deepest available stop state, causing
> > a idle cpu to enter deeper stop state on a special wakeup, which causes
> > the cpu to hang on wakeup.
> > 
> > A "sensors" command which reads temperature (through DTS sensors) on idle
> > cpu can trigger special wakeup.
> > 
> > Failed Scenario :
> > Request restore of PSSCR with RL = 11
> > cpu enters idle state (stop5)
> >   user triggers "sensors" command
> >    Assert special wakeup on cpu
> >      Restores PSSCR with RL = 11  <---- Done by firmware
> >       Read DTS sensor
> >    Deassert special wakeup
> >   cpu enters idle state (stop11) <-- Instead of stop5
> > 
> > Cpu hang is caused because cpu ended up in a deeper state than it requested
> > 
> > This patch fixes instability caused by special wakeup when stop11 is
> > enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> > Only when offlining cpu, request restore of PSSCR to deepest stop state.
> > On onlining cpu, request restore of PSSCR to deepest stop state used by
> > cpuidle.
> 
> So if we chose a stop state, but somebody else does a special wakeup,
> we'll end up going back into a *deeper* one than the one we came from ?

Unfortunately yes.  This is the current limitation.  If we are in stop4
and above and we had not set a PSSCR to be restored, then the hardware
will default to all bits set (stop15) leading to entry into stop11
after the special wakeup is removed.  The requirement is such that we
need to have a correct PSSCR restore value set using stop-api.

We need to set a restore PSSCR value that represents one in a group
like stop4,5,6,7 will have identical state loss, hence we can either
set a PSSCR of 7 or 4 or 5 for any of this stop state entry and not
have to use stop-api to set exact value of stop4 or 5 at every entry.
 
> I still think this is broken by design. The chip should automatically
> go back to the state it went to after special wakeup, thus the PPE
> controlling the state should override the PSSCR value accordingly
> rather than relying on those SW hoops.

Special wakeup de-assertion and re-entry hits this limitation where we
have lost the original content of PSSCR SPR and hence CME does not know
what was requested.

Additional stop-api calls from software could have been avoided, but
practically we have only cpu hotplug case that uses stop11 and needs
this stop-api.  We can default the system to stop4 or stop5 and then
make stop-api call to explicitly set stop11 and then hotplug out the
cpu. We have to restore the deepest cpuidle state (stop4/5) back
during online.  As such this is not much of software overhead. But we
need an elegant method to control these calls from OPAL flags so that
kernel behaviour can be more closely controlled.

If we want to use stop11 in cpuidle (despite being very slow) for
evaluation reasons, then we will need to make more stop-api call to
choose between stop4/5 vs stop11 since they belong to different group.
Even in this case, since stop11 is the slow path, we would want to set
stop11 before entry and restore to stop4/5 after wakeup.  This way we
still completely avoid stop-api call in fast-path stop4/5 entry/exit.

--Vaidy
