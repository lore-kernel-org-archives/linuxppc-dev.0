Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9BA0FB7BCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 839F6DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n6V6I0U1016593
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:18:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V6KETX1277990
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V6KDVO024749
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Date: Fri, 31 Jul 2009 16:10:13 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/6] [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint
	interfaces - ver VIII
Message-ID: <20090731061013.GG3950@yookeroo.seuss>
References: <20090727001152.GA13562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090727001152.GA13562@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 27, 2009 at 05:41:52AM +0530, K.Prasad wrote:
> Hi David,
> 	I'm back with a new version of patches after a brief hiatus!
> 
> After much deliberation about modifying the code to change the timing of signal
> delivery to user-space, it has been decided to retain the existing behaviour
> i.e. SIGTRAP delivered to user-space after execution of causative instruction
> although exception is raised before execution of it.

Ok.  Except, presumably for ptrace, since changing that would break
gdb.

> One-shot behaviour will now be restricted only to ptrace
> requests. Kernel-space and non-ptrace user-space requests will
> result in persistent breakpoints.

Ok.

> Reasons
> --------
> - Signal delivery before execution of instruction requires complex workarounds
> - One of the plausible workarounds is a two-pass hw-breakpoint handler which
>   delivers the signal after the first pass (with the breakpoints enabled).
>   In the second pass, it follows the existing semantics of
>   disable_hbp-->enable_ss-->single_step-->disable_ss-->enable_hbp.

Yes, that's the only way I can see to do it.

> - Possibility of nested exceptions is a problem here.

Ok, why?

> - Proper identification of a  second-pass of first exception and a new nested
>   exception is difficult. Possibility of stray exceptions due to accesses in
>   neighbouring memory regions of the breakpoint address further complicates it.
> - Alternatives are i)use one-shot for all user-space requests ii)disable signal
>   delivery for non-ptrace requests, allow the user-defined callback routine to
>   generate signal.
> - Using one-shot for all user-space requests will break the register/unregister
>   interface semantics.
> - Disabling signal delivery for non-ptrace requests is one of the options
>   but will be a digression from x86 behaviour, or would require changes in x86
>   code too. Even user-defined callback routines cannot deliver signal
>   before instruction execution.
> 
> Considering all the above, we propose a behaviour that delivers the signal to
> user-space after breakpoint execution. In due course, it will be good to have
> ptrace on PPC64 follow the same behaviour.

Um.. except we can't change ptrace semantics in this way.  It could
break existing users.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
