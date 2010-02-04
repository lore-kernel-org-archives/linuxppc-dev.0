Return-Path: <support@skycomputers.com>
Received: from omr11.networksolutionsemail.com
	(omr11.networksolutionsemail.com [205.178.146.61])
	by ozlabs.org (Postfix) with ESMTP id 91FEDB7D55
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 11:20:06 +1100 (EST)
Received: from localhcloudmarkgw1 (mail.networksolutionsemail.com
	[205.178.146.50])
	by omr11.networksolutionsemail.com (8.13.6/8.13.6) with ESMTP id
	o140BDnP004756
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2010 19:11:14 -0500
Message-ID: <B134A7A4FBBE4369B89D3A549EA6BD88@your4dacd0ea75>
From: "support" <support@skycomputers.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<akpm@linux-foundation.org>
References: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
	<1265239287.8287.125.camel@pasglop>
Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on
	unsigned
Date: Wed, 3 Feb 2010 19:10:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"; reply-type=original
Cc: gorcunov@gmail.com, linuxppc-dev@ozlabs.org, roel.kluin@gmail.com,
	waite@skycomputers.com, galak@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To All:
The sky cpu is a PPC7448.
I'm actually amazed that you guys are still working on a problem for a 
product that was finished a number of years ago, at the request of someone 
who hasn't worked here for years.
I sorry you, seem to have been wasting your time.
I think, but am NOT sure,  that our HAA function sets it off.
http://www.skycomputers.com/Systems/HAA_HMM.php

Still, we have finished the product some time ago, and as far as reported 
have no problems.
Again, I'm sorry you have wasted any time on this, we just recently found 
these emails.


Dave Bushee
Director OEM Sales and Services
SKY Computers Inc.
27 Industrial Ave.
978-250-2420 x232
www.skycomputers.com


----- Original Message ----- 
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <akpm@linux-foundation.org>
Cc: <linuxppc-dev@ozlabs.org>; <roel.kluin@gmail.com>; 
<galak@gate.crashing.org>; <gorcunov@gmail.com>; <waite@skycomputers.com>
Sent: Wednesday, February 03, 2010 6:21 PM
Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on 
unsigned


> On Tue, 2010-02-02 at 14:40 -0800, akpm@linux-foundation.org wrote:
>> From: Roel Kluin <roel.kluin@gmail.com>
>>
>> count is unsigned and cannot be less than 0.
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>> Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Kumar Gala <galak@gate.crashing.org>
>> Cc: Brian Waite <waite@skycomputers.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>
> I still have a hard time figuring out what this sky CPU actually is :-)
>
> The whole drivers/misc/hdpuftrs is only built when CONFIG_HDPU_FEATURES
> is set and git grep HDPU_FEATURES doesn't show anybody ever setting
> it :-)
>
> Is that just dead code ? I'm happy to carry it in powerpc.git if you
> wish so but you it would be nice to figure out what's going on there...
>
> Cheers,
> Ben.
>
>>  drivers/misc/hdpuftrs/hdpu_cpustate.c |    5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff -puN 
>> drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned 
>> drivers/misc/hdpuftrs/hdpu_cpustate.c
>> ---  
>> a/drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned
>> +++ a/drivers/misc/hdpuftrs/hdpu_cpustate.c
>> @@ -121,8 +121,6 @@ static ssize_t cpustate_read(struct file
>>  {
>>  unsigned char data;
>>
>> - if (count < 0)
>> - return -EFAULT;
>>  if (count == 0)
>>  return 0;
>>
>> @@ -137,9 +135,6 @@ static ssize_t cpustate_write(struct fil
>>  {
>>  unsigned char data;
>>
>> - if (count < 0)
>> - return -EFAULT;
>> -
>>  if (count == 0)
>>  return 0;
>>
>> _
>
>
> 
