Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0938D1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 02:49:42 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 21:19:40 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 80E0C394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 21:19:37 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2HFna8934340958
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 21:19:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2HFnau4025605
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 21:19:36 +0530
Message-ID: <55084D0C.1040309@linux.vnet.ibm.com>
Date: Tue, 17 Mar 2015 21:19:32 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC, v2] powerpc/powernv: Introduce kernel param to control
 fastsleep workaround behavior
References: <20150317085708.7102714017B@ozlabs.org>
 <1426585198.4770.23.camel@kernel.crashing.org>
In-Reply-To: <1426585198.4770.23.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 17 March 2015 03:09 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-03-17 at 19:57 +1100, Michael Ellerman wrote:
>>
>> So my first preference is that you just bite the bullet and decide to either
>> always apply the workaround, or just stick with the current behaviour. That's a
>> trade-off between (I think) better idle latency but a risk of checkstops, vs.
>> slower idle latency but less (how much less?) risk of checkstops.
>>
>> I think the reason you're proposing a kernel parameter is because we aren't
>> willing to make that decision, ie. we're saying that users should decide. Is
>> that right?
> 
> Correct. More specifically, a fairly high profile user that I will not
> name here has expressed interest in such a feature...
> 
>> I'm not a big fan of kernel parameters. They are a pain to use, and are often
>> just pushing a decision down one layer for no reason. What I mean is that
>> individual users are probably just going to accept whatever the default value
>> is from their distro.
> 
> Right. This is quite an obscure tunable.
> 
>> But anyway, that's a bit of a rant.
>>
>> As far as this patch is concerned, I don't think it actually needs to be a
>> kernel parameter.
>>
>> >From what I can see below, the decision as to whether you apply the workaround
>> or not doesn't affect the list of idle states. So this could just as well be a
>> runtime parameter, ie. a sysfs file, which can then be set by the user whenever
>> they like? They might do it in a boot script, but that's up to them.
> 
> Right, that would work too.

Okay. I'll send a patch with this design.
> 
>> For simplicity I think it would also be fine to make it a write-once parameter,
>> ie. you don't need to handle undoing it.
> 
> It would be easy enough to make it rw using stop machine I think... 
> 
>> I think the only complication that would add is that you'd need to be a little
>> careful about the order in which you nop out the calls vs applying the
>> workaround, in case some threads are idle when you're called.

Right, we should be safe with this sequence-
- NOP call to undo workaround
- Apply workaround on all cores.
- NOP call to apply workaround

> 
> I wouldn't bother with NOP'ing in that case, a runtime test will probably be noise
> in the measurement.
> 

Didn't get your point here. Do you mean, ignore the request if some
cores are in sleep or deeper state?
> Cheers,
> Ben.
> 
> 
