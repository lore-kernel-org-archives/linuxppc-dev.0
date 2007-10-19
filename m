Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 3ACC7DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:34:53 +1000 (EST)
Message-ID: <4718B287.20306@ru.mvista.com>
Date: Fri, 19 Oct 2007 17:35:03 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161C38.2070305@ru.mvista.com>	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>	<471777BD.8090800@ru.mvista.com>	<18200.3600.459275.823335@cargo.ozlabs.ibm.com>	<47189EF3.7010103@ru.mvista.com>
	<18200.42194.853246.935329@cargo.ozlabs.ibm.com>
In-Reply-To: <18200.42194.853246.935329@cargo.ozlabs.ibm.com>
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

>>    The xtime_lock is still grabbed by time_init()

    Oops, I got distracted and hadn't finish the passage.
    My patch got rid of this xtime_lock stuff -- but this was in a different
context, with all vDSO initialization code in between being killed by John's
patch.  I'm not sure it still has sense to hold this lock in time_init()
around that initialization...

> That was left in there because we are setting sys_tz

    My patch moved that to read_persistent_clock()...

> and do_gtod, and do_gtod at least is only updated with the xtime_lock held.

> Of course, at that early stage in the boot process, no lock is really needed, but
> xtime_lock was taken for consistency with other code.

    Thanks for claryfing this.

>>    The only thing I'm still unusre about is that deterministic accounting. 
>>Could you point me at the patch which deals with this (at least for System 390 

> See efe567fc8281661524ffa75477a7c4ca9b466c63 in Linus' tree, and look

    Wait, how this is related to the hrtimer's event handlers not being able 
to call account_process_time() from arch/powerpc/kernel/time.c instead of 
update_process_timess()?

> for posts to lkml by Christian Borntraeger, who has been pursuing the
> issue (subject "Re: [stable] 2.6.23 regression: top displaying 9999%
> CPU usage").

    Fun. :-)

> Paul.

WBR, Sergei
