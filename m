Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0B24B67A33
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 20:22:29 +1000 (EST)
Message-ID: <425266E2.7060605@gmx.de>
Date: Tue, 05 Apr 2005 12:22:26 +0200
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------000109070503030401030608"
Subject: [Fwd: Re: iBook G3 owners]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000109070503030401030608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bah! Different mailing list, different behaviour if you click on "Reply 
to Sender only"! ;-)


Sebasitna

--------------000109070503030401030608
Content-Type: message/rfc822;
 name="Re: iBook G3 owners"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: iBook G3 owners"

Message-ID: <42526635.2010709@gmx.de>
Date: Tue, 05 Apr 2005 12:19:33 +0200
From: Sebastian Heutling <sheutlin@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: iBook G3 owners
References: <1112594783.26086.22.camel@gaston>
In-Reply-To: <1112594783.26086.22.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IMAPbase: 1112695643 1
X-UID: 1
X-Keywords: 

Benjamin Herrenschmidt wrote:

>Hi !
>
>There have been various reports of issues with sleep among others on
>iBook G3 equiped with the 750FX processor. Also, the cpufreq code on
>these so far didn't change the CPU voltage, which limited the actual
>power saving at low frequency.
>
>I have uploaded various patches that should help fix these issues. Those
>patches are all against current linus bk and they should be all applied
>in the order below.
>
>I would really appreciate some tests as I don't have access to any of
>these machines. I need to know if cpufreq works reliably with those
>patches and if the new voltage control makes any differnece on battery
>life (check power consumption in /proc/pmu/battery_*/current when
>running on battery) and I need to know if the patches are improving
>reliability of sleep/wakeup.
>
>The 4 patches can be found at these URLs. If you had earlier versions of
>some of these, those patches replace them:
>
>http://gate.crahsing.org/~benh/ppc32-750-errata-fix.diff
>http://gate.crahsing.org/~benh/ppc32-pmac-sleep-fix.diff
>http://gate.crahsing.org/~benh/cpufreq-add-suspend.diff
>http://gate.crahsing.org/~benh/ppc32-cpufreq-gpio-off.diff
>
>Please, let me know asap,
>  
>
Sleep/wakeup works with a modified arch/ppc/platform/pmac_sleep.S (bl 
reloc_offset was missing which you send later). I still have a strange 
problem with some programs started in init-Scripts. For example if I run 
dbus on bootup and directly after that go to sleep and wake-up again my 
ibook doesn't resume harddisks leaving the following last messages:

eth0 resuming
PHY ID: 4061e4, addr: 0
eth0: Link is up at 100 Mbps, full duplex.
eth0: Pause is disabled

If I disable dbus (stop it) and go to sleep, wakeup - no problem. 
Sometimes it is even enough to just only restart the
daemon.

I'm not sure about cpufreq. I used to run the cpufreq daemon. With this 
program I realised three possible frequencies on my ibook: 400,  462, 
700 MHz. Using powernowd or directly the userspace governour gives only 
400 and 700MHz. So maybe there is something wrong here, too or this 
specific CPU/ibook does only support 2 states.

Details about the ibook:
iBook, Dual USB
blueberry:~# cat /proc/cpuinfo
processor       : 0
cpu             : 750FX
temperature     : 1-76 C (uncalibrated)
clock           : 700MHz
revision        : 2.2 (pvr 7000 0202)
bogomips        : 1388.54
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000001b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld




Sebastian



--------------000109070503030401030608--
