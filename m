Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5hjT4X6WzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 08:45:49 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: Nicholas Piggin <npiggin@gmail.com>
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, Pat Wall <pjwall@me.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>,
 Christian Zigotzky <info@xenosoft.de>,
 "contact@a-eon.com" <contact@a-eon.com>, R.T.Dickinson <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Olof Johansson <olof@lixom.net>,
 Julian Margetson <runaway@candw.ms>, R.T.Dickinson <rtd@a-eon.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Aug 2016 22:42:59 +0100 (BST)
Message-ID: <4898d738ba6.9f2ad89@auth.smtp.1and1.co.uk>
In-Reply-To: <20160806012454.0c9a26f9@roar.ozlabs.ibm.com>
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
 <57A34254.6090702@xenosoft.de> <871t23k91w.fsf@concordia.ellerman.id.au>
 <ec7d4fbb-3823-c4fc-0152-4f5cd6dd9c88@xenosoft.de>
 <87r3a3cwgr.fsf@concordia.ellerman.id.au>
 <030efdf4-7b13-864e-7202-0630a604bcdc@xenosoft.de>
 <4168bd4c-f895-fd08-0d1a-ca4c999ab6b2@xenosoft.de>
 <20160806012454.0c9a26f9@roar.ozlabs.ibm.com>
Subject: Re: Internal CompactFlash (CF) card device not recognised after
 the powerpc-4.8-1 merge
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

Hello Nicholas

On 06/08/2016, Nicholas Piggin wrote:
> On Fri, 5 Aug 2016 16:38:17 +0200
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>
>> Hi All,
>
>
> Hi Christian,
[...]
> As for your driver support, it would indeed be a good idea to
> get it supported in the upstream kernel. You should post a
> new mail about that. Take a look at these 3 commits:
>
> 61f7162117d4767875825abf2f6ed1eeebbcceed
> 9cd55be4d22376893d2818ce3c0e5706a3d74121
> ca99140a63b7326ee9a38f64c326317f2c63b594
>
> Your patch comes from code based on the second one. The last
> commit removed it, and says that it is not the best way to
> implement it. You could cc this list and some of the people
> involved with those commits and ask ask for advice about
> getting your driver supported.

Actually, it's almost supported by the base PASemi code anyway, there is a
PCMCIA driver in setup.c, but our hardware has been changed enough to make it
hang the system when used. I should probably take another look and see If I
can fix that. The other option would be to move the above patch to where we
add our rtc platform device. One thing that does confuse me is the interrupt,
it's attached to GPIO 0, so should be on the mpic int 0 (or maybe 16?)but I
could never get it to work.

Regards
Darren
