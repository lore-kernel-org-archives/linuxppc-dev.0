Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E71A5DDE99
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:45:16 +1000 (EST)
Message-ID: <471603E6.9040608@ru.mvista.com>
Date: Wed, 17 Oct 2007 16:45:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
References: <1190345162.620000.305760830507.qpush@thor>	
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>	
	<46FAB56E.8080509@ru.mvista.com>	
	<Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>	
	<1190836713.23376.41.camel@chaos> <4713ABDA.2000506@ru.mvista.com>
	<1192497543.19073.0.camel@pasglop>
In-Reply-To: <1192497543.19073.0.camel@pasglop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>   Eh... poor you. Tony got clockevent driver reengineered for no apparent 
>>reason.  And he's introduced the jiffy drift by deleting the main loop from 
>>timer_interrupt(). Yet this borken version was preferred to what was known 
>>working since about 2.6.18 and included into 2.6.21-rt patchset.  I don't like 
>>that policy. Will you be pushing fixes from -rt to PowerPC, or will it fall on 
>>my shoulders now?

> Possibly because whatever implementation existed before was never
> provided in a mergeable form

    The fact that vDSO calls were removed out of the necessity (because having 
the broken TOD stuff removed was better than to leave it in place producing 
inexact results) doesn't mean that everything in the patches provided was 
broken and of no use.  Yet you want everything removed in favor of somewhat 
dubious implementation.

> and pushed to -rt bypassing the powerpc architecture maintainer ?

    There was no bypassing, everything was submitted publicly via this list. 
The -rt patch (via the hrtimers patchset) was the place to merge the hrtimers 
code at thiat time, and nobody showed any interest in making the code better, 
i.e. amending vDSO stuff, for months... (The question also is why Tony was 
submitting his patches also to linux-rt-users while they were known not to 
apply to the -rt patch.)

> Ben.

WBR, Sergei
