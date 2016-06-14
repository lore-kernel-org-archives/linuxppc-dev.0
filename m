Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTSD426jJzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:32:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EBU3vt015853
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:32:02 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jfmnb9xe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:32:01 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 14 Jun 2016 21:31:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9335A3578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:31:57 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EBVvwD38011036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:31:57 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EBVuoW017057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:31:57 +1000
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>, maddy@linux.vnet.ibm.com
Date: Tue, 14 Jun 2016 21:31:17 +1000
In-Reply-To: <575FE64C.9080107@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465903877.30200.9.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
	
	
 <1465854492.3022.30.camel@au1.ibm.com>
	 <575FE64C.9080107@linux.vnet.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.3 (3.20.3-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2016-06-14 at 16:41 +0530, Shreyas B Prabhu wrote:
> >> +            psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> >> +                                GFP_KERNEL);
> >> +            rc = of_property_read_u64_array(power_mgt,
> >> +                                            "ibm,cpu-idle-state-psscr",
> >> +                                            psscr_val, dt_idle_states);
> > 
> > Here, psscr val is only one u64 ... shouldn't you kmalloc sizeof(..) *
> > dt_idle_states ?
> 
> I'm using kcalloc here since checkpatch script suggested kcalloc over
> kzalloc for allocating memory for arrays.
> I'll also include a patch to use kcalloc throughout the file for
> uniformity in next version. I was originally planning to post that
> cleanup separately.

Ah ok, I missed the use of kcalloc (I didn't even know its existence),
my brain just read kmalloc :-)

Still, I find it inconsistent that you allocate here while you use the
stack for the names. Any reason for that ?

Cheers,
Ben.
