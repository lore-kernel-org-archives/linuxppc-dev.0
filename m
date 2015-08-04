Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 308A51A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 12:46:20 +1000 (AEST)
Date: Tue, 4 Aug 2015 10:46:08 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5] powerpc/rcpm: add RCPM driver
To: Scott Wood <scottwood@freescale.com>
CC: <Yuantian.Tang@freescale.com>, <b07421@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Message-ID: <1438656368.10331.0@remotesmtp.freescale.net>
In-Reply-To: <1438633423.2097.33.camel@freescale.com>
References: <1435304656-34505-1-git-send-email-Yuantian.Tang@freescale.com>
 <1438389906.19345.101.camel@freescale.com>
 <1438600486.7515.1@remotesmtp.freescale.net>
 <1438633423.2097.33.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, Aug 4, 2015 at 4:23 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> On Mon, 2015-08-03 at 19:14 +0800, Chenhui Zhao wrote:
>>  On Sat, Aug 1, 2015 at 8:45 AM, Scott Wood <scottwood@freescale.com>
>>  wrote:
>>  > On Fri, 2015-06-26 at 15:44 +0800,  
>> Yuantian.Tang@freescale.comwrote:
>>  > >  +static void rcpm_v1_set_ip_power(bool enable, u32 *mask)
>>  > >  +{
>>  > >  +     if (enable)
>>  > >  +             setbits32(&rcpm_v1_regs->ippdexpcr, *mask);
>>  > >  +     else
>>  > >  +             clrbits32(&rcpm_v1_regs->ippdexpcr, *mask);
>>  > >  +}
>>  > >  +
>>  > >  +static void rcpm_v2_set_ip_power(bool enable, u32 *mask)
>>  > >  +{
>>  > >  +     if (enable)
>>  > >  +             setbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
>>  > >  +     else
>>  > >  +             clrbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
>>  > >  +}
>>  >
>>  > Why do these take "u32 *mask" instead of "u32 mask"?
>>  >
>>  > -Scott
>> 
>>  I think it can be used in the case where there are several mask 
>> values.
> 
> When would that be?
> 
> -Scott

So far, only use one register, even though the register name is 
"IPPDEXPCRn" (has "n" suffix) in T4 RM.

OK. Just change the parameter to "u32 mask".

-Chenhui
