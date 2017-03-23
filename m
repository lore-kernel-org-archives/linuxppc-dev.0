Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpdYX6XJWzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 18:32:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2N7SoAo042166
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 03:32:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29bv3hvwxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 03:32:25 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 03:32:24 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH][OPAL] cpufeatures: add base and POWER8,
 POWER9 /cpus/features dt
In-Reply-To: <20170321152745.4a3e1f36@roar.ozlabs.ibm.com>
References: <20170307111326.28129-1-npiggin@gmail.com>
 <20170307111326.28129-2-npiggin@gmail.com>
 <87a88fw89d.fsf@linux.vnet.ibm.com>
 <20170321152745.4a3e1f36@roar.ozlabs.ibm.com>
Date: Thu, 23 Mar 2017 18:32:15 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tnwtpmo.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Tue, 21 Mar 2017 15:42:22 +1100
> Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > With this patch and the Linux one, I can boot (in mambo) a POWER8 or
>> > POWER9 without looking up any cpu tables, and mainly looking at PVR
>> > for MCE and PMU.  
>> 
>> That's pretty neat. I now await the day where somebody produces a chip
>> with uneven feature sets between cores.
>> 
>> > Machine and ISA speicfic features that are not abstracted by firmware
>> > and not captured here will have to be handled on a case by case basis,
>> > using PVR if necessary. Major ones that remain are PMU and machine
>> > check.  
>> 
>> At least for machine check we could probably get something "good enough"
>> without too much effort.
>
> Machine check I'd like to put it in opal with a special case entry from
> the hypervisor. At the moment it just has a lot of implementation specific
> decoding of bits, and we can't really call opal to do anything useful
> with normal call because it re-enters the stack.

Ahh yep. Something along the lines of a machine check specific stack in
OPAL could do it, and we queue up calls etc etc.

It turns out my "not too much effort" metric is possibly different from
other people's :)

>> For PMU, I wonder if we could get something that's suitably common with
>> the IMC work being done so that we could "just work" on new PMUs (albeit
>> calling into OPAL for enable/disable)
>
> I don't know the PMU code, but if we could have some kind of firmware
> fallback like that it would be perfect.
>
> For machine specific implementations that are faster or more capable,
> I guess looking at PVR is not taboo as such. Just that it shouldn't
> be needed to boot and get some reasonable baseline.

Yeah, I'm not that familiar with it either. I need to go look over it
all in my copious amount of free time.

>> > Open question is where and how to develop and document these features?
>> > Not the dt representation created by skiboot, but the exact nature of
>> > each feature. What exact behaviour does a particular feature imply,
>> > etc.  
>> 
>> Part of me seems to think this could be something for the Architecture,
>> and then we just have a 1-to-1 mapping of the arch bits and we're all
>> one big happy family....
>> 
>> Benh/Paulus can probably laugh at me suitably hard for suggesting such a
>> thing being possible though :)
>
> I think to a degree we might be moving in that direction. Probably
> can't say much more in public at the moment, but at least this dt
> implementation must be flexible enough to cope with a range of
> approaches we might decide to take (fine/coarse grained, fscr bits
> or not, etc).

Yeah, I think so too.

>> > --- a/hdata/cpu-common.c
>> > +++ b/hdata/cpu-common.c  
>> 
>> > +	{ "vector-crypto",
>> > +	CPU_ALL,
>> > +	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
>> > +	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
>> > +	-1, -1, 38,
>> > +	"vector", },  
>> 
>> Did we want to break this down at all? Specifically maybe just the AES
>> instructions?
>> 
>> AFAIK it's been the only set where there was some amount of discussion
>> about somebody possibly not wanting to include.
>
> I don't have much opinion on it. Userspace has only the one feature bit
> there, so missing part of the instructions would have to disable the
> entire thing.
>
> That's not to say we couldn't add another bit and start getting userspace
> to use it. So if there is some need or strong potential future need,
> we should consider it.

Hopefully we're right on ISA3.00 for new instructions that random folk
may say could be disabled if they fab'd their own chip :)

-- 
Stewart Smith
OPAL Architect, IBM.
