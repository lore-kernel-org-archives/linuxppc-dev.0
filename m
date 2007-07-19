Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5836BDDEFC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 04:46:10 +1000 (EST)
In-Reply-To: <18078.43412.493174.590540@cargo.ozlabs.ibm.com>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FB9F7C22-8598-4E72-B663-130A7989925D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Date: Thu, 19 Jul 2007 20:46:03 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hmmm.  The dangling else clauses are pretty gross,

I hoped you wouldn't notice.  I guess I shouldn't have
commented them :-)

"It was the cleanest thing I could come up with".  Every
other thing I tried ended up as a maze of #ifdefs or some
incomprehensible cross-jumping mess; and I was aiming for
a minimal fix, too.

Or, perhaps, it was just a ploy to trick you into writing
a patch yourself.

> and in fact we have
> the same problem on POWER3 and RS64 processors

Right.  Too bad there is no public documentation for either :-/

> (to be fair, we had
> the problem before and didn't notice, but we should still fix it).

Yeah.

> How about this instead?

It's the better way forward, consider my patch withdrawn :-)

> -		if (!(vma->vm_flags & VM_EXEC))
> +		/*
> +		 * Allow execution from readable areas if the MMU does not
> +		 * provide separate controls over reading and executing.
> +		 */
> +		if (!(vma->vm_flags & VM_EXEC) &&
> +		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
> +		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;

Should you really be testing VM_READ|VM_WRITE, or should it just
be VM_READ?

Oh, and that conditional might benefit from being split into
two separate "if" statements, it's a bit hard to read this way.


Segher
