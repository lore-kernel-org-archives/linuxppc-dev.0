Return-Path: <grimm@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E79DF1A0B5B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 13:15:24 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 382801401EF
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2015 13:15:24 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 19:15:22 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 262A519D8040
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 19:06:31 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t0T2FKDe20840632
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 19:15:20 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T2FJ4R021617
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 19:15:20 -0700
Message-ID: <54C997B6.5090306@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2015 21:15:18 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] CXL: Fix device_node reference counting
References: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
 <1422417621-sup-4057@delenn.ozlabs.ibm.com>
 <1422421480.2728.1.camel@ellerman.id.au>
 <1422423577-sup-6588@delenn.ozlabs.ibm.com>
In-Reply-To: <1422423577-sup-6588@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2015 12:53 AM, Ian Munsie wrote:
> Excerpts from Michael Ellerman's message of 2015-01-28 16:04:40 +1100:
>>> I just wanted to check the status of this one? I can't see it in your
>>> tree and wanted to make sure you didn't simply miss it.
>>
>> It looked fishy, but I never got around to replying.
>>
>> The second sentence in the explanation should never be true:
>
> Right, that was the point of the fix ;)
>
>> You shouldn't have np unless you did an of_node_get() to get it, otherwise it's
>> pointing at something you don't have a reference for and it might go away at
>> any time.
>>
>> So the patch may fix the bug but I don't think it's correct.
>>
>> I think pnv_pci_to_phb_node() should be doing a get for you, before returning
>> the pointer.
>
> Agreed - we should probably also rename it to have 'get' in the name,
> like pnv_pci_get_phb_node().

Yeah, that's way better than the current patch.

>
>> See as a comparison pcibios_get_phb_of_node().
>
> We could almost use that instead, except it's not exported for modules
> and I'm not sure if that even works with __weak functions?
>
>
> Ryan - do you want to respin this, or would you rather I take it?

Sure, I'll respin and resend as a bug fix.

-Ryan

>
> Cheers,
> -Ian
>
