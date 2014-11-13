Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3D01A010D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 05:10:08 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 257CF1400AB
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 05:10:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Thu, 13 Nov 2014 23:40:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 47A59E0053
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 23:40:13 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADIAYO551642406
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 23:40:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADIA1oK030143
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 23:40:01 +0530
Message-ID: <5464F39C.8020700@linux.vnet.ibm.com>
Date: Thu, 13 Nov 2014 23:38:28 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <20141113075817.GA1288@katana> <1415876169.666.2.camel@kernel.crashing.org>
 <1415882455.666.4.camel@kernel.crashing.org>
In-Reply-To: <1415882455.666.4.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11/13/2014 06:10 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-11-13 at 21:56 +1100, Benjamin Herrenschmidt wrote:
>> No, there is no timeout, if that fails something went quite wrong, it
>> could almost be a BUG_ON (basically we passed a wrong token or a NULL
>> msg).
>>
>>>> +   }
>>>> +
>>>> +   rc = be64_to_cpu(msg.params[1]);
>>>> +   if (rc != OPAL_SUCCESS) {
>>>> +           rc = -EIO;
>>>> +           goto exit;
>>>> +   }
>>>> +
> Actually, to correct myself, there are a number of error conditions
> including timeouts inside the FW layer, but they are returned here, not
> from opal_async_wait_response(). So indeed, we could do some error code
> conversion at that point.
>
> Neelesh, can you do that on top of your patch that adds the detailed
> error codes ? We can merge it fw side tomorrow if you have a new spin,
> worst case if the FW is old and only returns OPAL_HARDWARE we return
> -EIO and if the FW is newer we'll have more precise error codes in Linux
> too.

Yes, nice to have more precise error codes so I'm adding them in firmware
and rolling out new version of the FW. Please look at it.

Thanks,
Neelesh

>
> Cheers,
> Ben.
>
>
