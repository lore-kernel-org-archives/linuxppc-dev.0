Return-Path: <srs0=0lnn=3m=linux-powerpc.org=kda@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy8702m6wzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 22:54:04 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vy8702Cbpz8svk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 22:54:04 +1000 (AEST)
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vy86z5nVRz9s8W
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2017 22:54:03 +1000 (AEST)
Received: by mail-pg0-x234.google.com with SMTP id x125so151640825pgb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 04 Apr 2017 05:54:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f30v19q.fsf@concordia.ellerman.id.au>
References: <1490882779-16066-1-git-send-email-kda@linux-powerpc.org>
 <877f30v19q.fsf@concordia.ellerman.id.au>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Tue, 4 Apr 2017 15:54:01 +0300
Message-ID: <CAOJe8K3qURm2XcWfzXMF8rPqHJYSyGLKuZc2MX34khhOAh7aAg@mail.gmail.com>
Subject: Re: [PATCH] tty/hvc_console: fix console lock ordering with spinlock
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/4/17, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
>
>> hvc_remove() takes a spin lock first then acquires the console
>> semaphore. This situation can easily lead to a deadlock scenario
>> where we call scheduler with spin lock held.
>
> Have you actually hit the deadlock? Because that code's been like that
> for years and I've never received a bug report.

Nope, I didn't. I've found the bug in the code while looking at the
lockdep output

>
>> diff --git a/drivers/tty/hvc/hvc_console.c
>> b/drivers/tty/hvc/hvc_console.c
>> index b19ae36..a8d3991 100644
>> --- a/drivers/tty/hvc/hvc_console.c
>> +++ b/drivers/tty/hvc/hvc_console.c
>> @@ -920,17 +920,17 @@ int hvc_remove(struct hvc_struct *hp)
>>
>>  	tty = tty_port_tty_get(&hp->port);
>>
>> +	console_lock();
>>  	spin_lock_irqsave(&hp->lock, flags);
>>  	if (hp->index < MAX_NR_HVC_CONSOLES) {
>> -		console_lock();
>>  		vtermnos[hp->index] = -1;
>>  		cons_ops[hp->index] = NULL;
>> -		console_unlock();
>>  	}
>>
>>  	/* Don't whack hp->irq because tty_hangup() will need to free the irq.
>> */
>>
>>  	spin_unlock_irqrestore(&hp->lock, flags);
>> +	console_unlock();
>
> I get that you're trying to do the minimal change, but I don't think the
> result is ideal. If this isn't a console hvc then we take both locks but
> do nothing.
>
> So what about:
>
> 	if (hp->index < MAX_NR_HVC_CONSOLES) {
> 		console_lock();
> 		spin_lock_irqsave(&hp->lock, flags);
> 		vtermnos[hp->index] = -1;
> 		cons_ops[hp->index] = NULL;
> 		spin_unlock_irqrestore(&hp->lock, flags);
> 		console_unlock();
> 	}
Are you sure that we don't corrupt the hp->index between hvc_poll in
interrupt context and hvc_remoev?

>
> cheers
>
