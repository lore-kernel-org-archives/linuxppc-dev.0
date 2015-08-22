Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B46781A027F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 14:10:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Sat, 22 Aug 2015 09:40:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 55075E005C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 09:39:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7M49xmd61079584
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 09:39:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7M49x1w022933
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 09:39:59 +0530
Message-ID: <55D7F616.1060308@linux.vnet.ibm.com>
Date: Sat, 22 Aug 2015 09:39:58 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: linux-next: build failure after merge of the powerpc tree
References: <20150821182535.4423868e@canb.auug.org.au>
 <55D6E86E.105@linux.vnet.ibm.com> <1440200403.13795.1.camel@ellerman.id.au>
In-Reply-To: <1440200403.13795.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2015 05:10 AM, Michael Ellerman wrote:
> On Fri, 2015-08-21 at 14:29 +0530, Vasant Hegde wrote:
>> On 08/21/2015 01:55 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the nvdimm tree, today's linux-next build (powerpc
>>> allyesconfig) failed like this:
>>
>> Stephen,
>>
>> Thanks for reporting! I checked powerpc tree.. This is because of commit
>> 8a8d9181 in powerpc tree.. Basically Michael missed one hunk (below hunk in
>> opal-api.h)
> 
> Hmm, looks like it.
> 
> I do remember the patch didn't apply to my tree, so I guess I accidentally
> dropped a hunk when I was forcing it to apply.

Hmmm yeah..My patchset was based on pstream tree (4.2-rc7) instead of powerpc
next tree.


> 
> I also should have looked closer, as the following aren't in the skiboot
> version of opal-api.h. The skiboot and Linux versions of opal-api.h should be
> in sync as much as possible.
> 

As I mentioned in other thread I should have added all these macros to
opal-api.h in skiboot..


>> +/* LED Mode */
>> +#define POWERNV_LED_MODE_LIGHT_PATH    "lightpath"
>> +#define POWERNV_LED_MODE_GUIDING_LIGHT "guidinglight"
>> +
>> +/* LED type */
>> +#define POWERNV_LED_TYPE_IDENTIFY      "identify"
>> +#define POWERNV_LED_TYPE_FAULT         "fault"
>> +#define POWERNV_LED_TYPE_ATTENTION     "attention"
> 
> Furthermore, I don't see the first two used at all, and the bottom three are
> only used in one place in the driver. So I've just sucked the values into the
> driver code and dropped the #defines. Patch coming shortly.
> 
> Also we're obviously not building this in any of our defconfigs. Can you please
> send a patch to enable it for pseries_defconfig and ppc64_defconfig.

Sure.. Will send separate patch.

-Vasant
