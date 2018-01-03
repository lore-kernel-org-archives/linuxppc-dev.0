Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBW1Z1QLTzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 23:48:01 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id w75so781182vkd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 04:48:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3110289.BbUpyYVBQa@aspire.rjw.lan>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
 <20171218083820.GA28881@in.ibm.com> <3110289.BbUpyYVBQa@aspire.rjw.lan>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 3 Jan 2018 23:47:58 +1100
Message-ID: <CAKTCnznuf1jwWZEqi+og8LyayfzMwGYRUXhK4+zfbSYDfexyRA@mail.gmail.com>
Subject: Re: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle
 non-continguous pstates
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Abhishek <huntbag@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Wed, Jan 3, 2018 at 11:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, December 18, 2017 9:38:20 AM CET Gautham R Shenoy wrote:
>> Hi Balbir,
>>
>> On Sun, Dec 17, 2017 at 02:15:25PM +1100, Balbir Singh wrote:
>> > On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
>> > <ego@linux.vnet.ibm.com> wrote:
>> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > >
>> > > The code in powernv-cpufreq, makes the following two assumptions which
>> > > are not guaranteed by the device-tree bindings:
>> > >
>> > >     1) Pstate ids are continguous: This is used in pstate_to_idx() to
>> > >        obtain the reverse map from a pstate to it's corresponding
>> > >        entry into the cpufreq frequency table.
>> > >
>> > >     2) Every Pstate should always lie between the max and the min
>> > >        pstates that are explicitly reported in the device tree: This
>> > >        is used to determine whether a pstate reported by the PMSR is
>> > >        out of bounds.
>> > >
>> > > Both these assumptions are unwarranted and can change on future
>> > > platforms.
>> >
>> > While this is a good thing, I wonder if it is worth the complexity. Pstates
>> > are contiguous because they define transitions in incremental value
>> > of change in frequency and I can't see how this can be broken in the
>> > future?
>>
>> In the future, we can have the OPAL firmware give us a smaller set of
>> pstates instead of expose every one of them. As it stands today, for
>> most of the workloads, we will need at best 20-30 pstates and not
>> beyond that.
>
> I'm not sure about the status here.
>
> Is this good to go as is or is it going to be updated?
>

I have no major objections, except some of the added complexity, but
Gautham makes a point that this is refactoring for the future

Balbir Singh.
