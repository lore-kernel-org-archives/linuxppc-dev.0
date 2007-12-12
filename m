Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B70DDDF81
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 22:34:41 +1100 (EST)
Subject: Re: cpu frequency governor regression (?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Dave Jones <davej@redhat.com>, Tim Dijkstra <tim@famdijkstra.org>
In-Reply-To: <20071212173001.GA18973@redhat.com>
References: <1197399165.2214.15.camel@johannes.berg>
	<20071212173001.GA18973@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tggaUNcYnAqaJ5Ie+vju"
Date: Wed, 12 Dec 2007 20:53:43 +0100
Message-Id: <1197489224.6558.178.camel@johannes.berg>
Mime-Version: 1.0
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


--=-tggaUNcYnAqaJ5Ie+vju
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, umm, sorry for bothering. This is actually a userspace problem.
Because I had it written up already below is the mail I was composing; I
was just checking whether the same would happen without the performance
module loaded, and voila, the same *did* happen which lead me to
investigate userspace. Turns out pm-utils is the cause of this problem.
Nothing but trouble with pm-utils on non-standard non-ACPI systems :/

The problem is this: pm-utils's hibernate_cpufreq() does:

savestate ${x}_governor $(cat $x/cpufreq/scaling_governor)
          ^^^^^

but thaw_cpufreq() does:

gov=3D$(restorestate $(echo cpu${x}_governor))
                          ^^^^^^^^

doh! Again, sorry, I really should have looked there first.

johannes

--- >% >% >% ---

> bizarre. It should default back to whatever CONFIG_CPU_FREQ_DEFAULT_* opt=
ion
> was set.  (Arguably a bug in itself, as we don't track & restore them
> on resume, so if you changed from the default after booting: splat)

Ok I verified this again:

$ zgrep CPU_FREQ /proc/config.gz=20
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_DEBUG=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dm
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
CONFIG_CPU_FREQ_PMAC64=3Dy

> Also, does /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor=20
> have performance in *all* the cpus?

Yes, it does.

> Why you're getting the performance governor is puzzling though.
> Can you enable CONFIG_CPU_FREQ_DEBUG=3Dy, and boot with cpufreq.debug=3D7
> and send the log from a transition across hibernate?

Ok, fresh boot with cpufreq.debug=3D7, so far I have "userspace" in all
scaling_governor files for the four CPUs.

Up to this point, I have the following in the log (dmesg | grep "freq"):

[    0.000000] time_init: decrementer frequency =3D 33.333333 MHz
[    0.000000] time_init: processor frequency   =3D 2500.000000 MHz
[    0.168566] Registering G5 CPU frequency driver
[    0.168583] cpufreq-core: trying to register driver powermac
[    0.168588] cpufreq-core: adding CPU 0
[    0.168597] freq-table: setting show_table for cpu 0 to c00000000054caf0
[    0.168601] freq-table: table entry 0: 2500000 kHz, 0 index
[    0.168605] freq-table: table entry 1: 1250000 kHz, 1 index
[    0.168751] cpufreq-core: CPU 1 already managed, adding link
[    0.168758] cpufreq-core: CPU 2 already managed, adding link
[    0.168766] cpufreq-core: CPU 3 already managed, adding link
[    0.168774] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[    0.168779] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    0.168784] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    0.168789] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    0.168794] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    0.168799] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[    0.168802] cpufreq-core: governor switch
[    0.168810] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[    0.168823] cpufreq-core: governor: change or update limits
[    0.168827] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[    0.168837] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[    0.168842] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[    0.168846] freq-table: target is 0 (2500000 kHz, 0)
[    0.168849] cpufreq-core: initialization complete
[    0.168853] cpufreq-core: adding CPU 1
[    0.168856] cpufreq-core: adding CPU 2
[    0.168859] cpufreq-core: adding CPU 3
[    0.168865] cpufreq-core: driver powermac up and running
[    4.997986] cpufreq-core: updating policy for CPU 0
[    4.997992] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[    4.997998] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998003] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998009] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998013] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998029] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[    4.998032] cpufreq-core: governor: change or update limits
[    4.998036] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[    4.998048] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[    4.998052] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[    4.998056] freq-table: target is 0 (2500000 kHz, 0)
[    4.998061] cpufreq-core: updating policy for CPU 1
[    4.998065] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[    4.998070] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998075] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998080] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998085] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998090] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[    4.998093] cpufreq-core: governor: change or update limits
[    4.998097] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[    4.998108] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[    4.998112] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[    4.998116] freq-table: target is 0 (2500000 kHz, 0)
[    4.998120] cpufreq-core: updating policy for CPU 2
[    4.998125] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[    4.998130] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998135] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998140] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998145] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998149] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[    4.998153] cpufreq-core: governor: change or update limits
[    4.998157] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[    4.998167] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[    4.998172] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[    4.998175] freq-table: target is 0 (2500000 kHz, 0)
[    4.998180] cpufreq-core: updating policy for CPU 3
[    4.998184] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[    4.998189] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998194] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998199] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[    4.998204] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[    4.998208] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[    4.998212] cpufreq-core: governor: change or update limits
[    4.998216] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[    4.998226] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[    4.998231] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[    4.998235] freq-table: target is 0 (2500000 kHz, 0)
[   29.644593] userspace: cpufreq_set for cpu 0, freq 1250000 kHz
[   29.644602] cpufreq-core: target for CPU 0: 1250000 kHz, relation 0
[   29.644607] freq-table: request for target 1250000 kHz (relation: 0) for=
 cpu 0
