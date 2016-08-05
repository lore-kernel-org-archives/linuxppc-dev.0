Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Vx61XhdzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 01:25:14 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id x72so98279558pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 08:25:13 -0700 (PDT)
Date: Sat, 6 Aug 2016 01:24:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, luigi burdo <intermediadc@hotmail.com>, Darren
 Stevens <darren@stevens-zone.net>, Julian Margetson <runaway@candw.ms>,
 Steven Jeffery <sajeffer@gmail.com>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>, Pat Wall
 <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders
 <kfs1971@gmail.com>, Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX
 <mail@entwickler-x.de>, "xray@relec.ch" <xray@relec.ch>, Steve-David
 Marguet <steve@esdeem.ch>, George Sokianos <walkero@gmail.com>, Sinan
 =?UTF-8?B?R8O8cmthbg==?= <sinan.amigaone@gmail.com>, Mike
 <michael.heltne@gmail.com>, Thomas Ferreira <macsociety@me.com>, Christian
 Zigotzky <info@xenosoft.de>, "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato
 Malkenes <ben.cato@gmail.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [pasemi] Internal CompactFlash (CF) card device not recognised
 after the powerpc-4.8-1 merge
Message-ID: <20160806012454.0c9a26f9@roar.ozlabs.ibm.com>
In-Reply-To: <4168bd4c-f895-fd08-0d1a-ca4c999ab6b2@xenosoft.de>
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <4e97a4dd-3fe0-84aa-47f0-29d1544c9f8c@xenosoft.de>
 <72eed836-767c-402a-576a-8049db34d281@xenosoft.de>
 <8878883b-bd51-b7c9-ee5b-927e481e5d30@xenosoft.de>
 <8a3764d2-7fc1-1967-f557-146a3df16894@xenosoft.de>
 <1d98af3c-f585-967b-1413-58d34fad20af@xenosoft.de>
 <f6a4c3c1-f452-f4fc-1d36-b2bed81f32a3@xenosoft.de>
 <3fd5ecda-7e1f-52ec-6f11-ed603d2dcd76@xenosoft.de>
 <1470221638.12584.82.camel@kernel.crashing.org>
 <57A34254.6090702@xenosoft.de>
 <871t23k91w.fsf@concordia.ellerman.id.au>
 <ec7d4fbb-3823-c4fc-0152-4f5cd6dd9c88@xenosoft.de>
 <87r3a3cwgr.fsf@concordia.ellerman.id.au>
 <030efdf4-7b13-864e-7202-0630a604bcdc@xenosoft.de>
 <4168bd4c-f895-fd08-0d1a-ca4c999ab6b2@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Aug 2016 16:38:17 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> Hi All,


Hi Christian,

Firstly, thanks for the report. As a suggestion, it can be
better to reduce the CC list unless you have found a specific
commit that causes the problem. powerpc developers read this
list so you can send initial bug reports there.

Have you been able to bisect the exact commit which caused the
regression? If it's possible, that is the fastest way to get a
response to your report.

As for your driver support, it would indeed be a good idea to
get it supported in the upstream kernel. You should post a
new mail about that. Take a look at these 3 commits:

61f7162117d4767875825abf2f6ed1eeebbcceed
9cd55be4d22376893d2818ce3c0e5706a3d74121
ca99140a63b7326ee9a38f64c326317f2c63b594

Your patch comes from code based on the second one. The last
commit removed it, and says that it is not the best way to
implement it. You could cc this list and some of the people
involved with those commits and ask ask for advice about
getting your driver supported.

Thanks,
Nick


> I have found some information about the electra IDE CF card device: 
> http://linuxppc-dev.ozlabs.narkive.com/kxQRFqGe/patch-pasemi-electra-ide-pata-platform-glue
> 
> I checked the kernel config and the merge but without any success.
> 
> Cheers,
> 
> Christian
> 
> On 05 August 2016 at 1:41 PM, Christian Zigotzky wrote:
> > Hi All,
> >
> > The internal PASEMI CompactFlash (CF) card device doesn't work anymore 
> > after the powerpc-4.8-1 merge. That means the code for the internal CF 
> > card device in the Nemo patch doesn't work after the first PowerPC 
> > merge. The CompactFlash (CF) card slot is wired to the CPU local bus. 
> > It is typically used to hold the Linux kernel. I know it isn't well to 
> > use an own patch for that but I think it is a good time to integrate 
> > the PASEMI internal CompactFlash (CF) card device to the official 
> > kernel. What do you think? I am not a programmer so I can't integrate 
> > the source code for the internal CF card device. But maybe you can 
> > take the patch and integrate it.
> >
> > We use the following patch for the kernel 4.7:
