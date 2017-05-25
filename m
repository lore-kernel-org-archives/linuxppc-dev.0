Return-Path: <srs0=ecaq=47=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYHrq3spkzDqbr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:29:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wYHrq2r4pz8sxJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:29:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wYHrp5ynyz9s9Y
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 15:29:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P5SYqn029131
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:29:44 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2anpm65nh2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:29:44 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 May 2017 01:29:43 -0400
Date: Wed, 24 May 2017 22:29:29 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 apopple@au1.ibm.com, oohall@gmail.com, michael.neuling@au1.ibm.com
Subject: Re: [PATCH v4 04/11] VAS: Define vas_init() and vas_exit()
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <ec960605-e705-b400-cdc8-def7233d3870@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec960605-e705-b400-cdc8-def7233d3870@linux.vnet.ibm.com>
Message-Id: <20170525052929.GE26091@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler [tyreld@linux.vnet.ibm.com] wrote:
> > +	vinst = &vas_instances[0];
> > +	for_each_node_by_name(dn, "vas") {
> > +		rc = init_vas_instance(dn, vinst);
> > +		if (rc) {
> > +			pr_err("Error %d initializing VAS instance %ld\n", rc,
> > +					(vinst-&vas_instances[0]));
> 
> You need a of_node_put(dn) here. The for_each_node_by_name() loop will get/put the
> references of the device_node for you. However, if you bail out of the loop you are
> responsible for the of_node_put() on the current *dn reference otherwise you will leak a
> reference.

Thanks for the pointing it out.  Based on Ben's comments, I have modified this
code and no longer need to break out of the loop.

Sukadev
