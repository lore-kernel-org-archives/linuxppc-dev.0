Return-Path: <jbaron@akamai.com>
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [72.246.2.115]) by ozlabs.org (Postfix) with ESMTP id 7C97E2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 09:10:03 +1100 (EST)
Message-ID: <528BE05E.8090501@akamai.com>
Date: Tue, 19 Nov 2013 17:04:14 -0500
From: Jason Baron <jbaron@akamai.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] panic: Make panic_timeout configurable
References: <20131118210436.233B5202A@prod-mail-relay06.akamai.com>
 <20131118143059.afe17d2faced16171a05eb10@linux-foundation.org>
 <528A9F24.1000206@akamai.com> <20131119070905.GF32367@gmail.com>
In-Reply-To: <20131119070905.GF32367@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2013 02:09 AM, Ingo Molnar wrote:
> 
> * Jason Baron <jbaron@akamai.com> wrote:
> 
>> On 11/18/2013 05:30 PM, Andrew Morton wrote:
>>> On Mon, 18 Nov 2013 21:04:36 +0000 (GMT) Jason Baron <jbaron@akamai.com> wrote:
>>>
>>>> The panic_timeout value can be set via the command line option 'panic=x', or via
>>>> /proc/sys/kernel/panic, however that is not sufficient when the panic occurs
>>>> before we are able to set up these values. Thus, add a CONFIG_PANIC_TIMEOUT
>>>> so that we can set the desired value from the .config.
>>>>
>>>> The default panic_timeout value continues to be 0 - wait forever, 
>>>> except for powerpc and mips, which have been defaulted to 180 and 
>>>> 5 respectively. This is in keeping with the fact that these 
>>>> arches already set panic_timeout in their arch init code. 
>>>> However, I found three exceptions- two in mips and one in powerpc 
>>>> where the settings didn't match these default values. In those 
>>>> cases, I left the arch code so it continues to override, in case 
>>>> the user has not changed from the default. It would nice if these 
>>>> arches had one default value, or if we could determine the 
>>>> correct setting at compile-time.
>>>
>>> Felipe is proposing a simpler patch ("panic: setup panic_timeout 
>>> early") which switches to early_param().  Is that sufficient for 
>>> the (undescribed!) failure which you are presumably observing?
>>>
>>
>> No - that patch doesn't change the 'panic_timeout' value until the 
>> call to 'parse_early_param()' is made. If there is a panic before 
>> that point, the param doesn't do anything. The idea of this patch is 
>> to allow it to be configured at build-time.
>>
>> I've tested the patch by simply inserting a panic() call at the 
>> beginning of 'start_kernel()'. So, no I do not have a specific panic 
>> in mind for this.
> 
> Would you be interested in picking up Felipe's patch/fix on top of 
> yours? I was unable to communicate with him efficiently, but I'd take 
> the patch if it's signed off by you.
> 
> Thanks,
> 
> 	Ingo
> 

Sure, I can round up all the related patches in this area that make
sense and re-submit as a series.

Felipe, would the CONFIG_PANIC_TIMEOUT=xx .config parameter work for your
needs, or would you still like to see the command-line processing moved
up?

I'd also like to hear from the PowerPC folks about the arch defaults
there. Now, that mips is ok with CONFIG_PANIC_TIMEOUT, PowerPC is the
only arch doing specific initialization of 'panic_timeout'.

Thanks,

-Jason
