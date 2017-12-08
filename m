Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytZ2D3gW6zDx9R
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Dec 2017 01:08:20 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id r63so7233183oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Dec 2017 06:08:20 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <87indhh25h.fsf@concordia.ellerman.id.au>
References: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAJZ5v0jzh1B_8FYciWhpJZVPZNzm3n30NEE25LO_YJ17Wi+h+w@mail.gmail.com>
 <87indhh25h.fsf@concordia.ellerman.id.au>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Dec 2017 15:08:17 +0100
Message-ID: <CAJZ5v0hg7AAJBeKpAi2Bv6-udGjGT7RywgofCPmO7j3BsZ2P9A@mail.gmail.com>
Subject: Re: [v2 PATCH] cpufreq: powernv: Correctly parse the sign of pstates
 on POWER8 vs POWER9
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 8, 2017 at 12:47 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
>> On Thu, Dec 7, 2017 at 6:59 AM, Gautham R. Shenoy
>> <ego@linux.vnet.ibm.com> wrote:
>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>
>>> On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
>>> negatively numbered while on POWER9 they are positively
>>> numbered. Thus, on POWER9, the maximum number of pstates could be as
>>> high as 256.
>>>
>>> The current code interprets pstates as a signed 8-bit value. This
>>> causes a problem on POWER9 platforms which have more than 128 pstates.
>>> On such systems, on a CPU that is in a lower pstate whose number is
>>> greater than 128, querying the current pstate returns a "pstate X is
>>> out of bound" error message and the current pstate is reported as the
>>> nominal pstate.
>>>
>>> This patch fixes the aforementioned issue by correctly differentiating
>>> the sign whenever a pstate value read, depending on whether the
>>> pstates are positively numbered or negatively numbered.
>>>
>>> Fixes: commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
>>> Cc: <stable@vger.kernel.org> #v4.8
>>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>>> Tested-and-reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> I'm going to apply this, or please let me know if you want to route it
>> differently.
>
> Do you mind waiting for now, we're still debating how to fix it.

No problem. :-)

Just please let me know when you're ready.
