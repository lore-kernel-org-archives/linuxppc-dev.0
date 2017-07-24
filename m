Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGVc65XCdzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 04:42:46 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id p3so2412968qtg.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:42:46 -0700 (PDT)
Subject: Re: [PATCH] powerpc/pseries: Fix of_node_put() underflow during
 pseries remove
To: Michael Ellerman <mpe@ellerman.id.au>, Laurent Vivier
 <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20170721145139.9384-1-lvivier@redhat.com>
 <87tw22jeud.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <a4601a62-71c1-8b67-61fe-795dbed8397c@gmail.com>
Date: Mon, 24 Jul 2017 11:42:40 -0700
MIME-Version: 1.0
In-Reply-To: <87tw22jeud.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2017 03:42 AM, Michael Ellerman wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
>> underflow during DLPAR remove"), the call to of_node_put()
>> must be removed from pSeries_reconfig_remove_node().
>>
>> dlpar_detach_node() and pSeries_reconfig_remove_node() call
>> of_detach_node(), and thus the node should not be released
>> in this case too.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  arch/powerpc/platforms/pseries/reconfig.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Thanks. I'll spare you the swearing about why we have the same bug in
> two places.

That's probably my bad. I must have failed to test with older powerpc-util tooling where
drmgr uses the /proc/ofdt interface for device tree modification.

-Tyrel

> 
> As for the other fix, I'll add:
> 
> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
> Cc: stable@vger.kernel.org # v3.15+
> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
>> index e5bf1e8..011ef21 100644
>> --- a/arch/powerpc/platforms/pseries/reconfig.c
>> +++ b/arch/powerpc/platforms/pseries/reconfig.c
>> @@ -82,7 +82,6 @@ static int pSeries_reconfig_remove_node(struct device_node *np)
>>  
>>  	of_detach_node(np);
>>  	of_node_put(parent);
>> -	of_node_put(np); /* Must decrement the refcount */
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.9.4
