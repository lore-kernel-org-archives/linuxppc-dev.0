Return-Path: <jimix@watson.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDC4B68383
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:18:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8LCIqZP026791
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 08:18:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8LCIqdc264132
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:18:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8LCIpuB019558
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:18:51 -0600
In-Reply-To: <20060921145522.366a3b03.sfr@canb.auug.org.au>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [POWERPC] mark BUG() as noreturn
Date: Thu, 21 Sep 2006 08:18:47 -0400
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 21, 2006, at 12:55 AM, Stephen Rothwell wrote:

> From an idea from Michael Ellerman.
>
> We finish the BUG() macro with a call to a function marked with  
> attribute
> "noreturn" so that the compiler will know that BUG() and BUG_ON()
> (with a constant, non-zero argument) will not return.

But BUG() _can_ return, if I have a probe, xmon or kgdb configured it  
is possible  to play with the state of the world and try to continue/ 
recover, (xmon "x" command).  IMHO, this is a powerful debugging  
scenario.

Why are we concerned with the performance of this anyway?

-JX
