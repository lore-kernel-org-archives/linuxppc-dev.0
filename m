Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9896A1A07E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 03:39:18 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 11:39:15 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DDF203E40048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 11:39:12 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GHaeZ141418906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 10:36:40 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GHdCwF029175
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 11:39:12 -0600
Message-ID: <55A7EC3F.1080406@linux.vnet.ibm.com>
Date: Thu, 16 Jul 2015 12:39:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: BUG: sleeping function called from ras_epow_interrupt context
References: <55A55846.5080904@redhat.com>
 <1436908977.3948.266.camel@kernel.crashing.org> <55A66F96.6030808@redhat.com>
 <55A6BB73.7050402@linux.vnet.ibm.com> <55A74DF9.2010100@redhat.com>
In-Reply-To: <55A74DF9.2010100@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2015 01:23 AM, Thomas Huth wrote:
> On 07/15/2015 09:58 PM, Nathan Fontenot wrote:
>> On 07/15/2015 09:35 AM, Thomas Huth wrote:
>>> On 07/14/2015 11:22 PM, Benjamin Herrenschmidt wrote:
>>>> On Tue, 2015-07-14 at 20:43 +0200, Thomas Huth wrote:
>>>>> Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
>>>>> mdelay() instead of msleep() in rtas_busy_delay()? Something more
>>>>> fancy?
>>>>
>>>> A proper fix would be more fancy, the get_sensor should happen in a
>>>> kernel thread instead.
>>>
>>> I'm not very familiar with this stuff, but isn't the EPOW interrupt
>>> something that is very time-critical? Moving parts of the handler into a
>>> kernel thread then does not sound like a very good idea to me...
>>>
>>> Another question: Can it happen at all that this get-sensor call results
>>> in a sleep condition? Looking at commit ID
>>> 81b73dd92b97423b8f5324a59044da478c04f4c4 ("Fix might-sleep warning on
>>> removing cpus"), which apparently fixed a similar issue for CPU
>>> hot-plugging, indicates that at least some of the rtas calls are never
>>> returning the busy code? In that case we could fix this by introducing a
>>> similar rtas_get_sensor_fast() function? (or simply revert 587f83e8dd50d
>>> which would be quite similar, I think)
>>>
>>
>> Looking at the PAPR, the get-sensor-state rtas call for the EPOW sensor
>> is listed as a fast call and should not return a busy indication.
> 
> Great, good to know, thanks for looking that up! So IMHO we should
> either introduce a rtas_get_sensor_fast() function or revert
> 587f83e8dd50d ... any preferences? Shall I come up with a patch?
>
A quick look at the kernel, I only find three places that rtas_get_sensor
is called. The instance you point out here for the EPOW sensor is the
only time I find it called for a sensor that should not return a busy
indication.

Reverting commit 587f83e8dd50d would solve the issue but not fix any future
users of a fast get-sensor call. I don't have an issue with a patch for a
rtas_get_sensor_fast().

-Nathan
 
>> I'm curious as to why we're getting a busy return indication when
>> making this call.
> 
> Looking at the code again, rtas_busy_delay() likely never slept ... it's
> likely just the "might_sleep()" annotation in that function that causes
> the BUG.
> 
>  Thomas
> 
> 
