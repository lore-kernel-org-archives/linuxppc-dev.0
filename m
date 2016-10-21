Return-Path: <lists@pfupf.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0lg55nBCzDt1D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 23:41:51 +1100 (AEDT)
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
To: Peter Zijlstra <peterz@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 virtualization@lists.linux-foundation.org, Noam Camus <noamc@ezchip.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Juergen Gross <lists@pfupf.net>
Message-ID: <d7caed29-9c7a-6324-9da8-6a9a28bda98a@pfupf.net>
Date: Fri, 21 Oct 2016 14:41:41 +0200
MIME-Version: 1.0
In-Reply-To: <20161021120536.GC3142@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/10/16 14:05, Peter Zijlstra wrote:
> On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
>> stop_machine can take a very long time if the hypervisor does
>> overcommitment for guest CPUs. When waiting for "the one", lets
>> give up our CPU by using the new cpu_relax_yield.
> 
> This seems something that would apply to most other virt stuff. Lets Cc
> a few more lists for that.

Corrected xen-devel mail address.


Juergen

> 
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  kernel/stop_machine.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index ec9ab2f..1eb8266 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>>  	/* Simple state machine */
>>  	do {
>>  		/* Chill out and ensure we re-read multi_stop_state. */
>> -		cpu_relax();
>> +		cpu_relax_yield();
>>  		if (msdata->state != curstate) {
>>  			curstate = msdata->state;
>>  			switch (curstate) {
>> -- 
>> 2.5.5
>>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
