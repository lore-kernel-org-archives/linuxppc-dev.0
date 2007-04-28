Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17971.14223.435220.418649@cargo.ozlabs.ibm.com>
Date: Sat, 28 Apr 2007 22:01:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: proper sleep management
In-Reply-To: <1177746562.3448.10.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> After having removed the power management ops from powermac completely, this
> patch adds them back for PMU based machines, directly in the PMU driver.
> This finally allows suspending via /sys/power/state on powerbooks.

I would very much rather that we keep the existing code path intact
and add the code to suspend via /sys/power/state as a separate code
path.  I am not confident enough about the state of the generic
suspend/resume code to commit to using it as the only way to suspend
to RAM, given how many bugs it seems to have (as evidenced by the
number of suspend-related bugs in Adrian Bunk's regression lists, for
instance).

I don't mind code being factored out into helpers, or moved from one
file to another, as long as the control flow for the old sleep ioctl
remains essentially unchanged, for now.

Paul.
