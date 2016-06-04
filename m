Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMPbk6pH8zDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 01:13:06 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
Date: Sat, 4 Jun 2016 17:07:02 +0200
MIME-Version: 1.0
In-Reply-To: <874m99uibc.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh,

Shall I bisect the kernel from the powerpc git?

git clone 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/powerpc/linux

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/

Shall I start with the following commit?

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=8ffb4103f5e28d7e7890ed4774d8e009f253f56e

Thanks,

Christian

On 04 June 2016 at 4:42 PM, Aneesh Kumar K.V wrote:
>
> Are you looking for changes too kernel that will add ISA 3.0 MMU model
> without making changes to other part of kernel ?. I don't think we ever
> had a kernel patch which did the ISA 3.0 work like that. In order to add
> the new ISA support we did have to make changes to other part of the
> kernel.
>
> To debug your boot issue, I still haven't understood why the suggested
> changes are not working. Because for a  non cache guarded page the
> mapping didn't change at all. Hence I was asking for what the expected
> WIMG values are for your board.
>
> One other option is to bisect test the kernel and if you can isolate
> which patch is breaking the boot, we can possibly understand it better.
> ie, instead of reverting the entire merge, try a git bisect.
>
> -aneesh
>
>
