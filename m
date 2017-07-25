Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGm2F2LmvzDrBS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 14:47:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] powerpc/pseries: Fix of_node_put() underflow during
 pseries remove
In-Reply-To: <a4601a62-71c1-8b67-61fe-795dbed8397c@gmail.com>
References: <20170721145139.9384-1-lvivier@redhat.com>
 <87tw22jeud.fsf@concordia.ellerman.id.au>
 <a4601a62-71c1-8b67-61fe-795dbed8397c@gmail.com>
Date: Tue, 25 Jul 2017 14:47:48 +1000
Message-ID: <87inih6s23.fsf@concordia.ellerman.id.au>
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

Tyrel Datwyler <turtle.in.the.kernel@gmail.com> writes:

> On 07/24/2017 03:42 AM, Michael Ellerman wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>> 
>>> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
>>> underflow during DLPAR remove"), the call to of_node_put()
>>> must be removed from pSeries_reconfig_remove_node().
>>>
>>> dlpar_detach_node() and pSeries_reconfig_remove_node() call
>>> of_detach_node(), and thus the node should not be released
>>> in this case too.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/reconfig.c | 1 -
>>>  1 file changed, 1 deletion(-)
>> 
>> Thanks. I'll spare you the swearing about why we have the same bug in
>> two places.
>
> That's probably my bad. I must have failed to test with older powerpc-util tooling where
> drmgr uses the /proc/ofdt interface for device tree modification.

OK. Really we should have automated tests of the various cases, I've
just never had time to write any.

Mainly the thing that bugs me is that we still have the two separate
paths. Or if we must maintain both they could at least share more code,
the two functions do basically the same thing AFAICS.

cheers
