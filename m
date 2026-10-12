Return-Path: <linuxppc-dev+bounces-29336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81476CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 22:23:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3X6h1FMXz308Q;
	Tue, 13 Oct 2026 09:23:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791843804;
	cv=none; b=Aj4smzu+je+A0JwITQQu7qOg06Gnzv4JMmH6DIIow84H2r0CLpMqpgh3T/XnmlxScfC2324ikXbkgkrN449s8q6msDnR7Sxrm1i8CHzwiAMmQhlMugPc1PI7WSWlHkzjXITU+xOPULj45RP78H2MEBoK0noCUvHfQv9ZZ2TlsTKwrS1ADTebmxn1WxrE8umOYyx5rtjElvqcMXQCSNABqR5DVwKW4QNUIVhaSyzH+aOjAr5B8hhmce/jZWjIfC/Kwv7zoz6220Xmc5edZv79p9hkj4Tv6mYEODHBUlLBClm9L+zia3VZF2Njs7o9liHavFyQr44IUx9vJ664XIng+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791843804; c=relaxed/relaxed;
	bh=3DJW+8ttSN+m0sshWeLbzAFqyZm04EcgN2ppzpFFZUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyvjczotmFne8SPhGiGmIZL1ZODw6rKDt7ky3H8CS1mUjojv5vv3czWZsPG6OOZQG9fgrggdV0erlDcag8xMGMnB2FndjXhZ+w1/sQm+j1ZYtBgbr1oQ6+oeoeQ+7oaE6XnxM7jYqk56EsP+xBx2NBu+uL+TxrRqGXkj+IFa1OQXtIB0SolmSRTtrF8Mj8/3nwHjAU6Up9/nEv8VjNvvRG0iid57rgErasqtE8AjWQW4ZRIYdj6TDXzTfkhL0v6lQm244YwijjjqUpMg/sd6OHIkvmXMAf8Y9je+PtkMBcUsuFJPzoJcppGxKb4G2c+QhkFnGOO/gm83IQuxRk3bdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cbq1aRpo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cbq1aRpo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 13 Oct 2026 09:23:18 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3X6Z2V2wz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 09:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791843798; x=1823379798;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5iYML6suNYDZHpJCoRMwwkKPkNnfmUYM0wRwTPR5wTg=;
  b=Cbq1aRpo/54ecGYyvdiCkE+CChetExD44JGvTN1rRHV1ntMFSCD1zITu
   hc7OmJ8/6U1Ukkj4xowPaGunzbMJOwciHhIQXF9Q8erg06qi0XCwBBwlT
   TSpoFQ9rN9Xi62tFomwo2FwxIk4FVzaeQ+uM7jyo2+HINShLm2dC8Q2jm
   2H8eWZk9t/dyjgKivb9aQi8Scq5c7m1NBuFMvLB2J/jDpltsRthmXVGcU
   OSietPvNC5X+cRR8YnWLNyDyAMiIO1e65a9Pa/KCzAAJnJIgk1Ubm8z4L
   taCpH5boBkvFbHbbew5axTv073jPQzaRmQnd6LZD8atFbJNx9tY9shBA1
   g==;
X-CSE-ConnectionGUID: VJFCMHv3TmW7YaJUqVAyEg==
X-CSE-MsgGUID: XEwr7p0kSvehWnrcSmo7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="465272"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="465272"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:22:09 -0700
X-CSE-ConnectionGUID: bsNifrMSSyi0AAQqyZ3Cpw==
X-CSE-MsgGUID: qdV+tLJBSweNMNI+jxDX3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="974426"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:22:09 -0700
Message-ID: <460a7726022740feeee606538e4cf63adf6090c2.camel@linux.intel.com>
Subject: Re: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for
 architectures to configure LLC properties
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra	
 <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Ingo Molnar	
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Arnd Bergmann	 <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-mips@vger.kernel.org,
 loongarch@lists.linux.dev, 	driver-core@lists.linux.dev, Sudeep Holla
 <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Thomas Bogendoerfer
	 <tsbogend@alpha.franken.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson	 <andreas@gaisler.com>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth
 Hegde	 <sshegde@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <chleroy@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, "H.
 Peter Anvin" <hpa@zytor.com>
Date: Mon, 12 Oct 2026 15:22:08 -0700
In-Reply-To: <20261001192849.74788-2-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
	 <20261001192849.74788-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-01 at 19:28 +0000, K Prateek Nayak wrote:
> Subsequent commits will add arch/ hooks to configure the sparsebitmask
> (sbm) topology - number of sbm instance and the maximum CPUs that a
> single instance can represent.
>=20
> Introduce sbm_set_topology() that helps architectures configure the sbm
> topology. Also add arch_sbm_cpu_instance_id() which will be used to map
> CPUs to the sbm instances during init to keep CPUs on the same instance
> on the same sbm leaf.
>=20
> Individual arch/ users will be added one at a time in the subsequent
> commits.

Thanks for working on this series.

>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/linux/sbm.h |  8 ++++++++
>  lib/Makefile        |  2 +-
>  lib/sbm.c           | 27 +++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sbm.h
>  create mode 100644 lib/sbm.c
>=20
> diff --git a/include/linux/sbm.h b/include/linux/sbm.h
> new file mode 100644
> index 000000000000..adac12ed233a
> --- /dev/null
> +++ b/include/linux/sbm.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SBM_H
> +#define _LINUX_SBM_H
> +
> +int arch_sbm_cpu_instance_id(int cpu);
> +void sbm_set_topology(int num_instances, int max_threads_per_instance);
> +
> +#endif /* _LINUX_SBM_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index dfab958327c5..7776330f5b25 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -40,7 +40,7 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o iomem_copy.o sys_info.o
> +	 buildid.o objpool.o iomem_copy.o sys_info.o sbm.o
> =20
>  lib-$(CONFIG_UNION_FIND) +=3D union_find.o
>  lib-$(CONFIG_PRINTK) +=3D dump_stack.o
> diff --git a/lib/sbm.c b/lib/sbm.c
> new file mode 100644
> index 000000000000..82280e3306de
> --- /dev/null
> +++ b/lib/sbm.c
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Minor nits.  Convention is

// SPDX-License-Identifier: GPL-2.0=20

for .c file according to
Documentation/process/license-rules.rst

checkpatch asks for a MAINTAINERS entry for include/linux/sbm.h and
lib/sbm.c.

Tim

> +#include <linux/sbm.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +
> +static int sbm_max_threads_per_instance =3D -1;
> +static int sbm_num_instance =3D -1;
> +
> +/*
> + * In absence of an arch definition, consider all CPUs to
> + * belong to the same sbm instance.
> + */
> +int __weak arch_sbm_cpu_instance_id(int cpu)
> +{
> +	return 0;
> +}
> +
> +void __init sbm_set_topology(int num_instances, int max_threads_per_inst=
ance)
> +{
> +	sbm_max_threads_per_instance =3D max_threads_per_instance;
> +	sbm_num_instance =3D num_instances;
> +
> +	pr_info("sbm topology set to %d instance(s) with a maximum of %d thread=
(s) per instance\n",
> +		sbm_num_instance,
> +		sbm_max_threads_per_instance);
> +}
> +

