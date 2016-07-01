Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rh23X6SwkzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 02:31:17 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: Olof Johansson <olof@lixom.net>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Pat Wall <pjwall@mac.com>,
 Alex Perez <aperez@alexperez.com>, matthew@a-eon.com,
 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 R.T.Dickinson <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Fri, 01 Jul 2016 16:29:43 +0100 (BST)
Message-ID: <486a5b4c86b.69ed7e66@auth.smtp.1and1.co.uk>
In-Reply-To: <CAOesGMgvNY8YBeyT3uMfD5XyQbhv0ucFtC8EVHS7gwrTmTNzGw@mail.gmail.com>
References: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
 <CAOesGMgvNY8YBeyT3uMfD5XyQbhv0ucFtC8EVHS7gwrTmTNzGw@mail.gmail.com>
Subject: Re: pasemi: Fix boot failure on 4.7-rc1
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

Hello Olof

On 29/06/2016, Olof Johansson wrote:
> I don't see the panic here on a Chitra, at least not on recent -next.
>
> What config are you building with when you see this?

If you are not seeing this on the Chitra, it means that our Nemo patch
is causing the problem. I don't know where, as we haven't patched the
pas_pci_init function, or any function it directly calls,
although there are patches in pasemi/pci.c to enable support for the 
SB600.

The best solution would be for us to add the patch for setup.c I found to
our nemo patch.

Sorry for wasting everyones time.

> Please cc me on PA Semi related patches if you want my attention. I
> still have hardware, in fact I boot every -next release on it through
> automation.

Didn't know that, I will do so in future, just be aware that all of my
patches will be in relation to the X1000 as that is the only PA-Semi machine
I have here.

If you have the time, there is something you can check for us - we've had to
add 'PPC_PASEMI_IOMMU_DMA_FORCE' to our config since 4.4 to get the onboard
gig-e ethernet to work. We need PPC_PASEMI_IOMMU for the SB600, or we are
stuck with a kernel that will only work with 2GRam

Regards
Darren
