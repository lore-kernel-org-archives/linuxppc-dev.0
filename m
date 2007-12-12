Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 09D37DDF11
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:30:17 +1100 (EST)
Date: Wed, 12 Dec 2007 12:30:01 -0500
From: Dave Jones <davej@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: cpu frequency governor regression (?)
Message-ID: <20071212173001.GA18973@redhat.com>
References: <1197399165.2214.15.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197399165.2214.15.camel@johannes.berg>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	cpufreq <cpufreq@lists.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 07:52:45PM +0100, Johannes Berg wrote:
 > Hi,
 > 
 > No idea who to bother with this and maybe it's just a
 > misconfiguration... Apologies if my guesses are totally wrong.
 > 
 > I'm currently on 2.6.24-rc3 (+wireless-2.6#everything) but couldn't find
 > any patches between that and 2.6.24-rc5 that seemed relevant.
 > 
 > On my quad powermac, I'm seeing the cpufreq governor changed by a
 > hibernation cycle. My default governor is "userspace", which is driven
 > by powernowd (because the latency is too high "ondemand" doesn't like my
 > machine) but after a hibernation cycle I'm having the governor set to
 > "performance".

bizarre. It should default back to whatever CONFIG_CPU_FREQ_DEFAULT_* option
was set.  (Arguably a bug in itself, as we don't track & restore them
on resume, so if you changed from the default after booting: splat)

Why you're getting the performance governor is puzzling though.
Can you enable CONFIG_CPU_FREQ_DEBUG=y, and boot with cpufreq.debug=7
and send the log from a transition across hibernate?

Also, does /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 
have performance in *all* the cpus?

	Dave

-- 
http://www.codemonkey.org.uk
