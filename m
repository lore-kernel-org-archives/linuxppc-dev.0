Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vJ841494zF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 10:46:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4S0hrJ7080031
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 20:46:25 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j86hxsn6v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 20:46:25 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Sun, 27 May 2018 20:46:24 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, ego@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <87fu2gqa9o.fsf@concordia.ellerman.id.au>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87fu2gqa9o.fsf@concordia.ellerman.id.au>
Date: Mon, 28 May 2018 10:46:11 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k1ror4j0.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
>
>> Init all present cpus for deep states instead of "all possible" cpus.
>> Init fails if the possible cpu is gaurded. Resulting in making only
>> non-deep states available for cpuidle/hotplug.
>
> This is basically the opposite of what we just did for IMC.
>
> There we switched from present to possible, to make it work when some
> CPUs are guarded.
>
> Which makes me think we need a better way of dealing with guarded CPUs,
> because working out which code should use present or possible seems to
> be basically trial-and-error.
>
> I'm not actually sure why Guarded CPUs are showing up as possible but
> not present, did we do that on purpose or is it just happening by
> accident?

My guess is that it flows through from firmware putting the guarded out
CPUs in the device tree with a not "okay" status (which, I just
realised, we're putting something in 'status' that isn't what the
current DeviceTree spec says we should... gah -
https://github.com/open-power/skiboot/issues/178 filed for that one).

The idea behind that is that you can answer "where did all my CPUs go?"
by looking at the device tree rather than having to know the platform
specific way of how guards are stored.

-- 
Stewart Smith
OPAL Architect, IBM.
