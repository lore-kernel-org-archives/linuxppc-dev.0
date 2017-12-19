Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x232.google.com (mail-ua0-x232.google.com
 [IPv6:2607:f8b0:400c:c08::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1DTw1nPXzDsSf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:21:55 +1100 (AEDT)
Received: by mail-ua0-x232.google.com with SMTP id g4so5258525ual.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171219092037.GA27991@in.ibm.com>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
 <20171214044239.GU3322@vireshk-i7>
 <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
 <20171218082935.GH19815@vireshk-i7> <20171219092037.GA27991@in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 19 Dec 2017 21:21:52 +1100
Message-ID: <CAKTCnz=Wq_qgG0=cxHuCibFZxLM7uPv0iULGBO5AkUGZgHLXkg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Abhishek <huntbag@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2017 at 8:20 PM, Gautham R Shenoy
<ego@linux.vnet.ibm.com> wrote:
> Hi Viresh,
> On Mon, Dec 18, 2017 at 01:59:35PM +0530, Viresh Kumar wrote:
>> On 18-12-17, 10:41, Abhishek wrote:
>> > We need to do it in this way as the current implementation takes the max of
>> > the PMSR of the cores. Thus, when the frequency is required to be ramped up,
>> > it suffices to write to just the local PMSR, but when the frequency is to be
>> > ramped down, if we don't send the IPI it breaks the compatibility with P8.
>>
>> Looks strange really that you have to program this differently for speeding up
>> or down. These CPUs are part of one cpufreq policy and so I would normally
>> expect changes to any CPU should reflect for other CPUs as well.
>>
>> @Goutham: Do you know why it is so ?
>>
>
> These are due to some implementation quirks where the platform has
> provided a PMCR per-core to be backward compatible with POWER8, but
> controls the frequency at a quad-level, by taking the maximum of the
> four PMCR values instead of the latest one. So, changes to any CPU in
> the core will reflect on all the cores if the frequency is higher than
> the current frequency, but not necessarily if the requested frequency
> is lower than the current frequency.
>
> Without sending the extra IPIs, we will be breaking the ABI since if
> we set userspace governor, and change the frequency of a core by
> lowering it, then it will not reflect on the CPUs of the cores in the
> quad.


What about cpufreq_policy->cpus/related_cpus? Am I missing something?

>
> Abhishek,
> I think we can rework this by sending the extra IPIs only in the
> presence of the quirk which can be indicated through a device-tree
> parameter. If the future implementation fix this, then we won't need
> the extra IPIs.

Balbir Singh.
