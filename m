Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5A252DF4A9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:27:43 +1000 (EST)
Date: Tue, 28 Aug 2007 13:27:41 -0700 (PDT)
Message-Id: <20070828.132741.118957759.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708281321.10679.ossthema@de.ibm.com>
References: <46D2F301.7050105@katalix.com>
	<20070827.140251.95055210.davem@davemloft.net>
	<200708281321.10679.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Tue, 28 Aug 2007 13:21:09 +0200

> So I guess one solution is to "force" an HW interrupt when two many
> RQs are processed on the same CPU (when no IRQ pinning is
> used). This is something the driver has to handle.

No, the solution is to lock the interrupts onto one specific
processor and don't move it around.  That's what's causing
all of the problems.

And you can enforce this policy now in the driver even if just
for testing by calling the set_affinity() interfaces on the
interrupts your driver has.

You can even walk over the cpu_online_map and choose a load
distribution of your liking.
