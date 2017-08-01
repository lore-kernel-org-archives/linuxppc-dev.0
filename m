Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFtw4HkXzDqsF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:27:04 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v71COgve062748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 08:27:02 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c2n3jwyee-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 08:27:01 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 08:27:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 01 Aug 2017 09:28:29 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ltc-interlock@lists.linux.ibm.com, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com
Subject: Re: [PATCH] drivers: cpuidle: Disable preemption before get_lppaca
 function call in pseries_idle_probe function
In-Reply-To: <1500585713.10674.10.camel@kernel.crashing.org>
References: <20170720175735.3957-1-victora@linux.vnet.ibm.com>
 <1500585713.10674.10.camel@kernel.crashing.org>
Message-Id: <a4a42aadef838e115db89590a2ebeb67@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 2017-07-20 18:21, Benjamin Herrenschmidt escreveu:
> On Thu, 2017-07-20 at 14:57 -0300, Victor Aoqui wrote:
>> When CONFIG_PREEMPT=y, the following warning shows up:
>> 
>> BUG: using smp_processor_id() in preemptible [00000000] code: 
>> swapper/0/1
>> caller is pseries_processor_idle_init+0x58/0x21c
>> 
>> This warning shows up because preemption cannot occur when using
>> get_paca(), otherwise the paca_struct it points to may be the wrong 
>> one
>> just after.
>> 
>> For this reason, preemption needs to be disabled before
>> lppaca_shared_proc(get_lppaca()).
> 
> Also chekc the generated assembly. We had all sort of interesting
> issues where gcc would copy the paca pointer or the lppaca pointer
> to a GPR *outside* of the preempt disabled section...
> 
> In that specific case it's not a big deal but overall, I am not
> comfortable with PREEMPT on powerpc until we do something a bit
> more drastic...
> 
> I would like to remove all such direct accesses to paca, instead have a
> "new" get_paca() written in asm that does the preempt disable then
> returns the PACA in a GPR (not directly use r13, hide that from gcc),
> and which is paired with a put_paca().
> 
> The few places where we want to directly access r13 should be hand
> written in asm too to hide r13 from gcc, for accessing the irq_happened
> in the fast path of local_irq_enable/disable/... we should do the same
> with lock tokens.
> 
> Ben.

Hi Benjamin,

Sorry for the delay. I was a little bit busy last days.
I took note of your comments and I will work on those changes.
I will let you know soon when it's done.

Thanks

-- 
Victor Aoqui
