Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zs53H6vkzzF1bx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 06:19:23 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1SJJ9qr081533
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 14:19:20 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gdx0a551m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 14:19:19 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 28 Feb 2018 19:19:17 -0000
Date: Thu, 1 Mar 2018 00:49:03 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and
 hotplug
References: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87vaekmk6n.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vaekmk6n.fsf@linux.vnet.ibm.com>
Message-Id: <20180228191903.23jmawvfqzbcwi2r@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 03:47:12PM +1100, Stewart Smith wrote:
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
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
> >
> > Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> > states via stop API.")
> 
> This should CC stable ?
> 
> We'll need this to enable stop11 in firmware and not break things, right?

Yes I will resend and CC it to stable.
> 
> -- 
> Stewart Smith
> OPAL Architect, IBM.
> 
