Date: Wed, 16 Oct 2002 11:42:30 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Conn Clark <clark@esteem.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021016154230.GA20227@segfault.usine.8d.com>
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021015225625.GA8153@segfault.usine.8d.com> <3DACBC0F.DDB832E0@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DACBC0F.DDB832E0@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn,

I noticed a couple of things...

1- If SCCR[PRQEN] is NOT set, your idle.c patch makes the current
consumption drop as expected, but the processor never wakes up, which
is normal, but not what we want.

2- If SCCR[PRQEN] IS set, your idle.c patch seems to put the processor
in doze mode at each loop, but the current consumption does not
drop. I printk'ed the 'jiffies' global variable immediately before and
immediately after the
	_nmask_and_or_msr(0, MSR_POW | MSR_EE);
instruction. The printed values are all distant of 3 or 4 jiffies,
which suuggests that the processor spends as much time in doze mode
than in high mode. But the current consumption stays the same...

Any idea?

Regards,



Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