[   29.644660] freq-table: target is 1 (1250000 kHz, 1)
[   29.644665] cpufreq-core: notification 0 of frequency transition to 1250=
000 kHz
[   29.644670] userspace: saving cpu_cur_freq of cpu 0 to be 1250000 kHz
[   29.644688] cpufreq-core: notification 1 of frequency transition to 1250=
000 kHz
[   29.644697] userspace: saving cpu_cur_freq of cpu 0 to be 1250000 kHz
[   31.646503] userspace: cpufreq_set for cpu 0, freq 2500000 kHz
[   31.646521] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[   37.653379] userspace: cpufreq_set for cpu 0, freq 2500000 kHz
[   47.661393] userspace: cpufreq_set for cpu 0, freq 2500000 kHz
[   47.661405] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[   49.662323] userspace: cpufreq_set for cpu 0, freq 1250000 kHz
[   59.670718] userspace: cpufreq_set for cpu 0, freq 2500000 kHz
[   59.670730] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0


Now I hibernate. Afterwards, I have "performance" in all four governor
files. The log across hibernate (a bit after above log I hibernated the
system) is (again | grep "freq"):

[  161.071430] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  161.071446] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.071456] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.071468] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.071479] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.071489] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  161.071496] cpufreq-core: governor switch
[  161.071504] cpufreq-core: __cpufreq_governor for CPU 0, event 2
[  161.087864] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[  161.087882] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  161.087892] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  161.087901] freq-table: target is 0 (2500000 kHz, 0)
[  161.087910] cpufreq-core: notification 0 of frequency transition to 2500=
000 kHz
[  161.087929] cpufreq-core: notification 1 of frequency transition to 2500=
000 kHz
[  161.087934] cpufreq-core: governor: change or update limits
[  161.087938] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  161.087947] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  161.087951] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  161.087955] freq-table: target is 0 (2500000 kHz, 0)
[  161.098312] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  161.098326] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.098331] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.098338] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.098343] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.098348] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  161.098352] cpufreq-core: governor: change or update limits
[  161.098356] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  161.098503] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  161.098508] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  161.098512] freq-table: target is 0 (2500000 kHz, 0)
[  161.105644] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  161.105654] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.105659] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.105665] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.105670] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.105675] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  161.105679] cpufreq-core: governor: change or update limits
[  161.105683] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  161.105692] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  161.105697] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  161.105701] freq-table: target is 0 (2500000 kHz, 0)
[  161.114175] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  161.114185] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.114190] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.114196] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  161.114201] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  161.114206] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  161.114209] cpufreq-core: governor: change or update limits
[  161.114214] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  161.114223] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  161.114228] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  161.114232] freq-table: target is 0 (2500000 kHz, 0)
[  164.193568] cpufreq-core: unregistering CPU 1
[  164.193571] cpufreq-core: removing link
[  164.199711] cpufreq-core: unregistering CPU 2
[  164.199714] cpufreq-core: removing link
[  164.204755] cpufreq-core: unregistering CPU 3
[  164.204758] cpufreq-core: removing link
[  164.254908] cpufreq-core: suspending cpu 0
[  164.254912] cpufreq-core: suspending cpu 1
[  164.254915] cpufreq-core: suspending cpu 2
[  164.254918] cpufreq-core: suspending cpu 3
[  164.271294] cpufreq-core: resuming cpu 0
[  164.271304] cpufreq-core: resuming cpu 1
[  164.271307] cpufreq-core: resuming cpu 2
[  164.271310] cpufreq-core: resuming cpu 3
[  164.321819] cpufreq-core: handle_update for cpu 0 called
[  164.321824] cpufreq-core: updating policy for CPU 0
[  164.321829] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  164.321835] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.321840] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.321846] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.321851] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.321856] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  164.321860] cpufreq-core: governor: change or update limits
[  164.321864] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  164.321873] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  164.321878] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  164.321882] freq-table: target is 0 (2500000 kHz, 0)
[  164.349425] cpufreq-core: adding CPU 1
[  164.349432] freq-table: setting show_table for cpu 1 to c00000000054caf0
[  164.349436] freq-table: table entry 0: 2500000 kHz, 0 index
[  164.349440] freq-table: table entry 1: 1250000 kHz, 1 index
[  164.349444] cpufreq-core: CPU already managed, adding link
[  164.349457] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  164.349462] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.349467] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.349473] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.349478] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.349482] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  164.349486] cpufreq-core: governor: change or update limits
[  164.349490] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  164.349498] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  164.349503] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  164.349507] freq-table: target is 0 (2500000 kHz, 0)
[  164.376472] cpufreq-core: adding CPU 2
[  164.376477] freq-table: setting show_table for cpu 2 to c00000000054caf0
[  164.376481] freq-table: table entry 0: 2500000 kHz, 0 index
[  164.376485] freq-table: table entry 1: 1250000 kHz, 1 index
[  164.376490] cpufreq-core: CPU already managed, adding link
[  164.376501] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  164.376506] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.376511] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.376516] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.376521] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.376526] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  164.376529] cpufreq-core: governor: change or update limits
[  164.376533] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  164.376542] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  164.376546] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  164.376550] freq-table: target is 0 (2500000 kHz, 0)
[  164.403562] cpufreq-core: adding CPU 3
[  164.403568] freq-table: setting show_table for cpu 3 to c00000000054caf0
[  164.403573] freq-table: table entry 0: 2500000 kHz, 0 index
[  164.403576] freq-table: table entry 1: 1250000 kHz, 1 index
[  164.403581] cpufreq-core: CPU already managed, adding link
[  164.403592] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  164.403597] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.403602] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.403607] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  164.403612] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  164.403617] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  164.403621] cpufreq-core: governor: change or update limits
[  164.403624] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  164.403633] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  164.403637] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  164.403641] freq-table: target is 0 (2500000 kHz, 0)
[  165.337598] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  165.337608] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.337613] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.337619] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.337624] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.337629] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  165.337632] cpufreq-core: governor switch
[  165.337636] cpufreq-core: __cpufreq_governor for CPU 0, event 2
[  165.337641] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[  165.337661] cpufreq-core: governor: change or update limits
[  165.337665] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  165.337676] cpufreq-core: target for CPU 0: 2500000 kHz, relation 0
[  165.337681] freq-table: request for target 2500000 kHz (relation: 0) for=
 cpu 0
