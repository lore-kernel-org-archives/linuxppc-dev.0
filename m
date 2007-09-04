Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 865A8DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 22:29:35 +1000 (EST)
Message-ID: <46DD500B.4020207@genesi-usa.com>
Date: Tue, 04 Sep 2007 13:31:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
In-Reply-To: <20070904113937.GA3994@iram.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gabriel Paubert wrote:
> On Tue, Sep 04, 2007 at 12:09:22PM +0100, Matt Sealey wrote:
>> Hi guys,
>>
>> The Solaris PPC code drop included most of these functions for 32-bit ops on
>> 32-bit PPC architectures but the 64-bit operations are not present. What I
>> a not clear on is the operation of lwarx and stwcx. and if they will work if
>> you are doing operations on two words at a time.
> 
> No. There is a single reservation for a single word.

This is what I gathered from the programming environments manual at least.

> the 64 bit operations inside a spinlock on PPC32, and then select the
> number /location of spinlock(s) based on your needs, from one global
> per machine to one per 64 bit variable if you find excessive contention.

Okay that makes sense, but it would have to be a super global big lock,
I don't think the code is there in ZFS to give every 64-bit variable it's
own dedicated spinlock (kind of an overhaul) and I'm trying to be fast..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
