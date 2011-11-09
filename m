Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR001.bigfish.com (smtp-cpk.frontbridge.com
 [204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 284B5B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 22:38:34 +1100 (EST)
Received: from mail90-db3 (localhost.localdomain [127.0.0.1])	by
 mail90-db3-R.bigfish.com (Postfix) with ESMTP id 8835F7D00BC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 11:38:07 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.249])	by
 mail90-db3.bigfish.com (Postfix) with ESMTP id 54BE118D8050	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 11:38:07 +0000 (UTC)
Received: from localhost.localdomain ([10.193.20.166])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id pA9BcCTx015804	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 05:38:13 -0600 (CST)
Date: Wed, 9 Nov 2011 19:38:13 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20111109113813.GB3303@localhost.localdomain>
References: <1320410166-14500-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4403E.3040700@freescale.com>
 <20111107102724.GA16470@localhost.localdomain>
 <4EB82870.1090907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EB82870.1090907@freescale.com>
Sender: <zch@localhost.localdomain>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: zch@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2011 at 12:50:24PM -0600, Scott Wood wrote:
> On 11/07/2011 04:27 AM, Zhao Chenhui wrote:
> > On Fri, Nov 04, 2011 at 02:42:54PM -0500, Scott Wood wrote:
> >> On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
> >>> +	cpufreq_frequency_table_target(policy,
> >>> +				       mpc85xx_freqs,
> >>> +				       target_freq,
> >>> +				       relation,
> >>> +				       &new);
> >>> +
> >>> +	freqs.old = policy->cur;
> >>> +	freqs.new = mpc85xx_freqs[new].frequency;
> >>> +	freqs.cpu = policy->cpu;
> >>> +
> >>> +	mutex_lock(&mpc85xx_switch_mutex);
> >>> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> >>> +
> >>> +	pr_info("Setting frequency for core %d to %d kHz, " \
> >>> +		 "PLL ratio is %d/2\n",
> >>> +		 policy->cpu,
> >>> +		 mpc85xx_freqs[new].frequency,
> >>> +		 mpc85xx_freqs[new].index);
> >>> +
> >>> +	set_pll(mpc85xx_freqs[new].index, policy->cpu);
> >>> +
> >>> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> >>> +	mutex_unlock(&mpc85xx_switch_mutex);
> >>> +
> >>> +	ppc_proc_freq = freqs.new * 1000ul;
> >>
> >> ppc_proc_freq is global -- can CPUs not have their frequencies adjusted
> >> separately?
> >>
> >> It should be under the lock, if the lock is needed at all.
> >>
> > 
> > There is only one ppc_proc_freq. no lock.
> 
> I realize there's only one.
> 
> I'm asking whether CPUs can have their frequencies set indpendently --
> if the answer is no, and this function is not specific to a CPU, my only
> concern is the lock.  Either this function can be called multiple times
> in parallel, in which case the ppc_proc_freq update should be inside the
> lock, or it can't, in which case why do we need the lock at all?
> 
> -Scott

Yes. They can be changed independently.
I will set ppc_proc_freq inside the lock.

-chenhui
