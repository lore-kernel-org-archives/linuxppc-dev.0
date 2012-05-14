Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp01.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D8FCB7010
 for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2012 20:25:01 +1000 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Mon, 14 May 2012 07:24:53 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 04DF4352004A
 for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2012 07:24:45 -0300 (BRT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4EAONt057999620
 for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2012 07:24:24 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4E8OfrH005735
 for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2012 05:24:41 -0300
Date: Mon, 14 May 2012 15:54:38 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch][hw-breakpoint] Use generic hw-breakpoint interfaces for
 new PPC ptrace flags
Message-ID: <20120514102438.GA31573@in.ibm.com>
References: <20120511084338.GA31696@in.ibm.com>
 <1336956822.6727.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336956822.6727.4.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 14, 2012 at 10:53:42AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2012-05-11 at 14:13 +0530, K.Prasad wrote:
> 
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	int ret, len = 0;
> > +	struct thread_struct *thread = &(child->thread);
> > +	struct perf_event *bp;
> > +	struct perf_event_attr attr;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> 
> "ret" is unused in that function, causing a warning which breaks the
> build since we have -Werror. I'm fixing that locally but be more careful
> next time please.
> 
> Ben.

Sorry about that warning, I clearly missed that. I guess you
do a custom build with -Werror flag enabled, unlike what the normal
Makefile does?

Thanks,
K.Prasad
