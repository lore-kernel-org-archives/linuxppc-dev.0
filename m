Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w87HZ31HhzDqKk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 04:51:06 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3KInOwV047923
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 14:50:56 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y0hde0jm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 14:50:56 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 04:50:53 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3KIogAj6488364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 04:50:50 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3KIoI7V004178
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 04:50:18 +1000
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
 <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
 <20170418161816.20e124f0@kitsune.suse.cz>
 <878tmx6nbw.fsf@concordia.ellerman.id.au>
 <20170419160826.617d173f@kitsune.suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 21 Apr 2017 00:19:55 +0530
MIME-Version: 1.0
In-Reply-To: <20170419160826.617d173f@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4dcf00a6-9293-a261-9ebe-68c80ce49a83@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 19 April 2017 07:38 PM, Michal Suchánek wrote:
> On Wed, 19 Apr 2017 14:19:47 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Michal Suchánek <msuchanek@suse.de> writes:
>>> On Mon, 17 Apr 2017 20:43:02 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>> On Friday 14 April 2017 01:28 AM, Michal Suchánek wrote:
>>>>> more (optional) properties cannot be added?
>>>> Kernel change seems simple over f/w enhancement..
>>> That certainly looks so when you are a kernel developer and can
>>> implement the change yourself compared to convincing some firmware
>>> developer that this feature makes sense.
>>>
>>> On the other hand, the proposed kernel-only solution introduces
>>> requirement that the maintainer does not like.
>>>
>>> For the platform as a whole does it make more sense to add a hack to
>>> the kernel or does it make sense to enhance the firmware to provide
>>> more options for firmware-assisted dump?
>> Unfortunately it doesn't really matter, because there is firmware out
>> there that implements the current behaviour and will never be updated.
>> So we have to work with what's there.
>>
> It's not that with the existing firmware fadump does not work. It just
> uses more memory than needed. So if new firmware revision allows more
> flexibility it will work for people with updated firmware and people
> with outdated firmware will get the current behavior.
>
> The memory saving is only significant for big systems so only people
> running those will get significant improvement from the updated
> firmware.
>


Hi Michal,

With the fadump_append= approach I posted in this response thread,
additional parameters are enforced when fadump is active. If f/w supports
appending additional parameters, it has to update chosen/bootargs
whenever fadump is active. Almost the same thing except the dirty job
is now done by f/w? Hence I thought fadump_append= kernel parameter
approach is simple and lesser of the two evils? Am i missing something 
here..

Thanks
Hari
