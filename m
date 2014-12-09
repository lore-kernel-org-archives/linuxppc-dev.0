Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91A161A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 00:20:29 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C0CF31400D2
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 00:20:28 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 18:50:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3B35FE0058
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 18:50:59 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9DMVVp65143016
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2014 18:52:32 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9DKNuZ029273
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2014 18:50:23 +0530
Message-ID: <5486F6B0.4030302@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2014 18:48:40 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
References: <20141209094503.100F81400DE@ozlabs.org>
In-Reply-To: <20141209094503.100F81400DE@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12/09/2014 03:15 PM, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
>> The patch exposes the available i2c busses on the PowerNV platform
>> to the kernel and implements the bus driver to support i2c and
>> smbus commands.
>> The driver uses the platform device infrastructure to probe the busses
>> on the platform and registers them with the i2c driver framework.
>>   arch/powerpc/include/asm/opal.h                    |   29 ++
>>   arch/powerpc/platforms/powernv/opal-wrappers.S     |    1
>>   arch/powerpc/platforms/powernv/opal.c              |   11 +
> This had major conflicts in the above files.
>
> I've fixed it up but please check I did it correctly:
>
>    https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c
>
> It also doesn't build as a module:
>
>    $ grep CONFIG_I2C_OPAL .config
>    CONFIG_I2C_OPAL=m
>    $ make ...
>    ...
>    ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!

Yeah, this needs to be exported.
I think for the same reason, "opal-rtc" is still waiting, plus awaiting 
"ack" from
maintainers.

- Neelesh

>
> cheers
>
