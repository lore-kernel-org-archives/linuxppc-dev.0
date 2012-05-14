Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D7C6AB7010
 for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2012 10:53:58 +1000 (EST)
Message-ID: <1336956822.6727.4.camel@pasglop>
Subject: Re: [Patch][hw-breakpoint] Use generic hw-breakpoint interfaces for
 new PPC ptrace flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
Date: Mon, 14 May 2012 10:53:42 +1000
In-Reply-To: <20120511084338.GA31696@in.ibm.com>
References: <20120511084338.GA31696@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-05-11 at 14:13 +0530, K.Prasad wrote:

> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	int ret, len = 0;
> +	struct thread_struct *thread = &(child->thread);
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */

"ret" is unused in that function, causing a warning which breaks the
build since we have -Werror. I'm fixing that locally but be more careful
next time please.

Ben.
