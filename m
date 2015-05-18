Return-Path: <jkosina@suse.cz>
Received: from mail.emea.novell.com (mail.emea.novell.com [130.57.118.101])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A90A71A0514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 22:50:30 +1000 (AEST)
Date: Mon, 18 May 2015 14:29:52 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace"
 (pt.1)
In-Reply-To: <20150516080534.GA27059@lst.de>
Message-ID: <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

yOn Sat, 16 May 2015, Torsten Duwe wrote:

> > > There's got to be a better solution than this.
> >
> > Can you think of a better approach?
> 
> Maybe a per thread variable to lock out a recursion into tracing?
> Thanks for your doubt.

ftrace already handles recursion protection by itself (depending on the 
per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).

It's however not really well-defined what to do when recursion would 
happen. Therefore __notrace__ annotation, that just completely avoid such 
situation by making tracing impossible, looks like saner general solution 
to me.

-- 
Jiri Kosina
SUSE Labs
