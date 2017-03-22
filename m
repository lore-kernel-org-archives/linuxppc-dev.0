Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnzBB3NHkzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:43:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M5dAUO074411
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:43:24 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vmgast-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:43:23 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 01:43:23 -0400
Date: Wed, 22 Mar 2017 11:13:15 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/4] powernv:idle: Don't override default/deepest
 directly in kernel
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <84bfbacbd0ab98dd82241292a29e4d5d1bb456c6.1490024477.git.ego@linux.vnet.ibm.com>
 <20170321023934.1a9b84f6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321023934.1a9b84f6@roar.ozlabs.ibm.com>
Message-Id: <20170322054315.GA8326@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, Mar 21, 2017 at 02:39:34AM +1000, Nicholas Piggin wrote:
> > @@ -241,8 +240,9 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
> >   * The default stop state that will be used by ppc_md.power_save
> >   * function on platforms that support stop instruction.
> >   */
> > -u64 pnv_default_stop_val;
> > -u64 pnv_default_stop_mask;
> > +static u64 pnv_default_stop_val;
> > +static u64 pnv_default_stop_mask;
> > +static bool default_stop_found;
> >  
> >  /*
> >   * Used for ppc_md.power_save which needs a function with no parameters
> > @@ -262,8 +262,9 @@ static void power9_idle(void)
> >   * psscr value and mask of the deepest stop idle state.
> >   * Used when a cpu is offlined.
> >   */
> > -u64 pnv_deepest_stop_psscr_val;
> > -u64 pnv_deepest_stop_psscr_mask;
> > +static u64 pnv_deepest_stop_psscr_val;
> > +static u64 pnv_deepest_stop_psscr_mask;
> > +static bool deepest_stop_found;
> 
> Aha you have made them static. Nitpick withdrawn :)
> 
> The log messages look good now.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
Thanks!

--
Thanks and Regards
gautham.
