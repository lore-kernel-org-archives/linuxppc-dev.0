Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMNwJ0GwkzDq80
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 00:42:23 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 Jun 2016 08:42:21 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
In-Reply-To: <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
Date: Sat, 04 Jun 2016 20:12:15 +0530
Message-ID: <874m99uibc.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Aneesh,
>
> Could you please send me only your patch for the Power ISA 3.0 (Power9) 
> Radix Tree MMU? You have done the most modifications for the kernel 4.7. 
> If the kernel boots with your modifications then I have to look to the 
> other few modifications.
>
> Thanks in advance,
>

Are you looking for changes too kernel that will add ISA 3.0 MMU model
without making changes to other part of kernel ?. I don't think we ever
had a kernel patch which did the ISA 3.0 work like that. In order to add
the new ISA support we did have to make changes to other part of the
kernel.

To debug your boot issue, I still haven't understood why the suggested
changes are not working. Because for a  non cache guarded page the
mapping didn't change at all. Hence I was asking for what the expected
WIMG values are for your board.

One other option is to bisect test the kernel and if you can isolate
which patch is breaking the boot, we can possibly understand it better.
ie, instead of reverting the entire merge, try a git bisect.

-aneesh
