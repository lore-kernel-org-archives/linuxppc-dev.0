Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmXFt0x78zF0W4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 20:27:42 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id c83so669183oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 01:27:42 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180221055450.GO28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2018 10:27:39 +0100
Message-ID: <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 6:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-02-18, 16:39, Michael Ellerman wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>
>> > AFAICT, you will get -1 here only if the freq table had no valid
>> > frequencies (or the freq table is empty). Why would that happen ?
>>
>> Bugs?
>
> The cupfreq driver shouldn't have registered itself in that case (i.e.
> if the cpufreq table is empty).

To be precise, ->init() should fail as that's where the table is
created.  The registration fails as a result then.

But what if the bug is that ->init() doesn't fail when it should?

I guess the core could double check the frequency table after ->init()
if ->target_index is not NULL.

The overall point here is that if you get a negative index in
->fast_switch(), that's way too late anyway and we should be able to
catch that error much earlier.
