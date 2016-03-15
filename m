Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPLjv0YyyzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 15:09:54 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 15 Mar 2016 09:39:51 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2F49PDV4325724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 09:39:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2F49ghx031948
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 09:39:45 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
In-Reply-To: <1458001649.12098.59.camel@neuling.org>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
Date: Tue, 15 Mar 2016 09:39:29 +0530
Message-ID: <87shzsmlfq.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

Michael Neuling <mikey@neuling.org> writes:

> I'm not happy with doing this unless we add something which advertises
> that it's synced or not to userspace.
>
> If we do that, I'm happy to just fail without the need of the parameter
> but advertise it to userspace.
>
> The parameter is a bit of a PITA too, as it's a driver level config not
> card level.  You really want to turn it on/off based on the card, not
> the whole system.

Would a bool attribute in sysfs for the card (e.g timebase_sync) make
sense? We can by default ignore (and log) timebase sync errors during card
initialization and provide a simple wrapper in libcxl to query and set
this attribute afterwards.

Also it might be better if the AFU advertises the need for timebase
synchronization via a configuration record so that we enable it for the
psl iif one of the slices asks for it. I am not sure if this possible at
the moment but I believe it something we can put forth the psl/hdk team
before timebase usage becomes more widespread.

~ Vaibhav
