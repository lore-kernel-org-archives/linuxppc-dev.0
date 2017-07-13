Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7qKQ6tYrzDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 07:51:54 +1000 (AEST)
Message-ID: <1499979030.2865.62.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/time: use get_tb instead of get_vtb in
 running_clock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hejianet <hejianet@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 fweisbec@gmail.com, Thomas Gleixner <tglx@linutronix.de>, John Stultz
 <john.stultz@linaro.org>, Stanislaw Gruszka <sgruszka@redhat.com>, Ivan
 Mikhaylov <ivan@de.ibm.com>, cyrilbur@gmail.com
Date: Fri, 14 Jul 2017 06:50:30 +1000
In-Reply-To: <946976cd-ca8b-7d26-d316-aeaab44beb04@gmail.com>
References: <1499871670-24671-1-git-send-email-hejianet@gmail.com>
 <1499899504.2865.44.camel@kernel.crashing.org>
 <946976cd-ca8b-7d26-d316-aeaab44beb04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-13 at 14:55 +0800, hejianet wrote:
> Hi Ben
> I add some printk logs in watchdog_timer_fn in the guest
> [   16.025222] get_vtb=8236291881, get_tb=13756711357, get_timestamp=4
> [   20.025624] get_vtb=9745285807, get_tb=15804711283, get_timestamp=7
> [   24.025042] get_vtb=11518119641, get_tb=17852711085, get_timestamp=10
> [   28.024074] get_vtb=13192704319, get_tb=19900711071, get_timestamp=13
> [   32.024086] get_vtb=14856516982, get_tb=21948711066, get_timestamp=16
> [   36.024075] get_vtb=16569127618, get_tb=23996711078, get_timestamp=20
> [   40.024138] get_vtb=17008865823, get_tb=26044718418, get_timestamp=20
> [   44.023993] get_vtb=17020637241, get_tb=28092716383, get_timestamp=20
> [   48.023996] get_vtb=17022857170, get_tb=30140718472, get_timestamp=20
> [   52.023996] get_vtb=17024268541, get_tb=32188718432, get_timestamp=20
> [   56.023996] get_vtb=17036577783, get_tb=34236718077, get_timestamp=20
> [   60.023996] get_vtb=17037829743, get_tb=36284718437, get_timestamp=20
> [   64.023992] get_vtb=17039846747, get_tb=38332716609, get_timestamp=20
> [   68.023991] get_vtb=17041448345, get_tb=40380715903, get_timestamp=20
> 
> The get_timestamp(use get_vtb(),unit is second) is slower down compared
> with printk time. You also can obviously watch the get_vtb increment is
> slowly less than get_tb increment.

But that is the entire point of vtb ... because it only counts when
running in the guest, not the time spent in the host.

> Without this patch, I thought there might be some softlockup warnings
> missed in guest.

Ugh ? We already have too many of these ! On the contrary, we don't
want the guest to start to spew soft lockup warnings because it was not
scheduled by the host enough. The guest soft lockup warnings should be
specifically about something bad happening inside the guest.

Your patch seems to defeat the whole purpose of that running_clock()
function unless I'm somewhat mistaken.

Ben.
