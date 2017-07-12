Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6yRY6575zDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 22:09:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
In-Reply-To: <20170712020827.GB31223@us.ibm.com>
References: <20170712020827.GB31223@us.ibm.com>
Date: Wed, 12 Jul 2017 22:09:12 +1000
Message-ID: <87a849luvr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Hi Arnaldo,
>
> Please pull the JSON files for POWER9 PMU events.
>
> The following changes since commit 07d306c838c5c30196619baae36107d0615e459b:
>
>   Merge git://www.linux-watchdog.org/linux-watchdog (2017-07-11 09:59:37 -0700)
>
> are available in the git repository at:
>
>   https://github.com/sukadev/linux/ p9-json
>
> for you to fetch changes up to f94a86dbb13e18bd7ad566cabe42df63d3bd1039:
>
>   perf vendor events: Add POWER9 PVRs to mapfile (2017-07-11 19:30:40 -0500)
>
> ----------------------------------------------------------------
> Sukadev Bhattiprolu (2):
>       perf vendor events: Add POWER9 PMU events
>       perf vendor events: Add POWER9 PVRs to mapfile

I think the PVRs need work.

You have:

+004e0100,1,power9.json,core
+004e0000,1,power9.json,core

The first is P9 DD1, but the second doesn't exist. We have it in the
kernel, but with a mask of 0xffff0000. From memory the perf code doesn't
do any masking or anything fancy, it looks for an exact match.

So for starters you should probably drop that one and add 0x004e1200 and
0x004e0200.

cheers
