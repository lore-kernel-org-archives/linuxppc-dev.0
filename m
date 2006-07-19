Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AF8A67B93
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 08:10:45 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6JMAgRi018940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 18:10:42 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6JMAf4u156800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 16:10:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6JMAfxc008642
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 16:10:41 -0600
Date: Wed, 19 Jul 2006 15:11:00 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060719221100.GB3087@w-mikek2.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<17597.19430.983453.919592@cargo.ozlabs.ibm.com>
	<20060719033618.GA3944@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719033618.GA3944@monkey.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 08:36:18PM -0700, Mike Kravetz wrote:
> > My other comment is this: wouldn't it actually turn out simpler if we
> > read the timebase (and PURR, if we really want to do that too) in the
> > assembly code that implements plpar_hcall_*?
> 
> I'll give that a try.  My assembly skills are a bit rusty, so it may
> take a little longer to produce something.

Getting the timebase and PURR in assembly is easy enough.  So, I thought
about updating the per-cpu statistics while in there.  But, I couldn't
find any other assembly code that does this.  Sure there is asm code that
updated fields in the PACA, but none that messes with paca.data_offset
(that I could find).

Should the statistic updates also be done in the assembly routines?  Or,
how about a call out to a C routine for this?

-- 
Mike
