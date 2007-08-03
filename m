Return-Path: <strosake@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96B22DDE07
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 07:54:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73LsmlD024911
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 17:54:48 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73LsmqC232300
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:54:48 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73LslGX019012
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:54:47 -0600
Message-ID: <46B3A426.6090001@austin.ibm.com>
Date: Fri, 03 Aug 2007 16:54:46 -0500
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Page faults blowing up ... [was Re: [PATCH] Fix special PTE code
	for	secondary hash bucket
References: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
	<20070803193258.GA9613@austin.ibm.com>
In-Reply-To: <20070803193258.GA9613@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, benh@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 3:mon> d c0000000077b21e0
> c0000000077b21e0 e00000008004b224 0674100900000080  |.......$.t......|
> 
> Well, howdy doody, there's the value that should have been in r3 ....
> 
> c0000000077b21f0 c4008e0000000000 0000000049424d00  |............IBM.|
> 
> IBM ???
> 
> c0000000077b2200 5048003006000000 0000000000000000  |PH.0............|
> c0000000077b2210 0000000000000000 4800000300000000  |........H.......|
> c0000000077b2220 0000000000000000 0000000000000000  |................|
> c0000000077b2230 5548001806000000 1000400000000000  |UH........@.....|
> c0000000077b2240 0000200000000000 4d43002806000000  |.. .....MC.(....|
> c0000000077b2250 0000000000000001 00c3000000000000  |................|
> c0000000077b2260 e00000008004b224 0000000000000000  |.......$........|
> c0000000077b2270 d0000000000d32c0 8000000000101032  |......2........2|
> 
> hey .. wait .. d0000000000d32c0 is the faulting adddress; whats it doing here ???
> ... and 8000000000101032 is the value of the MSR ... why is that here ??

That looks like part of an RTAS event.  PH indicates a "Main A" section, UH a 
"Main B" section, and, probably of most interest to you, MC indicates a "Failing 
Memory Address" section.  The "Error and Event Notification" chapter of the PAPR 
will be useful here.  You can use rtas_dump (in either powerpc-utils or 
ppc64-utils, depending on the distro) to decode the event in its entirety.  A 
quick hand-decode of the MC section yields (might be wrong, you'll want to 
double-check):

Unrecoverable memory error (UE); transient UE, 64-bit effective address provided 
by the log (located at c0000000077b2260), 64-bit logical address of logical page 
is not provided by the log; error detected by load/store unit of the processor.

Mike
