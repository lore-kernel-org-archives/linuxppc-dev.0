Return-Path: <mkravetz@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCD86679E7
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 03:40:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73HefCe030858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 13:40:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k73HefxX286944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 13:40:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k73Hee8L017190
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 13:40:41 -0400
Date: Thu, 3 Aug 2006 10:40:58 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-ID: <20060803174058.GA3179@w-mikek2.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
	<20060803135717.754bd37f.sfr@canb.auug.org.au>
	<20060803040506.GB3484@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060803040506.GB3484@monkey.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 09:05:06PM -0700, Mike Kravetz wrote:
> On Thu, Aug 03, 2006 at 01:57:17PM +1000, Stephen Rothwell wrote:
> > On Wed, 2 Aug 2006 10:59:47 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
> > > +#else
> > > +
> > > +#define STACKFRAMESIZE	0
> > > +#define HCALL_INST_PRECALL	nop
> > > +#define HCALL_INST_POSTCALL	nop
> > 
> > Why even "nop", why not just blank?
> 
> At first I was concerned about macro expansion and knew a 'nop'
> would be ok.  Intended to go back and try 'blank', but forgot.
> I'll give it a try.

What is the preferred method to 'leave it blank'?

#define HCALL_INST_PRECALL	/* nop */
#define HCALL_INST_PRECALL	;
something else?

Leaving HCALL_INST_PRECALL undefined results in an assembler error.

-- 
Mike
