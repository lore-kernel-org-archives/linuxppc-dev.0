Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0ksN5szzzDvyP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 23:05:44 +1100 (AEDT)
Date: Fri, 21 Oct 2016 14:05:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 virtualization@lists.linux-foundation.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Message-ID: <20161021120536.GC3142@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
> stop_machine can take a very long time if the hypervisor does
> overcommitment for guest CPUs. When waiting for "the one", lets
> give up our CPU by using the new cpu_relax_yield.

This seems something that would apply to most other virt stuff. Lets Cc
a few more lists for that.

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  kernel/stop_machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index ec9ab2f..1eb8266 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>  	/* Simple state machine */
>  	do {
>  		/* Chill out and ensure we re-read multi_stop_state. */
> -		cpu_relax();
> +		cpu_relax_yield();
>  		if (msdata->state != curstate) {
>  			curstate = msdata->state;
>  			switch (curstate) {
> -- 
> 2.5.5
> 
