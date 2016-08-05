Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Ljz2W8MzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 19:15:02 +1000 (AEST)
Subject: [pasemi] Radeon HD graphics card not recognised after the
 powerpc-4.8-1 commit
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 luigi burdo <intermediadc@hotmail.com>,
 Darren Stevens <darren@stevens-zone.net>, Julian Margetson
 <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <816DC2B4-5B33-4C5E-A09A-F5BF7C7BF1FD@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ec7d4fbb-3823-c4fc-0152-4f5cd6dd9c88@xenosoft.de>
Date: Fri, 5 Aug 2016 11:13:43 +0200
MIME-Version: 1.0
In-Reply-To: <871t23k91w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks a million for your patch! :-)

@All
Keep your fingers crossed!

1. git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a

2. patch -p0 < powerpc-pci-Only-do-fixed-PHB-numbering-on-powernv.patch

3. patch -p0 < nemo_4.8-3.patch

4. yes "" | make oldconfig

5. I activated the following new BTRFS options for Srtest:

CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y

6. make vmlinux

...

Cheers,

Christian

On 05 August 2016 at 08:46 AM, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
>> Hi All,
>>
>> I figured out that the Git kernel (4.8) successfully detected my Radeon
>> HD6870 but Xorg can't access it.
>>
>> The reason is, that the BusID has changed between the kernel 4.7 and 4.8.
> This should fix it?
>
>    https://patchwork.ozlabs.org/patch/656042/
>
> mpe breaks pasemi again :{
>
> cheers
>
