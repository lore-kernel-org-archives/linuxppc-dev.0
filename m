Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 42B67DDF83
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:11:46 +1000 (EST)
Message-ID: <471777BD.8090800@ru.mvista.com>
Date: Thu, 18 Oct 2007 19:11:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161C38.2070305@ru.mvista.com>
	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>
In-Reply-To: <18198.44590.721412.314409@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>>Tony started from an earlier patch by John Stultz, not from your
>>>patches.

>>    Well, that I can believe, yet the clockevents patch has traces of my
>>former work, and looking at read_persisitent_time() it looks suspiciously 
>>close to my version too...

> There is basically only one reasonably way to do a lot of this stuff.

>>>The main reason your patches were rejected were that you completely
>>>broke the VDSO and the deterministic time accounting, and made no

>>    That's just not true!
>>    They didn't broke vDSO (to be precise it was John's patch that broke it), 
>>they just removed the vDSO code known to already be broken by -rt patch for 
>>several months by then.  And they didn't broke determinictic accounting -- 
>>they just made two things mutually exclusive.  I haven't yet seen how the 
>>patches that were preferred dealt with it at all.

> OK.  My requirement was that the clocksource/clockevent stuff and the
> VDSO were both functional.  Your patch didn't meet that requirement.

    Which of my patches? There were many, and only one of them dealing with 
vDSO. That's reasonable to drop that patch but it's not reasonable to drop the 
other ones, not directly connected to vDSO issue.  One flaw doesn't make the 
whole patchset bad.
    And now you have incomplete read_persistent_clock() implementation for 
example, god knows why it was preferred to mine -- well, it also implemented 
update_persistent_clock() bit those functions haven't appeared at the same 
time, so read_persistent_clock() was written by me in the .

>>    Really? IMO, the harware does keep a constant interrupt rate better than 
>>software.

> Well, if you have actual numbers to back that up, show them to us.
> I don't believe you would be able to measure any difference, and so I
> prefer the simplicity of only implementing the one-shot mode.

    Well, that's up to you.  I take it you wouldn't accept a patch 
implementing auto-reload mode?

>>>Because you broke important features

>>    That is *not true*.
>>    And nobody had interest to fix them for months (quite strange if they're 
>>so important) while I had neither time nor interest to deal with them anymore 
>>having written the code that *did work*, and not only for me.

> Well, this is the difference between having a hack that works for you,

    Agreed, -rt is a patchset full of hacks. :-)

> and having something that can go upstream into mainline.

    It *went* upstream. Mainline wasn't my aim at that time.

> Anyway, this discussion doesn't seem to be going anywhere.  If there
> are changes you want made, or any other specific concrete action you

    There are. I'll have to send patches (it's not that I have time for this) 
but this is surely the fastest way to get things fixed (if I don't get ignored 
that is).

> want anyone to do, say so.  Otherwise stop whinging.

    I just wanted the reasons clarified and got what I wanted -- as I thought, 
the decision behind preferring patches was somewhat biased, nobody really 
cared about code quality or just wasn't familiar with hrtimers enough to judge 
on the code quality...

> Paul.

WBR, Sergei
