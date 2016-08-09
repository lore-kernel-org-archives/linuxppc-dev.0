Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7hWc11dczDqwM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 14:44:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, chzigotzky@xenosoft.de
Subject: Re: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
In-Reply-To: <57A93F59.5030204@linux.vnet.ibm.com>
References: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
 <20160807234824.GA4628@gwshan> <57A88661.2000606@linux.vnet.ibm.com>
 <87bn12srx8.fsf@concordia.ellerman.id.au>
 <57A93F59.5030204@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 14:44:11 +1000
Message-ID: <871t1ysg9w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> On 08/08/2016 09:32 PM, Michael Ellerman wrote:
>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>>>
>>> (i) What is the specific issue? Do you have some logs or at least a
>>> "high-level" description of the problem in Xorg? I took a look in its
>>> code and PCI domain is coded as u16, which is correct/expected. So it
>>> seems a subtle bug we should investigate and hopefully fix.
>>
>> It was reported here:
>>
>>    https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147062.html
>>
>> It seems xorg just has a hard coded limit of 256 domains.
>
> Thanks for the link Michael. I guess Xorg _had_ this limit in the 
> "past", since the function that was logged on error - xf86MapLegacyIO() 
> - was removed by a commit of 2014:
>
> https://lists.x.org/archives/xorg-devel/2014-July/043224.html

Aha, nice work.

In fact it seems to be better than that, the array of domains was
removed in 2011 in:

  https://cgit.freedesktop.org/xorg/xserver/commit/?id=858fbbb40d7c69540cd1fb5315cebf811c6e7b3f

Which is officially ancient history as far as I'm concerned.

>>> (ii) Why is it related to the absence of pseries check?! You said this
>>> was your bad, but as far as I understand, Xorg runs in pSeries too so
>>> the issue should also be there heheh
>>
>> Well yes I guess it would, if anyone had tested Xorg on pseries :)
>
> We use to test Xorg on pSeries regularly; in fact, I made a quick test 
> today:
>
> http://imgur.com/a/l1lP8
>
> I forced the domain to be 0xffff as in the above image, and everything 
> worked fine.

Awesome.

>> I think for now I'm going to apply this, and we'll work out something
>> else later.
>
> OK, I guess your solution is fine and solves the pasemi issue quickly, 

No given the above info on xorg I'll drop this, and merge just the
endian fix.

cheers
