Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Kl63R2jzF3TB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 03:29:37 +1000 (AEST)
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: Ram Pai <linuxram@us.ibm.com>
Cc: Linux-MM <linux-mm@kvack.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
References: <20180520191115.GM5479@ram.oc3035372033.ibm.com>
 <aae1952c-886b-cfc8-e98b-fa3be5fab0fa@redhat.com>
 <20180603201832.GA10109@ram.oc3035372033.ibm.com>
 <4e53b91f-80a7-816a-3e9b-56d7be7cd092@redhat.com>
 <20180604140135.GA10088@ram.oc3035372033.ibm.com>
 <f2f61c24-8e8f-0d36-4e22-196a2a3f7ca7@redhat.com>
 <20180604190229.GB10088@ram.oc3035372033.ibm.com>
 <30040030-1aa2-623b-beec-dd1ceb3eb9a7@redhat.com>
 <20180608023441.GA5573@ram.oc3035372033.ibm.com>
 <2858a8eb-c9b5-42ce-5cfc-74a4b3ad6aa9@redhat.com>
 <20180611172305.GB5697@ram.oc3035372033.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <30f5cb0e-e09a-15e6-f77d-a3afa422a651@redhat.com>
Date: Mon, 11 Jun 2018 19:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180611172305.GB5697@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2018 07:23 PM, Ram Pai wrote:
> On Fri, Jun 08, 2018 at 07:53:51AM +0200, Florian Weimer wrote:
>> On 06/08/2018 04:34 AM, Ram Pai wrote:
>>>>
>>>> So the remaining question at this point is whether the Intel
>>>> behavior (default-deny instead of default-allow) is preferable.
>>>
>>> Florian, remind me what behavior needs to fixed?
>>
>> See the other thread.  The Intel register equivalent to the AMR by
>> default disallows access to yet-unallocated keys, so that threads
>> which are created before key allocation do not magically gain access
>> to a key allocated by another thread.
> 
> Are you referring to the thread
> '[PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change signal semantics'

> Otherwise please point me to the URL of that thread. Sorry and thankx. :)

No, it's this issue:

   <https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-May/173157.html>

The UAMOR part has been fixed (thanks), but I think processes still 
start out with default-allow AMR.

Thanks,
Florian
