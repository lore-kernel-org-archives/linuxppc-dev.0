Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ABE01A0185
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:40:41 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 09:40:37 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EACD96E8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 09:40:25 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6ADeZIF131330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 13:40:35 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6ADeYEV005054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 09:40:35 -0400
Message-ID: <53BE97D1.1070000@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 08:40:33 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: dynamically added OF nodes need to call
 of_node_init
References: <1404955205-12847-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1404959630.27178.1.camel@concordia>
In-Reply-To: <1404959630.27178.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2014 09:33 PM, Michael Ellerman wrote:
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

Yes. Partition migration would also be affected by this.

-Nathan

> 
> If so this should have a Cc: stable@kernel.org shouldn't it?
> 
> And the latest trend is to also add:
> 
> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
> 
> cheers
> 
> 
