Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52E6367B5E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 03:43:00 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6KHguGa001668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 13:42:56 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6KHguF1266500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 11:42:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6KHguRf009671
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 11:42:56 -0600
Date: Thu, 20 Jul 2006 12:42:55 -0500
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: AltiVec in the kernel
Message-ID: <20060720174255.GP5905@austin.ibm.com>
References: <20060719181047.GL5905@austin.ibm.com>
	<001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2006 at 07:31:32AM -0500, Matt Sealey wrote:
> 
> What's the case in the kernel for the memcpy functions etc., are
> they optimized for doing things like longword copies rather than
> byte-per-byte etc.? 

arch/powerpc/lib/copy_32.S
arch/powerpc/lib/memcpy_64.S

Looks pretty darned optimized to me.

> We found glibc sucked for that.

Only because someone was asleep at the wheel, or there was a bug. 

When glibc gets ported to a new architecture, one of the earliest 
tasks is to create optimized versions of memcpy and the like. 
Presumably, on powerpc, this would have been done more than a 
decade ago; its hard for me to imagine that there'd be a problem 
there.  Now, I haven't looked at the code, but I just can't imagine 
how this would not have been found and fixed by now. Is there
really a problem wiht glibc performance on powerpc? I mean,
this is a pretty serious accusation, and something that should 
be fixed asap.

--linas
