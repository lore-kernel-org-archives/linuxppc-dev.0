Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1GkC48CYzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 13:00:51 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gh9so9522959pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 20:00:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc: Update of_remove_property() call sites to
 remove null checking
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
 <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
 <57292702.5070507@linux.vnet.ibm.com>
 <1462431031.12473.3.camel@ellerman.id.au>
Cc: grant.likely@linaro.org, frowand.list@gmail.com, robh+dt@kernel.org,
 paulus@samba.org
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <572C08DB.9000109@gmail.com>
Date: Fri, 6 May 2016 13:00:43 +1000
MIME-Version: 1.0
In-Reply-To: <1462431031.12473.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/05/16 16:50, Michael Ellerman wrote:
> On Tue, 2016-05-03 at 15:32 -0700, Tyrel Datwyler wrote:
>> On 04/27/2016 10:34 PM, Suraj Jitindar Singh wrote:
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index ceb18d3..a560a98 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -191,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope)
>>>  				break;
>>>  
>>>  			case 0x80000000:
>>> -				prop = of_find_property(dn, prop_name, NULL);
>>> -				of_remove_property(dn, prop);
>>> +				of_remove_property(dn, of_find_property(dn,
>>> +							prop_name, NULL));
>>>  				prop = NULL;
>>>  				break;
>>>
>> You haven't removed a NULL check here, as suggested by the changelog,
>> but instead made a cosmetic change to the code that still leaves behind
>> a now unnecessary "prop = NULL;" to bit rot.
> Yeah I think you're right. Though it's not very clear how prop is used in that
> function.
>
> Please one of you send me an incremental to remove the prop = NULL;
>
> cheers
>

Resend of previous message due to formatting issues:

I didn't delete the prop = NULL; initially as I didn't fully understand
how it was used in the rest of the function and the effect of deleting
it.
