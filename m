Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sHx1kbmzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:19:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7sHw5rTkz9t1L
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2016 21:19:40 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79BE7d7036093
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 07:19:39 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24na7gp34n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Aug 2016 07:19:39 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 08:19:36 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 36664352005F
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2016 07:19:14 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79BJYUW13173110
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 08:19:34 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79BJYZn000658
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 08:19:34 -0300
Subject: Re: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
To: Michael Ellerman <mpe@ellerman.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
 <20160807234824.GA4628@gwshan> <57A88661.2000606@linux.vnet.ibm.com>
 <87bn12srx8.fsf@concordia.ellerman.id.au>
 <57A93F59.5030204@linux.vnet.ibm.com>
 <871t1ysg9w.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, chzigotzky@xenosoft.de
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 9 Aug 2016 08:19:33 -0300
MIME-Version: 1.0
In-Reply-To: <871t1ysg9w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57A9BC45.6090904@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/09/2016 01:44 AM, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>> On 08/08/2016 09:32 PM, Michael Ellerman wrote:
>>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>>>>
>>>> (i) What is the specific issue? Do you have some logs or at least a
>>>> "high-level" description of the problem in Xorg? I took a look in its
>>>> code and PCI domain is coded as u16, which is correct/expected. So it
>>>> seems a subtle bug we should investigate and hopefully fix.
>>>
>>> It was reported here:
>>>
>>>     https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147062.html
>>>
>>> It seems xorg just has a hard coded limit of 256 domains.
>>
>> Thanks for the link Michael. I guess Xorg _had_ this limit in the
>> "past", since the function that was logged on error - xf86MapLegacyIO()
>> - was removed by a commit of 2014:
>>
>> https://lists.x.org/archives/xorg-devel/2014-July/043224.html
>
> Aha, nice work.
>
> In fact it seems to be better than that, the array of domains was
> removed in 2011 in:
>
>    https://cgit.freedesktop.org/xorg/xserver/commit/?id=858fbbb40d7c69540cd1fb5315cebf811c6e7b3f
>
> Which is officially ancient history as far as I'm concerned.

Heheh great, good finding Michael!

>>>> (ii) Why is it related to the absence of pseries check?! You said this
>>>> was your bad, but as far as I understand, Xorg runs in pSeries too so
>>>> the issue should also be there heheh
>>>
>>> Well yes I guess it would, if anyone had tested Xorg on pseries :)
>>
>> We use to test Xorg on pSeries regularly; in fact, I made a quick test
>> today:
>>
>> http://imgur.com/a/l1lP8
>>
>> I forced the domain to be 0xffff as in the above image, and everything
>> worked fine.
>
> Awesome.
>
>>> I think for now I'm going to apply this, and we'll work out something
>>> else later.
>>
>> OK, I guess your solution is fine and solves the pasemi issue quickly,
>
> No given the above info on xorg I'll drop this, and merge just the
> endian fix.

Perfect, thanks!

> cheers
>
