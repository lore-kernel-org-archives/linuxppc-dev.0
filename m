Return-Path: <albert_herranz@yahoo.es>
Received: from smtp107.mail.ukl.yahoo.com (smtp107.mail.ukl.yahoo.com
	[77.238.184.39]) by ozlabs.org (Postfix) with SMTP id 128ABB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 10:45:42 +1100 (EST)
Message-ID: <4B0C701F.1040101@yahoo.es>
Date: Wed, 25 Nov 2009 00:45:35 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
In-Reply-To: <CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> So what's your proposal then? Placing it within a fake func?
>> That asm snippet is the entry point. I took as an example how
>> prpmc2800.c deals with that, providing an own version of the (weak)
>> _zImage_start.
> 
> Use an assembler source file.  You'll get much nicer syntax as well
> (none of that \n stuff).
> 

I found it cleaner to embed the entry point code in the .c file and avoid touching the wrapper script.
But I'm fine with that if it is the way to go (and I already finally touched the wrapper to increase the link address...).

>>> WIMG=0000, are you sure?  Not M=1?
>>
>> To be honest, I don't recall the details now.
>> But it was tested in the very early days, the result was not the
>> expected one and, in the end, manual cache coherency management was
>> still needed.
> 
> Sure, the memory controllers don't do coherency.  I'm slightly worried
> about two things:
> 1) Will the generic code use M=0 as well?  Is it a problem if it doesn't?
> 2) Do lwarx. etc. work in M=0?
> 
> And a question: does M=0 actually give better performance (lower bus
> utilisation, and maybe saves a few cycles)?
> 

I think that the generic code uses M=0 _except_ for SMP and some platforms (see comment in cputable.h).
And yes, the generic code works with these processors :)

M=0 should have a lower bus utilization, yes.
Also M=0 is a requirement if you use some Gekko/Broadway features like the locked (half-)cache.

Thanks,
Albert
