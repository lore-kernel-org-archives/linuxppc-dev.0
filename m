Return-Path: <lee.nipper@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) by ozlabs.org (Postfix) with ESMTP id 91077B6EF7
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 04:54:53 +1000 (EST)
Received: by qwb8 with SMTP id 8so266800qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 11:54:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100708182455.GC28969@zod.rchland.ibm.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
	<AANLkTim8xuZSaDHyxRVqk63PTT66rrR8hUhEDeNzfmKD@mail.gmail.com>
	<20100708182455.GC28969@zod.rchland.ibm.com>
Date: Thu, 8 Jul 2010 13:54:49 -0500
Message-ID: <AANLkTikhr0XeeAM1flIo4_qY6F0ENrYumKSbyElAoAJS@mail.gmail.com>
Subject: Re: 405EX Rev D mis-identification?
From: Lee Nipper <lee.nipper@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 8, 2010 at 13:24, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote=
:
> On Thu, Jul 08, 2010 at 11:01:11AM -0500, Lee Nipper wrote:
>>On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wr=
ote:
>>> It looks like the Rev D version of the 405EX chip without security
>>> will be identified as a 405EXr, based on the values in the cpu_specs
>>> table. =A0For 405EX/405EXr the pvr_mask is =A00xffff0004 with the
>>> pvr_value's as 0x12910004 and 0x12910000 respectively. I see that the
>>> Rev D PVR value for the 405EX without security is 0x12911473, which
>>> would mask out to the EXr value.
>>>
>>> Is there an algorithm update needed or am I missing something?
>>
>>With 405EX Rev D, we have noticed that we must reset our board
>>one time after the initial powerup to make the PVR read correctly.
>>
>>See this post:
>>http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/079099.html
>
> That is very very weird. =A0Have you seen that behavior on multiple Rev D=
 CPUs
> or just one board or?
>

Multiple Rev D CPUs.  In fact, ALL of the samples we obtained behave this w=
ay.

> The PVR value should never change, so if you have odd behavior I wonder i=
f the
> are silicon bugs in that revision. =A0Did you happen to ask AMCC about it=
?
>

Yes, I did.
AMCC suggested doing an early one-time s/w reset to make the PVR read
"correctly" afterwards.
Since we only support one specific 405EX variety, we could do that.

However, on a generic u-boot, there is no way to know if a "correct"
PVR is read,
so that approach is not a solution.

I'm wondering if our power on reset circuitry is not entirely correct,
and it showed up with the Rev D part.  I received no comments on my
original post
from other users of the 405EX, so I'm thinking it is a possible explanation=
.

Does anyone have a board with a 405EX Rev D ?
If so, does the PVR value match your processor chip after power up ?

Lee
