Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 614E0DDFDE
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 00:45:28 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1015173ywe.77
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jan 2009 05:45:26 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Sun, 18 Jan 2009 08:40:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: Re[2]: [PATCH][v4] powerpc 44x: support for 256KB PAGE_SIZE
Message-ID: <20090118134003.GB14516@yoda.jdub.homelinux.org>
References: <200901130149.43588.yur@emcraft.com>
	<f341f40f2bfa0818be32a86da62ada9b@bga.com>
	<1336101832.20090116181842@emcraft.com>
	<6206e2ad09c4ee677275859dc6d5046e@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6206e2ad09c4ee677275859dc6d5046e@bga.com>
Cc: yanok@emcraft.com, dzu@denx.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	hugh@veritas.com, akpm@linux-foundation.org, prodyuth@gmail.com, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 17, 2009 at 08:32:25PM -0600, Milton Miller wrote:
> On Jan 16, 2009, at 9:18 AM, Yuri Tikhonov wrote:
>> On Friday, January 16, 2009 you wrote:
>>> On Jan 12, 2009, at 4:49 PM, Yuri Tikhonov wrote:
>>
>>>> This patch adds support for 256KB pages on ppc44x-based boards.
>>
>>
>>>> +config STDBINUTILS
>>>> +     bool "Using standard binutils settings"
>>>> +     depends on 44x
>>>> +     default y
>>
>>
>>> I think this should be
>>
>>> config STDBINUTILS
>>>         bool "Using standard binutils settings" if 44x
>>>         default y
>>
>>> that way we imply that all powerpc users are using the standard
>>> binutils instead of only those using a 44x platform.  We still get the
>>> intended effect of asking the user only on 44x.
>>
>>> I haven't looked at the resulting question or config order to see if  
>>> it
>>> makes sense to leave it here or put it closer to the page size.
>>
>>  I'm not sure about this. For 44x platforms - the STDBINUTILS option
>> is reasonable, because it's used in the PAGE_SIZE selection process.
>> But as regarding the other powerpcs the STDBINUTILS option will do
>> nothing, but taking a superfluous string in configs. Are you sure this
>> will be better ?
>
>
> Ok I tried this out in menuconfig.  You are right that the depends on  
> makes sense as it removes the option from the config file as not  
> relevant.  But right now to enable 256K pages one has to go to platform  
> setup to find this dependency, then has to go to general setup to find  
> the shmem option at the bottom of the list in the embedded/expert  
> section, then finally go to the kernel options menu to finally choose  
> the page size.

Which is fine with me.  This is for people that really know what they're
doing, so making  it harder to enable isn't really a bad thing.

josh
