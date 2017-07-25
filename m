Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xH5Sn6sLlzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 03:53:29 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id u19so2365082qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 10:53:29 -0700 (PDT)
Subject: Re: [PATCH] powerpc/pseries: Fix of_node_put() underflow during
 pseries remove
To: Michael Ellerman <mpe@ellerman.id.au>, Laurent Vivier
 <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20170721145139.9384-1-lvivier@redhat.com>
 <87tw22jeud.fsf@concordia.ellerman.id.au>
 <a4601a62-71c1-8b67-61fe-795dbed8397c@gmail.com>
 <87inih6s23.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <f6209720-305b-0503-9549-d11f84b7ffbb@gmail.com>
Date: Tue, 25 Jul 2017 10:53:23 -0700
MIME-Version: 1.0
In-Reply-To: <87inih6s23.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2017 09:47 PM, Michael Ellerman wrote:
> Tyrel Datwyler <turtle.in.the.kernel@gmail.com> writes:
> 
>> On 07/24/2017 03:42 AM, Michael Ellerman wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>
>>>> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
>>>> underflow during DLPAR remove"), the call to of_node_put()
>>>> must be removed from pSeries_reconfig_remove_node().
>>>>
>>>> dlpar_detach_node() and pSeries_reconfig_remove_node() call
>>>> of_detach_node(), and thus the node should not be released
>>>> in this case too.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>  arch/powerpc/platforms/pseries/reconfig.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>
>>> Thanks. I'll spare you the swearing about why we have the same bug in
>>> two places.
>>
>> That's probably my bad. I must have failed to test with older powerpc-util tooling where
>> drmgr uses the /proc/ofdt interface for device tree modification.
> 
> OK. Really we should have automated tests of the various cases, I've
> just never had time to write any.

Agreed, some better CI is warranted.

> 
> Mainly the thing that bugs me is that we still have the two separate
> paths. Or if we must maintain both they could at least share more code,
> the two functions do basically the same thing AFAICS.

Yeah, I think that is where I dropped the ball. I wrongly assumed by not looking close
enough that code was shared in those two paths. Definitely some code de-duplication work
that can be done.

-Tyrel

> 
> cheers
> 
