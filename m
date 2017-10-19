Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHmN62kx1zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 22:07:01 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JB5X46011052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:06:58 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpskbc0md-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:06:58 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 05:06:57 -0600
Subject: Re: [PATCH] powerpc/xmon: Always enable xmon sysrq trigger
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: brking@linux.vnet.ibm.com, paulus@samba.org
References: <20171018113436.16112-1-gpiccoli@linux.vnet.ibm.com>
 <878tg7n2we.fsf@concordia.ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 09:06:53 -0200
MIME-Version: 1.0
In-Reply-To: <878tg7n2we.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <ef4f7d71-4b35-381a-1114-1bdf39119a33@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2017 03:05 AM, Michael Ellerman wrote:
> [...]
> I know it's annoying when you get stuck with a box like this, but I
> can't merge this patch.
> 
> You're *removing* the system administrators ability to control access to
> xmon (other than disabling sysrq entirely). That's a regression.
> 
> What we should do is get a bit allocated for xmon, so it can have a
> non-zero single-bit enable mask.
> 

Agree with you, thanks for the enlightening comment. Let's then drop
this one, since sysrq=1 would do the job for us now anyway.

Cheers,


Guilherme

> cheers
> 
> 
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 4679aeb84767..780d708472a2 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -3514,6 +3514,7 @@ static struct sysrq_key_op sysrq_xmon_op = {
>>  	.handler =	sysrq_handle_xmon,
>>  	.help_msg =	"xmon(x)",
>>  	.action_msg =	"Entering xmon",
>> +	.enable_mask =	0xFFFF,
>>  };
>>  
>>  static int __init setup_xmon_sysrq(void)
>> -- 
>> 2.14.2
> 
