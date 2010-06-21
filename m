Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 9E527B6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 07:06:22 +1000 (EST)
Received: by gyf2 with SMTP id 2so2627868gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 14:06:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTiltEWJQa5FL0Pjpd8JeQdo-ECBSM5EJHruIAJK0@mail.gmail.com>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141008.25879.2050.stgit@angua>
	<1276152212.1962.59.camel@pasglop>
	<AANLkTiltEWJQa5FL0Pjpd8JeQdo-ECBSM5EJHruIAJK0@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Jun 2010 15:06:00 -0600
Message-ID: <AANLkTin5sMa-imgNeY4kM8wofnxUyQOtOT-gLILL7rlj@mail.gmail.com>
Subject: Re: [PATCH 3/5] of/address: Merge all of the bus translation code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 8:26 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Thu, Jun 10, 2010 at 12:43 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
>>> Microblaze and PowerPC share a large chunk of code for translating
>>> OF device tree data into usable addresses. =A0There aren't many differe=
nces
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^^^
>> Care to comment on these differences ?
>
> Purely cosmetic IIRC, but I will go back and double check. =A0Things
> like printk vs. pr_info and some style differences. =A0I looked at them
> side-by-side and fixed each difference individually until they were
> identical.
>
>>> between the two, so merge the codebase wholesale rather than trying to
>>> work out the independent bits.
>>
>> Well, I don't see ifdef's in the resulting code (but I'm a bit blind),
>> so what did you do with the differences ?
>>
>> This is complex and fragile code, so any change to it must be very
>> carefully scrutinized.

Hi Ben,

I've double checked side-by-side.  The changes are all cosmetic expect
for the addition of dma-ranges support on the powerpc version that
hadn't been applied to microblaze.  This patch takes the powerpc code
plus the cosmetic changes (spaces, pr_debug vs DBG, etc) from the
microblaze side.  There should be no functional changes to either
platform since microblaze doesn't currently use dma-ranges anyway.

Here's the new commit text:

----
    of/address: Merge all of the bus translation code

    Microblaze and PowerPC share a large chunk of code for translating
    OF device tree data into usable addresses.  Differences between the two
    consist of cosmetic differences, and the addition of dma-ranges support
    to powerpc but not microblaze.  This patch moves the powerpc
    version into common code and applies many of the cosmetic (non-function=
al)
    changes from the microblaze version.
----

I've only changed the commit text.  The patch remains unchanged.  Are
you okay with this patch?

Cheers,
g.


>>
>> Cheers,
>> Ben.
>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> CC: Michal Simek <monstr@monstr.eu>
>>> CC: Wolfram Sang <w.sang@pengutronix.de>
>>> CC: Stephen Rothwell <sfr@canb.auug.org.au>
>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> CC: microblaze-uclinux@itee.uq.edu.au
>>> CC: linuxppc-dev@ozlabs.org
