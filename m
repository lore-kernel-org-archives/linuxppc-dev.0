Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FEC22C00BA
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 22:45:37 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id uy5so2310828obc.20
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 04:45:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321110445.GB2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
Date: Fri, 21 Mar 2014 17:15:34 +0530
Message-ID: <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 March 2014 16:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Heh! Well, that wasn't the reason why this was sent out as a separate
> patch, but never mind. Though I don't understand why it would be
> difficult to review the patch though.

Because the initial driver wasn't complete earlier. There were 2-3 patches
after the first one which are changing what the first patch has added.
Nothing else :)

>> > +static void powernv_read_cpu_freq(void *ret_freq)
>> > +{
>> > +       unsigned long pmspr_val;
>> > +       s8 local_pstate_id;
>> > +       int *cur_freq, freq, pstate_id;
>> > +
>> > +       cur_freq = (int *)ret_freq;
>>
>> You don't need cur_freq variable at all..
>
> I don't like it either. But the compiler complains without this hack
> :-(

Why would the compiler warn for doing this?:

*(int *)ret_freq = freq;

>> > +       pmspr_val = get_pmspr(SPRN_PMSR);
>> > +
>> > +       /* The local pstate id corresponds bits 48..55 in the PMSR.
>> > +         * Note: Watch out for the sign! */
>> > +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
>> > +       pstate_id = local_pstate_id;
>>
>> similarly local_pstate_id
>
> well, I am interested in the bits 48..55 of pmspr_val. That's the
> pstate_id which can be negative. So I'll like to keep
> local_pstate_id.

Can you please explain at bit level how getting the value in a s8
first and then into a s32 will help you here? Instead of getting it
directly into s32.
