Return-Path: <supriyak@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36A2767BC6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 17:57:35 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAN78deu134984
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 18:08:39 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAN70Uf3074484
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 18:00:41 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAN6v2k6009359
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 17:57:02 +1100
Message-ID: <45654966.2050108@in.ibm.com>
Date: Thu, 23 Nov 2006 12:40:30 +0530
From: supriya kannery <supriyak@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
References: <453F421A.6070507@in.ibm.com>	<1164220580.12365.8.camel@hades.cambridge.redhat.com>
	<1164231343.5653.30.camel@localhost.localdomain>
In-Reply-To: <1164231343.5653.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Wed, 2006-11-22 at 18:36 +0000, David Woodhouse wrote:
>  
>
>>On
>>    
>>
>>>This is because PPC_PTRACE_GETREGS option for powerpc is implemented
>>>such that general purpose
>>>registers of the child process get copied to the address variable
>>>instead of data variable. Same is
>>>the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS
>>>and SETFPREGS.
>>>
>>>Prepared a patch for this problem and tested with 2.6.18-rc6 kernel.
>>>This patch can be applied directly to 2.6.19-rc3 kernel.
>>>      
>>>
>>A more appropriate place to send this would be the linux-ppc development
>>list.
>>    
>>
>
>Also it's possible that existing code like gcc relies on that "feature"
>no ?
>
>Ben.
>
>
>  
>
Thanks David for posting this in ppc-dev list.
    I checked in GDB and ltrace which uses ptrace(). None of them are 
using PPC_PTRACE* options to get register values. The reasons for its 
less (or no) usage could be
1. These options are not documented in manpage
2. The usage is different from the general format of ptrace
3. These are used for copying all the registers. Most applications will 
require data from a single addr/register at a time and can get this data 
from a specific register/address using PEEKTEXT or POKETEXT options.
Supriya
