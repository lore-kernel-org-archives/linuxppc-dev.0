Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 646501A06CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 22:56:13 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 09:56:08 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 74DFC1DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 06:56:01 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DBrsBZ8389058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 09:53:55 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DBu3oY002818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 09:56:04 -0200
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452665080.2403.21.camel@kernel.crashing.org>
Cc: mpe@ellerman.id.au, gwshan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56963B53.8050505@linux.vnet.ibm.com>
Date: Wed, 13 Jan 2016 09:56:03 -0200
MIME-Version: 1.0
In-Reply-To: <1452665080.2403.21.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2016 04:04 AM, Benjamin Herrenschmidt wrote:
> On Sun, 2016-01-10 at 01:08 -0200, Guilherme G. Piccoli wrote:weust changes the way the arch checking is done in function
>>
>> This patch jeeh_add_device_early(): we use no more eeh_enabled(), but instead we check the running architecture by using the macro machine_is(). If we are running on
>> pSeries or PowerNV, the EEH mechanism can be enabled; otherwise, we bail out
>> the function. This way, we don't enable EEH on Cell and we don't hit the oops
>> on DLPAR either.
>
> Can't we just check for eeh_ops being NULL ?
>
> Cheers,
> Ben.

Sure, we can. I prefer the arch checking just because I think it's more 
"logical", so it's easier to understand why it's there. The "cost" is 
the same in practice, since the arch checking is just a macro that 
checks a struct member.

What do you think it's better? Thanks for the review.

Cheers,


Guilherme
