Return-Path: <kazutomo.yoshii@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB36FB6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:22:33 +1000 (EST)
Received: by gwj17 with SMTP id 17so1056380gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 08:22:30 -0700 (PDT)
Message-ID: <4DD535B3.6040101@gmail.com>
Date: Thu, 19 May 2011 10:22:27 -0500
From: Kazutomo Yoshii <kazutomo.yoshii@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [bg-linux] [PATCH 3/7] [RFC] add support for BlueGene/P FPU
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>	<1305753895-24845-3-git-send-email-ericvh@gmail.com>	<425.1305784718@neuling.org>
	<BANLkTimKhApFW8G1-pG0u_9Kv2YB0R1O0w@mail.gmail.com>
In-Reply-To: <BANLkTimKhApFW8G1-pG0u_9Kv2YB0R1O0w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2011 08:53 AM, Eric Van Hensbergen wrote:
>>> >>  +#ifdef CONFIG_BGP
>>> >>  +#define SAVE_FPR(n, b, base) li b, THREAD_FPR0+(16*(n)); STFPDX(n, base, b)
>>> >>  +#define REST_FPR(n, b, base) li b, THREAD_FPR0+(16*(n)); LFPDX(n, base, b)
>>>        
>> >
>> >  16*?  Are these FP regs 64 or 128 bits wide?  If 128 you are doing to
>> >  have to play with TS_WIDTH to get the size of the FPs correct in the
>> >  thread_struct.
>> >
>> >  I think there's a bug here.
>> >
>>      
> I actually have three different versions of this code from different
> source patches that I'm drawing from - so your help in figuring out
> the best way to approach this is appreciated.  The kittyhawk version
> of the code has 8* instead of 16*.  According to the docs:
> "Each of the two FPU units contains 32 64-bit floating point registers
> for a total of 64 FP registers per processor." which would seem to
> point to the kittyhawk version - but they have a second SAVE_32SFPRS
> for the second hummer.  What wasn't clear to me with this version of
> the code was whether or not they were doing something clever like
> saving the pair of the 64-bit FPU registers in a single 128-bit slot
> (seems plausible).
Yes, it does.    SIMD like instructions are added to BGP PPC.
stdpdx or lfpdx, for example, handle two FPU registers (primary and 
secondary).

Thanks,
Kaz
