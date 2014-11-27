Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 357CD1A0C78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 05:28:06 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia> <1417045827.16862.32.camel@otta>
 <20141127160829.GA26139@gate.crashing.org>
Date: Thu, 27 Nov 2014 19:20:53 +0100
In-Reply-To: <20141127160829.GA26139@gate.crashing.org> (Segher Boessenkool's
 message of "Thu, 27 Nov 2014 10:08:29 -0600")
Message-ID: <87oarstshm.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Wed, Nov 26, 2014 at 05:50:27PM -0600, Peter Bergner wrote:
>> On Thu, 2014-11-27 at 09:38 +1100, Michael Ellerman wrote:
>> > On Thu, 2014-11-27 at 08:11 +1100, Anton Blanchard wrote:
>> > > I used some 64 bit instructions when adding the 32 bit getcpu VDSO
>> > > function. Fix it.
>> > 
>> > Ouch. The symptom is a SIGILL I presume?
>> 
>> Nope, you don't get a SIGILL when executing 64-bit instructions in
>> 32-bit mode, so it'll happily just execute the instruction, doing
>> a full 64-bit compare.  I'm guessing that the upper 32-bits of both
>> r3 and r4 contain zeros, so we're probably just getting lucky.
>
> You will get a SIGILL if you run on 32-bit hardware.

Not on the 7447A, fwiw.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
