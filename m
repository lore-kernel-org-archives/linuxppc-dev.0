Return-Path: <mkravetz@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B517467C61
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 04:52:31 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PIqSTF021113
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:52:28 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7PIqSgk094688
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 12:52:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7PIqRIe001643
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 12:52:27 -0600
Date: Fri, 25 Aug 2006 11:52:40 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-ID: <20060825185240.GA1619@w-mikek2.ibm.com>
References: <20060816160456.GA4170@w-mikek2.ibm.com>
	<17645.19790.527223.207556@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17645.19790.527223.207556@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 04:55:10PM +1000, Paul Mackerras wrote:
> > +	/* calculate address of stat structure */		\
> > +	ld	r4,STK_PARM(r3)(r1);	/* use opcode as */	\
> > +	rldicl	r4,r4,62,2;		/* index into array */	\
> > +	mulli	r4,r4,HCALL_STAT_SIZE;				\
> 
> It's a pity our multiplies are slow (6 cycles).  The rldicl would I
> think be more clearly expressed as srdi r4,r4,2.  We could use a shift
> and add instead of the multiply if we put a big fat comment in the
> header that defines the structure warning people to adjust the
> assembly if they change the structure.  Might not be worth it though.

I would rather keep the multiply and minimal safety it provides when
people change the structure.

> BTW are we going to die horribly if someone uses an hcall greater than
> MAX_HCALL_OPCODES?  The hcall functions are available to modules, so
> it would be quite possible for a module to come along and try to use
> some new hcalls that weren't known about when the kernel was built.

Yes, bad things would happen.  This is/was a bad assumption on my part
that all callers would pass in valid opcodes.  I'll put in a simple check
for that.

-- 
Mike
