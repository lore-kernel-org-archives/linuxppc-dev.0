Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rN2pM2ZFtzDq7v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 02:09:28 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>, rtd@a-eon.com,
 rtd2@xtra.co.nz, pjwall@mac.com, pjwall@me.com, matthew@a-eon.biz,
 intermediadc@hotmail.com, contact@a-eon.com, info@xenosoft.de
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
 <871t4dui4g.fsf@skywalker.in.ibm.com>
 <2bf8f412-2631-75b4-70a3-cb5ecee5cf48@xenosoft.de>
 <2FB13B5B-42F0-4396-AD29-70924D2710CC@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <053dd416-a9ab-5b06-5c3b-1acefb53fd3b@xenosoft.de>
Date: Sun, 5 Jun 2016 18:09:05 +0200
MIME-Version: 1.0
In-Reply-To: <2FB13B5B-42F0-4396-AD29-70924D2710CC@xenosoft.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I need an answer because I think Darren's guess is correct. It isn't a 
problem in the pci code. I replaced the file head_64.S that Darren 
mentioned with the one from the kernel 4.6 and it compiled but 
unfortunately it doesn't boot. We know "head_64.S" is one file for the 
early boot phase but I think there are some other files.

I am not a fan of reverting the PowerPC commits but there are some other 
new things in the new kernel e.g. DRM 2.45.0 which are very interesting 
for the Nemo board.

@Julian

What about the issues with the Sam460ex? Have you solved the problem 
with the commit powerpc-4.7-1?

Cheers,

Christian

On 04 June 2016 at 5:25 PM, Christian Zigotzky wrote:
> Which files are responsible for the early boot phase in the commit powerpc-4.7-1? Perhaps the problem is there.
>
> - Christian
>
> Sent from my iPhone
>

On 28 May 2016 at 8:51 PM, Darren Stevens wrote:
> Hello Adrian
>
> On 28/05/2016, Adrian Cox wrote:
>>> From: Christian Zigotzky [mailto:chzigotzky@xenosoft.de]
>>> Sent: 28 May 2016 07:06
>>> Adrian, what is the expected WIMG bit mapping for the Nemo board?
>>>
>> I'm not able to help much here, I'm afraid. I don't have a Nemo board at
>> the moment, and it's been a few years. From memory all the peripherals
>> required standard uncached and guarded mappings on Nemo.
> Before everybody gets too involved, from what I've seen with my tests today
> the kernel is crashing long before it gets to the pci-common code.
>
> I've attached 2 boot logs, one from a 4.4 kernel I've been working on, and
> from a build of the latest git.
>
> You can see from this that the 4.7 kernel hangs right after the booting linux
> via __start(), whereas in the 4.4 there's about 29 lines of output before it
> gets to the Initialised io_base_virt printk in our patch.
>
> The last time we had a hang this early in the boot it turned out to be a
> problem in head_64.S, I think there is something else wrong in the commit
> Christian has identified
>
> I will see if this is something I can fix, but it may need better low level
> knowledge of PPC hardware than I have.
>
> Regards
> Darren