[  165.337685] freq-table: target is 0 (2500000 kHz, 0)
[  165.348578] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  165.348591] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.348597] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.348604] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.348609] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.348614] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  165.348617] cpufreq-core: governor switch
[  165.348621] cpufreq-core: __cpufreq_governor for CPU 0, event 2
[  165.358459] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[  165.358468] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  165.358530] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  165.358534] freq-table: target is 0 (2500000 kHz, 0)
[  165.358538] cpufreq-core: governor: change or update limits
[  165.358541] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  165.358550] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  165.358554] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  165.358558] freq-table: target is 0 (2500000 kHz, 0)
[  165.365797] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  165.365809] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.365815] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.365873] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.365877] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.365882] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  165.365886] cpufreq-core: governor: change or update limits
[  165.365890] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  165.365898] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  165.365903] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  165.365907] freq-table: target is 0 (2500000 kHz, 0)
[  165.373083] cpufreq-core: setting new policy for CPU 0: 1250000 - 250000=
0 kHz
[  165.373096] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.373102] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.373160] freq-table: request for verification of policy (1250000 - 25=
00000 kHz) for cpu 0
[  165.373165] freq-table: verification lead to (1250000 - 2500000 kHz) for=
 cpu 0
[  165.373169] cpufreq-core: new min and max freqs are 1250000 - 2500000 kH=
z
[  165.373173] cpufreq-core: governor: change or update limits
[  165.373177] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  165.373185] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
[  165.373190] freq-table: request for target 2500000 kHz (relation: 1) for=
 cpu 0
