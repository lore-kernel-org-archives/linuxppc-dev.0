Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7D651A01A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 04:36:13 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 12:36:10 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DF6ABC40002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:36:06 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6AIYvTe9634294
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 20:34:57 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6AIa6Pa013107
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:36:06 -0600
Message-ID: <53BEDD14.10901@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 11:36:04 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: dynamically added OF nodes need to call
 of_node_init
References: <1404955205-12847-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1404959630.27178.1.camel@concordia>
In-Reply-To: <1404959630.27178.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: grant.likely@linaro.org, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2014 07:33 PM, Michael Ellerman wrote:
> On Wed, 2014-07-09 at 21:20 -0400, Tyrel Datwyler wrote:
>> Commit 75b57ecf9 refactored device tree nodes to use kobjects such that they
>> can be exposed via /sysfs. A secondary commit 0829f6d1f furthered this rework
>> by moving the kobect initialization logic out of of_node_add into its own
>> of_node_init function. The inital commit removed the existing kref_init calls
>> in the pseries dlpar code with the assumption kobject initialization would
>> occur in of_node_add. The second commit had the side effect of triggering a
>> BUG_ON as a result of dynamically added nodes being uninitialized.
> 
> So does this mean DLPAR is broken since 0829f6d1f (3.15-rc1)?

Yes, as well as suspend and migration.

> 
> If so this should have a Cc: stable@kernel.org shouldn't it?

Doh, right you are.

> 
> And the latest trend is to also add:
> 
> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")

Got it. Will resend v2.

-Tyrel

> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
