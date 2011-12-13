Return-Path: <fchen@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
 by ozlabs.org (Postfix) with SMTP id 535171007D4
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 07:49:27 +1100 (EST)
Received: by fanq24 with SMTP id q24so921449fan.35
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 12:49:25 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 13 Dec 2011 12:42:20 -0800
Message-ID: <CAEu=RPirE=H1N=KjHNjNRBM6H1fRvrugCw6ojqWaTNm2=WTfng@mail.gmail.com>
Subject: CONFIG_NO_HZ added too much idle time in /proc/stat during throughput
 test.
From: Fushen Chen <fchen@apm.com>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: multipart/alternative; boundary=f46d04428df2ab464204b3ff49a7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04428df2ab464204b3ff49a7
Content-Type: text/plain; charset=ISO-8859-1

On APM82181,  "vmstat" (/proc/stat)  doesn't show correct idle percent, if
kernel enables "CONFIG_NO_HZ" (Tickless System / Dynamic Tick).

When I run wireless throughput test with heavy traffic, "vmstat" shows very
high idle percent while "oprofile" shows very low idle percent. During the
test, the system is idle, but network traffic uses a lot of hard IRQ and
soft-irq time. "vmstat" would have the correct stats if
account_idle_ticks(ticks) in kernel/time/tick-sched.c doesn't add more idle
time in "vmstat". In the same test, if I disable "CONFIG_NO_HZ" in kernel,
idle percent in "vmstat" and "oprofile" would match.

My APM82181 kernel configuration is "CONFIG_NO_HZ", "CONFIG_HZ_250=y",
"CONFIG_HZ=250", and "CONFIG_HIGH_RES_TIMERS".

My question is that if kernel enables "CONFIG_NO_HZ", how would kernel
report correct stats.

Thanks,
Fushen

--f46d04428df2ab464204b3ff49a7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On APM82181,=A0 &quot;vmstat&quot; (/proc/stat)=A0 doesn&#39;t show correct=
 idle percent, if kernel enables &quot;CONFIG_NO_HZ&quot; (Tickless System =
/ Dynamic Tick).<br><br>When I run wireless throughput test with heavy traf=
fic, &quot;vmstat&quot; shows very high idle percent while &quot;oprofile&q=
uot; shows very low idle percent. During the test, the system is idle, but =
network traffic uses a lot of hard IRQ and soft-irq time. &quot;vmstat&quot=
; would have the correct stats if account_idle_ticks(ticks) in kernel/time/=
tick-sched.c doesn&#39;t add more idle time in &quot;vmstat&quot;. In the s=
ame test, if I disable &quot;CONFIG_NO_HZ&quot; in kernel, idle percent in =
&quot;vmstat&quot; and &quot;oprofile&quot; would match.<br>
<br>My APM82181 kernel configuration is &quot;CONFIG_NO_HZ&quot;, &quot;CON=
FIG_HZ_250=3Dy&quot;, &quot;CONFIG_HZ=3D250&quot;, and &quot;CONFIG_HIGH_RE=
S_TIMERS&quot;.<br><br>My question is that if kernel enables &quot;CONFIG_N=
O_HZ&quot;, how would kernel report correct stats.<br>
<br>Thanks,<br>Fushen<br>

--f46d04428df2ab464204b3ff49a7--
