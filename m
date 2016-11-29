Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSY7n16K7zDvyK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 17:10:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT648fq009491
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:10:42 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2711wntykv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:10:42 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 01:10:41 -0500
Date: Tue, 29 Nov 2016 11:40:35 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 skiboot@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powernv: Pass PSSCR value and mask to
 power9_idle_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <f3853e81d3b3a1cf51a920acbbddc8f64238d7b6.1478760806.git.ego@linux.vnet.ibm.com>
 <87shqittgx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shqittgx.fsf@concordia.ellerman.id.au>
Message-Id: <20161129061035.GB30454@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, Nov 23, 2016 at 08:51:10PM +1100, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The power9_idle_stop method currently takes only the requested stop
> > level as a parameter and picks up the rest of the PSSCR bits from a
> > hand-coded macro. This is not a very flexible design, especially when
> > the firmware has the capability to communicate the psscr value and the
> > mask associated with a particular stop state via device tree.
> >
> > This patch modifies the power9_idle_stop API to take as parameters the
> > PSSCR value and the PSSCR mask corresponding to the stop state that
> > needs to be set. These PSSCR value and mask are respectively obtained
> > by parsing the "ibm,cpu-idle-state-psscr" and
> > "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
> >
> > In addition to this, the patch adds support for handling stop states
> > for which ESL and EC bits in the PSSCR are zero. As per the
> > architecture, a wakeup from these stop states resumes execution from
> > the subsequent instruction as opposed to waking up at the System
> > Vector.
> >
> > The older firmware sets only the Requested Level (RL) field in the
> > psscr and psscr-mask exposed in the device tree. For older firmware
> > where psscr-mask=0xf, this patch will set the default sane values that
> > the set for for remaining PSSCR fields (i.e PSLL, MTL, ESL, EC, and
> > TR).
> 
> So we're using psscr-mas=0xf as a signal that we're running on old
> firmware.
> 
> That's OK I think, but please send a patch to document it in the device
> tree binding.
> 
> And call it out below in the code.

Sure will do this! Thanks for reviewing the code.

> 
> cheers
> 

--
Thanks and Regards
gautham.
