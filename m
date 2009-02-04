Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F4038DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 14:40:14 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1233182478-27113-2-git-send-email-ntl@pobox.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 14:39:49 +1100
Message-Id: <1233718789.16867.156.camel@pasglop>
Mime-Version: 1.0
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +struct cr_hdr_cpu {
> +	struct pt_regs pt_regs;
> +	/* relevant fields from thread_struct */
> +	double fpr[32][TS_FPRWIDTH];
> +	unsigned int fpscr;
> +	int fpexc_mode;
> +	/* unsigned int align_ctl; this is never updated? */
> +	unsigned long dabr;
> +};

Is there some version or other identification somewhere ? If not there
should be. ie, we're going to add things here. For example, what about
the vector registers ? Also, some CPUs will have more HW debug registers
than just the DABR (we plan to add support for all the BookE architected
IACs and DACs for example), etc...

Ben.
