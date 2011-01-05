Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4F511B7063
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 05:35:08 +1100 (EST)
To: Rafael Beims <rbeims@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc880 linux-2.6.32 slow running processes
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
Date: Wed, 05 Jan 2011 19:35:06 +0100
Message-Id: <20110105183506.07BB815243A@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Rafael Beims,

In message <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com> you wrote:
>
> I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
> some work, I could get the kernel up and running, mounting a rootfs via
> NFS.

2.6.32 is pretty old.  Is there any specific reason for not using a
recent kernel version?

> The problem that I'm facing now is that when I try to run any process (may
> be an ls, cat, or whatever), the response of the process is *very* slow
> (something like 10 to 20 seconds for a ls).

This sounds as if only the output to the (serial ?) console port was
slow - typically this happens when there is a problem with interrupt
assignment, and you receive charatcers only after each of these times
out.

> My question to all is, did anyone see something like this already? Besides

We have seen this many times in the past, when interrupts were not
working correctly.  I recommend to check youyr device tree settings
for these.

[It would have helped if you had included a log of your kernel's boot
messages.]

> that, what is the status of the linux kernel support for the 8xx platform?

It is working and actively maintained, but 8xx is a platform that is
more or less hopelessly obsoleted - nobody uses it in new designs any
more, so there is little work going on with it in recent kernel
versions (at least compared with other architectures).

> Is it being actively tested / used today? I ask this because it seems that

Yes, it is.

> all the information on the internet very aged (forum discussions from 2005
> and below mostly).

> Is there something that I can do to try to narrow the cause of the problem?

Check your interrupts.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never underestimate the power of human stupidity  when  it  comes  to
using technology they don't understand.
