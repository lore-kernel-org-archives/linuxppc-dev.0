From: Benjamin Herrenschmidt <bh40@calva.net>
To: Paul Schinder <schinder@pobox.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmac-time.c bug in 2.4.0-test3  (and still in -test8)
Date: Wed, 30 Aug 2000 18:54:29 +0200
Message-Id: <20000830165429.22851@mailhost.mipsys.com>
In-Reply-To: <p04330100b5d2e13f47a5@[10.0.1.12]>
References: <p04330100b5d2e13f47a5@[10.0.1.12]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Aug 30 09:50:01 c22234-c kernel: pmac_set_rtc_time: got 3 byte reply
>Aug 30 09:51:00 c22234-c kernel: pmac_set_rtc_time: got 3 byte reply
>
>etc., once per minute.
>
>This is on a Performa 6400/180.  I don't see it in Paul's test6.  It
>doesn't seem to be a real problem except for the excessive logging,
>since the clock seemed accurate (xntpd is running).  Does anyone know
>what's happening and how to shut it up?  CONFIG_PPC_RTC was n for all
>of these kernels.

This message is logged by code in arch/ppc/kernel/pmac_time.c, you can
comment it out. It appears that we get various reply length from Cuda and
our original test didn't always work.

The CONFIG_PPC_RTC will only enable the userland device /dev/rtc. The
basic RTC read code is still there.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
