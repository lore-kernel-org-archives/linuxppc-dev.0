Return-Path: <srs0=zqde=5h=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfPFk2fjPzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:50:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wfPFk1dSlz8vv9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:50:34 +1000 (AEST)
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wfPFj45hQz9s74
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2017 22:50:33 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id a96so452903ioj.1
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Jun 2017 05:50:33 -0700 (PDT)
Date: Fri, 2 Jun 2017 22:50:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, nish.aravamudan@gmail.com
Subject: Re: [PATCH] powerpc/numa: Fix percpu allocations to be NUMA aware
Message-ID: <20170602225016.06415f8f@roar.ozlabs.ibm.com>
In-Reply-To: <87y3ta1zqf.fsf@concordia.ellerman.id.au>
References: <1496380487-21699-1-git-send-email-mpe@ellerman.id.au>
 <20170602153004.62fd05d1@roar.ozlabs.ibm.com>
 <87y3ta1zqf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 02 Jun 2017 19:54:32 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> >> @@ -672,10 +672,19 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
> >>  
> >>  static int pcpu_cpu_distance(unsigned int from, unsigned int to)
> >>  {
> >> -	if (cpu_to_node(from) == cpu_to_node(to))
> >> -		return LOCAL_DISTANCE;
> >> -	else
> >> -		return REMOTE_DISTANCE;
> >> +#ifndef CONFIG_NUMA
> >> +	return LOCAL_DISTANCE;
> >> +#else
> >> +	int from_nid, to_nid;
> >> +
> >> +	from_nid = early_cpu_to_node(from);
> >> +	to_nid   = early_cpu_to_node(to);
> >> +
> >> +	if (from_nid == -1 || to_nid == -1)
> >> +		return LOCAL_DISTANCE;	/* Or assume remote? */
> >> +
> >> +	return node_distance(from_nid, to_nid);  
> >
> > If you made node_distance() return LOCAL_NODE for !NUMA, this
> > should fall out and not require the ifdef?  
> 
> Maybe yeah. This is designed to be minimal for backporting though.

Okay fair enough. Is it expected to get back -1 from this ever? I think
all we need is local vs not local to direct whether to pack CPUs into
the same chunks or not so I wonder if the equality test is simpler.

Probably not a big deal though. Patch looks good as is.

Thanks,
Nick
