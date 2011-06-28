Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CE3AB6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 21:48:18 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SBZBq0008178
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 05:35:11 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5SBm6pC196532
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 05:48:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5S5m4F3012833
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2011 23:48:05 -0600
Date: Tue, 28 Jun 2011 07:48:10 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc,	460gt: Add 460gt as compatible in the check
	for 460ex-compatible	crypto
Message-ID: <20110628114810.GA10237@zod.rchland.ibm.com>
References: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
	<14e6cd940efae1704f5908757f81f627@kernel.crashing.org>
	<BANLkTikKNqEoQxGA642h14eOUjZ3hGZaQw@mail.gmail.com>
	<BANLkTinisHPrEN8Xc_KoqFwxknMooE=H4w@mail.gmail.com>
	<f3bf96d99dfc13e2ebc07d6ce2282f2e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <f3bf96d99dfc13e2ebc07d6ce2282f2e@kernel.crashing.org>
Cc: Mike Williams <mikebwilliams@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 24, 2011 at 04:14:07AM +0200, Segher Boessenkool wrote:
>>>>-       if (of_find_compatible_node(NULL, NULL,
>>>>"amcc,ppc460ex-crypto")) {
>>>>+       if (of_find_compatible_node(NULL, NULL,
>>>>"amcc,ppc460ex-crypto") ||
>>>>+           of_find_compatible_node(NULL, NULL,
>>>>"amcc,ppc460gt-crypto")) {
>>>
>>>If the device is actually compatible, the device tree node should
>>>claim
>>>it is, and you do not need this code change.
>>
>>That was actually my first instinct, however I tried to follow the
>>current convention in the glacier and canyonlands DTS files, which is
>>to set every device compatible to 460gt or 460ex, depending on the
>>processor. Many of the devices are identical between the two, since
>>they are variations of the same SoC, so which is the preferred method?
>>Follow the device tree convention and add the compatibility check in
>>the driver,
>
>That is not the convention.
>
>>or alter the device trees? I'll send another patch if it's
>>the latter.
>
>You say
>
>  compatible = "amcc,ppc460gt-crypto", "amcc,ppc460ex-crypto";

I went ahead and modified the addition of the node to the glacier DTS
file to do this instead.  I think this specific patch can be dropped.

josh