[  165.373194] freq-table: target is 0 (2500000 kHz, 0)


I saw a "14 messages suppressed" message but I don't know if it came
from here.


--=-tggaUNcYnAqaJ5Ie+vju
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2A8RqVg1VMiehFYAQJSBw//UMGOq1MVccNY84LqLL+d00D8QVXMgrlC
eb9M83nuDu+C5q7HlX4s2NShkxsg28HeSzFvgjIihbJAkDT7ebIh60YFOmg6xDkf
MMJ++58wFGntu9xQ35WMkU5s9Db+qe75q0UMJRj1Meq1jMEg33e4GgGt9feaZBX3
Sz/v4Bu01Ru1MejXtQqKabGIR3fCQ7q9Vyi+fOCHnPdg2UmbGo9DPJPfgU9uCu8W
YvDiUbAQO+flKMImHRDTSHcnV9xgF/qo4uTBI1RP00P5NkMiozgu6lk6WZiF1Ko/
hrv8OSd4yZi0iwHTCSGeTPAc4YLbJbIEtI2LSvYr8DTHKaVMR8hXPs/fqg2vI9CG
kyzsyQHS+E4HcNq+KAhFW86DVsz4zuZeyktLuIWNcLoObAk2mxKi56gt4UBD01ll
kqnq/ycaVIGF/pNGVkXKCNGv860FU0uJoUagpGK2ltujIZ3VDJbJ2UAmJcvjvdRD
f8daWesmeEskCVikSO5EGFIZLdGspcNcpNuP/5mGW9SNAMQkrRBMmobW0NOv+fOc
1hG0QV77rjtgmrcBfJ8KUzL705P4YMQzGBRXchbnLCVGgV8pJDl9MbquGh1O3UZl
Lo34VKyMGRho23Q08y9sd/heY5gb5IYLGYrFA5IhJiXPltSjQ5I6EG3ryl0LFqpf
cIzU50OcGMM=
=VmVW
-----END PGP SIGNATURE-----

--=-tggaUNcYnAqaJ5Ie+vju--
