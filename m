Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPCml0zPFzDqJG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:57:58 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GArTtv095053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:57:56 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28n9b63trv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:57:56 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 08:57:53 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8E4401DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:57:53 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GAvq4f37486814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 08:57:52 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GAvpCi015391
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 08:57:51 -0200
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
To: Michael Ellerman <mpe@ellerman.id.au>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <87shnek9hd.fsf@concordia.ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 08:57:50 -0200
MIME-Version: 1.0
In-Reply-To: <87shnek9hd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <72cfff06-bd93-a727-0b93-31dfa3a7ac65@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/2017 03:09, Michael Ellerman wrote:
> Pan Xinhui <xinhui.pan@linux.vnet.ibm.com> writes:
> 
>> Once xmon is triggered by sysrq-x, it is enabled always afterwards even
>> if it is disabled during boot. This will cause a system reset interrut
>> fail to dump. So keep xmon in its original state after exit.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/xmon/xmon.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 9c0e17c..721212f 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -76,6 +76,7 @@ static int xmon_gate;
>>  #endif /* CONFIG_SMP */
>>  
>>  static unsigned long in_xmon __read_mostly = 0;
>> +static int xmon_off = 0;
>>  
>>  static unsigned long adrs;
>>  static int size = 1;
>> @@ -3250,6 +3251,8 @@ static void sysrq_handle_xmon(int key)
>>  	/* ensure xmon is enabled */
>>  	xmon_init(1);
>>  	debugger(get_irq_regs());
>> +	if (xmon_off)
>> +		xmon_init(0);
>>  }
> 
> I don't think this is right.
> 
> xmon_off is only true if you boot with xmon=off on the command line.
> 
> So if you boot with CONFIG_XMON_DEFAULT=n, and nothing on the command
> line, then enter xmon via sysrq, then exit, xmon will still be enabled.
> 

Agreed, noticed it after some work in V2 of my patch. I'm addressing it
there, so maybe no harm in keeping this way here..

Thanks,


Guilherme



> cheers
> 
