Return-Path: <Adam.Zajac@motorola.com>
Received: from motgate.mot.com (motgate.mot.com [129.188.136.100])
	by ozlabs.org (Postfix) with ESMTP id 8DDB72BD81
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 08:44:59 +1000 (EST)
Received: from az33exr04.mot.com (pobox4.mot.com [10.64.251.243])
	by motgate.mot.com (Motorola/Motgate) with ESMTP id i9IMitKM006774
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Oct 2004 15:44:55 -0700 (MST)
Received: from tx14exm06.ftw.mot.com (tx14exm06.ftw.mot.com [10.63.167.204])
	by az33exr04.mot.com (Motorola/az33exr04) with ESMTP id i9IKiWmm004594
	for <linuxppc-embedded@ozlabs.org>; Mon, 18 Oct 2004 15:44:32 -0500
Message-ID: <EFB813091B18D511BD3600508B644F820A6181E9@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'Eugene Surovegin'" <ebs@ebshome.net>
Date: Mon, 18 Oct 2004 17:44:52 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Help on tuning the Linux kernel for soft real-time requiremen ts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

It sounds like you're doing exactly what we've been trying to achieve.
We're trying to meet soft real-time deadlines that are in order of seconds
(2sec).
The only differences between our systems are:
- kernel 2.4.20
- HZ = 100
- Compact Flash

We tried to do a similar thing to the scenario you described where we were
running all other threads with SCHED_OTHER, and the thread with real-time
priority with RoundRobin scheduler policy. We keep experiencing the greatest
slips for such file system intensive operations like gzip and tar.
Also, for an experiment, we tried to turn disk caching off, which helped
meeting the deadlines a little but slowed down all file transfers
unacceptably.
To eliminate the question on the compact flash performance we tried using
NFS. Using NFS  yielded similar results (missed deadlines) to performing the
transfers with the cflash card.

Did you have to set anything special at your kernel config file (.config)?
Did you need to apply low-latency patch separately or the MV kernel you have
came pre-patched?

Thanks,
Adam Zajac
