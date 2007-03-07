Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF5A0DDFAA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 02:27:01 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l27FQvTv019334
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:26:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l27FQv0D174272
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:26:57 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l27FQvNr018365
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:26:57 -0500
Subject: Re: [PATCH] [POWERPC] fix up log_plpar_hcall_return
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1173278165.8635.0.camel@localhost.localdomain>
References: <1173222701.13165.9.camel@localhost>
	<1173278165.8635.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 09:26:53 -0600
Message-Id: <1173281214.13165.73.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-03 at 15:36 +0100, Benjamin Herrenschmidt wrote:
> On Tue, 2007-03-06 at 17:11 -0600, Will Schmidt wrote:
> > This is mostly cosmetic.  This updates log_plpar_hcall_return() to use a
> > case statement rather than an if-then-else jumble, and moves it to
> > rtas.c where it can be near the other rtas related functions. 
> 
> Except that this has nothing to do with RTAS or do I miss something ?
> 
> Ben.

Hi Ben, hello to other folks too, 

Milton made a similar comment via IRC.

I am likely blending the rtas/hcall terminology in a bad way, but will
clarify what I was thinking so someone can correct me.  :-)

The lparcfg function is named log_plpar_hcall_return(), taking a hcall
return value and a string, and outputs a human-readable error message
that corresponds to that return value.  

There is no hcall.c that this function would belong in.  HvCall.S and
plpar_wrappers.h contain wrappers and the assembly code that does the
actual calls; but neither of those places look like good candidates for
this function.   
The file rtas.c, however, does make some plpar_hcall function calls, and
has a number of the 900# magic numbers that *look* like the H_* defines
to me. 

-Will
