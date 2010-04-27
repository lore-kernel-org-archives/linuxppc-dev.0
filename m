Return-Path: <xiaoxianghua@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 5AE6FB7DBC
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 05:26:47 +1000 (EST)
Received: by pvg6 with SMTP id 6so1781196pvg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 12:26:46 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Apr 2010 14:26:44 -0500
Message-ID: <h2ie6bf505b1004271226m8441bf04qa0e0676b20340d57@mail.gmail.com>
Subject: gianfar driver with realtime patch does not work
From: Xianghua Xiao <xiaoxianghua@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to get 834x/TSEC gianfar.c working with 2.6.33/RT.

when PREEMPT is disabled gianfar driver worked well.

if PREEMPT is enabled, especially when PREEMPT_RT is enabled,
network(gianfar) will be disconnected in about 2-3 minutes under
iperf.

In an older version (2.6.18-rt) where NAPI is disabled, gianfar
performed well under PREEMPT_RT, in the new version of gianfar, NAPI
is enforced(the code is there by default and it's hard to disable NAPI
in the code now), also TX COALESCE is enabled while RX COALESCE is
disabled. It seems to me NAPI is now by default for Rx and COALESCE is
by default for Tx.

Both NAPI/COALESCE may have negative effects for real time systems,
where latency is more important than throughput. Unfortunately it's
hard to disable either of them now after some experiments.

Is there anyone here using gianfar with PREEMPT_RT? Do I have to port
an older version gianfar to get rid of NAPI at least?

Thanks,
Xianghua
