Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ggFk0cxXzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 03:26:17 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w71HPYGk142906
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 13:26:14 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kkdyx90w3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 13:26:14 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 1 Aug 2018 11:26:13 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w71HQ9e78126736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 10:26:09 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99926C605D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 11:26:09 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5555FC605B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 11:26:09 -0600 (MDT)
Received: from oc5000245537.ibm.com (unknown [9.53.92.182])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 11:26:09 -0600 (MDT)
Subject: Re: phandle_cache vs of_detach_node (was Re: [PATCH]
 powerpc/mobility: Fix node detach/rename problem)
To: linuxppc-dev@lists.ozlabs.org
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <8736w1jkte.fsf@concordia.ellerman.id.au>
 <ffaa7eba-5236-e42d-c901-79b045adfb94@linux.vnet.ibm.com>
 <8736vzj4la.fsf@concordia.ellerman.id.au>
 <CAL_JsqKf1k3MM+HgQ2U=Ep7L9nbBCmmvGZoEAKxLB1TVqQdW_w@mail.gmail.com>
 <85014a16-cd2c-0137-72e5-54d4bcdf788a@gmail.com>
 <87d0v2f9hp.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 1 Aug 2018 12:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <87d0v2f9hp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <e509f249-d08b-980c-b964-4e4f5008adc7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2018 09:26 AM, Michael Ellerman wrote:
> Frank Rowand <frowand.list@gmail.com> writes:
>> On 07/31/18 07:17, Rob Herring wrote:
>>> On Tue, Jul 31, 2018 at 12:34 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>
>>>> Hi Rob/Frank,
>>>>
>>>> I think we might have a problem with the phandle_cache not interacting
>>>> well with of_detach_node():
>>>
>>> Probably needs a similar fix as this commit did for overlays:
>>>
>>> commit b9952b5218added5577e4a3443969bc20884cea9
>>> Author: Frank Rowand <frank.rowand@sony.com>
>>> Date:   Thu Jul 12 14:00:07 2018 -0700
>>>
>>>     of: overlay: update phandle cache on overlay apply and remove
>>>
>>>     A comment in the review of the patch adding the phandle cache said that
>>>     the cache would have to be updated when modules are applied and removed.
>>>     This patch implements the cache updates.
>>>
>>>     Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
>>> of_find_node_by_phandle()")
>>>     Reported-by: Alan Tull <atull@kernel.org>
>>>     Suggested-by: Alan Tull <atull@kernel.org>
>>>     Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>     Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> Agreed.  Sorry about missing the of_detach_node() case.
>>
>>
>>> Really what we need here is an "invalidate phandle" function rather
>>> than free and re-allocate the whole damn cache.
>>
>> The big hammer approach was chosen to avoid the race conditions that
>> would otherwise occur.  OF does not have a locking strategy that
>> would be able to protect against the races.
>>
>> We could maybe implement a slightly smaller hammer by (1) disabling
>> the cache, (2) invalidate a phandle entry in the cache, (3) re-enable
>> the cache.  That is an off the cuff thought - I would have to look
>> a little bit more carefully to make sure it would work.
>>
>> But I don't see a need to add the complexity of the smaller hammer
>> or the bigger hammer of proper locking _unless_ we start seeing that
>> the cache is being freed and re-allocated frequently.  For overlays
>> I don't expect the high frequency because it happens on a per overlay
>> removal basis (not per node removal basis).  For of_detach_node() the
>> event _is_ on a per node removal basis.  Michael, do you expect node
>> removals to be a frequent event with low latency being important?  If
>> so, a rough guess on what the frequency would be?
> 
> No in practice we expect them to be fairly rare and in the thousands at
> most I think.
> 
> TBH you could just disable the phandle_cache on the first detach and
> that would be fine by me. I don't think we've ever noticed phandle
> lookups being much of a problem for us on our hardware.

I ran a couple of migrations with the calls to

of_free_phandle_cache() ... of_populate_phandle_cache()

bracketing the body of

arch/powerpc/platforms/pseries/mobility.c:post_mobility_fixup()

with a patch like,

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index e245a88..efc9442 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -22,6 +22,9 @@
 #include <asm/rtas.h>
 #include "pseries.h"

+extern int of_free_phandle_cache(void);
+extern void of_populate_phandle_cache(void);
+
 static struct kobject *mobility_kobj;

 struct update_props_workarea {
@@ -343,6 +346,8 @@ void post_mobility_fixup(void)
                rc = rtas_call(activate_fw_token, 0, 1, NULL);
        } while (rtas_busy_delay(rc));

+       of_free_phandle_cache();
+
        if (rc)
                printk(KERN_ERR "Post-mobility activate-fw failed: %d\n", rc);

@@ -354,6 +359,8 @@ void post_mobility_fixup(void)
        /* Possibly switch to a new RFI flush type */
        pseries_setup_rfi_flush();

+       of_populate_phandle_cache();
+
        return;
 }

and did not observe the warnings/crashes that have been
plaguing me.  We will need to move their prototypes out
of drivers/of/of_private.h to include/linux/of.h, though.

> 
> cheers
> 

Michael
 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
