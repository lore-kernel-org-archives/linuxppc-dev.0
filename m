Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 62C4DDDED6
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 07:08:00 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 21 Feb 2008 21:07:58 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20080221200758.62940@gmx.net>
MIME-Version: 1.0
Subject: How to dynamically disable/enable CPU features?
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm wondering how to disable or enable CPU features based on the board the
kernel is running on. In my case I want to disable the
CPU_FTR_NEED_COHERENT flag for 74xx CPUs, because it locks up the machine.
I tried to clear the flag in the platform's *_probe() function with the
following code:

cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;

First I thought that this works fine, because the kernel booted once till
the console login prompt (and died afterwards). Therefore I suspected that
another change or bug in the kernel conflicts with my hardware (usually
the machine died much earlier on older kernels, if the flag wasn't
cleared).
Now I removed all CPU_FTR_NEED_COHERENT entries from the cputable.h file
and the kernel boots just fine without any lockups (reproducable).
I don't quite understand the difference between dynamically clearing the
flag in the platform setup code and removing the flag for all CPU
defines in cputable.h. I can only suspect that clearing the flag in the
platform probe function is too late, as the MMU and BATs may already be
set up.

Can anybody confirm my suspicion or give me a hint how to implement it
correctly? (I don't want to tinker with cputable.h)

Thanks!

regards,

Gerhard
-- 
Psst! Geheimtipp: Online Games kostenlos spielen bei den GMX Free Games! 
http://games.entertainment.web.de/de/entertainment/games/free
