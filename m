Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D61112C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 03:51:38 +1000 (EST)
Subject: Re: [PATCH 3/4] cpu: export cpu hotplug disable/enable functions as
 global functions
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 7 Aug 2012 12:51:13 -0500
Message-Id: <B4FC7F5E-EA8F-4FCA-B206-353FE4481DCE@kernel.crashing.org>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
To: srivatsa.bhat@linux.vnet.ibm.com, rjw@sisk.pl
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 7, 2012, at 3:43 AM, Zhao Chenhui wrote:

> The cpufreq driver of mpc85xx will disable/enable cpu hotplug =
temporarily.
> Therefore, the related functions should be exported.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> include/linux/cpu.h |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

Rafael, Srivatsa,

Wanted to get your ack on export these functions for direct calling by =
arch code.

- k

>=20
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index ce7a074..df8f73d 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -146,6 +146,8 @@ void notify_cpu_starting(unsigned int cpu);
> extern void cpu_maps_update_begin(void);
> extern void cpu_maps_update_done(void);
>=20
> +extern void cpu_hotplug_disable_before_freeze(void);
> +extern void cpu_hotplug_enable_after_thaw(void);
> #else	/* CONFIG_SMP */
>=20
> #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
> @@ -167,6 +169,8 @@ static inline void cpu_maps_update_done(void)
> {
> }
>=20
> +static inline void cpu_hotplug_disable_before_freeze(void)	{}
> +static inline void cpu_hotplug_enable_after_thaw(void)	{}
> #endif /* CONFIG_SMP */
> extern struct bus_type cpu_subsys;
>=20
> --=20
> 1.6.4.1
>=20
