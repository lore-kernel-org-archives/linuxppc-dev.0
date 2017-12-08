Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytVvv1b3fzF06T
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 22:47:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Stable <stable@vger.kernel.org>
Subject: Re: [v2 PATCH] cpufreq: powernv: Correctly parse the sign of pstates
 on POWER8 vs POWER9
In-Reply-To: <CAJZ5v0jzh1B_8FYciWhpJZVPZNzm3n30NEE25LO_YJ17Wi+h+w@mail.gmail.com>
References: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAJZ5v0jzh1B_8FYciWhpJZVPZNzm3n30NEE25LO_YJ17Wi+h+w@mail.gmail.com>
Date: Fri, 08 Dec 2017 22:47:38 +1100
Message-ID: <87indhh25h.fsf@concordia.ellerman.id.au>
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

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Dec 7, 2017 at 6:59 AM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
>> negatively numbered while on POWER9 they are positively
>> numbered. Thus, on POWER9, the maximum number of pstates could be as
>> high as 256.
>>
>> The current code interprets pstates as a signed 8-bit value. This
>> causes a problem on POWER9 platforms which have more than 128 pstates.
>> On such systems, on a CPU that is in a lower pstate whose number is
>> greater than 128, querying the current pstate returns a "pstate X is
>> out of bound" error message and the current pstate is reported as the
>> nominal pstate.
>>
>> This patch fixes the aforementioned issue by correctly differentiating
>> the sign whenever a pstate value read, depending on whether the
>> pstates are positively numbered or negatively numbered.
>>
>> Fixes: commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
>> Cc: <stable@vger.kernel.org> #v4.8
>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Tested-and-reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> I'm going to apply this, or please let me know if you want to route it
> differently.

Do you mind waiting for now, we're still debating how to fix it.

cheers
