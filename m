Date: Wed, 14 Jan 2004 20:39:10 +0100
From: valvoline <valvoline@vrlteam.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: temp.c and cputable.c issues
Message-ID: <20040114193910.GN2658@adapter.n0skillz.org>
Reply-To: valvoline@vrlteam.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi folks!,

i'm running the last stable kernel tree with benh r1 patches (2.6.1-r1 under gentoo).

i've enabled TAU and CPUFREQ, and compiled everything...all seems to go well,
but looking into a dmesg from kernel i'm receiving this message:

...
Thermal assist unit not available
...

looking into /usr/src/linux/arch/ppc/kernel/cputable.c i've noticed that all
7455 based machine, have the CPU_FTR_TAU feature disabled, so i've patched the
file as in the included patch...now all seems to works fine!.

cputemperature is shown in /proc/cpuinfo, and all the infos seems to be
good calibrated and really near to real-world values.

Actually, i'm writing a dockapp for wm, and i've noticed some troubles in temperature;
after put my cpu to low-power with an:

'echo -n "0:600000:600000:performance" > /proc/cpufreq'

the value temperature in /proc/cpuinfo start to grow-up with NOSENSE...seems
that every 1sec-tick, the temperature value (both high and low) increment of
1 unit...at 68°-69° stop is race and the value remain at this point with
further changes; no matter if the cpuload is 0% or 100%...the value is
completely stalled.

If i restore the cpu to high-power with an:

'echo -n "0:900000:900000:performance" > /proc/cpufreq'

the temperature in /proc/cpuinfo start to grow down, and the values returns
to be correctly and with a real-life attinency.

Looking into sources under /usr/src/linux/arch/ppc/kernel/temp.c, i've
investigated around the lines concerning the TAU_update, and seems that
the double-if above:

...
        if((thrm = mfspr(SPRN_THRM2)) & THRM1_TIV){ /* is valid? */
	                if(thrm & THRM1_TIN){ /* crossed high threshold */
...

after switching down the cpu-freq, is every true!

I think that the problem is in interrupts enabling/disabling during the
'cpu_set_speed' function into pmac_cpufreq.c, but i've no ideas on howto check
it...perhaps some guru, can give a more comprensive answer.


any suggests/comments, are welcome,

regards
--
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
