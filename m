Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 11DA8B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 16:58:03 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7U6pV6f021015
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 16:51:31 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7U6udB01421374
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 16:56:39 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7U6w1ZY013530
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 16:58:02 +1000
Message-ID: <4E5C89F7.4070105@in.ibm.com>
Date: Tue, 30 Aug 2011 12:27:59 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PSeries: Cancel RTAS event scan before firmware flash
References: <20110727120801.10429.7276.stgit@localhost6.localdomain6>
	<1314684237.2488.77.camel@pasglop> <4E5C806C.1070809@in.ibm.com>
	<1314685198.2488.83.camel@pasglop>
	<1314685301.2488.84.camel@pasglop>
In-Reply-To: <1314685301.2488.84.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mikey@neuling.org, "Ravi K. Nittala" <ravi.nittala@in.ibm.com>,
	sbest@us.ibm.com, antonb@au1.ibm.com, subrata.modak@in.ibm.com,
	ranittal@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	divya.vikas@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/11 11:51, Benjamin Herrenschmidt wrote:
> On Tue, 2011-08-30 at 16:19 +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2011-08-30 at 11:47 +0530, Suzuki Poulose wrote:
>>>>
>>>
>>> The flash operation is performed in the reboot path at the very end.
>>> So, even if we restart the event scan, the thread may not be able to
>>> process
>>> the events. Hence we thought we would leave it stopped.
>>>
>>> Again, we do not have much expertise in deciding which is the best
>>> thing to do.
>>> We could resume the event scan, if you think that is needed.
>>>
>>> Thanks for the review.
>>
>> No that's ok, I'll merge the patch as-is then.
>
> Actually, please dbl check you get the dependencies right. The event
> scan stuff is only compiled if CONFIG_PPC_RTAS_DAEMON is set, but the
> rtas flash code depends on a different config option that can be set
> independently.
>
> So at the very least you need an ifdef to guard the cross-call

Thanks for catching this ! Will address this in the next version.

Thanks
Suzuki
