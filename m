Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nRZL1sqfzF29S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 22:00:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au, paulus@samba.org
Subject: Re: [PATCH 1/3] powerpc/io: Add __raw_writeq_be() __raw_rm_writeq_be()
In-Reply-To: <865de9ab557621787a26db40c6bf55e1e54ca30d.camel@mendozajonas.com>
References: <20180514125033.12000-1-mpe@ellerman.id.au>
 <865de9ab557621787a26db40c6bf55e1e54ca30d.camel@mendozajonas.com>
Date: Fri, 18 May 2018 22:00:23 +1000
Message-ID: <87y3ghxjfs.fsf@concordia.ellerman.id.au>
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

Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:

> On Mon, 2018-05-14 at 22:50 +1000, Michael Ellerman wrote:
>> Add byte-swapping versions of __raw_writeq() and __raw_rm_writeq().
>> 
>> This allows us to avoid sparse warnings caused by passing __be64 to
>> __raw_writeq(), which takes unsigned long:
>> 
>>   arch/powerpc/platforms/powernv/pci-ioda.c:1981:38:
>>   warning: incorrect type in argument 1 (different base types)
>>       expected unsigned long [unsigned] v
>>       got restricted __be64 [usertype] <noident>
>> 
>> It's also generally preferable to use a byte-swapping accessor rather
>> than doing it by hand in the code, which is more bug prone.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> For this and the following patches:
>
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Thanks.

cheers
