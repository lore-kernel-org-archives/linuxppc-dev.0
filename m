Return-Path: <segher@kernel.crashing.org>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 98ACB67A7C
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Feb 2005 00:13:05 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j14CPpdt122176
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 12:25:51 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j14CPpxO159278
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 13:25:51 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j14CPoX2032278
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 13:25:50 +0100
In-Reply-To: <1107407613.2363.9.camel@gaston>
References: <42011E77.6040906@nortel.com> <1107407613.2363.9.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <6A5B254A-7647-11D9-A418-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 4 Feb 2005 01:55:08 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Chris Friesen <cfriesen@nortel.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, 2005-02-02 at 12:39 -0600, Chris Friesen wrote:
>> The "tlbie" instruction has a bit which may be set to indicate regular
>> or large page size.  This used to be set via an optional second 
>> parameter.
>>
>> Apparently some time between binutils versions 2.15.91.0.2 and
>> 2.15.92.0.2 a change went in to make this second parameter mandatory,
>> which breaks the kernel ppc code.

> Wasn't it fixed ?
>
> Ben.

My patch indeed was backed out.  If ever I find the time I'll get it 
back
in though, but without affecting tlbie (the syntax for tlbie is 
different
when you look at the PEM or at the Books; the patch was supposed to 
handle
a problem in the cmpXX insns only).  Someone should get the PEM and the
architecture books back in line ;-)


Segher
