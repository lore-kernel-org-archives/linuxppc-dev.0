Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65EB81A01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 19:10:04 +1100 (AEDT)
Message-ID: <1447229393.31884.152.camel@kernel.crashing.org>
Subject: Re: [xmon PATCH 1/1] RFC: Add xmon command to dump process/task
 similar to ps(1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 Nov 2015 19:09:53 +1100
In-Reply-To: <56422051.8030505@linux.vnet.ibm.com>
References: <56420DC2.3070500@linux.vnet.ibm.com>
 <56422051.8030505@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-10 at 10:50 -0600, Douglas Miller wrote:
> +{
> +	unsigned long tskv;
> +	struct task_struct *tsk;
> +
> +	if (scanhex(&tskv)) {
> +		procshow((struct task_struct *)tskv);
> +	} else {
> +		for_each_process(tsk) {
> +			procshow(tsk);
> +		}
> +	}
> +}
> +

The main thing is wrap it with the setjump magic that xmon uses for
other things that allows it to recover if you hit a bad pointer
along the way:

	if (setjmp(bus_error_jmp) == 0) {
		catch_memory_errors = 1;
		sync();
		... do your stuff...
		sync();
	}
	catch_memory_errors = 0;

We could make some kind of helper or macro to factor that out
while it it ;-) (For bonus points !)

Cheers,
Ben.
