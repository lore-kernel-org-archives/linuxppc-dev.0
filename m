Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zrMd6XkLzF0xS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 20:12:13 +1000 (AEST)
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Dave Hansen <dave.hansen@intel.com>
References: <53828769-23c4-b2e3-cf59-239936819c3e@redhat.com>
 <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
 <CALCETrWMP9kTmAFCR0WHR3YP93gLSzgxhfnb0ma_0q=PCuSdQA@mail.gmail.com>
 <20180519202747.GK5479@ram.oc3035372033.ibm.com>
 <CALCETrVz9otkOQAxVkz6HtuMwjAeY6mMuLgFK_o0M0kbkUznwg@mail.gmail.com>
 <20180520060425.GL5479@ram.oc3035372033.ibm.com>
 <CALCETrVvQkphypn10A_rkX35DNqi29MJcXYRpRiCFNm02VYz2g@mail.gmail.com>
 <20180520191115.GM5479@ram.oc3035372033.ibm.com>
 <aae1952c-886b-cfc8-e98b-fa3be5fab0fa@redhat.com>
 <20180603201832.GA10109@ram.oc3035372033.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <4e53b91f-80a7-816a-3e9b-56d7be7cd092@redhat.com>
Date: Mon, 4 Jun 2018 12:12:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180603201832.GA10109@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2018 10:18 PM, Ram Pai wrote:
> On Mon, May 21, 2018 at 01:29:11PM +0200, Florian Weimer wrote:
>> On 05/20/2018 09:11 PM, Ram Pai wrote:
>>> Florian,
>>>
>>> 	Does the following patch fix the problem for you?  Just like x86
>>> 	I am enabling all keys in the UAMOR register during
>>> 	initialization itself. Hence any key created by any thread at
>>> 	any time, will get activated on all threads. So any thread
>>> 	can change the permission on that key. Smoke tested it
>>> 	with your test program.
>>
>> I think this goes in the right direction, but the AMR value after
>> fork is still strange:
>>
>> AMR (PID 34912): 0x0000000000000000
>> AMR after fork (PID 34913): 0x0000000000000000
>> AMR (PID 34913): 0x0000000000000000
>> Allocated key in subprocess (PID 34913): 2
>> Allocated key (PID 34912): 2
>> Setting AMR: 0xffffffffffffffff
>> New AMR value (PID 34912): 0x0fffffffffffffff
>> About to call execl (PID 34912) ...
>> AMR (PID 34912): 0x0fffffffffffffff
>> AMR after fork (PID 34914): 0x0000000000000003
>> AMR (PID 34914): 0x0000000000000003
>> Allocated key in subprocess (PID 34914): 2
>> Allocated key (PID 34912): 2
>> Setting AMR: 0xffffffffffffffff
>> New AMR value (PID 34912): 0x0fffffffffffffff
>>
>> I mean this line:
>>
>> AMR after fork (PID 34914): 0x0000000000000003
>>
>> Shouldn't it be the same as in the parent process?
> 
> Fixed it. Please try this patch. If it all works to your satisfaction, I
> will clean it up further and send to Michael Ellermen(ppc maintainer).
> 
> 
> commit 51f4208ed5baeab1edb9b0f8b68d7144449b3527
> Author: Ram Pai <linuxram@us.ibm.com>
> Date:   Sun Jun 3 14:44:32 2018 -0500
> 
>      Fix for the fork bug.
>      
>      Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Is this on top of the previous patch, or a separate fix?

Thanks,
Florian
