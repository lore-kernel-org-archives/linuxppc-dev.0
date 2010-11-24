Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id D227BB6ED0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2010 05:03:04 +1100 (EST)
Received: by ywe9 with SMTP id 9so8538ywe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2010 10:03:02 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4CED48CE.5060300@caviumnetworks.com>
References: <1290607413.12457.44.camel@concordia>
	<fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
	<4CED48CE.5060300@caviumnetworks.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Nov 2010 11:02:41 -0700
Message-ID: <AANLkTim+cmxtkw28aeW6ZrspTaiad+w_FHKTys7_NEfR@mail.gmail.com>
Subject: Re: Mega rename of device tree routines from of_*() to dt_*()
To: David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 24, 2010 at 10:18 AM, David Daney <ddaney@caviumnetworks.com> w=
rote:
> On 11/24/2010 09:02 AM, Stephen Neuendorffer wrote:
>>
>>
>>> -----Original Message-----
>>> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
>>> [mailto:linuxppc-dev-
>>> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Mich=
ael
>>> Ellerman
>>> Sent: Wednesday, November 24, 2010 6:04 AM
>>> To: LKML
>>> Cc: linux-mips; microblaze-uclinux@itee.uq.edu.au;
>>> devicetree-discuss@lists.ozlabs.org; linuxppc-dev
>>> list; sparclinux@vger.kernel.org
>>> Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
>>>
>>> Hi all,
>>>
>>> There were some murmurings on IRC last week about renaming the of_*()
>>> routines. I was procrastinating at the time and said I'd have a look at
>>> it, so here I am.
>>>
>>> The thinking is that on many platforms that use the of_() routines
>>> OpenFirmware is not involved at all, this is true even on many powerpc
>>> platforms. Also for folks who don't know the OpenFirmware connection it
>>> reads as "of", as in "a can of worms".
>>>
>>> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
>>> it would be nice to get rid of, but it's a lot of churn.
>>>
>>> So I'm hoping people with either say "YES this is a great idea", or "NO
>>> this is stupid".
>>
>> Personally, I think it's a great idea, if only because I stared long and
>> hard
>> at the code once upon a time trying to figure out what is really
>> OF-related
>> and what isn't. =A0It's somewhat clearer now that drivers/of has been
>> factored
>> out (although, shouldn't it be drivers/dt???)

Yes, the directory name should change, as should the CONFIG_OF* defines.

>>
>> That said, it *is* alot of code churn. =A0If it's going to be done, I th=
ink
>> it should be
>> done in concert with fixing a bunch of the function names which don't
>> really follow any
>> sane naming convention, so that the backporting discontinuity only happe=
ns
>> once.
>>
>
> Oh, you mean things like:
>
> of_{,un}register_platform_driver vs. platform_driver_{,un}register
>
> That one is particularly annoying to me.

Ignore that one.  of_{,un}platform_driver is deprecated and users will
all be converted to platform_drivers.

g.
