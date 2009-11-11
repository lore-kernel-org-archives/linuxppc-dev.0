Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BAF9B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 00:28:42 +1100 (EST)
Subject: Re: [PATCH v5 0/4] pseries: Add cede support for cpu-offline
From: Peter Zijlstra <peterz@infradead.org>
To: Gautham R Shenoy <ego@in.ibm.com>
In-Reply-To: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
References: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Nov 2009 14:25:35 +0100
Message-ID: <1257945935.4372.36.camel@twins>
Mime-Version: 1.0
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linux-kernel@vger.kernel.org,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-30 at 10:52 +0530, Gautham R Shenoy wrote:

> Gautham R Shenoy (4):
>       pseries: Serialize cpu hotplug operations during deactivate Vs deal=
locate
>       pseries: Add code to online/offline CPUs of a DLPAR node.
>       pSeries: Add hooks to put the CPU into an appropriate offline state
>       pSeries: extended_cede_processor() helper function.
>=20
>=20
>  Documentation/cpu-hotplug.txt                   |    6 +
>  arch/powerpc/include/asm/lppaca.h               |    9 +
>  arch/powerpc/platforms/pseries/dlpar.c          |  129 ++++++++++++++++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c    |  182 +++++++++++++++++=
+++++-
>  arch/powerpc/platforms/pseries/offline_states.h |   18 ++
>  arch/powerpc/platforms/pseries/plpar_wrappers.h |   22 +++
>  arch/powerpc/platforms/pseries/smp.c            |   19 ++
>  arch/powerpc/xmon/xmon.c                        |    3=20
>  drivers/base/cpu.c                              |    2=20
>  include/linux/cpu.h                             |   13 ++
>  10 files changed, 387 insertions(+), 16 deletions(-)
>  create mode 100644 arch/powerpc/platforms/pseries/offline_states.h

Not quite sure how you solved the DLPAR communication but since pretty
much everything is under arch/powerpc/ I really don't have much to say.
