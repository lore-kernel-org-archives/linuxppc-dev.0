Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ntT731RFzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 15:12:26 +1000 (AEST)
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Andy Lutomirski <luto@amacapital.net>
References: <53828769-23c4-b2e3-cf59-239936819c3e@redhat.com>
 <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <d886e425-71fc-e203-e22d-7e07552c91c4@redhat.com>
Date: Sat, 19 May 2018 07:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2018 03:19 AM, Ram Pai wrote:

>> New AMR value (PID 112291, before execl): 0x0c00000000000000
>> AMR (PID 112291): 0x0c00000000000000

The issue is here.  The second line is after the execl (printed from the 
start of main), and the AMR value is not reset to zero.

>> Allocated key (PID 112291): 2
>>
>> I think this is a real bug and needs to be fixed even if the
>> defaults are kept as-is (see the other thread).
> 
> The issue you may be talking about here is that  --
> 
> "when you set the AMR register to 0xffffffffffffffff, it
> just sets it to 0x0c00000000000000."
> 
> To me it looks like, exec/fork are not related to the issue.
> Or are they also somehow connected to the issue?

Yes, this is the other issue.  It is not really important here.

Thanks,
Florian
