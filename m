Return-Path: <serge@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96D29DDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 02:54:15 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n14Fqhwb025827
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 08:52:43 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n14Fs963191816
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 08:54:11 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n14Fs6Rh023531
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 08:54:08 -0700
Date: Wed, 4 Feb 2009 09:54:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
Message-ID: <20090204155406.GA2039@us.ibm.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
	<1233718789.16867.156.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233718789.16867.156.camel@pasglop>
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > +struct cr_hdr_cpu {
> > +	struct pt_regs pt_regs;
> > +	/* relevant fields from thread_struct */
> > +	double fpr[32][TS_FPRWIDTH];
> > +	unsigned int fpscr;
> > +	int fpexc_mode;
> > +	/* unsigned int align_ctl; this is never updated? */
> > +	unsigned long dabr;
> > +};
> 
> Is there some version or other identification somewhere ? If not there
> should be. ie, we're going to add things here. For example, what about
> the vector registers ? Also, some CPUs will have more HW debug registers
> than just the DABR (we plan to add support for all the BookE architected
> IACs and DACs for example), etc...

The arch-independent checkpoint header does have kernel
maj:min:rev:patch info.  We expect to have to do more,
assuming that the .config can change the arch-dependent
cpu header (i.e. perhaps TS_FPRWIDTH could be changed).

-serge
