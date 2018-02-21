Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmY1j0jNczF0S3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:02:15 +1100 (AEDT)
Received: by mail-pg0-x22a.google.com with SMTP id g12so458291pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 02:02:15 -0800 (PST)
Date: Wed, 21 Feb 2018 15:32:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180221100209.GP28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
 <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21-02-18, 10:27, Rafael J. Wysocki wrote:
> To be precise, ->init() should fail as that's where the table is
> created.  The registration fails as a result then.
> 
> But what if the bug is that ->init() doesn't fail when it should?
> 
> I guess the core could double check the frequency table after ->init()
> if ->target_index is not NULL.
> 
> The overall point here is that if you get a negative index in
> ->fast_switch(), that's way too late anyway and we should be able to
> catch that error much earlier.

I don't want to end up doing double checking as some of it is already
done at init, but let me check on what can be done.

-- 
viresh
