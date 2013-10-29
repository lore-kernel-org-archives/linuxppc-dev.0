Return-Path: <vince@deater.net>
Received: from fbr03.mfg.siteprotect.com (fbr03.mfg.siteprotect.com
 [64.26.60.138]) by ozlabs.org (Postfix) with ESMTP id 7DC2E2C034E
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 06:35:17 +1100 (EST)
Received: from smtpauth05.mfg.siteprotect.com (unknown [192.168.33.144])
 by fbr03.mfg.siteprotect.com (Postfix) with ESMTP id 8B697880A53
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Oct 2013 14:25:14 -0500 (CDT)
Date: Tue, 29 Oct 2013 15:27:05 -0400 (EDT)
From: Vince Weaver <vince@deater.net>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
In-Reply-To: <20131029103057.GN2490@laptop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.02.1310291524240.6608@pianoman.cluster.toy>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan> <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131029102131.GA16117@laptop.programming.kicks-ass.net>
 <20131029103057.GN2490@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Oct 2013, Peter Zijlstra wrote:

> On Tue, Oct 29, 2013 at 11:21:31AM +0100, Peter Zijlstra wrote:
> --- linux-2.6.orig/include/uapi/linux/perf_event.h
> +++ linux-2.6/include/uapi/linux/perf_event.h
> @@ -479,13 +479,15 @@ struct perf_event_mmap_page {
>  	/*
>  	 * Control data for the mmap() data buffer.
>  	 *
> -	 * User-space reading the @data_head value should issue an rmb(), on
> -	 * SMP capable platforms, after reading this value -- see
> -	 * perf_event_wakeup().
> +	 * User-space reading the @data_head value should issue an smp_rmb(),
> +	 * after reading this value.

so where's the patch fixing perf to use the new recommendations?

Is this purely a performance thing or a correctness change?

A change like this a bit of a pain, especially as userspace doesn't really 
have nice access to smb_mb() defines so a lot of cut-and-pasting will 
ensue for everyone who's trying to parse the mmap buffer.

Vince
