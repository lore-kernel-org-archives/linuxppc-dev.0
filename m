Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88DF6DE29A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:07:35 +1000 (EST)
Received: from mailhub1.br.ibm.com (unknown [9.18.232.109])
	by igw3.br.ibm.com (Postfix) with ESMTP id 026D8390145
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 14:52:16 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4NI7Rpq1147306
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:07:27 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4NI7DEL005950
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:07:13 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18484.60888.981390.893747@cargo.ozlabs.ibm.com>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 23 May 2008 15:06:14 -0300
Message-Id: <1211565974.15367.7.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-22 at 13:51 +1000, Paul Mackerras wrote:
> Luis Machado writes:
> 
> > This is a patch that has been sitting idle for quite some time. I
> > decided to move it further because it is something useful. It was
> > originally written by Michel Darneille, based off of 2.6.16.
> > 
> > The original patch, though, was not compatible with the current DABR
> > logic. DABR's are used to implement hardware watchpoint support for
> > ppc64 processors (i.e. 970, Power5 etc). 4xx's have a different
> > debugging register layout and needs to be handled differently (they two
> > registers: DAC and DBCR0).
> 
> Yes, they are different, but they do essentially the same thing, so I
> think we should try and unify the handling of the two.  Maybe you
> could rename set_dabr() to set_hw_watchpoint() or something and make
> it set DABR on 64-bit and "classic" 32-bit processors, and DAC on
> 4xx/Book E processors.
> 
> Likewise, I don't think we need both a "dabr" field and a "dac" field
> in the thread_struct - one should do.  Rename "dabr" to something else
> if you feel that the "dabr" name is too ppc64-specific.  And I don't
> think we need both __debugger_dabr_match and __debugger_dac_match.
> 

Thanks for the feedback Paul. I'll try consolidating those mechanisms
into a single, more general scheme. 

Best regards,
Luis
