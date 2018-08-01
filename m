Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbGq6JjmzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:26:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: mwb@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 devicetree@vger.kernel.org
Subject: Re: phandle_cache vs of_detach_node (was Re: [PATCH]
 powerpc/mobility: Fix node detach/rename problem)
In-Reply-To: <85014a16-cd2c-0137-72e5-54d4bcdf788a@gmail.com>
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <8736w1jkte.fsf@concordia.ellerman.id.au>
 <ffaa7eba-5236-e42d-c901-79b045adfb94@linux.vnet.ibm.com>
 <8736vzj4la.fsf@concordia.ellerman.id.au>
 <CAL_JsqKf1k3MM+HgQ2U=Ep7L9nbBCmmvGZoEAKxLB1TVqQdW_w@mail.gmail.com>
 <85014a16-cd2c-0137-72e5-54d4bcdf788a@gmail.com>
Date: Thu, 02 Aug 2018 00:26:58 +1000
Message-ID: <87d0v2f9hp.fsf@concordia.ellerman.id.au>
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

Frank Rowand <frowand.list@gmail.com> writes:
> On 07/31/18 07:17, Rob Herring wrote:
>> On Tue, Jul 31, 2018 at 12:34 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>
>>> Hi Rob/Frank,
>>>
>>> I think we might have a problem with the phandle_cache not interacting
>>> well with of_detach_node():
>> 
>> Probably needs a similar fix as this commit did for overlays:
>> 
>> commit b9952b5218added5577e4a3443969bc20884cea9
>> Author: Frank Rowand <frank.rowand@sony.com>
>> Date:   Thu Jul 12 14:00:07 2018 -0700
>> 
>>     of: overlay: update phandle cache on overlay apply and remove
>> 
>>     A comment in the review of the patch adding the phandle cache said that
>>     the cache would have to be updated when modules are applied and removed.
>>     This patch implements the cache updates.
>> 
>>     Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
>> of_find_node_by_phandle()")
>>     Reported-by: Alan Tull <atull@kernel.org>
>>     Suggested-by: Alan Tull <atull@kernel.org>
>>     Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>     Signed-off-by: Rob Herring <robh@kernel.org>
>
> Agreed.  Sorry about missing the of_detach_node() case.
>
>
>> Really what we need here is an "invalidate phandle" function rather
>> than free and re-allocate the whole damn cache.
>
> The big hammer approach was chosen to avoid the race conditions that
> would otherwise occur.  OF does not have a locking strategy that
> would be able to protect against the races.
>
> We could maybe implement a slightly smaller hammer by (1) disabling
> the cache, (2) invalidate a phandle entry in the cache, (3) re-enable
> the cache.  That is an off the cuff thought - I would have to look
> a little bit more carefully to make sure it would work.
>
> But I don't see a need to add the complexity of the smaller hammer
> or the bigger hammer of proper locking _unless_ we start seeing that
> the cache is being freed and re-allocated frequently.  For overlays
> I don't expect the high frequency because it happens on a per overlay
> removal basis (not per node removal basis).  For of_detach_node() the
> event _is_ on a per node removal basis.  Michael, do you expect node
> removals to be a frequent event with low latency being important?  If
> so, a rough guess on what the frequency would be?

No in practice we expect them to be fairly rare and in the thousands at
most I think.

TBH you could just disable the phandle_cache on the first detach and
that would be fine by me. I don't think we've ever noticed phandle
lookups being much of a problem for us on our hardware.

cheers
