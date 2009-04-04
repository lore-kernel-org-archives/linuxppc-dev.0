Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id EBE2BDDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 23:16:39 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g37so1262805rvb.1
	for <linuxppc-dev@ozlabs.org>; Sat, 04 Apr 2009 05:16:38 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 4 Apr 2009 17:46:38 +0530
Message-ID: <f234e2140904040516w7db57a5fsfaa6a8674d707bdd@mail.gmail.com>
Subject: CONFIG_PREEMPT and High Resolution Timers problem
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,
I have mpc8313erdb eval board with Linux-2.6.20 running on it.
Recently I had a problem, I wrote a driver and from I am sending
notification to user space application using fasync driver method
(SIGIO signal). In user space applicaion process I have used
posix-timers (timer_create and timer_settime), the timer is set for
10ms. But in actual I checked on oscilloscope the expiration of timer
or signal event generation varies between 10ms - 13ms. In kerenl
driver when the interrupt occurs I am making a gpio pin high and on
the signal event when timer expires I am making another gpio pin high,
and the time between these measured varies between 10ms - 13ms i.e. it
means the timer frequency is 250Hz, which was set by default for
powerpc. So to achieve close to precise of 10ms I set the timer
frequency to 1000Hz and then I got the resolution of 10ms -10.8ms.
I would like to ask is the right approach of changing Timer Frequency
to 1000Hz from 250Hz ? ? ?
Because while searching some information regarding this I learned
about High-Res Timers. In linux-2.6.20 x86 has this feature enabled
rather you can enable it but not for powerpc arch, Right ? ? ? If yes
then is there any way to add CONFIG_HIGH_RES_TIMERS feature to
linux-2.6.20, any patch available ? ? ? =A0otherwise what could be the
option ? ? ?

In Linux by default Preemption is not enabled, CONFIG_PREEMPT_NONE=3Dy
so I tried to enabled CONFIG_PREEMPT=3Dy but when I boot the board with
preemption enabled I got the scheduling with atomic error (please
check the log below, thanks). I tried to debug and find some info but
no luck. Could anyone please explain the reason for it and how I can
fix it ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

########################### Start #################################
NET: Registered protocol family 1
NET: Registered protocol family 17
BUG: scheduling while atomic: swapper/0x00000001/1
Call Trace:
[C07F5D50] [C0008938] =A0(unreliable)
[C07F5D80] [C02933CC]
[C07F5DD0] [C029472C]
[C07F5E10] [C0201AF0]
[C07F5E50] [C0201E08]
[C07F5E90] [C01FEE14]
[C07F5EB0] [C0202018]
[C07F5F30] [C0017490]
[C07F5F50] [C02FB4B0]
[C07F5F90] [C0003960]
[C07F5FF0] [C0010C74]
BUG: scheduling while atomic: swapper/0x00000001/1
########################## END ####################################
########################## Start ####################################
BUG: scheduling while atomic: jffs2_gcd_mtd4/0x00000004/719
Call Trace:
[C05BDBE0] [C0008938] =A0(unreliable)
[C05BDC10] [C02933CC]
[C05BDC60] [C029472C]
[C05BDCA0] [C01D9F14]
[C05BDCE0] [C01D5424]
[C05BDD40] [C01D74D4]
[C05BDD70] [C01C9330]
[C05BDD80] [C0127F88]
[C05BDDB0] [C011F26C]
[C05BDE20] [C0120320]
[C05BDE90] [C012327C]
--- Exception: 1[C05BDF50] [C0125F0C] =A0(unreliable)
[C05BDFF0] [C0010C74]
######################## END ########################################
