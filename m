Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id E672AB7BB7
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 02:57:57 +1000 (EST)
Message-ID: <4AC63112.7080404@ruggedcom.com>
Date: Fri, 02 Oct 2009 12:57:54 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Is volatile always verboten for FSL QE structures?
References: <4AC60AD8.8030509@ruggedcom.com> <4AC61247.1030507@freescale.com>
	<C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
In-Reply-To: <C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 2, 2009, at 9:46 AM, Timur Tabi wrote:
> 
>> Michael Barkowski wrote:
>>> Just wondering - is there a case where using volatile for UCC
>>> parameter RAM for example will not work, or is the use of I/O
>>> accessors everywhere an attempt to be portable to other architectures?
>>
>> 'volatile' just doesn't really do what you think it should do.  The
>> PowerPC architecture is too complicated w.r.t. ordering of reads and
>> writes.  In other words, you can't trust it.
>>
>> No one should be using 'volatile' to access I/O registers.
> 
> See Documentation/volatile-considered-harmful.txt
> 

I'm happy to adopt your interpretation of it, and I appreciate the explanation.

from Documentation/volatile-considered-harmful.txt:
>   - The above-mentioned accessor functions might use volatile on
>     architectures where direct I/O memory access does work.  Essentially,
>     each accessor call becomes a little critical section on its own and
>     ensures that the access happens as expected by the programmer.

Part of it was that I wondered if this was one of those architectures.  I guess not.

-- 
Michael Barkowski
905-482-4577
