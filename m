Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSM9r0FmhzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:42:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LDXcMn075062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:42:06 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r120ud3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:42:05 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 10:42:03 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id CE8521DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:42:01 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LDfqT232374890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:42:00 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LDfSjo027931
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:41:29 -0300
Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87poicm8cw.fsf@concordia.ellerman.id.au>
Cc: paulus@samba.org, npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 10:41:03 -0300
MIME-Version: 1.0
In-Reply-To: <87poicm8cw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6d952aa0-fb14-adf0-de3f-16770a50dd6f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2017 02:16 AM, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>> Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus minor fixes
> 
> In future please use the same version number for all patches of a
> series.
> 
> ie. This should include a v2, like the rest of the patches in the series.
> 
> It confuses the tools to have "v2 1/3" "2/3" "v2 3/3".
> 
> I realise that might seem a little odd when a patch is new to the
> series, but the version is the version *of the series*, not the
> individual patches.
> 
> For a new patch you can just add after the change log:
> 
> ---
> v2: New for v2 of the series.
> 
> 
> For example.

Sure, thanks for the hint and for explain very well how I should
proceed! Unfortunately...as you probably already noticed, I'm only
seeing this after sent the v2 of the series heheh
Sorry, next time I'll follow your suggestion (TBH I thought of it before
sending this, but I got more inclined in mess with the series numbering
heheh)

> 
>> The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
>> ("[POWERPC] print backtrace when entering xmon"). The problem that time
>> was that during a crash in a machine with USB keyboard, xmon wouldn't
>> respond to commands from the keyboard, so printing the backtrace wouldn't
>> be possible.
>>
>> Idea then was to show automatically the backtrace on xmon crash for the
>> first time it's invoked (if it recovers, next time xmon won't show
>> backtrace automatically). The nobt parameter was added _only_ to prevent
>> this automatic trace show. Seems long time ago USB keyboards didn't work
>> that well!
>>
>> We don't need it anymore, but the feature of auto showing the backtrace
>> on first crash seems interesting (imagine a case of auto-reboot script),
>> so this patch keeps the functionality, yet removes the nobt parameter.
> 
> 
> I'm going to take this as-is, because I want to get it in for v4.11.
> 
> But I don't think we need the auto back trace logic at all. If anything
> it's an anti-feature IMHO.
> 
> Imagine you're debugging a machine and you drop into xmon to check
> something, then drop out again.
> 
> Then you go away and leave the box, and it crashes into xmon, but xmon
> doesn't print a backtrace because you've already been in xmon. Usually
> you can just get on the console and hit 't', but sometimes the machine
> crashes so hard that xmon doesn't take input - in which case you now
> have no backtrace. :sadface:
> 
> So I'll send a follow-up patch to remove the auto backtrace stuff
> completely and see if anyone objects.
> 

OK, guess you noticed in your next message I kept the trace
behavior...let's discuss there =)

Cheers,


Guilherme
> cheers
> 
