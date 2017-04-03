Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxpn04XFtzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 09:52:20 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 79so33068350pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 16:52:20 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:52:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very
 low thread priority
Message-ID: <20170404095207.28fc5229@roar.ozlabs.ibm.com>
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
References: <20170403215414.16951-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  4 Apr 2017 07:54:12 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> The core of snooze_loop() continually bounces between low and very
> low thread priority. Changing thread priorities is an expensive
> operation that can negatively impact other threads on a core.
> 
> All CPUs that can run PowerNV support very low priority, so we can
> avoid the change completely.

This looks good. I have HMT_lowest() which does alt feature patching
we can use for pseries and default idle code.
