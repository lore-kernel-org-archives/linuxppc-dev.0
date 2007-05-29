Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7792DDFFE
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:11:33 +1000 (EST)
In-Reply-To: <1180425900.19517.136.camel@localhost.localdomain>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9C7D27C7-674E-44B7-A975-69B2E85AB8F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 08:10:30 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 3:05 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2007-05-29 at 03:52 -0400, Dan Malek wrote:
>>> I've been looking at saving & restoring the top 32 bits of 64 bits
>>> registers when delivering signals to 32 bits processes on a 64 bits
>>> kernel. The principle is easy, but I wonder where to stick them.
>>
>> I'm wondering why you need to do this at all?
>> Why would a 32-bit application care about or
>> know what to do with these?
>
> There are regular demands for the ability to use the full 64 bits
> registers in 32 bits applications when running on a 64 bits processor.
> That ranges from, iirc, the java folks, to people wanting to optimize
> some libs to use 64 bits registers internally when called from 32 bits
> apps etc...
>
> You can use the full 64 bits easily on powerpc, ld/std just work, it's
> only the flags calculations and branches, mostly, that are truncated
> when running in 32 bits mode. Also, the kernel syscall & interrupt
> entry/exit path will save & restore the full 64 bits.
>
> The problem is when you use signals. The compat signal code for 32  
> bits
> apps will only save and restore the bottom 32 bits, thus an  
> application
> using signals will potentially corrupt the top 32 bits, which can be a
> problem if, for example, it uses a library that has optimisations  
> based
> on using the full 64 bits.
>
> We don't intend to update jmpbuf, getcontext/setcontext etc... for
> those... they are purely call clobbered etc..., but it would be  
> nice if
> at least the signal frame save/restore could properly deal with  
> them so
> they don't get randomly clobbered.

This is all problematic since some 64-bit implementations may not  
guarantee the upper bits are valid when in 32-bit mode.  Look at the  
'Computation Modes' section in the architecture specs 2.03 or greater  
for embedded processors.

- k
