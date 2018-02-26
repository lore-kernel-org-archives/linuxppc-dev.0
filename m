Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqTp25p8yzF1PJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 15:47:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1Q4i8eK091995
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 23:47:20 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gc9y4agaq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 23:47:19 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 25 Feb 2018 23:47:19 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and
 hotplug
In-Reply-To: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 15:47:12 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vaekmk6n.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
> commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.") uses stop-api provided by the firmware to restore
> PSSCR. PSSCR restore is required for handling special wakeup. When special
> wakeup is completed, the core enters stop state based on restored PSSCR.
>
> Currently PSSCR is restored to deepest available stop state, causing
> a idle cpu to enter deeper stop state on a special wakeup, which causes
> the cpu to hang on wakeup.
>
> A "sensors" command which reads temperature (through DTS sensors) on idle
> cpu can trigger special wakeup.
>
> Failed Scenario :
> Request restore of PSSCR with RL = 11
> cpu enters idle state (stop5)
>   user triggers "sensors" command
>    Assert special wakeup on cpu
>      Restores PSSCR with RL = 11  <---- Done by firmware
>       Read DTS sensor
>    Deassert special wakeup
>   cpu enters idle state (stop11) <-- Instead of stop5
>
> Cpu hang is caused because cpu ended up in a deeper state than it requested
>
> This patch fixes instability caused by special wakeup when stop11 is
> enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> Only when offlining cpu, request restore of PSSCR to deepest stop state.
> On onlining cpu, request restore of PSSCR to deepest stop state used by
> cpuidle.
>
> Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")

This should CC stable ?

We'll need this to enable stop11 in firmware and not break things, right?

-- 
Stewart Smith
OPAL Architect, IBM.
