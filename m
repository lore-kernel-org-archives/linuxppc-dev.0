Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17982.59298.848311.626151@cargo.ozlabs.ibm.com>
Date: Mon, 7 May 2007 18:47:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] via-pmu: remove LED sleep notifier
In-Reply-To: <1178116377.13233.63.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178084161.13233.16.camel@johannes.berg>
	<20070502205741.72dc191b.sfr@canb.auug.org.au>
	<1178116377.13233.63.camel@johannes.berg>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> The generic LED code now makes sure that suspended devices don't blink,
> so we no longer need to do it ourselves. For the suspend to disk case,
> however, we need to make sure that we don't blink if the PMU sysdev
> was suspended before the LED device.

With this patch I get:

  LD      .tmp_vmlinux1
drivers/built-in.o:(.toc1+0x71d8): undefined reference to `pmu_sys_suspended'

with a 64-bit config that has CONFIG_PPC_PMAC=y and CONFIG_PM=n.

Paul.
