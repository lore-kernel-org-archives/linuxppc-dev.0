Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FFF167C02
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 18:53:55 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Ga5yu-00068H-69
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 09:36:52 +0200
Date: Wed, 18 Oct 2006 09:28:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018072858.GA29576@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061003155358.756788000@dwalker1.mvista.com>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Daniel Walker <dwalker@mvista.com> wrote:

> Pay close attention to the fasteoi interrupt threading. I added usage 
> of mask/unmask instead of using level handling, which worked well on 
> PPC.

this is wrong - it should be doing mask+ack.

also note that you changed:

> -		goto out_unlock;

to:

> +		goto out;

and you even tried to hide your tracks:

>  out:
>  	desc->chip->eoi(irq);
> -out_unlock:
>  	spin_unlock(&desc->lock);

:-)

really, the ->eoi() op should only be called for true fasteoi cases. 
What we want here is to turn the fasteoi handler into a handler that 
does mask+ack and then unmask. Not 'mask+eoi ... unmask' as your patch 
does.

	Ingo
