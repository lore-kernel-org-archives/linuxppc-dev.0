Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EED61007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 03:53:19 +1100 (EST)
Message-ID: <49400.84.105.60.153.1259167993.squirrel@gate.crashing.org>
In-Reply-To: <4B0C701F.1040101@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
	<4B0C701F.1040101@yahoo.es>
Date: Wed, 25 Nov 2009 17:53:13 +0100 (CET)
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Herranz" <albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> WIMG=0000, are you sure?  Not M=1?
>>>
>>> To be honest, I don't recall the details now.
>>> But it was tested in the very early days, the result was not the
>>> expected one and, in the end, manual cache coherency management was
>>> still needed.
>>
>> Sure, the memory controllers don't do coherency.  I'm slightly worried
>> about two things:
>> 1) Will the generic code use M=0 as well?  Is it a problem if it
>> doesn't?
>> 2) Do lwarx. etc. work in M=0?
>>
>> And a question: does M=0 actually give better performance (lower bus
>> utilisation, and maybe saves a few cycles)?
>
> I think that the generic code uses M=0 _except_ for SMP and some platforms
> (see comment in cputable.h).
> And yes, the generic code works with these processors :)

I meant, if it doesn't, does it give conflicts.  But I did some
reading up and M=0 is indeed the way to go, so all is fine :-)

> M=0 should have a lower bus utilization, yes.
> Also M=0 is a requirement if you use some Gekko/Broadway features like the
> locked (half-)cache.

Well we don't use that, but point taken.


Segher
