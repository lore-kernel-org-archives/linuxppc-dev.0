Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtRGf4hGKzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 23:02:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: tty/hvc: possible irq lock inversion dependency detected
In-Reply-To: <CAOJe8K3iHAP8LTAL16b1=BxDbEDpxEGEEiAj6_UbyDFgNUX_kw@mail.gmail.com>
References: <CAOJe8K3iHAP8LTAL16b1=BxDbEDpxEGEEiAj6_UbyDFgNUX_kw@mail.gmail.com>
Date: Wed, 29 Mar 2017 23:02:49 +1100
Message-ID: <877f38jno6.fsf@concordia.ellerman.id.au>
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

Denis Kirjanov <kda@linux-powerpc.org> writes:

> Hi,
>
> Ok, now we have a new locking issue with interrupts which I found on my P8 box.
> I haven't found where we take the console_lock, only in hvc_remove.
>
> BTW, Ben, looks like it's a bug in hvc_remove:
> we take spin_lock and then semaphore lock.

Yeah that does look bogus:

	spin_lock_irqsave(&hp->lock, flags);
	if (hp->index < MAX_NR_HVC_CONSOLES) {
		console_lock();
		vtermnos[hp->index] = -1;
		cons_ops[hp->index] = NULL;
		console_unlock();
	}


The console lock is a bit "special", but I don't think it's *that* special.

cheers
