Return-Path: <haren@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1BF267B7A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 14:40:59 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6P4eutw024255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 00:40:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6P4euJD171358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 22:40:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6P4etJh012589
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 22:40:55 -0600
Message-ID: <44C5A09A.5060005@us.ibm.com>
Date: Mon, 24 Jul 2006 21:39:54 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] reorg RTAS delay code
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>	<1149139866.28307.32.camel@localhost.localdomain>	<1149177349.9812.16.camel@sinatra.austin.ibm.com>	<1149200718.15158.0.camel@sinatra.austin.ibm.com>	<1149280229.18052.3.camel@sinatra.austin.ibm.com>	<20060602213308.GP8934@localdomain>	<1149543108.17307.6.camel@sinatra.austin.ibm.com>
	<20060713182016.GH19076@localdomain>
In-Reply-To: <20060713182016.GH19076@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller II <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:

>Hi folks-
>
>John Rose wrote:
>  
>
>>This patch attempts to handle RTAS "busy" return codes in a more simple
>>and consistent manner.  Typical callers of RTAS shouldn't have to
>>manage wait times and delay calls.
>>
>>This patch also changes the kernel to use msleep() rather than udelay()
>>when a runtime delay is necessary.  This will avoid CPU soft lockups
>>for extended delay conditions.
>>    
>>
>
>...
>
>  
>
>>+/* For an RTAS busy status code, perform the hinted delay. */
>>+unsigned int rtas_busy_delay(int status)
>>+{
>>+	unsigned int ms;
>> 
>>-	/* Use microseconds for reasonable accuracy */
>>-	for (ms = 1; order > 0; order--)
>>-		ms *= 10;
>>+	might_sleep();
>>+	ms = rtas_busy_delay_time(status);
>>+	if (ms)
>>+		msleep(ms);
>> 
>>-	return ms; 
>>+	return ms;
>> }
>>    
>>
>
>So I managed to test this with cpu hotplug recently and the
>might_sleep warning triggers in the cpu offline path (I had to
>reconstruct this from xmon due to the kernel crashing later on for a
>different reason, so it might be a little off):
>
>BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:463.
>in_atomic():1, irqs_disabled():1.
>Call Trace:
>[C0000000AAD379A0] [C000000000010ADC] .show_stack+0x68/0x1b4 (unreliable)
>[C0000000AAD37A50] [C000000000050C98] .__might_sleep+0xd0/0xec
>[C0000000AAD37AE0] [C00000000001DF5C] .rtas_busy_delay+0x20/0x54
>[C0000000AAD37B70] [C00000000001E2D0] .rtas_set_indicator+0x70/0xd4
>[C0000000AAD37C10] [C0000000000491C8] .xics_migrate_irqs_away+0x78/0x228
>[C0000000AAD37CD0] [C000000000047C14] .pSeries_cpu_disable+0x98/0xb4
>[C0000000AAD37D50] [C000000000029A5C] .__cpu_disable+0x4c/0x60
>[C0000000AAD37DC0] [C000000000080834] .take_cpu_down+0x10/0x38
>[C0000000AAD37E40] [C00000000008D1C0] .do_stop+0x198/0x248
>[C0000000AAD37EE0] [C000000000078124] .kthread+0x124/0x174
>[C0000000AAD37F90] [C000000000026568] .kernel_thread+0x4c/0x68
>
>
>As it turns out, set-indicator is not allowed to return a busy delay
>in this context, so we're actually safe here.  Maybe we need an
>rtas_set_indicator_fast which could take that into account, e.g.
>
>int rtas_set_indicator_fast(int indicator, int index, int new_value)
>{
>	int token = rtas_token("set-indicator");
>	int rc;
>
>	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
>
>	WARN_ON(rc == -2 || rc >= 9000 || rc <= 9005);
>
>	if (rc < 0)
>		return rtas_error_rc(rc);
>	return rc;
>}
>
>
>  
>
Hi, I am also noticing the similar stack trace from __might_sleep() for 
kdump boot. Before attempts kexec boot,  kdump code calls 
rtas_set_indicator() from xics_teardown_cpu().  Also, might_sleep() 
calls might_resched() -> cond_resched().  What about when the preemption 
is enabled? will the CPU get scheduled on another task?

 Can we have separate function rtas_set_indicator_fast() as mentioned 
above or

int rtas_set_indicator(int indicator, int index, int new_value, int 
sleep_on_delay)
{
        int token = rtas_token("set-indicator");
        int rc;

        if (token == RTAS_UNKNOWN_SERVICE)
                return -ENOENT;

        rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);

        if (!sleep_on_delay)
                WARN_ON(rc == -2 || rc >= 9000 || rc <= 9005);
        else
                while (rtas_busy_delay(rc))
                        rc = rtas_call(token, 3, 1, NULL, indicator, index,
                                new_value);

        if (rc < 0)
                return rtas_error_rc(rc);
        return rc;
}

Thanks
Haren

>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>
