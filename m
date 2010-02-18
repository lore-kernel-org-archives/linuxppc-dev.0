Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07662B7DEA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 09:01:20 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Convert socrates_fpga_pic_lock to
	raw_spinlock
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100218134512.GB5331@oksana.dev.rtsoft.ru>
Date: Thu, 18 Feb 2010 16:01:09 -0600
Message-Id: <E642CCB5-E18A-4737-A87F-F4A41BD06C37@kernel.crashing.org>
References: <20100218121904.620984825@linutronix.de>
	<20100218134512.GB5331@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 18, 2010, at 7:45 AM, Anton Vorontsov wrote:

> Interrupt controllers' hooks are executed in the atomic context, so
> they are not permitted to sleep (with RT kernels non-raw spinlocks are
> sleepable). So, socrates_fpga_pic_lock has to be a real =
(non-sleepable)
> spinlock.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>=20
> On Thu, Feb 18, 2010 at 12:22:18PM -0000, Thomas Gleixner wrote:
>> Ben,
>>=20
>> the following patch series is from preempt-rt. It converts the locks
>> which need to be real spinlocks in -rt to raw_spinlocks.
>>=20
>> There is no behaviourial change for !RT kernels because spinlocks and
>> raw_spinlocks are the same on !RT. So for mainline this is a pure
>> annotation while having it in mainline takes the burden of keeping up
>> with the code changes from the RT patch set.
>>=20
>> Please consider to merge into .34.
>=20
> Oh, and I guess the same for the socrates fpga pic...
>=20
> arch/powerpc/platforms/85xx/socrates_fpga_pic.c |   34 =
+++++++++++-----------
> 1 files changed, 17 insertions(+), 17 deletions(-)

applied to next

- k=
