Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DBC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:45:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC15214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eVeVBHNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC15214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431BJs1f46zDqNq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:45:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eVeVBHNi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=nam02-cy1-obe.outbound.protection.outlook.com
 (client-ip=40.107.76.84; helo=nam02-cy1-obe.outbound.protection.outlook.com;
 envelope-from=felix.kuehling@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amdcloud.onmicrosoft.com
 header.i=@amdcloud.onmicrosoft.com header.b="eVeVBHNi"; 
 dkim-atps=neutral
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4319MJ1f6TzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 07:02:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMTeHKatjxWVQeQH88VxdIMUFcpRAvypf5ZdYxH/DUM=;
 b=eVeVBHNiMAx5s67QErx5c2IIA3276op5wykcE1xJN13KkQ3+FdI48lRy/HNCha3J6SKGHBQOGqkifVfX/SQHL7L6pr5wBzqHU2xFveChwlvD2ADmH6OfbkCtjAkGpYppnj9rioVxyknShL2nbfnIDWwHBYXiSvUpSWNC8bzLRck=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1803.namprd12.prod.outlook.com (10.175.91.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 20:01:45 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::c839:4c0f:105b:b038]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::c839:4c0f:105b:b038%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 20:01:45 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: Arun KS <arunks@codeaurora.org>, Guo Ren <ren_guo@c-sky.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff
 Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Borislav
 Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org"
 <x86@kernel.org>, David Airlie <airlied@linux.ie>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oded Gabbay
 <oded.gabbay@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)"
 <David1.Zhou@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Houlong Wei
 <houlong.wei@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Xavier Deguillard
 <xdeguillard@vmware.com>, Nadav Amit <namit@vmware.com>, "VMware, Inc."
 <pv-drivers@vmware.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Laura Abbott <labbott@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen
 Gross <jgross@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil
 <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna.schumaker@netapp.com>, "J. Bruce Fields" <bfields@fieldses.org>, Jeff
 Layton <jlayton@kernel.org>, Anton Altaparmakov <anton@tuxera.com>, Alexey
 Dobriyan <adobriyan@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len
 Brown <len.brown@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>, Pekka
 Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Seth
 Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Gerrit
 Renker <gerrit@erg.abdn.ac.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian
 Westphal <fw@strlen.de>, Vlad Yasevich <vyasevich@gmail.com>, Neil Horman
 <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Mark Brown <broonie@kernel.org>, Mike Rapoport
 <rppt@linux.vnet.ibm.com>, Jessica Yu <jeyu@kernel.org>, Kees Cook
 <keescook@chromium.org>, Cyril Bur <cyrilbur@gmail.com>, Russell Currey
 <ruscur@russell.cc>, Michal Hocko <mhocko@suse.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, Tvrtko
 Ursulin <tvrtko.ursulin@intel.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Anthony
 Yznaga <anthony.yznaga@oracle.com>, Khalid Aziz <khalid@gonehiking.org>,
 Matthew Wilcox <willy@infradead.org>, Pavel Tatashin
 <pavel.tatashin@microsoft.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <guro@fb.com>, Petr Tesarik <ptesarik@suse.com>, Jia He
 <jia.he@hxt-semitech.com>, Minchan Kim <minchan@kernel.org>, Huang Ying
 <ying.huang@intel.com>, Mel Gorman <mgorman@techsingularity.net>, Tejun Heo
 <tj@kernel.org>, Jan Kara <jack@suse.cz>, Omar Sandoval <osandov@fb.com>,
 Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
 =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Aneesh Kumar K.V
 <aneesh.kumar@linux.ibm.com>, Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>, Jonathan Corbet <corbet@lwn.net>, Stefan Agner
 <stefan@agner.ch>, Daniel Vacek <neelx@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 Mathieu Malaterre <malat@debian.org>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>, Yang Shi <yang.shi@linux.alibaba.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, YueHaibing <yuehaibing@huawei.com>, Shakeel Butt
 <shakeelb@google.com>, Chintan Pandya <cpandya@codeaurora.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, Joe Perches <joe@perches.com>, Jann Horn
 <jannh@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Steven J. Hill" <steven.hill@cavium.com>, Kemi Wang <kemi.wang@intel.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org"
 <linux-um@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>, "linaro-mm-sig@lists.linaro.org"
 <linaro-mm-sig@lists.linaro.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
 <linux-ntfs-dev@lists.sourceforge.net>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "kasan-dev@googlegroups.com"
 <kasan-dev@googlegroups.com>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-decnet-user@lists.sourceforge.net"
 <linux-decnet-user@lists.sourceforge.net>, "netfilter-devel@vger.kernel.org"
 <netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org"
 <coreteam@netfilter.org>, "linux-sctp@vger.kernel.org"
 <linux-sctp@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Thread-Topic: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Thread-Index: AQHUaivuVhMUrNkFZEeQVkkdWd1Qe6VcaAAA
Date: Thu, 22 Nov 2018 20:01:44 +0000
Message-ID: <7f2ca83b-8fe5-e4bf-b657-486e0da58340@amd.com>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
In-Reply-To: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR12MB1803;
 20:KxEklvzmfBevxrntOcoz3mU7a6Kx/WWqw/zQs1V3fQuNywCBWOeEOkU28CQSix5M0CwAghV0xX+Zb9OQTjCcyuw8XkNDU0cYl6FhqDuhsVH14B6/W3fTtX0+Ok5lYTjniAlLSMQ5+tbfUj7Tr7YZ1/qoB80x4ltTV/NV7DLLuq01iaxdl+ZCFFkBA3rqtaqooDJ8poITyrzEWU6liLb5tBgvD8B3Ha2f3W0VkxEzH5aOEn6aeion3jeB+ZTsVysc
x-ms-office365-filtering-correlation-id: c8464fc4-2705-4383-8aa9-08d650b55350
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR12MB1803; 
x-ms-traffictypediagnostic: DM5PR12MB1803:
x-microsoft-antispam-prvs: <DM5PR12MB18030FFC81CD9272C71FEC3C92DB0@DM5PR12MB1803.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR12MB1803; BCL:0; PCL:0; RULEID:; SRVR:DM5PR12MB1803; 
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: =?utf-8?B?U0ZWOk5TUE07U0ZTOigxMDAwOTAyMCkoMzc2MDAyKSgzOTg2MDQwMDAwMiko?=
 =?utf-8?B?MzQ2MDAyKSgzNjYwMDQpKDEzNjAwMykoMzk2MDAzKSgxOTkwMDQpKDE4OTAw?=
 =?utf-8?B?MykoMjU3ODYwMDkpKDQwMDExNTAxMDAwMDEpKDk5Mjg2MDA0KSg1NzU3ODQw?=
 =?utf-8?B?MDEpKDYzMDYwMDIpKDg2MzYyMDAxKSg0MzI2MDA4KSgxNDQ0NDAwNSkoMjU2?=
 =?utf-8?B?MDA0KSg3NzM2MDAyKSgxODYwMDMpKDcyNzYwMDIpKDMxNjAwMikoNjU4MDYw?=
 =?utf-8?B?MDEpKDExMDEzNjAwNSkoNjU5NTYwMDEpKDY2MDY2MDAxKSgxMTkxMDAyKSg1?=
 =?utf-8?B?ODEyNjAwOCkoMzA1OTQ1MDA1KSg2ODczNjAwNykoNzQwNjAwNSkoNzM2NjAw?=
 =?utf-8?B?MikoNzQxNjAwMikoNzMzNjAwMikoNzYxNzYwMTEpKDMxNjk2MDAyKSg1Mzk0?=
 =?utf-8?B?NjAwMykoNDc0NDAwNCkoMTAyODM2MDA0KSgyMjAxMDAxKSg1MjExNjAwMiko?=
 =?utf-8?B?NjUwNjAwNykoNzExOTA0MDAwMDEpKDcxMjAwNDAwMDAxKSgzODYwMDMpKDM2?=
 =?utf-8?B?NzU2MDAzKSgxNDQ1NDAwNCkoMjYwMDUpKDUzNTQ2MDExKSg2NTEyMDA3KSg4?=
 =?utf-8?B?OTM2MDAyKSg0NDYwMDMpKDYyNDYwMDMpKDExMzQ2MDAyKSgyNjE2MDA1KSg0?=
 =?utf-8?B?ODYwMDYpKDMxNjg2MDA0KSgxMDU1ODYwMDIpKDk2NjAwNSkoNzIyMDYwMDMp?=
 =?utf-8?B?KDM5MDYwNDAwMDAyKSgyOTAwMTAwMDAxKSg4Njc2MDAyKSg4MTE2NjAwNiko?=
 =?utf-8?B?NjU4MjYwMDcpKDgxMTU2MDE0KSg0Nzg2MDAwMDEpKDQ3NjAwMykoMTA2MzU2?=
 =?utf-8?B?MDAxKSg1NjYwMzAwMDAxKSgzODQ2MDAyKSg2MTE2MDAyKSgyOTA2MDAyKSgy?=
 =?utf-8?B?NTAxMDAzKSgyMjk4NTMwMDIpKDY0MTI2MDAzKSg1MzkzNjAwMikoOTc3MzYw?=
 =?utf-8?B?MDQpKDY0ODYwMDIpKDE1MTEwMDEpKDY0MzYwMDIpKDkyMTAwMykoMTEyMTAw?=
 =?utf-8?B?MykoNTc5MDA0KSg1NTkwMDEpKDU2OTAwNik7RElSOk9VVDtTRlA6MTEwMTtT?=
 =?utf-8?B?Q0w6MTtTUlZSOkRNNVBSMTJNQjE4MDM7SDpETTVQUjEyTUIxNzA3Lm5hbXBy?=
 =?utf-8?B?ZDEyLnByb2Qub3V0bG9vay5jb207RlBSOjtTUEY6Tm9uZTtMQU5HOmVuO1BU?=
 =?utf-8?Q?R:InfoNoRecords;A:1;MX:1;?=
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ji4IppzOJ9oA56avfxhMcWwxVFvrlu3xvjTwFx+U+0jmkizDVjfI7hjlA+90Tk1wpUg4c5MVfs4io03OTGBOnXnlMtkGWG825poMPe9uf3fLHRraW+B6a6ThvQVwffMMPUQgwMBKKEJ4wBjbd7Zo7fcIi8kl6q7I4LhwA4W8C1kkgEfSIg656YaRNFpUhgFRxWTJmuMRwttD9GgtsqS+PLDU2KiN1Xb4PxdOvqw9NOGmIWQC3iCb2Al+KVFaREdwZZZt6dfX8DPbo0kJTqkQI+3ubSNIqSrbW2DzSc3hHfBFJBBjpVaS7iaFO67DALG97I9+/89ozYultliJGlrClsp4HqcLpVnhQl9KMGqEdQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A6D0117473B1B4EAAF1554883141BC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8464fc4-2705-4383-8aa9-08d650b55350
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 20:01:44.8043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
X-Mailman-Approved-At: Fri, 23 Nov 2018 07:40:30 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "getarunks@gmail.com" <getarunks@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMjAxOC0xMC0yMiAxOjIzIHAubS4sIEFydW4gS1Mgd3JvdGU6DQo+IFJlbW92ZSBtYW5hZ2Vk
X3BhZ2VfY291bnRfbG9jayBzcGlubG9jayBhbmQgaW5zdGVhZCB1c2UgYXRvbWljDQo+IHZhcmlh
Ymxlcy4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4N
Cj4gU3VnZ2VzdGVkLWJ5OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBcnVuIEtTIDxhcnVua3NAY29kZWF1cm9yYS5vcmc+DQoNCkFja2VkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCsKgIEZl
bGl4DQoNCj4NCj4gLS0tDQo+IEFzIGRpc2N1c3NlZCBoZXJlLA0KPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzEwNjI3NTIxLyMyMjI2MTI1Mw0KPiAtLS0NCj4gLS0tDQo+ICBh
cmNoL2Nza3kvbW0vaW5pdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAg
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL2NtbS5jICAgICAgICAgIHwgMTEgKystLQ0K
PiAgYXJjaC9zMzkwL21tL2luaXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0N
Cj4gIGFyY2gvdW0va2VybmVsL21lbS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICst
DQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9jb3JlLmMgICAgICAgICAgfCAgNSAr
LQ0KPiAgZHJpdmVycy9jaGFyL2FncC9iYWNrZW5kLmMgICAgICAgICAgICAgICAgICAgIHwgIDQg
Ky0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgICAgICAgICB8ICAy
ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2dlbS5jICAgICAgICAgICAgICAgfCAg
MiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvc2VsZnRlc3RzL2k5MTVfZ2VtX2d0dC5jIHwg
IDQgKy0NCj4gIGRyaXZlcnMvaHYvaHZfYmFsbG9vbi5jICAgICAgICAgICAgICAgICAgICAgICB8
IDE5ICsrKy0tLS0NCj4gIGRyaXZlcnMvbWQvZG0tYnVmaW8uYyAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA1ICstDQo+ICBkcml2ZXJzL21kL2RtLWNyeXB0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgNCArLQ0KPiAgZHJpdmVycy9tZC9kbS1pbnRlZ3JpdHkuYyAgICAgICAgICAgICAg
ICAgICAgIHwgIDQgKy0NCj4gIGRyaXZlcnMvbWQvZG0tc3RhdHMuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzICstDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12cHUvbXRrX3Zw
dS5jICAgICAgfCAgMyArLQ0KPiAgZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvcGFyaXNjL2NjaW8tZG1hLmMgICAgICAgICAg
ICAgICAgICAgICB8ICA1ICstDQo+ICBkcml2ZXJzL3BhcmlzYy9zYmFfaW9tbXUuYyAgICAgICAg
ICAgICAgICAgICAgfCAgNSArLQ0KPiAgZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvaW9uL2lvbl9z
eXN0ZW1faGVhcC5jIHwgIDIgKy0NCj4gIGRyaXZlcnMveGVuL3hlbi1zZWxmYmFsbG9vbi5jICAg
ICAgICAgICAgICAgICB8ICA3ICstLQ0KPiAgZnMvY2VwaC9zdXBlci5oICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4gIGZzL2ZpbGVfdGFibGUuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA5ICsrLS0NCj4gIGZzL2Z1c2UvaW5vZGUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBmcy9uZnMvd3JpdGUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgZnMvbmZzZC9uZnNjYWNoZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4gIGZzL250ZnMvbWFsbG9jLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBmcy9wcm9jL2Jhc2UuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgaW5jbHVkZS9saW51eC9oaWdobWVt
LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGluY2x1ZGUvbGludXgvbW0uaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBpbmNsdWRlL2xpbnV4L21tem9u
ZS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3N3
YXAuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAga2VybmVsL2ZvcmsuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBrZXJuZWwva2V4ZWNf
Y29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArLQ0KPiAga2VybmVsL3Bvd2Vy
L3NuYXBzaG90LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGxpYi9zaG93X21l
bS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstDQo+ICBtbS9oaWdobWVt
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbW0vaHVnZV9t
ZW1vcnkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1tL2thc2Fu
L3F1YXJhbnRpbmUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBtbS9tZW1i
bG9jay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArLS0NCj4gIG1tL21l
bW9yeV9ob3RwbHVnLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBtbS9t
bV9pbml0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgbW0v
b29tX2tpbGwuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1t
L3BhZ2VfYWxsb2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDc1ICsrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgbW0vc2htZW0uYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTIgKysrLS0NCj4gIG1tL3NsYWIuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzICstDQo+ICBtbS9zd2FwLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgbW0vdXRpbC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1tL3ZtYWxsb2MuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBtbS92bXN0YXQuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgbW0vd29ya2luZ3NldC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1tL3pzd2FwLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBuZXQvZGNjcC9wcm90by5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArLS0NCj4gIG5ldC9kZWNuZXQvZG5fcm91dGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBuZXQvaXB2NC90Y3BfbWV0cmlj
cy5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbmV0L25ldGZpbHRlci9uZl9j
b25udHJhY2tfY29yZS5jICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBuZXQvbmV0ZmlsdGVyL3h0
X2hhc2hsaW1pdC5jICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgbmV0L3NjdHAvcHJvdG9j
b2wuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBzZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2ltYV9rZXhlYy5jICAgICAgICAgICAgfCAgMiArLQ0KPiAgNTggZmlsZXMgY2hh
bmdlZCwgMTcxIGluc2VydGlvbnMoKyksIDE0MyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2FyY2gvY3NreS9tbS9pbml0LmMgYi9hcmNoL2Nza3kvbW0vaW5pdC5jDQo+IGluZGV4IGRj
MDdjMDcuLjNmNGQzNWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvY3NreS9tbS9pbml0LmMNCj4gKysr
IGIvYXJjaC9jc2t5L21tL2luaXQuYw0KPiBAQCAtNzEsNyArNzEsNyBAQCB2b2lkIGZyZWVfaW5p
dHJkX21lbSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkNCj4gIAkJQ2xl
YXJQYWdlUmVzZXJ2ZWQodmlydF90b19wYWdlKHN0YXJ0KSk7DQo+ICAJCWluaXRfcGFnZV9jb3Vu
dCh2aXJ0X3RvX3BhZ2Uoc3RhcnQpKTsNCj4gIAkJZnJlZV9wYWdlKHN0YXJ0KTsNCj4gLQkJdG90
YWxyYW1fcGFnZXMrKzsNCj4gKwkJYXRvbWljX2xvbmdfaW5jKCZ0b3RhbHJhbV9wYWdlcyk7DQo+
ICAJfQ0KPiAgfQ0KPiAgI2VuZGlmDQo+IEBAIC04OCw3ICs4OCw3IEBAIHZvaWQgZnJlZV9pbml0
bWVtKHZvaWQpDQo+ICAJCUNsZWFyUGFnZVJlc2VydmVkKHZpcnRfdG9fcGFnZShhZGRyKSk7DQo+
ICAJCWluaXRfcGFnZV9jb3VudCh2aXJ0X3RvX3BhZ2UoYWRkcikpOw0KPiAgCQlmcmVlX3BhZ2Uo
YWRkcik7DQo+IC0JCXRvdGFscmFtX3BhZ2VzKys7DQo+ICsJCWF0b21pY19sb25nX2luYygmdG90
YWxyYW1fcGFnZXMpOw0KPiAgCQlhZGRyICs9IFBBR0VfU0laRTsNCj4gIAl9DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9jbW0uYyBiL2FyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9jbW0uYw0KPiBpbmRleCAyNTQyN2E0Li44NWZlNTAzIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvY21tLmMNCj4gKysr
IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL2NtbS5jDQo+IEBAIC0yMDgsNyArMjA4
LDcgQEAgc3RhdGljIGxvbmcgY21tX2FsbG9jX3BhZ2VzKGxvbmcgbnIpDQo+ICANCj4gIAkJcGEt
PnBhZ2VbcGEtPmluZGV4KytdID0gYWRkcjsNCj4gIAkJbG9hbmVkX3BhZ2VzKys7DQo+IC0JCXRv
dGFscmFtX3BhZ2VzLS07DQo+ICsJCWF0b21pY19sb25nX2RlYygmdG90YWxyYW1fcGFnZXMpOw0K
PiAgCQlzcGluX3VubG9jaygmY21tX2xvY2spOw0KPiAgCQluci0tOw0KPiAgCX0NCj4gQEAgLTI0
Nyw3ICsyNDcsNyBAQCBzdGF0aWMgbG9uZyBjbW1fZnJlZV9wYWdlcyhsb25nIG5yKQ0KPiAgCQlm
cmVlX3BhZ2UoYWRkcik7DQo+ICAJCWxvYW5lZF9wYWdlcy0tOw0KPiAgCQluci0tOw0KPiAtCQl0
b3RhbHJhbV9wYWdlcysrOw0KPiArCQlhdG9taWNfbG9uZ19pbmMoJnRvdGFscmFtX3BhZ2VzKTsN
Cj4gIAl9DQo+ICAJc3Bpbl91bmxvY2soJmNtbV9sb2NrKTsNCj4gIAljbW1fZGJnKCJFbmQgcmVx
dWVzdCB3aXRoICVsZCBwYWdlcyB1bmZ1bGZpbGxlZFxuIiwgbnIpOw0KPiBAQCAtMjkxLDcgKzI5
MSw4IEBAIHN0YXRpYyB2b2lkIGNtbV9nZXRfbXBwKHZvaWQpDQo+ICAJaW50IHJjOw0KPiAgCXN0
cnVjdCBodmNhbGxfbXBwX2RhdGEgbXBwX2RhdGE7DQo+ICAJc2lnbmVkIGxvbmcgYWN0aXZlX3Bh
Z2VzX3RhcmdldCwgcGFnZV9sb2FuX3JlcXVlc3QsIHRhcmdldDsNCj4gLQlzaWduZWQgbG9uZyB0
b3RhbF9wYWdlcyA9IHRvdGFscmFtX3BhZ2VzICsgbG9hbmVkX3BhZ2VzOw0KPiArCXNpZ25lZCBs
b25nIHRvdGFsX3BhZ2VzID0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpICsNCj4g
KwkJCQkgIGxvYW5lZF9wYWdlczsNCj4gIAlzaWduZWQgbG9uZyBtaW5fbWVtX3BhZ2VzID0gKG1p
bl9tZW1fbWIgKiAxMDI0ICogMTAyNCkgLyBQQUdFX1NJWkU7DQo+ICANCj4gIAlyYyA9IGhfZ2V0
X21wcCgmbXBwX2RhdGEpOw0KPiBAQCAtMzIyLDcgKzMyMyw3IEBAIHN0YXRpYyB2b2lkIGNtbV9n
ZXRfbXBwKHZvaWQpDQo+ICANCj4gIAljbW1fZGJnKCJkZWx0YSA9ICVsZCwgbG9hbmVkID0gJWx1
LCB0YXJnZXQgPSAlbHUsIG9vbSA9ICVsdSwgdG90YWxyYW0gPSAlbHVcbiIsDQo+ICAJCXBhZ2Vf
bG9hbl9yZXF1ZXN0LCBsb2FuZWRfcGFnZXMsIGxvYW5lZF9wYWdlc190YXJnZXQsDQo+IC0JCW9v
bV9mcmVlZF9wYWdlcywgdG90YWxyYW1fcGFnZXMpOw0KPiArCQlvb21fZnJlZWRfcGFnZXMsIGF0
b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBz
dHJ1Y3Qgbm90aWZpZXJfYmxvY2sgY21tX29vbV9uYiA9IHsNCj4gQEAgLTU4MSw3ICs1ODIsNyBA
QCBzdGF0aWMgaW50IGNtbV9tZW1fZ29pbmdfb2ZmbGluZSh2b2lkICphcmcpDQo+ICAJCQlmcmVl
X3BhZ2UocGFfY3Vyci0+cGFnZVtpZHhdKTsNCj4gIAkJCWZyZWVkKys7DQo+ICAJCQlsb2FuZWRf
cGFnZXMtLTsNCj4gLQkJCXRvdGFscmFtX3BhZ2VzKys7DQo+ICsJCQlhdG9taWNfbG9uZ19pbmMo
JnRvdGFscmFtX3BhZ2VzKTsNCj4gIAkJCXBhX2N1cnItPnBhZ2VbaWR4XSA9IHBhX2xhc3QtPnBh
Z2VbLS1wYV9sYXN0LT5pbmRleF07DQo+ICAJCQlpZiAocGFfbGFzdC0+aW5kZXggPT0gMCkgew0K
PiAgCQkJCWlmIChwYV9jdXJyID09IHBhX2xhc3QpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3MzOTAv
bW0vaW5pdC5jIGIvYXJjaC9zMzkwL21tL2luaXQuYw0KPiBpbmRleCA3NmQwNzA4Li5kNjUyOWU4
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3MzOTAvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvczM5MC9t
bS9pbml0LmMNCj4gQEAgLTU5LDcgKzU5LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX3pl
cm9fcGFnZXModm9pZCkNCj4gIAlvcmRlciA9IDc7DQo+ICANCj4gIAkvKiBMaW1pdCBudW1iZXIg
b2YgZW1wdHkgemVybyBwYWdlcyBmb3Igc21hbGwgbWVtb3J5IHNpemVzICovDQo+IC0Jd2hpbGUg
KG9yZGVyID4gMiAmJiAodG90YWxyYW1fcGFnZXMgPj4gMTApIDwgKDFVTCA8PCBvcmRlcikpDQo+
ICsJd2hpbGUgKG9yZGVyID4gMiAmJiAoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMp
ID4+IDEwKSA8ICgxVUwgPDwgb3JkZXIpKQ0KPiAgCQlvcmRlci0tOw0KPiAgDQo+ICAJZW1wdHlf
emVyb19wYWdlID0gX19nZXRfZnJlZV9wYWdlcyhHRlBfS0VSTkVMIHwgX19HRlBfWkVSTywgb3Jk
ZXIpOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9rZXJuZWwvbWVtLmMgYi9hcmNoL3VtL2tlcm5l
bC9tZW0uYw0KPiBpbmRleCAxMDY3NDY5Li5kYTc4YTA2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Vt
L2tlcm5lbC9tZW0uYw0KPiArKysgYi9hcmNoL3VtL2tlcm5lbC9tZW0uYw0KPiBAQCAtNTEsOCAr
NTEsOCBAQCB2b2lkIF9faW5pdCBtZW1faW5pdCh2b2lkKQ0KPiAgDQo+ICAJLyogdGhpcyB3aWxs
IHB1dCBhbGwgbG93IG1lbW9yeSBvbnRvIHRoZSBmcmVlbGlzdHMgKi8NCj4gIAltZW1ibG9ja19m
cmVlX2FsbCgpOw0KPiAtCW1heF9sb3dfcGZuID0gdG90YWxyYW1fcGFnZXM7DQo+IC0JbWF4X3Bm
biA9IHRvdGFscmFtX3BhZ2VzOw0KPiArCW1heF9sb3dfcGZuID0gYXRvbWljX2xvbmdfcmVhZCgm
dG90YWxyYW1fcGFnZXMpOw0KPiArCW1heF9wZm4gPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJh
bV9wYWdlcyk7DQo+ICAJbWVtX2luaXRfcHJpbnRfaW5mbyhOVUxMKTsNCj4gIAlrbWFsbG9jX29r
ID0gMTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2Rl
L2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2NvcmUuYw0KPiBpbmRleCAy
NjM3ZmYwLi40Y2NjOGRkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3Jv
Y29kZS9jb3JlLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUvY29yZS5j
DQo+IEBAIC00MzUsOCArNDM1LDkgQEAgc3RhdGljIHNzaXplX3QgbWljcm9jb2RlX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KPiAgew0KPiAgCXNzaXpl
X3QgcmV0ID0gLUVJTlZBTDsNCj4gIA0KPiAtCWlmICgobGVuID4+IFBBR0VfU0hJRlQpID4gdG90
YWxyYW1fcGFnZXMpIHsNCj4gLQkJcHJfZXJyKCJ0b28gbXVjaCBkYXRhIChtYXggJWxkIHBhZ2Vz
KVxuIiwgdG90YWxyYW1fcGFnZXMpOw0KPiArCWlmICgobGVuID4+IFBBR0VfU0hJRlQpID4gYXRv
bWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpKSB7DQo+ICsJCXByX2VycigidG9vIG11Y2gg
ZGF0YSAobWF4ICVsZCBwYWdlcylcbiIsDQo+ICsJCQkJYXRvbWljX2xvbmdfcmVhZCgmdG90YWxy
YW1fcGFnZXMpKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2hhci9hZ3AvYmFja2VuZC5jIGIvZHJpdmVycy9jaGFyL2FncC9iYWNrZW5kLmMN
Cj4gaW5kZXggMzhmZmIyOC4uMjc1M2UxZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jaGFyL2Fn
cC9iYWNrZW5kLmMNCj4gKysrIGIvZHJpdmVycy9jaGFyL2FncC9iYWNrZW5kLmMNCj4gQEAgLTEx
NSw5ICsxMTUsOSBAQCBzdGF0aWMgaW50IGFncF9maW5kX21heCh2b2lkKQ0KPiAgCWxvbmcgbWVt
b3J5LCBpbmRleCwgcmVzdWx0Ow0KPiAgDQo+ICAjaWYgUEFHRV9TSElGVCA8IDIwDQo+IC0JbWVt
b3J5ID0gdG90YWxyYW1fcGFnZXMgPj4gKDIwIC0gUEFHRV9TSElGVCk7DQo+ICsJbWVtb3J5ID0g
YXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+ICgyMCAtIFBBR0VfU0hJRlQpOw0K
PiAgI2Vsc2UNCj4gLQltZW1vcnkgPSB0b3RhbHJhbV9wYWdlcyA8PCAoUEFHRV9TSElGVCAtIDIw
KTsNCj4gKwltZW1vcnkgPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPDwgKFBB
R0VfU0hJRlQgLSAyMCk7DQo+ICAjZW5kaWYNCj4gIAlpbmRleCA9IDE7DQo+ICANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+IGluZGV4IDU2NDEyYjAuLmNhMTg1MDIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiBAQCAtODQ4LDcgKzg0
OCw3IEBAIHN0YXRpYyBpbnQga2ZkX2ZpbGxfbWVtX2luZm9fZm9yX2NwdShpbnQgbnVtYV9ub2Rl
X2lkLCBpbnQgKmF2YWlsX3NpemUsDQo+ICAJICovDQo+ICAJcGdkYXQgPSBOT0RFX0RBVEEobnVt
YV9ub2RlX2lkKTsNCj4gIAlmb3IgKHpvbmVfdHlwZSA9IDA7IHpvbmVfdHlwZSA8IE1BWF9OUl9a
T05FUzsgem9uZV90eXBlKyspDQo+IC0JCW1lbV9pbl9ieXRlcyArPSBwZ2RhdC0+bm9kZV96b25l
c1t6b25lX3R5cGVdLm1hbmFnZWRfcGFnZXM7DQo+ICsJCW1lbV9pbl9ieXRlcyArPSBhdG9taWNf
bG9uZ19yZWFkKCZwZ2RhdC0+bm9kZV96b25lc1t6b25lX3R5cGVdLm1hbmFnZWRfcGFnZXMpOw0K
PiAgCW1lbV9pbl9ieXRlcyA8PD0gUEFHRV9TSElGVDsNCj4gIA0KPiAgCXN1Yl90eXBlX2hkci0+
bGVuZ3RoX2xvdyA9IGxvd2VyXzMyX2JpdHMobWVtX2luX2J5dGVzKTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9p
OTE1X2dlbS5jDQo+IGluZGV4IDBjOGFhNTcuLmI0YzI0NWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2k5MTVfZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
aTkxNV9nZW0uYw0KPiBAQCAtMjUzOSw3ICsyNTM5LDcgQEAgc3RhdGljIGludCBpOTE1X2dlbV9v
YmplY3RfZ2V0X3BhZ2VzX2d0dChzdHJ1Y3QgZHJtX2k5MTVfZ2VtX29iamVjdCAqb2JqKQ0KPiAg
CSAqIElmIHRoZXJlJ3Mgbm8gY2hhbmNlIG9mIGFsbG9jYXRpbmcgZW5vdWdoIHBhZ2VzIGZvciB0
aGUgd2hvbGUNCj4gIAkgKiBvYmplY3QsIGJhaWwgZWFybHkuDQo+ICAJICovDQo+IC0JaWYgKHBh
Z2VfY291bnQgPiB0b3RhbHJhbV9wYWdlcykNCj4gKwlpZiAocGFnZV9jb3VudCA+IGF0b21pY19s
b25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4g
IAlzdCA9IGttYWxsb2Moc2l6ZW9mKCpzdCksIEdGUF9LRVJORUwpOw0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvc2VsZnRlc3RzL2k5MTVfZ2VtX2d0dC5jIGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvc2VsZnRlc3RzL2k5MTVfZ2VtX2d0dC5jDQo+IGluZGV4IDhlMmUyNjkuLjll
YTEwZWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L3NlbGZ0ZXN0cy9pOTE1
X2dlbV9ndHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9zZWxmdGVzdHMvaTkxNV9n
ZW1fZ3R0LmMNCj4gQEAgLTE3MCw3ICsxNzAsNyBAQCBzdGF0aWMgaW50IGlndF9wcGd0dF9hbGxv
Yyh2b2lkICphcmcpDQo+ICAJICogVGhpcyBzaG91bGQgZW5zdXJlIHRoYXQgd2UgZG8gbm90IHJ1
biBpbnRvIHRoZSBvb21raWxsZXIgZHVyaW5nDQo+ICAJICogdGhlIHRlc3QgYW5kIHRha2UgZG93
biB0aGUgbWFjaGluZSB3aWxmdWxseS4NCj4gIAkgKi8NCj4gLQlsaW1pdCA9IHRvdGFscmFtX3Bh
Z2VzIDw8IFBBR0VfU0hJRlQ7DQo+ICsJbGltaXQgPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJh
bV9wYWdlcykgPDwgUEFHRV9TSElGVDsNCj4gIAlsaW1pdCA9IG1pbihwcGd0dC0+dm0udG90YWws
IGxpbWl0KTsNCj4gIA0KPiAgCS8qIENoZWNrIHdlIGNhbiBhbGxvY2F0ZSB0aGUgZW50aXJlIHJh
bmdlICovDQo+IEBAIC0xMjQ0LDcgKzEyNDQsNyBAQCBzdGF0aWMgaW50IGV4ZXJjaXNlX21vY2so
c3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsDQo+ICAJCQkJICAgICB1NjQgaG9sZV9zdGFy
dCwgdTY0IGhvbGVfZW5kLA0KPiAgCQkJCSAgICAgdW5zaWduZWQgbG9uZyBlbmRfdGltZSkpDQo+
ICB7DQo+IC0JY29uc3QgdTY0IGxpbWl0ID0gdG90YWxyYW1fcGFnZXMgPDwgUEFHRV9TSElGVDsN
Cj4gKwljb25zdCB1NjQgbGltaXQgPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykg
PDwgUEFHRV9TSElGVDsNCj4gIAlzdHJ1Y3QgaTkxNV9nZW1fY29udGV4dCAqY3R4Ow0KPiAgCXN0
cnVjdCBpOTE1X2h3X3BwZ3R0ICpwcGd0dDsNCj4gIAlJR1RfVElNRU9VVChlbmRfdGltZSk7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X2JhbGxvb24uYyBiL2RyaXZlcnMvaHYvaHZfYmFs
bG9vbi5jDQo+IGluZGV4IGM1YmMwYjUuLjQ0OThjOTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aHYvaHZfYmFsbG9vbi5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jDQo+IEBAIC0x
MDkyLDYgKzEwOTIsNyBAQCBzdGF0aWMgdm9pZCBwcm9jZXNzX2luZm8oc3RydWN0IGh2X2R5bm1l
bV9kZXZpY2UgKmRtLCBzdHJ1Y3QgZG1faW5mb19tc2cgKm1zZykNCj4gIHN0YXRpYyB1bnNpZ25l
ZCBsb25nIGNvbXB1dGVfYmFsbG9vbl9mbG9vcih2b2lkKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxv
bmcgbWluX3BhZ2VzOw0KPiArCXVuc2lnbmVkIGxvbmcgdG90YWxyYW0gPSAodW5zaWduZWQgbG9u
ZylhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcyk7DQo+ICAjZGVmaW5lIE1CMlBBR0VT
KG1iKSAoKG1iKSA8PCAoMjAgLSBQQUdFX1NISUZUKSkNCj4gIAkvKiBTaW1wbGUgY29udGludW91
cyBwaWVjZXdpZXNlIGxpbmVhciBmdW5jdGlvbjoNCj4gIAkgKiAgbWF4IE1pQiAtPiBtaW4gTWlC
ICBncmFkaWVudA0KPiBAQCAtMTEwNCwxNiArMTEwNSwxNiBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBjb21wdXRlX2JhbGxvb25fZmxvb3Iodm9pZCkNCj4gIAkgKiAgICA4MTkyICAgICAgIDc0NCAg
ICAoMS8xNikNCj4gIAkgKiAgIDMyNzY4ICAgICAgMTUxMgkoMS8zMikNCj4gIAkgKi8NCj4gLQlp
ZiAodG90YWxyYW1fcGFnZXMgPCBNQjJQQUdFUygxMjgpKQ0KPiAtCQltaW5fcGFnZXMgPSBNQjJQ
QUdFUyg4KSArICh0b3RhbHJhbV9wYWdlcyA+PiAxKTsNCj4gLQllbHNlIGlmICh0b3RhbHJhbV9w
YWdlcyA8IE1CMlBBR0VTKDUxMikpDQo+IC0JCW1pbl9wYWdlcyA9IE1CMlBBR0VTKDQwKSArICh0
b3RhbHJhbV9wYWdlcyA+PiAyKTsNCj4gLQllbHNlIGlmICh0b3RhbHJhbV9wYWdlcyA8IE1CMlBB
R0VTKDIwNDgpKQ0KPiAtCQltaW5fcGFnZXMgPSBNQjJQQUdFUygxMDQpICsgKHRvdGFscmFtX3Bh
Z2VzID4+IDMpOw0KPiAtCWVsc2UgaWYgKHRvdGFscmFtX3BhZ2VzIDwgTUIyUEFHRVMoODE5Mikp
DQo+IC0JCW1pbl9wYWdlcyA9IE1CMlBBR0VTKDIzMikgKyAodG90YWxyYW1fcGFnZXMgPj4gNCk7
DQo+ICsJaWYgKHRvdGFscmFtIDwgTUIyUEFHRVMoMTI4KSkNCj4gKwkJbWluX3BhZ2VzID0gTUIy
UEFHRVMoOCkgKyAodG90YWxyYW0gPj4gMSk7DQo+ICsJZWxzZSBpZiAodG90YWxyYW0gPCBNQjJQ
QUdFUyg1MTIpKQ0KPiArCQltaW5fcGFnZXMgPSBNQjJQQUdFUyg0MCkgKyAodG90YWxyYW0gPj4g
Mik7DQo+ICsJZWxzZSBpZiAodG90YWxyYW0gPCBNQjJQQUdFUygyMDQ4KSkNCj4gKwkJbWluX3Bh
Z2VzID0gTUIyUEFHRVMoMTA0KSArICh0b3RhbHJhbSA+PiAzKTsNCj4gKwllbHNlIGlmICh0b3Rh
bHJhbSA8IE1CMlBBR0VTKDgxOTIpKQ0KPiArCQltaW5fcGFnZXMgPSBNQjJQQUdFUygyMzIpICsg
KHRvdGFscmFtID4+IDQpOw0KPiAgCWVsc2UNCj4gLQkJbWluX3BhZ2VzID0gTUIyUEFHRVMoNDg4
KSArICh0b3RhbHJhbV9wYWdlcyA+PiA1KTsNCj4gKwkJbWluX3BhZ2VzID0gTUIyUEFHRVMoNDg4
KSArICh0b3RhbHJhbSA+PiA1KTsNCj4gICN1bmRlZiBNQjJQQUdFUw0KPiAgCXJldHVybiBtaW5f
cGFnZXM7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLWJ1ZmlvLmMgYi9kcml2
ZXJzL21kL2RtLWJ1ZmlvLmMNCj4gaW5kZXggZGMzODViNy4uNmQ2MTI1OSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tZC9kbS1idWZpby5jDQo+ICsrKyBiL2RyaXZlcnMvbWQvZG0tYnVmaW8uYw0K
PiBAQCAtMTg4Nyw4ICsxODg3LDkgQEAgc3RhdGljIGludCBfX2luaXQgZG1fYnVmaW9faW5pdCh2
b2lkKQ0KPiAgCWRtX2J1ZmlvX2FsbG9jYXRlZF92bWFsbG9jID0gMDsNCj4gIAlkbV9idWZpb19j
dXJyZW50X2FsbG9jYXRlZCA9IDA7DQo+ICANCj4gLQltZW0gPSAoX191NjQpbXVsdF9mcmFjKHRv
dGFscmFtX3BhZ2VzIC0gdG90YWxoaWdoX3BhZ2VzLA0KPiAtCQkJICAgICAgIERNX0JVRklPX01F
TU9SWV9QRVJDRU5ULCAxMDApIDw8IFBBR0VfU0hJRlQ7DQo+ICsJbWVtID0gKF9fdTY0KW11bHRf
ZnJhYyhhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgLQ0KPiArCQkJCWF0b21pY19s
b25nX3JlYWQoJnRvdGFsaGlnaF9wYWdlcyksDQo+ICsJCQkJRE1fQlVGSU9fTUVNT1JZX1BFUkNF
TlQsIDEwMCkgPDwgUEFHRV9TSElGVDsNCj4gIA0KPiAgCWlmIChtZW0gPiBVTE9OR19NQVgpDQo+
ICAJCW1lbSA9IFVMT05HX01BWDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tY3J5cHQu
YyBiL2RyaXZlcnMvbWQvZG0tY3J5cHQuYw0KPiBpbmRleCAwNDgxMjIzLi4xYzU4ZjRjIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL21kL2RtLWNyeXB0LmMNCj4gKysrIGIvZHJpdmVycy9tZC9kbS1j
cnlwdC5jDQo+IEBAIC0yMTU4LDcgKzIxNTgsOSBAQCBzdGF0aWMgaW50IGNyeXB0X3dpcGVfa2V5
KHN0cnVjdCBjcnlwdF9jb25maWcgKmNjKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBjcnlwdF9jYWxj
dWxhdGVfcGFnZXNfcGVyX2NsaWVudCh2b2lkKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgcGFn
ZXMgPSAodG90YWxyYW1fcGFnZXMgLSB0b3RhbGhpZ2hfcGFnZXMpICogRE1fQ1JZUFRfTUVNT1JZ
X1BFUkNFTlQgLyAxMDA7DQo+ICsJdW5zaWduZWQgbG9uZyBwYWdlcyA9IChhdG9taWNfbG9uZ19y
ZWFkKCZ0b3RhbHJhbV9wYWdlcykgLQ0KPiArCQkJCWF0b21pY19sb25nX3JlYWQoJnRvdGFsaGln
aF9wYWdlcykpICoNCj4gKwkJCQlETV9DUllQVF9NRU1PUllfUEVSQ0VOVCAvIDEwMDsNCj4gIA0K
PiAgCWlmICghZG1fY3J5cHRfY2xpZW50c19uKQ0KPiAgCQlyZXR1cm47DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21kL2RtLWludGVncml0eS5jIGIvZHJpdmVycy9tZC9kbS1pbnRlZ3JpdHkuYw0K
PiBpbmRleCBiYjMwOTZiLi5kOTFjOTMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21kL2RtLWlu
dGVncml0eS5jDQo+ICsrKyBiL2RyaXZlcnMvbWQvZG0taW50ZWdyaXR5LmMNCj4gQEAgLTI4NDMs
NyArMjg0Myw5IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2pvdXJuYWwoc3RydWN0IGRtX2ludGVncml0
eV9jICppYywgY2hhciAqKmVycm9yKQ0KPiAgCWpvdXJuYWxfcGFnZXMgPSByb3VuZHVwKChfX3U2
NClpYy0+am91cm5hbF9zZWN0aW9ucyAqIGljLT5qb3VybmFsX3NlY3Rpb25fc2VjdG9ycywNCj4g
IAkJCQlQQUdFX1NJWkUgPj4gU0VDVE9SX1NISUZUKSA+PiAoUEFHRV9TSElGVCAtIFNFQ1RPUl9T
SElGVCk7DQo+ICAJam91cm5hbF9kZXNjX3NpemUgPSBqb3VybmFsX3BhZ2VzICogc2l6ZW9mKHN0
cnVjdCBwYWdlX2xpc3QpOw0KPiAtCWlmIChqb3VybmFsX3BhZ2VzID49IHRvdGFscmFtX3BhZ2Vz
IC0gdG90YWxoaWdoX3BhZ2VzIHx8IGpvdXJuYWxfZGVzY19zaXplID4gVUxPTkdfTUFYKSB7DQo+
ICsJaWYgKGpvdXJuYWxfcGFnZXMgPj0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMp
IC0NCj4gKwkJCWF0b21pY19sb25nX3JlYWQoJnRvdGFsaGlnaF9wYWdlcykgfHwNCj4gKwkJCWpv
dXJuYWxfZGVzY19zaXplID4gVUxPTkdfTUFYKSB7DQo+ICAJCSplcnJvciA9ICJKb3VybmFsIGRv
ZXNuJ3QgZml0IGludG8gbWVtb3J5IjsNCj4gIAkJciA9IC1FTk9NRU07DQo+ICAJCWdvdG8gYmFk
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS1zdGF0cy5jIGIvZHJpdmVycy9tZC9kbS1z
dGF0cy5jDQo+IGluZGV4IDIxZGUzMGIuLmYxNTRhMDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bWQvZG0tc3RhdHMuYw0KPiArKysgYi9kcml2ZXJzL21kL2RtLXN0YXRzLmMNCj4gQEAgLTg1LDcg
Kzg1LDggQEAgc3RhdGljIGJvb2wgX19jaGVja19zaGFyZWRfbWVtb3J5KHNpemVfdCBhbGxvY19z
aXplKQ0KPiAgCWEgPSBzaGFyZWRfbWVtb3J5X2Ftb3VudCArIGFsbG9jX3NpemU7DQo+ICAJaWYg
KGEgPCBzaGFyZWRfbWVtb3J5X2Ftb3VudCkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAtCWlmIChh
ID4+IFBBR0VfU0hJRlQgPiB0b3RhbHJhbV9wYWdlcyAvIERNX1NUQVRTX01FTU9SWV9GQUNUT1Ip
DQo+ICsJaWYgKGEgPj4gUEFHRV9TSElGVCA+IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3Bh
Z2VzKSAvDQo+ICsJCQkJCURNX1NUQVRTX01FTU9SWV9GQUNUT1IpDQo+ICAJCXJldHVybiBmYWxz
ZTsNCj4gICNpZmRlZiBDT05GSUdfTU1VDQo+ICAJaWYgKGEgPiAoVk1BTExPQ19FTkQgLSBWTUFM
TE9DX1NUQVJUKSAvIERNX1NUQVRTX1ZNQUxMT0NfRkFDVE9SKQ0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdnB1L210a192cHUuYyBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLXZwdS9tdGtfdnB1LmMNCj4gaW5kZXggNjE2Zjc4Yi4uZWUzNjU0YSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdnB1L210a192cHUuYw0KPiArKysg
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12cHUvbXRrX3ZwdS5jDQo+IEBAIC04NTUsNyAr
ODU1LDggQEAgc3RhdGljIGludCBtdGtfdnB1X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJLyogU2V0IFBUQ00gdG8gOTZLIGFuZCBEVENNIHRvIDMySyAqLw0KPiAgCXZw
dV9jZmdfd3JpdGVsKHZwdSwgMHgyLCBWUFVfVENNX0NGRyk7DQo+ICANCj4gLQl2cHUtPmVuYWJs
ZV80R0IgPSAhISh0b3RhbHJhbV9wYWdlcyA+IChTWl8yRyA+PiBQQUdFX1NISUZUKSk7DQo+ICsJ
dnB1LT5lbmFibGVfNEdCID0gISEoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4N
Cj4gKwkJCQkJKFNaXzJHID4+IFBBR0VfU0hJRlQpKTsNCj4gIAlkZXZfaW5mbyhkZXYsICI0R0Ig
bW9kZSAldVxuIiwgdnB1LT5lbmFibGVfNEdCKTsNCj4gIA0KPiAgCWlmICh2cHUtPmVuYWJsZV80
R0IpIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jIGIvZHJpdmVy
cy9taXNjL3Ztd19iYWxsb29uLmMNCj4gaW5kZXggOWIwYjNmYS4uMGFjMGZlZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL3Zt
d19iYWxsb29uLmMNCj4gQEAgLTU3MCw3ICs1NzAsNyBAQCBzdGF0aWMgaW50IHZtYmFsbG9vbl9z
ZW5kX2dldF90YXJnZXQoc3RydWN0IHZtYmFsbG9vbiAqYikNCj4gIAl1bnNpZ25lZCBsb25nIHN0
YXR1czsNCj4gIAl1bnNpZ25lZCBsb25nIGxpbWl0Ow0KPiAgDQo+IC0JbGltaXQgPSB0b3RhbHJh
bV9wYWdlczsNCj4gKwlsaW1pdCA9IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKTsN
Cj4gIA0KPiAgCS8qIEVuc3VyZSBsaW1pdCBmaXRzIGluIDMyLWJpdHMgKi8NCj4gIAlpZiAobGlt
aXQgIT0gKHUzMilsaW1pdCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGFyaXNjL2NjaW8tZG1h
LmMgYi9kcml2ZXJzL3BhcmlzYy9jY2lvLWRtYS5jDQo+IGluZGV4IDYxNDgyMzYuLjcwNWRmMWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGFyaXNjL2NjaW8tZG1hLmMNCj4gKysrIGIvZHJpdmVy
cy9wYXJpc2MvY2Npby1kbWEuYw0KPiBAQCAtMTI1NSw3ICsxMjU1LDggQEAgdm9pZCBfX2luaXQg
Y2Npb19jdWpvMjBfZml4dXAoc3RydWN0IHBhcmlzY19kZXZpY2UgKmN1am8sIHUzMiBpb3ZwKQ0K
PiAgCSoqIEhvdC1QbHVnL1JlbW92YWwgb2YgUENJIGNhcmRzLiAoYWthIFBDSSBPTEFSRCkuDQo+
ICAJKi8NCj4gIA0KPiAtCWlvdmFfc3BhY2Vfc2l6ZSA9ICh1MzIpICh0b3RhbHJhbV9wYWdlcyAv
IGNvdW50X3BhcmlzY19kcml2ZXIoJmNjaW9fZHJpdmVyKSk7DQo+ICsJaW92YV9zcGFjZV9zaXpl
ID0gKHUzMikgKGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAvDQo+ICsJCQkJY291
bnRfcGFyaXNjX2RyaXZlcigmY2Npb19kcml2ZXIpKTsNCj4gIA0KPiAgCS8qIGxpbWl0IElPVkEg
c3BhY2Ugc2l6ZSB0byAxTUItMUdCICovDQo+ICANCj4gQEAgLTEyOTQsNyArMTI5NSw3IEBAIHZv
aWQgX19pbml0IGNjaW9fY3VqbzIwX2ZpeHVwKHN0cnVjdCBwYXJpc2NfZGV2aWNlICpjdWpvLCB1
MzIgaW92cCkNCj4gIA0KPiAgCURCR19JTklUKCIlcygpIGhwYSAweCVwIG1lbSAlbHVNQiBJT1Yg
JWRNQiAoJWQgYml0cylcbiIsDQo+ICAJCQlfX2Z1bmNfXywgaW9jLT5pb2NfcmVncywNCj4gLQkJ
CSh1bnNpZ25lZCBsb25nKSB0b3RhbHJhbV9wYWdlcyA+PiAoMjAgLSBQQUdFX1NISUZUKSwNCj4g
KwkJCSh1bnNpZ25lZCBsb25nKSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPj4g
KDIwIC0gUEFHRV9TSElGVCksDQo+ICAJCQlpb3ZhX3NwYWNlX3NpemU+PjIwLA0KPiAgCQkJaW92
X29yZGVyICsgUEFHRV9TSElGVCk7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGFyaXNj
L3NiYV9pb21tdS5jIGIvZHJpdmVycy9wYXJpc2Mvc2JhX2lvbW11LmMNCj4gaW5kZXggMTFkZTBl
Yy4uMDJmNGNlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wYXJpc2Mvc2JhX2lvbW11LmMNCj4g
KysrIGIvZHJpdmVycy9wYXJpc2Mvc2JhX2lvbW11LmMNCj4gQEAgLTE0MTksNyArMTQxOSw4IEBA
IHN0YXRpYyBpbnQgc2V0dXBfaWJhc2VfaW1hc2tfY2FsbGJhY2soc3RydWN0IGRldmljZSAqZGV2
LCB2b2lkICpkYXRhKQ0KPiAgCSoqIGZvciBETUEgaGludHMgLSBlcmdvIG9ubHkgMzAgYml0cyBt
YXguDQo+ICAJKi8NCj4gIA0KPiAtCWlvdmFfc3BhY2Vfc2l6ZSA9ICh1MzIpICh0b3RhbHJhbV9w
YWdlcy9nbG9iYWxfaW9jX2NudCk7DQo+ICsJaW92YV9zcGFjZV9zaXplID0gKHUzMikgKGF0b21p
Y19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKS8NCj4gKwkJCQkJCWdsb2JhbF9pb2NfY250KTsN
Cj4gIA0KPiAgCS8qIGxpbWl0IElPVkEgc3BhY2Ugc2l6ZSB0byAxTUItMUdCICovDQo+ICAJaWYg
KGlvdmFfc3BhY2Vfc2l6ZSA8ICgxIDw8ICgyMCAtIFBBR0VfU0hJRlQpKSkgew0KPiBAQCAtMTQ0
NCw3ICsxNDQ1LDcgQEAgc3RhdGljIGludCBzZXR1cF9pYmFzZV9pbWFza19jYWxsYmFjayhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+ICAJREJHX0lOSVQoIiVzKCkgaHBhIDB4JWx4
IG1lbSAlbGRNQiBJT1YgJWRNQiAoJWQgYml0cylcbiIsDQo+ICAJCQlfX2Z1bmNfXywNCj4gIAkJ
CWlvYy0+aW9jX2hwYSwNCj4gLQkJCSh1bnNpZ25lZCBsb25nKSB0b3RhbHJhbV9wYWdlcyA+PiAo
MjAgLSBQQUdFX1NISUZUKSwNCj4gKwkJCSh1bnNpZ25lZCBsb25nKSBhdG9taWNfbG9uZ19yZWFk
KCZ0b3RhbHJhbV9wYWdlcykgPj4gKDIwIC0gUEFHRV9TSElGVCksDQo+ICAJCQlpb3ZhX3NwYWNl
X3NpemU+PjIwLA0KPiAgCQkJaW92X29yZGVyICsgUEFHRV9TSElGVCk7DQo+ICANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb25fc3lzdGVtX2hlYXAuYyBiL2Ry
aXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb25fc3lzdGVtX2hlYXAuYw0KPiBpbmRleCA1NDhi
YjAyLi42NGJkOTI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9pb24v
aW9uX3N5c3RlbV9oZWFwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvaW9uL2lv
bl9zeXN0ZW1faGVhcC5jDQo+IEBAIC0xMTAsNyArMTEwLDcgQEAgc3RhdGljIGludCBpb25fc3lz
dGVtX2hlYXBfYWxsb2NhdGUoc3RydWN0IGlvbl9oZWFwICpoZWFwLA0KPiAgCXVuc2lnbmVkIGxv
bmcgc2l6ZV9yZW1haW5pbmcgPSBQQUdFX0FMSUdOKHNpemUpOw0KPiAgCXVuc2lnbmVkIGludCBt
YXhfb3JkZXIgPSBvcmRlcnNbMF07DQo+ICANCj4gLQlpZiAoc2l6ZSAvIFBBR0VfU0laRSA+IHRv
dGFscmFtX3BhZ2VzIC8gMikNCj4gKwlpZiAoc2l6ZSAvIFBBR0VfU0laRSA+IGF0b21pY19sb25n
X3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAvIDIpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+
ICAJSU5JVF9MSVNUX0hFQUQoJnBhZ2VzKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hl
bi1zZWxmYmFsbG9vbi5jIGIvZHJpdmVycy94ZW4veGVuLXNlbGZiYWxsb29uLmMNCj4gaW5kZXgg
NTE2NWFhOC4uMGI5MjVmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4veGVuLXNlbGZiYWxs
b29uLmMNCj4gKysrIGIvZHJpdmVycy94ZW4veGVuLXNlbGZiYWxsb29uLmMNCj4gQEAgLTE4OSw3
ICsxODksNyBAQCBzdGF0aWMgdm9pZCBzZWxmYmFsbG9vbl9wcm9jZXNzKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCj4gIAlib29sIHJlc2V0X3RpbWVyID0gZmFsc2U7DQo+ICANCj4gIAlpZiAo
eGVuX3NlbGZiYWxsb29uaW5nX2VuYWJsZWQpIHsNCj4gLQkJY3VyX3BhZ2VzID0gdG90YWxyYW1f
cGFnZXM7DQo+ICsJCWN1cl9wYWdlcyA9IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2Vz
KTsNCj4gIAkJdGd0X3BhZ2VzID0gY3VyX3BhZ2VzOyAvKiBkZWZhdWx0IGlzIG5vIGNoYW5nZSAq
Lw0KPiAgCQlnb2FsX3BhZ2VzID0gdm1fbWVtb3J5X2NvbW1pdHRlZCgpICsNCj4gIAkJCQl0b3Rh
bHJlc2VydmVfcGFnZXMgKw0KPiBAQCAtMjI3LDcgKzIyNyw4IEBAIHN0YXRpYyB2b2lkIHNlbGZi
YWxsb29uX3Byb2Nlc3Moc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCQlpZiAodGd0X3Bh
Z2VzIDwgZmxvb3JfcGFnZXMpDQo+ICAJCQl0Z3RfcGFnZXMgPSBmbG9vcl9wYWdlczsNCj4gIAkJ
YmFsbG9vbl9zZXRfbmV3X3RhcmdldCh0Z3RfcGFnZXMgKw0KPiAtCQkJYmFsbG9vbl9zdGF0cy5j
dXJyZW50X3BhZ2VzIC0gdG90YWxyYW1fcGFnZXMpOw0KPiArCQkJYmFsbG9vbl9zdGF0cy5jdXJy
ZW50X3BhZ2VzIC0NCj4gKwkJCWF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSk7DQo+
ICAJCXJlc2V0X3RpbWVyID0gdHJ1ZTsNCj4gIAl9DQo+ICAjaWZkZWYgQ09ORklHX0ZST05UU1dB
UA0KPiBAQCAtNTY5LDcgKzU3MCw3IEBAIGludCB4ZW5fc2VsZmJhbGxvb25faW5pdChib29sIHVz
ZV9zZWxmYmFsbG9vbmluZywgYm9vbCB1c2VfZnJvbnRzd2FwX3NlbGZzaHJpbmspDQo+ICAJICog
bXVjaCBtb3JlIHJlbGlhYmx5IGFuZCByZXNwb25zZSBmYXN0ZXIgaW4gc29tZSBjYXNlcy4NCj4g
IAkgKi8NCj4gIAlpZiAoIXNlbGZiYWxsb29uX3Jlc2VydmVkX21iKSB7DQo+IC0JCXJlc2VydmVf
cGFnZXMgPSB0b3RhbHJhbV9wYWdlcyAvIDEwOw0KPiArCQlyZXNlcnZlX3BhZ2VzID0gYXRvbWlj
X2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpIC8gMTA7DQo+ICAJCXNlbGZiYWxsb29uX3Jlc2Vy
dmVkX21iID0gUEFHRVMyTUIocmVzZXJ2ZV9wYWdlcyk7DQo+ICAJfQ0KPiAgCXNjaGVkdWxlX2Rl
bGF5ZWRfd29yaygmc2VsZmJhbGxvb25fd29ya2VyLCBzZWxmYmFsbG9vbl9pbnRlcnZhbCAqIEha
KTsNCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvc3VwZXIuaCBiL2ZzL2NlcGgvc3VwZXIuaA0KPiBp
bmRleCA1ODJlMjhmLi45MmY1NmQzIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL3N1cGVyLmgNCj4g
KysrIGIvZnMvY2VwaC9zdXBlci5oDQo+IEBAIC04MDcsNyArODA3LDggQEAgc3RhdGljIGlubGlu
ZSBpbnQgZGVmYXVsdF9jb25nZXN0aW9uX2tiKHZvaWQpDQo+ICAJICogVGhpcyBhbGxvd3MgbGFy
Z2VyIG1hY2hpbmVzIHRvIGhhdmUgbGFyZ2VyL21vcmUgdHJhbnNmZXJzLg0KPiAgCSAqIExpbWl0
IHRoZSBkZWZhdWx0IHRvIDI1Nk0NCj4gIAkgKi8NCj4gLQljb25nZXN0aW9uX2tiID0gKDE2Kmlu
dF9zcXJ0KHRvdGFscmFtX3BhZ2VzKSkgPDwgKFBBR0VfU0hJRlQtMTApOw0KPiArCWNvbmdlc3Rp
b25fa2IgPSAoMTYqaW50X3NxcnQoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpKSkg
PDwNCj4gKwkJCQkJCQkJKFBBR0VfU0hJRlQtMTApOw0KPiAgCWlmIChjb25nZXN0aW9uX2tiID4g
MjU2KjEwMjQpDQo+ICAJCWNvbmdlc3Rpb25fa2IgPSAyNTYqMTAyNDsNCj4gIA0KPiBkaWZmIC0t
Z2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmlsZV90YWJsZS5jDQo+IGluZGV4IGUwM2M4ZDEu
LjVkZGU1YzMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2ZpbGVfdGFibGUuYw0KPiArKysgYi9mcy9maWxl
X3RhYmxlLmMNCj4gQEAgLTM4MywxMCArMzgzLDEzIEBAIHZvaWQgX19pbml0IGZpbGVzX2luaXQo
dm9pZCkNCj4gIHZvaWQgX19pbml0IGZpbGVzX21heGZpbGVzX2luaXQodm9pZCkNCj4gIHsNCj4g
IAl1bnNpZ25lZCBsb25nIG47DQo+IC0JdW5zaWduZWQgbG9uZyBtZW1yZXNlcnZlID0gKHRvdGFs
cmFtX3BhZ2VzIC0gbnJfZnJlZV9wYWdlcygpKSAqIDMvMjsNCj4gKwl1bnNpZ25lZCBsb25nIG1l
bXJlc2VydmUgPSAoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpIC0NCj4gKwkJCQkJ
CW5yX2ZyZWVfcGFnZXMoKSkgKiAzLzI7DQo+ICANCj4gLQltZW1yZXNlcnZlID0gbWluKG1lbXJl
c2VydmUsIHRvdGFscmFtX3BhZ2VzIC0gMSk7DQo+IC0JbiA9ICgodG90YWxyYW1fcGFnZXMgLSBt
ZW1yZXNlcnZlKSAqIChQQUdFX1NJWkUgLyAxMDI0KSkgLyAxMDsNCj4gKwltZW1yZXNlcnZlID0g
bWluKG1lbXJlc2VydmUsDQo+ICsJCQkodW5zaWduZWQgbG9uZylhdG9taWNfbG9uZ19yZWFkKCZ0
b3RhbHJhbV9wYWdlcykgLSAxKTsNCj4gKwluID0gKChhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJh
bV9wYWdlcykgLSBtZW1yZXNlcnZlKSAqDQo+ICsJCQkJCShQQUdFX1NJWkUgLyAxMDI0KSkgLyAx
MDsNCj4gIA0KPiAgCWZpbGVzX3N0YXQubWF4X2ZpbGVzID0gbWF4X3QodW5zaWduZWQgbG9uZywg
biwgTlJfRklMRSk7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9mcy9mdXNlL2lub2RlLmMgYi9mcy9m
dXNlL2lub2RlLmMNCj4gaW5kZXggNDcyN2VmNi4uYWNkYmFmNyAxMDA2NDQNCj4gLS0tIGEvZnMv
ZnVzZS9pbm9kZS5jDQo+ICsrKyBiL2ZzL2Z1c2UvaW5vZGUuYw0KPiBAQCAtODI1LDggKzgyNSw4
IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpmdXNlX2dldF9wYXJlbnQoc3RydWN0IGRlbnRyeSAq
Y2hpbGQpDQo+ICBzdGF0aWMgdm9pZCBzYW5pdGl6ZV9nbG9iYWxfbGltaXQodW5zaWduZWQgKmxp
bWl0KQ0KPiAgew0KPiAgCWlmICgqbGltaXQgPT0gMCkNCj4gLQkJKmxpbWl0ID0gKCh0b3RhbHJh
bV9wYWdlcyA8PCBQQUdFX1NISUZUKSA+PiAxMykgLw0KPiAtCQkJIHNpemVvZihzdHJ1Y3QgZnVz
ZV9yZXEpOw0KPiArCQkqbGltaXQgPSAoKGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2Vz
KQ0KPiArCQkJIDw8IFBBR0VfU0hJRlQpID4+IDEzKSAvIHNpemVvZihzdHJ1Y3QgZnVzZV9yZXEp
Ow0KPiAgDQo+ICAJaWYgKCpsaW1pdCA+PSAxIDw8IDE2KQ0KPiAgCQkqbGltaXQgPSAoMSA8PCAx
NikgLSAxOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUuYw0K
PiBpbmRleCA1ODY3MjZhLi5lMzY2M2I3IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvd3JpdGUuYw0K
PiArKysgYi9mcy9uZnMvd3JpdGUuYw0KPiBAQCAtMjEyMSw3ICsyMTIxLDggQEAgaW50IF9faW5p
dCBuZnNfaW5pdF93cml0ZXBhZ2VjYWNoZSh2b2lkKQ0KPiAgCSAqIFRoaXMgYWxsb3dzIGxhcmdl
ciBtYWNoaW5lcyB0byBoYXZlIGxhcmdlci9tb3JlIHRyYW5zZmVycy4NCj4gIAkgKiBMaW1pdCB0
aGUgZGVmYXVsdCB0byAyNTZNDQo+ICAJICovDQo+IC0JbmZzX2Nvbmdlc3Rpb25fa2IgPSAoMTYq
aW50X3NxcnQodG90YWxyYW1fcGFnZXMpKSA8PCAoUEFHRV9TSElGVC0xMCk7DQo+ICsJbmZzX2Nv
bmdlc3Rpb25fa2IgPSAoMTYqaW50X3NxcnQoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFn
ZXMpKSkgPDwNCj4gKwkJCQkJCQkJKFBBR0VfU0hJRlQtMTApOw0KPiAgCWlmIChuZnNfY29uZ2Vz
dGlvbl9rYiA+IDI1NioxMDI0KQ0KPiAgCQluZnNfY29uZ2VzdGlvbl9rYiA9IDI1NioxMDI0Ow0K
PiAgDQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mc2NhY2hlLmMgYi9mcy9uZnNkL25mc2NhY2hl
LmMNCj4gaW5kZXggZTJmZTBlOS4uZTg3NzU1OCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnNj
YWNoZS5jDQo+ICsrKyBiL2ZzL25mc2QvbmZzY2FjaGUuYw0KPiBAQCAtOTksNyArOTksOCBAQCBz
dGF0aWMgdW5zaWduZWQgbG9uZyBuZnNkX3JlcGx5X2NhY2hlX3NjYW4oc3RydWN0IHNocmlua2Vy
ICpzaHJpbmssDQo+ICBuZnNkX2NhY2hlX3NpemVfbGltaXQodm9pZCkNCj4gIHsNCj4gIAl1bnNp
Z25lZCBpbnQgbGltaXQ7DQo+IC0JdW5zaWduZWQgbG9uZyBsb3dfcGFnZXMgPSB0b3RhbHJhbV9w
YWdlcyAtIHRvdGFsaGlnaF9wYWdlczsNCj4gKwl1bnNpZ25lZCBsb25nIGxvd19wYWdlcyA9IGF0
b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAtDQo+ICsJCQkJCWF0b21pY19sb25nX3Jl
YWQoJnRvdGFsaGlnaF9wYWdlcyk7DQo+ICANCj4gIAlsaW1pdCA9ICgxNiAqIGludF9zcXJ0KGxv
d19wYWdlcykpIDw8IChQQUdFX1NISUZULTEwKTsNCj4gIAlyZXR1cm4gbWluX3QodW5zaWduZWQg
aW50LCBsaW1pdCwgMjU2KjEwMjQpOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbnRmcy9tYWxsb2MuaCBi
L2ZzL250ZnMvbWFsbG9jLmgNCj4gaW5kZXggYWIxNzJlNS4uNGFlNmJiZSAxMDA2NDQNCj4gLS0t
IGEvZnMvbnRmcy9tYWxsb2MuaA0KPiArKysgYi9mcy9udGZzL21hbGxvYy5oDQo+IEBAIC00Nyw3
ICs0Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqX19udGZzX21hbGxvYyh1bnNpZ25lZCBsb25n
IHNpemUsIGdmcF90IGdmcF9tYXNrKQ0KPiAgCQlyZXR1cm4ga21hbGxvYyhQQUdFX1NJWkUsIGdm
cF9tYXNrICYgfl9fR0ZQX0hJR0hNRU0pOw0KPiAgCQkvKiByZXR1cm4gKHZvaWQgKilfX2dldF9m
cmVlX3BhZ2UoZ2ZwX21hc2spOyAqLw0KPiAgCX0NCj4gLQlpZiAobGlrZWx5KChzaXplID4+IFBB
R0VfU0hJRlQpIDwgdG90YWxyYW1fcGFnZXMpKQ0KPiArCWlmIChsaWtlbHkoKHNpemUgPj4gUEFH
RV9TSElGVCkgPCBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykpKQ0KPiAgCQlyZXR1
cm4gX192bWFsbG9jKHNpemUsIGdmcF9tYXNrLCBQQUdFX0tFUk5FTCk7DQo+ICAJcmV0dXJuIE5V
TEw7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9mcy9wcm9jL2Jhc2UuYyBiL2ZzL3Byb2MvYmFzZS5j
DQo+IGluZGV4IGNlMzQ2NTQuLjllZjI2ZGMgMTAwNjQ0DQo+IC0tLSBhL2ZzL3Byb2MvYmFzZS5j
DQo+ICsrKyBiL2ZzL3Byb2MvYmFzZS5jDQo+IEBAIC01MzAsNyArNTMwLDggQEAgc3RhdGljIHNz
aXplX3QgbHN0YXRzX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAq
YnVmLA0KPiAgc3RhdGljIGludCBwcm9jX29vbV9zY29yZShzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0
cnVjdCBwaWRfbmFtZXNwYWNlICpucywNCj4gIAkJCSAgc3RydWN0IHBpZCAqcGlkLCBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRhc2spDQo+ICB7DQo+IC0JdW5zaWduZWQgbG9uZyB0b3RhbHBhZ2VzID0g
dG90YWxyYW1fcGFnZXMgKyB0b3RhbF9zd2FwX3BhZ2VzOw0KPiArCXVuc2lnbmVkIGxvbmcgdG90
YWxwYWdlcyA9IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSArDQo+ICsJCQkJCQkJ
dG90YWxfc3dhcF9wYWdlczsNCj4gIAl1bnNpZ25lZCBsb25nIHBvaW50cyA9IDA7DQo+ICANCj4g
IAlwb2ludHMgPSBvb21fYmFkbmVzcyh0YXNrLCBOVUxMLCBOVUxMLCB0b3RhbHBhZ2VzKSAqDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2hpZ2htZW0uaCBiL2luY2x1ZGUvbGludXgvaGln
aG1lbS5oDQo+IGluZGV4IDA2OTA2NzkuLjg0ZWRhYTIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvaGlnaG1lbS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvaGlnaG1lbS5oDQo+IEBAIC0z
Niw3ICszNiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpbnZhbGlkYXRlX2tlcm5lbF92bWFwX3Jh
bmdlKHZvaWQgKnZhZGRyLCBpbnQgc2l6ZSkNCj4gIA0KPiAgLyogZGVjbGFyYXRpb25zIGZvciBs
aW51eC9tbS9oaWdobWVtLmMgKi8NCj4gIHVuc2lnbmVkIGludCBucl9mcmVlX2hpZ2hwYWdlcyh2
b2lkKTsNCj4gLWV4dGVybiB1bnNpZ25lZCBsb25nIHRvdGFsaGlnaF9wYWdlczsNCj4gK2V4dGVy
biBhdG9taWNfbG9uZ190IHRvdGFsaGlnaF9wYWdlczsNCj4gIA0KPiAgdm9pZCBrbWFwX2ZsdXNo
X3VudXNlZCh2b2lkKTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIv
aW5jbHVkZS9saW51eC9tbS5oDQo+IGluZGV4IGZjZjljYzkuLmFmOTUyZmMgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gQEAg
LTQ4LDcgKzQ4LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHNldF9tYXhfbWFwbnIodW5zaWduZWQg
bG9uZyBsaW1pdCkNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfbWF4X21hcG5yKHVuc2lnbmVk
IGxvbmcgbGltaXQpIHsgfQ0KPiAgI2VuZGlmDQo+ICANCj4gLWV4dGVybiB1bnNpZ25lZCBsb25n
IHRvdGFscmFtX3BhZ2VzOw0KPiArZXh0ZXJuIGF0b21pY19sb25nX3QgdG90YWxyYW1fcGFnZXM7
DQo+ICBleHRlcm4gdm9pZCAqIGhpZ2hfbWVtb3J5Ow0KPiAgZXh0ZXJuIGludCBwYWdlX2NsdXN0
ZXI7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW16b25lLmggYi9pbmNsdWRl
L2xpbnV4L21tem9uZS5oDQo+IGluZGV4IDg1NTU1MDkuLjI2MzliMDUgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvbW16b25lLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tbXpvbmUuaA0K
PiBAQCAtNDI4LDE0ICs0MjgsOCBAQCBzdHJ1Y3Qgem9uZSB7DQo+ICAJICogV3JpdGUgYWNjZXNz
IHRvIHByZXNlbnRfcGFnZXMgYXQgcnVudGltZSBzaG91bGQgYmUgcHJvdGVjdGVkIGJ5DQo+ICAJ
ICogbWVtX2hvdHBsdWdfYmVnaW4vZW5kKCkuIEFueSByZWFkZXIgd2hvIGNhbid0IHRvbGVyYW50
IGRyaWZ0IG9mDQo+ICAJICogcHJlc2VudF9wYWdlcyBzaG91bGQgZ2V0X29ubGluZV9tZW1zKCkg
dG8gZ2V0IGEgc3RhYmxlIHZhbHVlLg0KPiAtCSAqDQo+IC0JICogUmVhZCBhY2Nlc3MgdG8gbWFu
YWdlZF9wYWdlcyBzaG91bGQgYmUgc2FmZSBiZWNhdXNlIGl0J3MgdW5zaWduZWQNCj4gLQkgKiBs
b25nLiBXcml0ZSBhY2Nlc3MgdG8gem9uZS0+bWFuYWdlZF9wYWdlcyBhbmQgdG90YWxyYW1fcGFn
ZXMgYXJlDQo+IC0JICogcHJvdGVjdGVkIGJ5IG1hbmFnZWRfcGFnZV9jb3VudF9sb2NrIGF0IHJ1
bnRpbWUuIElkZWFseSBvbmx5DQo+IC0JICogYWRqdXN0X21hbmFnZWRfcGFnZV9jb3VudCgpIHNo
b3VsZCBiZSB1c2VkIGluc3RlYWQgb2YgZGlyZWN0bHkNCj4gLQkgKiB0b3VjaGluZyB6b25lLT5t
YW5hZ2VkX3BhZ2VzIGFuZCB0b3RhbHJhbV9wYWdlcy4NCj4gIAkgKi8NCj4gLQl1bnNpZ25lZCBs
b25nCQltYW5hZ2VkX3BhZ2VzOw0KPiArCWF0b21pY19sb25nX3QJCW1hbmFnZWRfcGFnZXM7DQo+
ICAJdW5zaWduZWQgbG9uZwkJc3Bhbm5lZF9wYWdlczsNCj4gIAl1bnNpZ25lZCBsb25nCQlwcmVz
ZW50X3BhZ2VzOw0KPiAgDQo+IEBAIC04MTQsNyArODA4LDcgQEAgc3RhdGljIGlubGluZSBib29s
IGlzX2Rldl96b25lKGNvbnN0IHN0cnVjdCB6b25lICp6b25lKQ0KPiAgICovDQo+ICBzdGF0aWMg
aW5saW5lIGJvb2wgbWFuYWdlZF96b25lKHN0cnVjdCB6b25lICp6b25lKQ0KPiAgew0KPiAtCXJl
dHVybiB6b25lLT5tYW5hZ2VkX3BhZ2VzOw0KPiArCXJldHVybiBhdG9taWNfbG9uZ19yZWFkKCZ6
b25lLT5tYW5hZ2VkX3BhZ2VzKTsNCj4gIH0NCj4gIA0KPiAgLyogUmV0dXJucyB0cnVlIGlmIGEg
em9uZSBoYXMgbWVtb3J5ICovDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N3YXAuaCBi
L2luY2x1ZGUvbGludXgvc3dhcC5oDQo+IGluZGV4IGQwOTg3NDMuLmIzNGM2ZTcgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvc3dhcC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3dhcC5o
DQo+IEBAIC0zMDksNyArMzA5LDcgQEAgc3RydWN0IHZtYV9zd2FwX3JlYWRhaGVhZCB7DQo+ICB9
IHdoaWxlICgwKQ0KPiAgDQo+ICAvKiBsaW51eC9tbS9wYWdlX2FsbG9jLmMgKi8NCj4gLWV4dGVy
biB1bnNpZ25lZCBsb25nIHRvdGFscmFtX3BhZ2VzOw0KPiArZXh0ZXJuIGF0b21pY19sb25nX3Qg
dG90YWxyYW1fcGFnZXM7DQo+ICBleHRlcm4gdW5zaWduZWQgbG9uZyB0b3RhbHJlc2VydmVfcGFn
ZXM7DQo+ICBleHRlcm4gdW5zaWduZWQgbG9uZyBucl9mcmVlX2J1ZmZlcl9wYWdlcyh2b2lkKTsN
Cj4gIGV4dGVybiB1bnNpZ25lZCBsb25nIG5yX2ZyZWVfcGFnZWNhY2hlX3BhZ2VzKHZvaWQpOw0K
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMNCj4gaW5kZXggMmY3
OGQzMi4uYjYwNjhjNSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2ZvcmsuYw0KPiArKysgYi9rZXJu
ZWwvZm9yay5jDQo+IEBAIC03NDQsMTEgKzc0NCwxMSBAQCBzdGF0aWMgdm9pZCBzZXRfbWF4X3Ro
cmVhZHModW5zaWduZWQgaW50IG1heF90aHJlYWRzX3N1Z2dlc3RlZCkNCj4gIAkgKiBUaGUgbnVt
YmVyIG9mIHRocmVhZHMgc2hhbGwgYmUgbGltaXRlZCBzdWNoIHRoYXQgdGhlIHRocmVhZA0KPiAg
CSAqIHN0cnVjdHVyZXMgbWF5IG9ubHkgY29uc3VtZSBhIHNtYWxsIHBhcnQgb2YgdGhlIGF2YWls
YWJsZSBtZW1vcnkuDQo+ICAJICovDQo+IC0JaWYgKGZsczY0KHRvdGFscmFtX3BhZ2VzKSArIGZs
czY0KFBBR0VfU0laRSkgPiA2NCkNCj4gKwlpZiAoZmxzNjQoYXRvbWljX2xvbmdfcmVhZCgmdG90
YWxyYW1fcGFnZXMpKSArIGZsczY0KFBBR0VfU0laRSkgPiA2NCkNCj4gIAkJdGhyZWFkcyA9IE1B
WF9USFJFQURTOw0KPiAgCWVsc2UNCj4gLQkJdGhyZWFkcyA9IGRpdjY0X3U2NCgodTY0KSB0b3Rh
bHJhbV9wYWdlcyAqICh1NjQpIFBBR0VfU0laRSwNCj4gLQkJCQkgICAgKHU2NCkgVEhSRUFEX1NJ
WkUgKiA4VUwpOw0KPiArCQl0aHJlYWRzID0gZGl2NjRfdTY0KCh1NjQpIGF0b21pY19sb25nX3Jl
YWQoJnRvdGFscmFtX3BhZ2VzKSAqDQo+ICsJCQkJKHU2NCkgUEFHRV9TSVpFLCAodTY0KSBUSFJF
QURfU0laRSAqIDhVTCk7DQo+ICANCj4gIAlpZiAodGhyZWFkcyA+IG1heF90aHJlYWRzX3N1Z2dl
c3RlZCkNCj4gIAkJdGhyZWFkcyA9IG1heF90aHJlYWRzX3N1Z2dlc3RlZDsNCj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9rZXhlY19jb3JlLmMgYi9rZXJuZWwva2V4ZWNfY29yZS5jDQo+IGluZGV4IDg2
ZWYwNmQuLmVkODVkZGQgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9rZXhlY19jb3JlLmMNCj4gKysr
IGIva2VybmVsL2tleGVjX2NvcmUuYw0KPiBAQCAtMjE3LDEzICsyMTcsMTQgQEAgaW50IHNhbml0
eV9jaGVja19zZWdtZW50X2xpc3Qoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQo+ICAJICogd2FzdGVk
IGFsbG9jYXRpbmcgcGFnZXMsIHdoaWNoIGNhbiBjYXVzZSBhIHNvZnQgbG9ja3VwLg0KPiAgCSAq
Lw0KPiAgCWZvciAoaSA9IDA7IGkgPCBucl9zZWdtZW50czsgaSsrKSB7DQo+IC0JCWlmIChQQUdF
X0NPVU5UKGltYWdlLT5zZWdtZW50W2ldLm1lbXN6KSA+IHRvdGFscmFtX3BhZ2VzIC8gMikNCj4g
KwkJaWYgKFBBR0VfQ09VTlQoaW1hZ2UtPnNlZ21lbnRbaV0ubWVtc3opID4NCj4gKwkJCQlhdG9t
aWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgLyAyKQ0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7
DQo+ICANCj4gIAkJdG90YWxfcGFnZXMgKz0gUEFHRV9DT1VOVChpbWFnZS0+c2VnbWVudFtpXS5t
ZW1zeik7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKHRvdGFsX3BhZ2VzID4gdG90YWxyYW1fcGFnZXMg
LyAyKQ0KPiArCWlmICh0b3RhbF9wYWdlcyA+IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3Bh
Z2VzKSAvIDIpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+ICAJLyoNCj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9wb3dlci9zbmFwc2hvdC5jIGIva2VybmVsL3Bvd2VyL3NuYXBzaG90LmMNCj4g
aW5kZXggYjAzMDhhMi4uMTQyYTNjNzYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9wb3dlci9zbmFw
c2hvdC5jDQo+ICsrKyBiL2tlcm5lbC9wb3dlci9zbmFwc2hvdC5jDQo+IEBAIC0xMDUsNyArMTA1
LDcgQEAgdm9pZCBfX2luaXQgaGliZXJuYXRlX3Jlc2VydmVkX3NpemVfaW5pdCh2b2lkKQ0KPiAg
DQo+ICB2b2lkIF9faW5pdCBoaWJlcm5hdGVfaW1hZ2Vfc2l6ZV9pbml0KHZvaWQpDQo+ICB7DQo+
IC0JaW1hZ2Vfc2l6ZSA9ICgodG90YWxyYW1fcGFnZXMgKiAyKSAvIDUpICogUEFHRV9TSVpFOw0K
PiArCWltYWdlX3NpemUgPSAoKGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAqIDIp
IC8gNSkgKiBQQUdFX1NJWkU7DQo+ICB9DQo+ICANCj4gIC8qDQo+IGRpZmYgLS1naXQgYS9saWIv
c2hvd19tZW0uYyBiL2xpYi9zaG93X21lbS5jDQo+IGluZGV4IDBiZWFhMWQuLjA3MDFmNjMgMTAw
NjQ0DQo+IC0tLSBhL2xpYi9zaG93X21lbS5jDQo+ICsrKyBiL2xpYi9zaG93X21lbS5jDQo+IEBA
IC0yOCw3ICsyOCw4IEBAIHZvaWQgc2hvd19tZW0odW5zaWduZWQgaW50IGZpbHRlciwgbm9kZW1h
c2tfdCAqbm9kZW1hc2spDQo+ICAJCQkJY29udGludWU7DQo+ICANCj4gIAkJCXRvdGFsICs9IHpv
bmUtPnByZXNlbnRfcGFnZXM7DQo+IC0JCQlyZXNlcnZlZCArPSB6b25lLT5wcmVzZW50X3BhZ2Vz
IC0gem9uZS0+bWFuYWdlZF9wYWdlczsNCj4gKwkJCXJlc2VydmVkICs9IHpvbmUtPnByZXNlbnRf
cGFnZXMgLQ0KPiArCQkJCWF0b21pY19sb25nX3JlYWQoJnpvbmUtPm1hbmFnZWRfcGFnZXMpOw0K
PiAgDQo+ICAJCQlpZiAoaXNfaGlnaG1lbV9pZHgoem9uZWlkKSkNCj4gIAkJCQloaWdobWVtICs9
IHpvbmUtPnByZXNlbnRfcGFnZXM7DQo+IGRpZmYgLS1naXQgYS9tbS9oaWdobWVtLmMgYi9tbS9o
aWdobWVtLmMNCj4gaW5kZXggNTlkYjMyMi4uOTNhNDVjMCAxMDA2NDQNCj4gLS0tIGEvbW0vaGln
aG1lbS5jDQo+ICsrKyBiL21tL2hpZ2htZW0uYw0KPiBAQCAtMTA1LDcgKzEwNSw3IEBAIHN0YXRp
YyBpbmxpbmUgd2FpdF9xdWV1ZV9oZWFkX3QgKmdldF9wa21hcF93YWl0X3F1ZXVlX2hlYWQodW5z
aWduZWQgaW50IGNvbG9yKQ0KPiAgfQ0KPiAgI2VuZGlmDQo+ICANCj4gLXVuc2lnbmVkIGxvbmcg
dG90YWxoaWdoX3BhZ2VzIF9fcmVhZF9tb3N0bHk7DQo+ICthdG9taWNfbG9uZ190IHRvdGFsaGln
aF9wYWdlcyBfX3JlYWRfbW9zdGx5Ow0KPiAgRVhQT1JUX1NZTUJPTCh0b3RhbGhpZ2hfcGFnZXMp
Ow0KPiAgDQo+ICANCj4gZGlmZiAtLWdpdCBhL21tL2h1Z2VfbWVtb3J5LmMgYi9tbS9odWdlX21l
bW9yeS5jDQo+IGluZGV4IGQzOTRkMTguLmYyZjE4YjUgMTAwNjQ0DQo+IC0tLSBhL21tL2h1Z2Vf
bWVtb3J5LmMNCj4gKysrIGIvbW0vaHVnZV9tZW1vcnkuYw0KPiBAQCAtNDIwLDcgKzQyMCw3IEBA
IHN0YXRpYyBpbnQgX19pbml0IGh1Z2VwYWdlX2luaXQodm9pZCkNCj4gIAkgKiB3aGVyZSB0aGUg
ZXh0cmEgbWVtb3J5IHVzZWQgY291bGQgaHVydCBtb3JlIHRoYW4gVExCIG92ZXJoZWFkDQo+ICAJ
ICogaXMgbGlrZWx5IHRvIHNhdmUuICBUaGUgYWRtaW4gY2FuIHN0aWxsIGVuYWJsZSBpdCB0aHJv
dWdoIC9zeXMuDQo+ICAJICovDQo+IC0JaWYgKHRvdGFscmFtX3BhZ2VzIDwgKDUxMiA8PCAoMjAg
LSBQQUdFX1NISUZUKSkpIHsNCj4gKwlpZiAoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFn
ZXMpIDwgKDUxMiA8PCAoMjAgLSBQQUdFX1NISUZUKSkpIHsNCj4gIAkJdHJhbnNwYXJlbnRfaHVn
ZXBhZ2VfZmxhZ3MgPSAwOw0KPiAgCQlyZXR1cm4gMDsNCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9t
bS9rYXNhbi9xdWFyYW50aW5lLmMgYi9tbS9rYXNhbi9xdWFyYW50aW5lLmMNCj4gaW5kZXggYjIw
OWRiYS4uNGQzNmFlZCAxMDA2NDQNCj4gLS0tIGEvbW0va2FzYW4vcXVhcmFudGluZS5jDQo+ICsr
KyBiL21tL2thc2FuL3F1YXJhbnRpbmUuYw0KPiBAQCAtMjM2LDggKzIzNiw4IEBAIHZvaWQgcXVh
cmFudGluZV9yZWR1Y2Uodm9pZCkNCj4gIAkgKiBVcGRhdGUgcXVhcmFudGluZSBzaXplIGluIGNh
c2Ugb2YgaG90cGx1Zy4gQWxsb2NhdGUgYSBmcmFjdGlvbiBvZg0KPiAgCSAqIHRoZSBpbnN0YWxs
ZWQgbWVtb3J5IHRvIHF1YXJhbnRpbmUgbWludXMgcGVyLWNwdSBxdWV1ZSBsaW1pdHMuDQo+ICAJ
ICovDQo+IC0JdG90YWxfc2l6ZSA9IChSRUFEX09OQ0UodG90YWxyYW1fcGFnZXMpIDw8IFBBR0Vf
U0hJRlQpIC8NCj4gLQkJUVVBUkFOVElORV9GUkFDVElPTjsNCj4gKwl0b3RhbF9zaXplID0gKFJF
QURfT05DRShhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykpIDw8DQo+ICsJCQlQQUdF
X1NISUZUKSAvIFFVQVJBTlRJTkVfRlJBQ1RJT047DQo+ICAJcGVyY3B1X3F1YXJhbnRpbmVzID0g
UVVBUkFOVElORV9QRVJDUFVfU0laRSAqIG51bV9vbmxpbmVfY3B1cygpOw0KPiAgCW5ld19xdWFy
YW50aW5lX3NpemUgPSAodG90YWxfc2l6ZSA8IHBlcmNwdV9xdWFyYW50aW5lcykgPw0KPiAgCQkw
IDogdG90YWxfc2l6ZSAtIHBlcmNwdV9xdWFyYW50aW5lczsNCj4gZGlmZiAtLWdpdCBhL21tL21l
bWJsb2NrLmMgYi9tbS9tZW1ibG9jay5jDQo+IGluZGV4IGVkZGNhYzIuLjQzZjUzZTkgMTAwNjQ0
DQo+IC0tLSBhL21tL21lbWJsb2NrLmMNCj4gKysrIGIvbW0vbWVtYmxvY2suYw0KPiBAQCAtMTYy
Nyw3ICsxNjI3LDcgQEAgdm9pZCBfX2luaXQgX19tZW1ibG9ja19mcmVlX2xhdGUocGh5c19hZGRy
X3QgYmFzZSwgcGh5c19hZGRyX3Qgc2l6ZSkNCj4gIA0KPiAgCWZvciAoOyBjdXJzb3IgPCBlbmQ7
IGN1cnNvcisrKSB7DQo+ICAJCW1lbWJsb2NrX2ZyZWVfcGFnZXMocGZuX3RvX3BhZ2UoY3Vyc29y
KSwgY3Vyc29yLCAwKTsNCj4gLQkJdG90YWxyYW1fcGFnZXMrKzsNCj4gKwkJYXRvbWljX2xvbmdf
aW5jKCZ0b3RhbHJhbV9wYWdlcyk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IEBAIC0yMDAxLDcgKzIw
MDEsNyBAQCB2b2lkIHJlc2V0X25vZGVfbWFuYWdlZF9wYWdlcyhwZ19kYXRhX3QgKnBnZGF0KQ0K
PiAgCXN0cnVjdCB6b25lICp6Ow0KPiAgDQo+ICAJZm9yICh6ID0gcGdkYXQtPm5vZGVfem9uZXM7
IHogPCBwZ2RhdC0+bm9kZV96b25lcyArIE1BWF9OUl9aT05FUzsgeisrKQ0KPiAtCQl6LT5tYW5h
Z2VkX3BhZ2VzID0gMDsNCj4gKwkJYXRvbWljX2xvbmdfc2V0KCZ6LT5tYW5hZ2VkX3BhZ2VzLCAw
KTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBfX2luaXQgcmVzZXRfYWxsX3pvbmVzX21hbmFnZWRfcGFn
ZXModm9pZCkNCj4gQEAgLTIwMjksNyArMjAyOSw3IEBAIHVuc2lnbmVkIGxvbmcgX19pbml0IG1l
bWJsb2NrX2ZyZWVfYWxsKHZvaWQpDQo+ICAJcmVzZXRfYWxsX3pvbmVzX21hbmFnZWRfcGFnZXMo
KTsNCj4gIA0KPiAgCXBhZ2VzID0gZnJlZV9sb3dfbWVtb3J5X2NvcmVfZWFybHkoKTsNCj4gLQl0
b3RhbHJhbV9wYWdlcyArPSBwYWdlczsNCj4gKwlhdG9taWNfbG9uZ19hZGQocGFnZXMsICZ0b3Rh
bHJhbV9wYWdlcyk7DQo+ICANCj4gIAlyZXR1cm4gcGFnZXM7DQo+ICB9DQo+IGRpZmYgLS1naXQg
YS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiBpbmRleCBkYmJi
OTQ1Li4wNzI1OTg0IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+ICsrKyBi
L21tL21lbW9yeV9ob3RwbHVnLmMNCj4gQEAgLTY1NywxMCArNjU3LDEwIEBAIHZvaWQgX19vbmxp
bmVfcGFnZV9mcmVlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgc3RhdGljIGludCBnZW5lcmljX29u
bGluZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCB1bnNpZ25lZCBpbnQgb3JkZXIpDQo+ICB7DQo+
ICAJX19mcmVlX3BhZ2VzX2NvcmUocGFnZSwgb3JkZXIpOw0KPiAtCXRvdGFscmFtX3BhZ2VzICs9
ICgxVUwgPDwgb3JkZXIpOw0KPiArCWF0b21pY19sb25nX2FkZCgoMVVMIDw8IG9yZGVyKSwgJnRv
dGFscmFtX3BhZ2VzKTsNCj4gICNpZmRlZiBDT05GSUdfSElHSE1FTQ0KPiAgCWlmIChQYWdlSGln
aE1lbShwYWdlKSkNCj4gLQkJdG90YWxoaWdoX3BhZ2VzICs9ICgxVUwgPDwgb3JkZXIpOw0KPiAr
CQlhdG9taWNfbG9uZ19hZGQoKDFVTCA8PCBvcmRlciksICZ0b3RhbGhpZ2hfcGFnZXMpOw0KPiAg
I2VuZGlmDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9tbS9tbV9pbml0LmMg
Yi9tbS9tbV9pbml0LmMNCj4gaW5kZXggNjgzOGE1My4uOTNhNjYxMSAxMDA2NDQNCj4gLS0tIGEv
bW0vbW1faW5pdC5jDQo+ICsrKyBiL21tL21tX2luaXQuYw0KPiBAQCAtMTQ2LDcgKzE0Niw4IEBA
IHN0YXRpYyB2b2lkIF9fbWVtaW5pdCBtbV9jb21wdXRlX2JhdGNoKHZvaWQpDQo+ICAJczMyIGJh
dGNoID0gbWF4X3QoczMyLCBucioyLCAzMik7DQo+ICANCj4gIAkvKiBiYXRjaCBzaXplIHNldCB0
byAwLjQlIG9mICh0b3RhbCBtZW1vcnkvI2NwdXMpLCBvciBtYXggaW50MzIgKi8NCj4gLQltZW1z
aXplZF9iYXRjaCA9IG1pbl90KHU2NCwgKHRvdGFscmFtX3BhZ2VzL25yKS8yNTYsIDB4N2ZmZmZm
ZmYpOw0KPiArCW1lbXNpemVkX2JhdGNoID0gbWluX3QodTY0LCAoYXRvbWljX2xvbmdfcmVhZCgm
dG90YWxyYW1fcGFnZXMpL25yKS8yNTYsDQo+ICsJCQkJCQkJCTB4N2ZmZmZmZmYpOw0KPiAgDQo+
ICAJdm1fY29tbWl0dGVkX2FzX2JhdGNoID0gbWF4X3QoczMyLCBtZW1zaXplZF9iYXRjaCwgYmF0
Y2gpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvbW0vb29tX2tpbGwuYyBiL21tL29vbV9raWxsLmMN
Cj4gaW5kZXggNjU4OWY2MC4uMWEzN2Q2OCAxMDA2NDQNCj4gLS0tIGEvbW0vb29tX2tpbGwuYw0K
PiArKysgYi9tbS9vb21fa2lsbC5jDQo+IEBAIC0yNjksNyArMjY5LDcgQEAgc3RhdGljIGVudW0g
b29tX2NvbnN0cmFpbnQgY29uc3RyYWluZWRfYWxsb2Moc3RydWN0IG9vbV9jb250cm9sICpvYykN
Cj4gIAl9DQo+ICANCj4gIAkvKiBEZWZhdWx0IHRvIGFsbCBhdmFpbGFibGUgbWVtb3J5ICovDQo+
IC0Jb2MtPnRvdGFscGFnZXMgPSB0b3RhbHJhbV9wYWdlcyArIHRvdGFsX3N3YXBfcGFnZXM7DQo+
ICsJb2MtPnRvdGFscGFnZXMgPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgKyB0
b3RhbF9zd2FwX3BhZ2VzOw0KPiAgDQo+ICAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19OVU1BKSkN
Cj4gIAkJcmV0dXJuIENPTlNUUkFJTlRfTk9ORTsNCj4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxs
b2MuYyBiL21tL3BhZ2VfYWxsb2MuYw0KPiBpbmRleCA0YmQ4NThkLi5jN2IyNmUzIDEwMDY0NA0K
PiAtLS0gYS9tbS9wYWdlX2FsbG9jLmMNCj4gKysrIGIvbW0vcGFnZV9hbGxvYy5jDQo+IEBAIC0x
MjEsMTAgKzEyMSw3IEBADQo+ICB9Ow0KPiAgRVhQT1JUX1NZTUJPTChub2RlX3N0YXRlcyk7DQo+
ICANCj4gLS8qIFByb3RlY3QgdG90YWxyYW1fcGFnZXMgYW5kIHpvbmUtPm1hbmFnZWRfcGFnZXMg
Ki8NCj4gLXN0YXRpYyBERUZJTkVfU1BJTkxPQ0sobWFuYWdlZF9wYWdlX2NvdW50X2xvY2spOw0K
PiAtDQo+IC11bnNpZ25lZCBsb25nIHRvdGFscmFtX3BhZ2VzIF9fcmVhZF9tb3N0bHk7DQo+ICth
dG9taWNfbG9uZ190IHRvdGFscmFtX3BhZ2VzIF9fcmVhZF9tb3N0bHk7DQo+ICB1bnNpZ25lZCBs
b25nIHRvdGFscmVzZXJ2ZV9wYWdlcyBfX3JlYWRfbW9zdGx5Ow0KPiAgdW5zaWduZWQgbG9uZyB0
b3RhbGNtYV9wYWdlcyBfX3JlYWRfbW9zdGx5Ow0KPiAgDQo+IEBAIC0xMjc1LDcgKzEyNzIsNyBA
QCB2b2lkIF9fZnJlZV9wYWdlc19jb3JlKHN0cnVjdCBwYWdlICpwYWdlLCB1bnNpZ25lZCBpbnQg
b3JkZXIpDQo+ICAJCXNldF9wYWdlX2NvdW50KHAsIDApOw0KPiAgCX0NCj4gIA0KPiAtCXBhZ2Vf
em9uZShwYWdlKS0+bWFuYWdlZF9wYWdlcyArPSBucl9wYWdlczsNCj4gKwlhdG9taWNfbG9uZ19h
ZGQobnJfcGFnZXMsICZwYWdlX3pvbmUocGFnZSktPm1hbmFnZWRfcGFnZXMpOw0KPiAgCXNldF9w
YWdlX3JlZmNvdW50ZWQocGFnZSk7DQo+ICAJX19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsNCj4g
IH0NCj4gQEAgLTIyNTQsNyArMjI1MSw4IEBAIHN0YXRpYyB2b2lkIHJlc2VydmVfaGlnaGF0b21p
Y19wYWdlYmxvY2soc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCB6b25lICp6b25lLA0KPiAgCSAq
IExpbWl0IHRoZSBudW1iZXIgcmVzZXJ2ZWQgdG8gMSBwYWdlYmxvY2sgb3Igcm91Z2hseSAxJSBv
ZiBhIHpvbmUuDQo+ICAJICogQ2hlY2sgaXMgcmFjZS1wcm9uZSBidXQgaGFybWxlc3MuDQo+ICAJ
ICovDQo+IC0JbWF4X21hbmFnZWQgPSAoem9uZS0+bWFuYWdlZF9wYWdlcyAvIDEwMCkgKyBwYWdl
YmxvY2tfbnJfcGFnZXM7DQo+ICsJbWF4X21hbmFnZWQgPSAoYXRvbWljX2xvbmdfcmVhZCgmem9u
ZS0+bWFuYWdlZF9wYWdlcykgLyAxMDApICsNCj4gKwkJCQkJCXBhZ2VibG9ja19ucl9wYWdlczsN
Cj4gIAlpZiAoem9uZS0+bnJfcmVzZXJ2ZWRfaGlnaGF0b21pYyA+PSBtYXhfbWFuYWdlZCkNCj4g
IAkJcmV0dXJuOw0KPiAgDQo+IEBAIC00NjU4LDcgKzQ2NTYsNyBAQCBzdGF0aWMgdW5zaWduZWQg
bG9uZyBucl9mcmVlX3pvbmVfcGFnZXMoaW50IG9mZnNldCkNCj4gIAlzdHJ1Y3Qgem9uZWxpc3Qg
KnpvbmVsaXN0ID0gbm9kZV96b25lbGlzdChudW1hX25vZGVfaWQoKSwgR0ZQX0tFUk5FTCk7DQo+
ICANCj4gIAlmb3JfZWFjaF96b25lX3pvbmVsaXN0KHpvbmUsIHosIHpvbmVsaXN0LCBvZmZzZXQp
IHsNCj4gLQkJdW5zaWduZWQgbG9uZyBzaXplID0gem9uZS0+bWFuYWdlZF9wYWdlczsNCj4gKwkJ
dW5zaWduZWQgbG9uZyBzaXplID0gYXRvbWljX2xvbmdfcmVhZCgmem9uZS0+bWFuYWdlZF9wYWdl
cyk7DQo+ICAJCXVuc2lnbmVkIGxvbmcgaGlnaCA9IGhpZ2hfd21hcmtfcGFnZXMoem9uZSk7DQo+
ICAJCWlmIChzaXplID4gaGlnaCkNCj4gIAkJCXN1bSArPSBzaXplIC0gaGlnaDsNCj4gQEAgLTQ3
NDQsMTEgKzQ3NDIsMTUgQEAgbG9uZyBzaV9tZW1fYXZhaWxhYmxlKHZvaWQpDQo+ICANCj4gIHZv
aWQgc2lfbWVtaW5mbyhzdHJ1Y3Qgc3lzaW5mbyAqdmFsKQ0KPiAgew0KPiAtCXZhbC0+dG90YWxy
YW0gPSB0b3RhbHJhbV9wYWdlczsNCj4gKwl2YWwtPnRvdGFscmFtID0gYXRvbWljX2xvbmdfcmVh
ZCgmdG90YWxyYW1fcGFnZXMpOw0KPiAgCXZhbC0+c2hhcmVkcmFtID0gZ2xvYmFsX25vZGVfcGFn
ZV9zdGF0ZShOUl9TSE1FTSk7DQo+ICAJdmFsLT5mcmVlcmFtID0gZ2xvYmFsX3pvbmVfcGFnZV9z
dGF0ZShOUl9GUkVFX1BBR0VTKTsNCj4gIAl2YWwtPmJ1ZmZlcnJhbSA9IG5yX2Jsb2NrZGV2X3Bh
Z2VzKCk7DQo+IC0JdmFsLT50b3RhbGhpZ2ggPSB0b3RhbGhpZ2hfcGFnZXM7DQo+ICsjaWZkZWYg
Q09ORklHX0hJR0hNRU0NCj4gKwl2YWwtPnRvdGFsaGlnaCA9IGF0b21pY19sb25nX3JlYWQoJnRv
dGFsaGlnaF9wYWdlcyk7DQo+ICsjZWxzZQ0KPiArCXZhbC0+dG90YWxoaWdoID0gMDsNCj4gKyNl
bmRpZg0KPiAgCXZhbC0+ZnJlZWhpZ2ggPSBucl9mcmVlX2hpZ2hwYWdlcygpOw0KPiAgCXZhbC0+
bWVtX3VuaXQgPSBQQUdFX1NJWkU7DQo+ICB9DQo+IEBAIC00NzY1LDcgKzQ3NjcsNyBAQCB2b2lk
IHNpX21lbWluZm9fbm9kZShzdHJ1Y3Qgc3lzaW5mbyAqdmFsLCBpbnQgbmlkKQ0KPiAgCXBnX2Rh
dGFfdCAqcGdkYXQgPSBOT0RFX0RBVEEobmlkKTsNCj4gIA0KPiAgCWZvciAoem9uZV90eXBlID0g
MDsgem9uZV90eXBlIDwgTUFYX05SX1pPTkVTOyB6b25lX3R5cGUrKykNCj4gLQkJbWFuYWdlZF9w
YWdlcyArPSBwZ2RhdC0+bm9kZV96b25lc1t6b25lX3R5cGVdLm1hbmFnZWRfcGFnZXM7DQo+ICsJ
CW1hbmFnZWRfcGFnZXMgKz0gYXRvbWljX2xvbmdfcmVhZCgmcGdkYXQtPm5vZGVfem9uZXNbem9u
ZV90eXBlXS5tYW5hZ2VkX3BhZ2VzKTsNCj4gIAl2YWwtPnRvdGFscmFtID0gbWFuYWdlZF9wYWdl
czsNCj4gIAl2YWwtPnNoYXJlZHJhbSA9IG5vZGVfcGFnZV9zdGF0ZShwZ2RhdCwgTlJfU0hNRU0p
Ow0KPiAgCXZhbC0+ZnJlZXJhbSA9IHN1bV96b25lX25vZGVfcGFnZV9zdGF0ZShuaWQsIE5SX0ZS
RUVfUEFHRVMpOw0KPiBAQCAtNDc3NCw3ICs0Nzc2LDcgQEAgdm9pZCBzaV9tZW1pbmZvX25vZGUo
c3RydWN0IHN5c2luZm8gKnZhbCwgaW50IG5pZCkNCj4gIAkJc3RydWN0IHpvbmUgKnpvbmUgPSAm
cGdkYXQtPm5vZGVfem9uZXNbem9uZV90eXBlXTsNCj4gIA0KPiAgCQlpZiAoaXNfaGlnaG1lbSh6
b25lKSkgew0KPiAtCQkJbWFuYWdlZF9oaWdocGFnZXMgKz0gem9uZS0+bWFuYWdlZF9wYWdlczsN
Cj4gKwkJCW1hbmFnZWRfaGlnaHBhZ2VzICs9IGF0b21pY19sb25nX3JlYWQoJnpvbmUtPm1hbmFn
ZWRfcGFnZXMpOw0KPiAgCQkJZnJlZV9oaWdocGFnZXMgKz0gem9uZV9wYWdlX3N0YXRlKHpvbmUs
IE5SX0ZSRUVfUEFHRVMpOw0KPiAgCQl9DQo+ICAJfQ0KPiBAQCAtNDk4MSw3ICs0OTgzLDcgQEAg
dm9pZCBzaG93X2ZyZWVfYXJlYXModW5zaWduZWQgaW50IGZpbHRlciwgbm9kZW1hc2tfdCAqbm9k
ZW1hc2spDQo+ICAJCQlLKHpvbmVfcGFnZV9zdGF0ZSh6b25lLCBOUl9aT05FX1VORVZJQ1RBQkxF
KSksDQo+ICAJCQlLKHpvbmVfcGFnZV9zdGF0ZSh6b25lLCBOUl9aT05FX1dSSVRFX1BFTkRJTkcp
KSwNCj4gIAkJCUsoem9uZS0+cHJlc2VudF9wYWdlcyksDQo+IC0JCQlLKHpvbmUtPm1hbmFnZWRf
cGFnZXMpLA0KPiArCQkJSyhhdG9taWNfbG9uZ19yZWFkKCZ6b25lLT5tYW5hZ2VkX3BhZ2VzKSks
DQo+ICAJCQlLKHpvbmVfcGFnZV9zdGF0ZSh6b25lLCBOUl9NTE9DSykpLA0KPiAgCQkJem9uZV9w
YWdlX3N0YXRlKHpvbmUsIE5SX0tFUk5FTF9TVEFDS19LQiksDQo+ICAJCQlLKHpvbmVfcGFnZV9z
dGF0ZSh6b25lLCBOUl9QQUdFVEFCTEUpKSwNCj4gQEAgLTU2NDMsNyArNTY0NSw3IEBAIHN0YXRp
YyBpbnQgem9uZV9iYXRjaHNpemUoc3RydWN0IHpvbmUgKnpvbmUpDQo+ICAJICogVGhlIHBlci1j
cHUtcGFnZXMgcG9vbHMgYXJlIHNldCB0byBhcm91bmQgMTAwMHRoIG9mIHRoZQ0KPiAgCSAqIHNp
emUgb2YgdGhlIHpvbmUuDQo+ICAJICovDQo+IC0JYmF0Y2ggPSB6b25lLT5tYW5hZ2VkX3BhZ2Vz
IC8gMTAyNDsNCj4gKwliYXRjaCA9IGF0b21pY19sb25nX3JlYWQoJnpvbmUtPm1hbmFnZWRfcGFn
ZXMpIC8gMTAyNDsNCj4gIAkvKiBCdXQgbm8gbW9yZSB0aGFuIGEgbWVnLiAqLw0KPiAgCWlmIChi
YXRjaCAqIFBBR0VfU0laRSA+IDEwMjQgKiAxMDI0KQ0KPiAgCQliYXRjaCA9ICgxMDI0ICogMTAy
NCkgLyBQQUdFX1NJWkU7DQo+IEBAIC01NzU0LDcgKzU3NTYsNyBAQCBzdGF0aWMgdm9pZCBwYWdl
c2V0X3NldF9oaWdoX2FuZF9iYXRjaChzdHJ1Y3Qgem9uZSAqem9uZSwNCj4gIHsNCj4gIAlpZiAo
cGVyY3B1X3BhZ2VsaXN0X2ZyYWN0aW9uKQ0KPiAgCQlwYWdlc2V0X3NldF9oaWdoKHBjcCwNCj4g
LQkJCSh6b25lLT5tYW5hZ2VkX3BhZ2VzIC8NCj4gKwkJCShhdG9taWNfbG9uZ19yZWFkKCZ6b25l
LT5tYW5hZ2VkX3BhZ2VzKSAvDQo+ICAJCQkJcGVyY3B1X3BhZ2VsaXN0X2ZyYWN0aW9uKSk7DQo+
ICAJZWxzZQ0KPiAgCQlwYWdlc2V0X3NldF9iYXRjaChwY3AsIHpvbmVfYmF0Y2hzaXplKHpvbmUp
KTsNCj4gQEAgLTYzMDksNyArNjMxMSw3IEBAIHN0YXRpYyB2b2lkIF9fbWVtaW5pdCBwZ2RhdF9p
bml0X2ludGVybmFscyhzdHJ1Y3QgcGdsaXN0X2RhdGEgKnBnZGF0KQ0KPiAgc3RhdGljIHZvaWQg
X19tZW1pbml0IHpvbmVfaW5pdF9pbnRlcm5hbHMoc3RydWN0IHpvbmUgKnpvbmUsIGVudW0gem9u
ZV90eXBlIGlkeCwgaW50IG5pZCwNCj4gIAkJCQkJCQl1bnNpZ25lZCBsb25nIHJlbWFpbmluZ19w
YWdlcykNCj4gIHsNCj4gLQl6b25lLT5tYW5hZ2VkX3BhZ2VzID0gcmVtYWluaW5nX3BhZ2VzOw0K
PiArCWF0b21pY19sb25nX3NldCgmem9uZS0+bWFuYWdlZF9wYWdlcywgcmVtYWluaW5nX3BhZ2Vz
KTsNCj4gIAl6b25lX3NldF9uaWQoem9uZSwgbmlkKTsNCj4gIAl6b25lLT5uYW1lID0gem9uZV9u
YW1lc1tpZHhdOw0KPiAgCXpvbmUtPnpvbmVfcGdkYXQgPSBOT0RFX0RBVEEobmlkKTsNCj4gQEAg
LTcwNjEsMTQgKzcwNjMsMTIgQEAgc3RhdGljIGludCBfX2luaXQgY21kbGluZV9wYXJzZV9tb3Zh
YmxlY29yZShjaGFyICpwKQ0KPiAgDQo+ICB2b2lkIGFkanVzdF9tYW5hZ2VkX3BhZ2VfY291bnQo
c3RydWN0IHBhZ2UgKnBhZ2UsIGxvbmcgY291bnQpDQo+ICB7DQo+IC0Jc3Bpbl9sb2NrKCZtYW5h
Z2VkX3BhZ2VfY291bnRfbG9jayk7DQo+IC0JcGFnZV96b25lKHBhZ2UpLT5tYW5hZ2VkX3BhZ2Vz
ICs9IGNvdW50Ow0KPiAtCXRvdGFscmFtX3BhZ2VzICs9IGNvdW50Ow0KPiArCWF0b21pY19sb25n
X2FkZChjb3VudCwgJnBhZ2Vfem9uZShwYWdlKS0+bWFuYWdlZF9wYWdlcyk7DQo+ICsJYXRvbWlj
X2xvbmdfYWRkKGNvdW50LCAmdG90YWxyYW1fcGFnZXMpOw0KPiAgI2lmZGVmIENPTkZJR19ISUdI
TUVNDQo+ICAJaWYgKFBhZ2VIaWdoTWVtKHBhZ2UpKQ0KPiAtCQl0b3RhbGhpZ2hfcGFnZXMgKz0g
Y291bnQ7DQo+ICsJCWF0b21pY19sb25nX2FkZChjb3VudCwgJnRvdGFsaGlnaF9wYWdlcyk7DQo+
ICAjZW5kaWYNCj4gLQlzcGluX3VubG9jaygmbWFuYWdlZF9wYWdlX2NvdW50X2xvY2spOw0KPiAg
fQ0KPiAgRVhQT1JUX1NZTUJPTChhZGp1c3RfbWFuYWdlZF9wYWdlX2NvdW50KTsNCj4gIA0KPiBA
QCAtNzEwOSw5ICs3MTA5LDkgQEAgdW5zaWduZWQgbG9uZyBmcmVlX3Jlc2VydmVkX2FyZWEodm9p
ZCAqc3RhcnQsIHZvaWQgKmVuZCwgaW50IHBvaXNvbiwgY2hhciAqcykNCj4gIHZvaWQgZnJlZV9o
aWdobWVtX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICB7DQo+ICAJX19mcmVlX3Jlc2VydmVk
X3BhZ2UocGFnZSk7DQo+IC0JdG90YWxyYW1fcGFnZXMrKzsNCj4gLQlwYWdlX3pvbmUocGFnZSkt
Pm1hbmFnZWRfcGFnZXMrKzsNCj4gLQl0b3RhbGhpZ2hfcGFnZXMrKzsNCj4gKwlhdG9taWNfbG9u
Z19pbmMoJnRvdGFscmFtX3BhZ2VzKTsNCj4gKwlhdG9taWNfbG9uZ19pbmMoJnBhZ2Vfem9uZShw
YWdlKS0+bWFuYWdlZF9wYWdlcyk7DQo+ICsJYXRvbWljX2xvbmdfaW5jKCZ0b3RhbGhpZ2hfcGFn
ZXMpOw0KPiAgfQ0KPiAgI2VuZGlmDQo+ICANCj4gQEAgLTcxNjAsMTAgKzcxNjAsMTAgQEAgdm9p
ZCBfX2luaXQgbWVtX2luaXRfcHJpbnRfaW5mbyhjb25zdCBjaGFyICpzdHIpDQo+ICAJCXBoeXNw
YWdlcyA8PCAoUEFHRV9TSElGVCAtIDEwKSwNCj4gIAkJY29kZXNpemUgPj4gMTAsIGRhdGFzaXpl
ID4+IDEwLCByb3NpemUgPj4gMTAsDQo+ICAJCShpbml0X2RhdGFfc2l6ZSArIGluaXRfY29kZV9z
aXplKSA+PiAxMCwgYnNzX3NpemUgPj4gMTAsDQo+IC0JCShwaHlzcGFnZXMgLSB0b3RhbHJhbV9w
YWdlcyAtIHRvdGFsY21hX3BhZ2VzKSA8PCAoUEFHRV9TSElGVCAtIDEwKSwNCj4gKwkJKHBoeXNw
YWdlcyAtIGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAtIHRvdGFsY21hX3BhZ2Vz
KSA8PCAoUEFHRV9TSElGVCAtIDEwKSwNCj4gIAkJdG90YWxjbWFfcGFnZXMgPDwgKFBBR0VfU0hJ
RlQgLSAxMCksDQo+ICAjaWZkZWYJQ09ORklHX0hJR0hNRU0NCj4gLQkJdG90YWxoaWdoX3BhZ2Vz
IDw8IChQQUdFX1NISUZUIC0gMTApLA0KPiArCQlhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbGhpZ2hf
cGFnZXMpIDw8IChQQUdFX1NISUZUIC0gMTApLA0KPiAgI2VuZGlmDQo+ICAJCXN0ciA/ICIsICIg
OiAiIiwgc3RyID8gc3RyIDogIiIpOw0KPiAgfQ0KPiBAQCAtNzI1Myw4ICs3MjUzLDggQEAgc3Rh
dGljIHZvaWQgY2FsY3VsYXRlX3RvdGFscmVzZXJ2ZV9wYWdlcyh2b2lkKQ0KPiAgCQkJLyogd2Ug
dHJlYXQgdGhlIGhpZ2ggd2F0ZXJtYXJrIGFzIHJlc2VydmVkIHBhZ2VzLiAqLw0KPiAgCQkJbWF4
ICs9IGhpZ2hfd21hcmtfcGFnZXMoem9uZSk7DQo+ICANCj4gLQkJCWlmIChtYXggPiB6b25lLT5t
YW5hZ2VkX3BhZ2VzKQ0KPiAtCQkJCW1heCA9IHpvbmUtPm1hbmFnZWRfcGFnZXM7DQo+ICsJCQlp
ZiAobWF4ID4gYXRvbWljX2xvbmdfcmVhZCgmem9uZS0+bWFuYWdlZF9wYWdlcykpDQo+ICsJCQkJ
bWF4ID0gYXRvbWljX2xvbmdfcmVhZCgmem9uZS0+bWFuYWdlZF9wYWdlcyk7DQo+ICANCj4gIAkJ
CXBnZGF0LT50b3RhbHJlc2VydmVfcGFnZXMgKz0gbWF4Ow0KPiAgDQo+IEBAIC03Mjc4LDcgKzcy
NzgsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9wZXJfem9uZV9sb3dtZW1fcmVzZXJ2ZSh2b2lkKQ0K
PiAgCWZvcl9lYWNoX29ubGluZV9wZ2RhdChwZ2RhdCkgew0KPiAgCQlmb3IgKGogPSAwOyBqIDwg
TUFYX05SX1pPTkVTOyBqKyspIHsNCj4gIAkJCXN0cnVjdCB6b25lICp6b25lID0gcGdkYXQtPm5v
ZGVfem9uZXMgKyBqOw0KPiAtCQkJdW5zaWduZWQgbG9uZyBtYW5hZ2VkX3BhZ2VzID0gem9uZS0+
bWFuYWdlZF9wYWdlczsNCj4gKwkJCXVuc2lnbmVkIGxvbmcgbWFuYWdlZF9wYWdlcyA9IGF0b21p
Y19sb25nX3JlYWQoJnpvbmUtPm1hbmFnZWRfcGFnZXMpOw0KPiAgDQo+ICAJCQl6b25lLT5sb3dt
ZW1fcmVzZXJ2ZVtqXSA9IDA7DQo+ICANCj4gQEAgLTcyOTYsNyArNzI5Niw3IEBAIHN0YXRpYyB2
b2lkIHNldHVwX3Blcl96b25lX2xvd21lbV9yZXNlcnZlKHZvaWQpDQo+ICAJCQkJCWxvd2VyX3pv
bmUtPmxvd21lbV9yZXNlcnZlW2pdID0NCj4gIAkJCQkJCW1hbmFnZWRfcGFnZXMgLyBzeXNjdGxf
bG93bWVtX3Jlc2VydmVfcmF0aW9baWR4XTsNCj4gIAkJCQl9DQo+IC0JCQkJbWFuYWdlZF9wYWdl
cyArPSBsb3dlcl96b25lLT5tYW5hZ2VkX3BhZ2VzOw0KPiArCQkJCW1hbmFnZWRfcGFnZXMgKz0g
YXRvbWljX2xvbmdfcmVhZCgmbG93ZXJfem9uZS0+bWFuYWdlZF9wYWdlcyk7DQo+ICAJCQl9DQo+
ICAJCX0NCj4gIAl9DQo+IEBAIC03MzE1LDE0ICs3MzE1LDE0IEBAIHN0YXRpYyB2b2lkIF9fc2V0
dXBfcGVyX3pvbmVfd21hcmtzKHZvaWQpDQo+ICAJLyogQ2FsY3VsYXRlIHRvdGFsIG51bWJlciBv
ZiAhWk9ORV9ISUdITUVNIHBhZ2VzICovDQo+ICAJZm9yX2VhY2hfem9uZSh6b25lKSB7DQo+ICAJ
CWlmICghaXNfaGlnaG1lbSh6b25lKSkNCj4gLQkJCWxvd21lbV9wYWdlcyArPSB6b25lLT5tYW5h
Z2VkX3BhZ2VzOw0KPiArCQkJbG93bWVtX3BhZ2VzICs9IGF0b21pY19sb25nX3JlYWQoJnpvbmUt
Pm1hbmFnZWRfcGFnZXMpOw0KPiAgCX0NCj4gIA0KPiAgCWZvcl9lYWNoX3pvbmUoem9uZSkgew0K
PiAgCQl1NjQgdG1wOw0KPiAgDQo+ICAJCXNwaW5fbG9ja19pcnFzYXZlKCZ6b25lLT5sb2NrLCBm
bGFncyk7DQo+IC0JCXRtcCA9ICh1NjQpcGFnZXNfbWluICogem9uZS0+bWFuYWdlZF9wYWdlczsN
Cj4gKwkJdG1wID0gKHU2NClwYWdlc19taW4gKiBhdG9taWNfbG9uZ19yZWFkKCZ6b25lLT5tYW5h
Z2VkX3BhZ2VzKTsNCj4gIAkJZG9fZGl2KHRtcCwgbG93bWVtX3BhZ2VzKTsNCj4gIAkJaWYgKGlz
X2hpZ2htZW0oem9uZSkpIHsNCj4gIAkJCS8qDQo+IEBAIC03MzM2LDcgKzczMzYsOCBAQCBzdGF0
aWMgdm9pZCBfX3NldHVwX3Blcl96b25lX3dtYXJrcyh2b2lkKQ0KPiAgCQkJICovDQo+ICAJCQl1
bnNpZ25lZCBsb25nIG1pbl9wYWdlczsNCj4gIA0KPiAtCQkJbWluX3BhZ2VzID0gem9uZS0+bWFu
YWdlZF9wYWdlcyAvIDEwMjQ7DQo+ICsJCQltaW5fcGFnZXMgPSBhdG9taWNfbG9uZ19yZWFkKCZ6
b25lLT5tYW5hZ2VkX3BhZ2VzKSAvDQo+ICsJCQkJCQkJCQkxMDI0Ow0KPiAgCQkJbWluX3BhZ2Vz
ID0gY2xhbXAobWluX3BhZ2VzLCBTV0FQX0NMVVNURVJfTUFYLCAxMjhVTCk7DQo+ICAJCQl6b25l
LT53YXRlcm1hcmtbV01BUktfTUlOXSA9IG1pbl9wYWdlczsNCj4gIAkJfSBlbHNlIHsNCj4gQEAg
LTczNTMsNyArNzM1NCw3IEBAIHN0YXRpYyB2b2lkIF9fc2V0dXBfcGVyX3pvbmVfd21hcmtzKHZv
aWQpDQo+ICAJCSAqIGVuc3VyZSBhIG1pbmltdW0gc2l6ZSBvbiBzbWFsbCBzeXN0ZW1zLg0KPiAg
CQkgKi8NCj4gIAkJdG1wID0gbWF4X3QodTY0LCB0bXAgPj4gMiwNCj4gLQkJCSAgICBtdWx0X2Zy
YWMoem9uZS0+bWFuYWdlZF9wYWdlcywNCj4gKwkJCSAgICBtdWx0X2ZyYWMoYXRvbWljX2xvbmdf
cmVhZCgmem9uZS0+bWFuYWdlZF9wYWdlcyksDQo+ICAJCQkJICAgICAgd2F0ZXJtYXJrX3NjYWxl
X2ZhY3RvciwgMTAwMDApKTsNCj4gIA0KPiAgCQl6b25lLT53YXRlcm1hcmtbV01BUktfTE9XXSAg
PSBtaW5fd21hcmtfcGFnZXMoem9uZSkgKyB0bXA7DQo+IEBAIC03NDgzLDcgKzc0ODQsOCBAQCBz
dGF0aWMgdm9pZCBzZXR1cF9taW5fdW5tYXBwZWRfcmF0aW8odm9pZCkNCj4gIAkJcGdkYXQtPm1p
bl91bm1hcHBlZF9wYWdlcyA9IDA7DQo+ICANCj4gIAlmb3JfZWFjaF96b25lKHpvbmUpDQo+IC0J
CXpvbmUtPnpvbmVfcGdkYXQtPm1pbl91bm1hcHBlZF9wYWdlcyArPSAoem9uZS0+bWFuYWdlZF9w
YWdlcyAqDQo+ICsJCXpvbmUtPnpvbmVfcGdkYXQtPm1pbl91bm1hcHBlZF9wYWdlcyArPQ0KPiAr
CQkJCShhdG9taWNfbG9uZ19yZWFkKCZ6b25lLT5tYW5hZ2VkX3BhZ2VzKSAqDQo+ICAJCQkJc3lz
Y3RsX21pbl91bm1hcHBlZF9yYXRpbykgLyAxMDA7DQo+ICB9DQo+ICANCj4gQEAgLTc1MTEsOCAr
NzUxMyw5IEBAIHN0YXRpYyB2b2lkIHNldHVwX21pbl9zbGFiX3JhdGlvKHZvaWQpDQo+ICAJCXBn
ZGF0LT5taW5fc2xhYl9wYWdlcyA9IDA7DQo+ICANCj4gIAlmb3JfZWFjaF96b25lKHpvbmUpDQo+
IC0JCXpvbmUtPnpvbmVfcGdkYXQtPm1pbl9zbGFiX3BhZ2VzICs9ICh6b25lLT5tYW5hZ2VkX3Bh
Z2VzICoNCj4gLQkJCQlzeXNjdGxfbWluX3NsYWJfcmF0aW8pIC8gMTAwOw0KPiArCQl6b25lLT56
b25lX3BnZGF0LT5taW5fc2xhYl9wYWdlcyArPQ0KPiArCQkJKGF0b21pY19sb25nX3JlYWQoJnpv
bmUtPm1hbmFnZWRfcGFnZXMpICoNCj4gKwkJCXN5c2N0bF9taW5fc2xhYl9yYXRpbykgLyAxMDA7
DQo+ICB9DQo+ICANCj4gIGludCBzeXNjdGxfbWluX3NsYWJfcmF0aW9fc3lzY3RsX2hhbmRsZXIo
c3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwNCj4gZGlmZiAtLWdpdCBhL21tL3No
bWVtLmMgYi9tbS9zaG1lbS5jDQo+IGluZGV4IGE2OTY0YmEuLmVkZDU1ZGIgMTAwNjQ0DQo+IC0t
LSBhL21tL3NobWVtLmMNCj4gKysrIGIvbW0vc2htZW0uYw0KPiBAQCAtMTA5LDEyICsxMDksMTgg
QEAgc3RydWN0IHNobWVtX2ZhbGxvYyB7DQo+ICAjaWZkZWYgQ09ORklHX1RNUEZTDQo+ICBzdGF0
aWMgdW5zaWduZWQgbG9uZyBzaG1lbV9kZWZhdWx0X21heF9ibG9ja3Modm9pZCkNCj4gIHsNCj4g
LQlyZXR1cm4gdG90YWxyYW1fcGFnZXMgLyAyOw0KPiArCXJldHVybiBhdG9taWNfbG9uZ19yZWFk
KCZ0b3RhbHJhbV9wYWdlcykgLyAyOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBzaG1lbV9kZWZhdWx0X21heF9pbm9kZXModm9pZCkNCj4gIHsNCj4gLQlyZXR1cm4gbWluKHRv
dGFscmFtX3BhZ2VzIC0gdG90YWxoaWdoX3BhZ2VzLCB0b3RhbHJhbV9wYWdlcyAvIDIpOw0KPiAr
CXJldHVybiBtaW4oKHVuc2lnbmVkIGxvbmcpYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFn
ZXMpIC0NCj4gKyNpZmRlZiBDT05GSUdfSElHSE1FTQ0KPiArCQkodW5zaWduZWQgbG9uZykgYXRv
bWljX2xvbmdfcmVhZCgmdG90YWxoaWdoX3BhZ2VzKSwNCj4gKyNlbHNlDQo+ICsJCTAsDQo+ICsj
ZW5kaWYNCj4gKwkJKHVuc2lnbmVkIGxvbmcpYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFn
ZXMpIC8gMik7DQo+ICB9DQo+ICAjZW5kaWYNCj4gIA0KPiBAQCAtMzI3NCw3ICszMjgwLDcgQEAg
c3RhdGljIGludCBzaG1lbV9wYXJzZV9vcHRpb25zKGNoYXIgKm9wdGlvbnMsIHN0cnVjdCBzaG1l
bV9zYl9pbmZvICpzYmluZm8sDQo+ICAJCQlzaXplID0gbWVtcGFyc2UodmFsdWUsJnJlc3QpOw0K
PiAgCQkJaWYgKCpyZXN0ID09ICclJykgew0KPiAgCQkJCXNpemUgPDw9IFBBR0VfU0hJRlQ7DQo+
IC0JCQkJc2l6ZSAqPSB0b3RhbHJhbV9wYWdlczsNCj4gKwkJCQlzaXplICo9IGF0b21pY19sb25n
X3JlYWQoJnRvdGFscmFtX3BhZ2VzKTsNCj4gIAkJCQlkb19kaXYoc2l6ZSwgMTAwKTsNCj4gIAkJ
CQlyZXN0Kys7DQo+ICAJCQl9DQo+IGRpZmYgLS1naXQgYS9tbS9zbGFiLmMgYi9tbS9zbGFiLmMN
Cj4gaW5kZXggMmE1NjU0Yi4uNzAyNTJiMCAxMDA2NDQNCj4gLS0tIGEvbW0vc2xhYi5jDQo+ICsr
KyBiL21tL3NsYWIuYw0KPiBAQCAtMTI0OCw3ICsxMjQ4LDggQEAgdm9pZCBfX2luaXQga21lbV9j
YWNoZV9pbml0KHZvaWQpDQo+ICAJICogcGFnZSBvcmRlcnMgb24gbWFjaGluZXMgd2l0aCBtb3Jl
IHRoYW4gMzJNQiBvZiBtZW1vcnkgaWYNCj4gIAkgKiBub3Qgb3ZlcnJpZGRlbiBvbiB0aGUgY29t
bWFuZCBsaW5lLg0KPiAgCSAqLw0KPiAtCWlmICghc2xhYl9tYXhfb3JkZXJfc2V0ICYmIHRvdGFs
cmFtX3BhZ2VzID4gKDMyIDw8IDIwKSA+PiBQQUdFX1NISUZUKQ0KPiArCWlmICghc2xhYl9tYXhf
b3JkZXJfc2V0ICYmIGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSA+DQo+ICsJCQkJ
CQkoMzIgPDwgMjApID4+IFBBR0VfU0hJRlQpDQo+ICAJCXNsYWJfbWF4X29yZGVyID0gU0xBQl9N
QVhfT1JERVJfSEk7DQo+ICANCj4gIAkvKiBCb290c3RyYXAgaXMgdHJpY2t5LCBiZWNhdXNlIHNl
dmVyYWwgb2JqZWN0cyBhcmUgYWxsb2NhdGVkDQo+IGRpZmYgLS1naXQgYS9tbS9zd2FwLmMgYi9t
bS9zd2FwLmMNCj4gaW5kZXggYWE0ODM3MS4uZTg1YmM0YSAxMDA2NDQNCj4gLS0tIGEvbW0vc3dh
cC5jDQo+ICsrKyBiL21tL3N3YXAuYw0KPiBAQCAtMTAyMyw3ICsxMDIzLDggQEAgdW5zaWduZWQg
cGFnZXZlY19sb29rdXBfcmFuZ2VfbnJfdGFnKHN0cnVjdCBwYWdldmVjICpwdmVjLA0KPiAgICov
DQo+ICB2b2lkIF9faW5pdCBzd2FwX3NldHVwKHZvaWQpDQo+ICB7DQo+IC0JdW5zaWduZWQgbG9u
ZyBtZWdzID0gdG90YWxyYW1fcGFnZXMgPj4gKDIwIC0gUEFHRV9TSElGVCk7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBtZWdzID0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+DQo+ICsJ
CQkJCQkoMjAgLSBQQUdFX1NISUZUKTsNCj4gIA0KPiAgCS8qIFVzZSBhIHNtYWxsZXIgY2x1c3Rl
ciBmb3Igc21hbGwtbWVtb3J5IG1hY2hpbmVzICovDQo+ICAJaWYgKG1lZ3MgPCAxNikNCj4gZGlm
ZiAtLWdpdCBhL21tL3V0aWwuYyBiL21tL3V0aWwuYw0KPiBpbmRleCA3ZjFmMTY1Li5hM2FlOGVl
IDEwMDY0NA0KPiAtLS0gYS9tbS91dGlsLmMNCj4gKysrIGIvbW0vdXRpbC5jDQo+IEBAIC02MDAs
NyArNjAwLDcgQEAgdW5zaWduZWQgbG9uZyB2bV9jb21taXRfbGltaXQodm9pZCkNCj4gIAlpZiAo
c3lzY3RsX292ZXJjb21taXRfa2J5dGVzKQ0KPiAgCQlhbGxvd2VkID0gc3lzY3RsX292ZXJjb21t
aXRfa2J5dGVzID4+IChQQUdFX1NISUZUIC0gMTApOw0KPiAgCWVsc2UNCj4gLQkJYWxsb3dlZCA9
ICgodG90YWxyYW1fcGFnZXMgLSBodWdldGxiX3RvdGFsX3BhZ2VzKCkpDQo+ICsJCWFsbG93ZWQg
PSAoKGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAtIGh1Z2V0bGJfdG90YWxfcGFn
ZXMoKSkNCj4gIAkJCSAgICogc3lzY3RsX292ZXJjb21taXRfcmF0aW8gLyAxMDApOw0KPiAgCWFs
bG93ZWQgKz0gdG90YWxfc3dhcF9wYWdlczsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvbW0vdm1hbGxv
Yy5jIGIvbW0vdm1hbGxvYy5jDQo+IGluZGV4IDk3ZDRiMjUuLmYxNzdhZjggMTAwNjQ0DQo+IC0t
LSBhL21tL3ZtYWxsb2MuYw0KPiArKysgYi9tbS92bWFsbG9jLmMNCj4gQEAgLTE2MzQsNyArMTYz
NCw3IEBAIHZvaWQgKnZtYXAoc3RydWN0IHBhZ2UgKipwYWdlcywgdW5zaWduZWQgaW50IGNvdW50
LA0KPiAgDQo+ICAJbWlnaHRfc2xlZXAoKTsNCj4gIA0KPiAtCWlmIChjb3VudCA+IHRvdGFscmFt
X3BhZ2VzKQ0KPiArCWlmIChjb3VudCA+IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2Vz
KSkNCj4gIAkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAlzaXplID0gKHVuc2lnbmVkIGxvbmcpY291
bnQgPDwgUEFHRV9TSElGVDsNCj4gQEAgLTE3MzksNyArMTczOSw3IEBAIHZvaWQgKl9fdm1hbGxv
Y19ub2RlX3JhbmdlKHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBhbGlnbiwNCj4g
IAl1bnNpZ25lZCBsb25nIHJlYWxfc2l6ZSA9IHNpemU7DQo+ICANCj4gIAlzaXplID0gUEFHRV9B
TElHTihzaXplKTsNCj4gLQlpZiAoIXNpemUgfHwgKHNpemUgPj4gUEFHRV9TSElGVCkgPiB0b3Rh
bHJhbV9wYWdlcykNCj4gKwlpZiAoIXNpemUgfHwgKHNpemUgPj4gUEFHRV9TSElGVCkgPiBhdG9t
aWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykpDQo+ICAJCWdvdG8gZmFpbDsNCj4gIA0KPiAg
CWFyZWEgPSBfX2dldF92bV9hcmVhX25vZGUoc2l6ZSwgYWxpZ24sIFZNX0FMTE9DIHwgVk1fVU5J
TklUSUFMSVpFRCB8DQo+IGRpZmYgLS1naXQgYS9tbS92bXN0YXQuYyBiL21tL3Ztc3RhdC5jDQo+
IGluZGV4IDYwMzhjZTUuLjIwNTUxZTggMTAwNjQ0DQo+IC0tLSBhL21tL3Ztc3RhdC5jDQo+ICsr
KyBiL21tL3Ztc3RhdC5jDQo+IEBAIC0yMjcsNyArMjI3LDcgQEAgaW50IGNhbGN1bGF0ZV9ub3Jt
YWxfdGhyZXNob2xkKHN0cnVjdCB6b25lICp6b25lKQ0KPiAgCSAqIDEyNQkJMTAyNAkJMTAJMTYt
MzIgR0IJOQ0KPiAgCSAqLw0KPiAgDQo+IC0JbWVtID0gem9uZS0+bWFuYWdlZF9wYWdlcyA+PiAo
MjcgLSBQQUdFX1NISUZUKTsNCj4gKwltZW0gPSBhdG9taWNfbG9uZ19yZWFkKCZ6b25lLT5tYW5h
Z2VkX3BhZ2VzKSA+PiAoMjcgLSBQQUdFX1NISUZUKTsNCj4gIA0KPiAgCXRocmVzaG9sZCA9IDIg
KiBmbHMobnVtX29ubGluZV9jcHVzKCkpICogKDEgKyBmbHMobWVtKSk7DQo+ICANCj4gQEAgLTE1
NjksNyArMTU2OSw3IEBAIHN0YXRpYyB2b2lkIHpvbmVpbmZvX3Nob3dfcHJpbnQoc3RydWN0IHNl
cV9maWxlICptLCBwZ19kYXRhX3QgKnBnZGF0LA0KPiAgCQkgICBoaWdoX3dtYXJrX3BhZ2VzKHpv
bmUpLA0KPiAgCQkgICB6b25lLT5zcGFubmVkX3BhZ2VzLA0KPiAgCQkgICB6b25lLT5wcmVzZW50
X3BhZ2VzLA0KPiAtCQkgICB6b25lLT5tYW5hZ2VkX3BhZ2VzKTsNCj4gKwkJICAgYXRvbWljX2xv
bmdfcmVhZCgmem9uZS0+bWFuYWdlZF9wYWdlcykpOw0KPiAgDQo+ICAJc2VxX3ByaW50ZihtLA0K
PiAgCQkgICAiXG4gICAgICAgIHByb3RlY3Rpb246ICglbGQiLA0KPiBkaWZmIC0tZ2l0IGEvbW0v
d29ya2luZ3NldC5jIGIvbW0vd29ya2luZ3NldC5jDQo+IGluZGV4IGIxNTc5OWQuLmRjZDRlMTYg
MTAwNjQ0DQo+IC0tLSBhL21tL3dvcmtpbmdzZXQuYw0KPiArKysgYi9tbS93b3JraW5nc2V0LmMN
Cj4gQEAgLTU1MCw3ICs1NTAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB3b3JraW5nc2V0X2luaXQo
dm9pZCkNCj4gIAkgKiBkb3VibGUgdGhlIGluaXRpYWwgbWVtb3J5IGJ5IHVzaW5nIHRvdGFscmFt
X3BhZ2VzIGFzLWlzLg0KPiAgCSAqLw0KPiAgCXRpbWVzdGFtcF9iaXRzID0gQklUU19QRVJfTE9O
RyAtIEVWSUNUSU9OX1NISUZUOw0KPiAtCW1heF9vcmRlciA9IGZsc19sb25nKHRvdGFscmFtX3Bh
Z2VzIC0gMSk7DQo+ICsJbWF4X29yZGVyID0gZmxzX2xvbmcoYXRvbWljX2xvbmdfcmVhZCgmdG90
YWxyYW1fcGFnZXMpIC0gMSk7DQo+ICAJaWYgKG1heF9vcmRlciA+IHRpbWVzdGFtcF9iaXRzKQ0K
PiAgCQlidWNrZXRfb3JkZXIgPSBtYXhfb3JkZXIgLSB0aW1lc3RhbXBfYml0czsNCj4gIAlwcl9p
bmZvKCJ3b3JraW5nc2V0OiB0aW1lc3RhbXBfYml0cz0lZCBtYXhfb3JkZXI9JWQgYnVja2V0X29y
ZGVyPSV1XG4iLA0KPiBkaWZmIC0tZ2l0IGEvbW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gaW5k
ZXggY2Q5MWZkOS4uNWQyZDdiOSAxMDA2NDQNCj4gLS0tIGEvbW0venN3YXAuYw0KPiArKysgYi9t
bS96c3dhcC5jDQo+IEBAIC0yMTksNyArMjE5LDcgQEAgc3RydWN0IHpzd2FwX3RyZWUgew0KPiAg
DQo+ICBzdGF0aWMgYm9vbCB6c3dhcF9pc19mdWxsKHZvaWQpDQo+ICB7DQo+IC0JcmV0dXJuIHRv
dGFscmFtX3BhZ2VzICogenN3YXBfbWF4X3Bvb2xfcGVyY2VudCAvIDEwMCA8DQo+ICsJcmV0dXJu
IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAqIHpzd2FwX21heF9wb29sX3BlcmNl
bnQgLyAxMDAgPA0KPiAgCQlESVZfUk9VTkRfVVAoenN3YXBfcG9vbF90b3RhbF9zaXplLCBQQUdF
X1NJWkUpOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9uZXQvZGNjcC9wcm90by5jIGIvbmV0
L2RjY3AvcHJvdG8uYw0KPiBpbmRleCA4NzU4NThjLi40YTkyZDExIDEwMDY0NA0KPiAtLS0gYS9u
ZXQvZGNjcC9wcm90by5jDQo+ICsrKyBiL25ldC9kY2NwL3Byb3RvLmMNCj4gQEAgLTExNTQsMTAg
KzExNTQsMTAgQEAgc3RhdGljIGludCBfX2luaXQgZGNjcF9pbml0KHZvaWQpDQo+ICAJICoNCj4g
IAkgKiBUaGUgbWV0aG9kb2xvZ3kgaXMgc2ltaWxhciB0byB0aGF0IG9mIHRoZSBidWZmZXIgY2Fj
aGUuDQo+ICAJICovDQo+IC0JaWYgKHRvdGFscmFtX3BhZ2VzID49ICgxMjggKiAxMDI0KSkNCj4g
LQkJZ29hbCA9IHRvdGFscmFtX3BhZ2VzID4+ICgyMSAtIFBBR0VfU0hJRlQpOw0KPiArCWlmIChh
dG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPj0gKDEyOCAqIDEwMjQpKQ0KPiArCQln
b2FsID0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+ICgyMSAtIFBBR0VfU0hJ
RlQpOw0KPiAgCWVsc2UNCj4gLQkJZ29hbCA9IHRvdGFscmFtX3BhZ2VzID4+ICgyMyAtIFBBR0Vf
U0hJRlQpOw0KPiArCQlnb2FsID0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+
ICgyMyAtIFBBR0VfU0hJRlQpOw0KPiAgDQo+ICAJaWYgKHRoYXNoX2VudHJpZXMpDQo+ICAJCWdv
YWwgPSAodGhhc2hfZW50cmllcyAqDQo+IGRpZmYgLS1naXQgYS9uZXQvZGVjbmV0L2RuX3JvdXRl
LmMgYi9uZXQvZGVjbmV0L2RuX3JvdXRlLmMNCj4gaW5kZXggMWMwMDJjMC4uYmI0OWIwZiAxMDA2
NDQNCj4gLS0tIGEvbmV0L2RlY25ldC9kbl9yb3V0ZS5jDQo+ICsrKyBiL25ldC9kZWNuZXQvZG5f
cm91dGUuYw0KPiBAQCAtMTg2Niw3ICsxODY2LDcgQEAgdm9pZCBfX2luaXQgZG5fcm91dGVfaW5p
dCh2b2lkKQ0KPiAgCWRuX3JvdXRlX3RpbWVyLmV4cGlyZXMgPSBqaWZmaWVzICsgZGVjbmV0X2Rz
dF9nY19pbnRlcnZhbCAqIEhaOw0KPiAgCWFkZF90aW1lcigmZG5fcm91dGVfdGltZXIpOw0KPiAg
DQo+IC0JZ29hbCA9IHRvdGFscmFtX3BhZ2VzID4+ICgyNiAtIFBBR0VfU0hJRlQpOw0KPiArCWdv
YWwgPSBhdG9taWNfbG9uZ19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPj4gKDI2IC0gUEFHRV9TSElG
VCk7DQo+ICANCj4gIAlmb3Iob3JkZXIgPSAwOyAoMVVMIDw8IG9yZGVyKSA8IGdvYWw7IG9yZGVy
KyspDQo+ICAJCS8qIE5PVEhJTkcgKi87DQo+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfbWV0
cmljcy5jIGIvbmV0L2lwdjQvdGNwX21ldHJpY3MuYw0KPiBpbmRleCAwM2I1MWNkLi5kOTFiZGFi
IDEwMDY0NA0KPiAtLS0gYS9uZXQvaXB2NC90Y3BfbWV0cmljcy5jDQo+ICsrKyBiL25ldC9pcHY0
L3RjcF9tZXRyaWNzLmMNCj4gQEAgLTEwMDAsNyArMTAwMCw3IEBAIHN0YXRpYyBpbnQgX19uZXRf
aW5pdCB0Y3BfbmV0X21ldHJpY3NfaW5pdChzdHJ1Y3QgbmV0ICpuZXQpDQo+ICANCj4gIAlzbG90
cyA9IHRjcG1oYXNoX2VudHJpZXM7DQo+ICAJaWYgKCFzbG90cykgew0KPiAtCQlpZiAodG90YWxy
YW1fcGFnZXMgPj0gMTI4ICogMTAyNCkNCj4gKwkJaWYgKGF0b21pY19sb25nX3JlYWQoJnRvdGFs
cmFtX3BhZ2VzKSA+PSAxMjggKiAxMDI0KQ0KPiAgCQkJc2xvdHMgPSAxNiAqIDEwMjQ7DQo+ICAJ
CWVsc2UNCj4gIAkJCXNsb3RzID0gOCAqIDEwMjQ7DQo+IGRpZmYgLS1naXQgYS9uZXQvbmV0Zmls
dGVyL25mX2Nvbm50cmFja19jb3JlLmMgYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19jb3Jl
LmMNCj4gaW5kZXggY2ExMTY4ZC4uMzI4NWRmOSAxMDA2NDQNCj4gLS0tIGEvbmV0L25ldGZpbHRl
ci9uZl9jb25udHJhY2tfY29yZS5jDQo+ICsrKyBiL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNr
X2NvcmUuYw0KPiBAQCAtMjI2NywxMSArMjI2NywxMSBAQCBpbnQgbmZfY29ubnRyYWNrX2luaXRf
c3RhcnQodm9pZCkNCj4gIAkJICogPj0gNEdCIG1hY2hpbmVzIGhhdmUgNjU1MzYgYnVja2V0cy4N
Cj4gIAkJICovDQo+ICAJCW5mX2Nvbm50cmFja19odGFibGVfc2l6ZQ0KPiAtCQkJPSAoKCh0b3Rh
bHJhbV9wYWdlcyA8PCBQQUdFX1NISUZUKSAvIDE2Mzg0KQ0KPiArCQkJPSAoKChhdG9taWNfbG9u
Z19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPDwgUEFHRV9TSElGVCkgLyAxNjM4NCkNCj4gIAkJCSAg
IC8gc2l6ZW9mKHN0cnVjdCBobGlzdF9oZWFkKSk7DQo+IC0JCWlmICh0b3RhbHJhbV9wYWdlcyA+
ICg0ICogKDEwMjQgKiAxMDI0ICogMTAyNCAvIFBBR0VfU0laRSkpKQ0KPiArCQlpZiAoYXRvbWlj
X2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4gKDQgKiAoMTAyNCAqIDEwMjQgKiAxMDI0IC8g
UEFHRV9TSVpFKSkpDQo+ICAJCQluZl9jb25udHJhY2tfaHRhYmxlX3NpemUgPSA2NTUzNjsNCj4g
LQkJZWxzZSBpZiAodG90YWxyYW1fcGFnZXMgPiAoMTAyNCAqIDEwMjQgKiAxMDI0IC8gUEFHRV9T
SVpFKSkNCj4gKwkJZWxzZSBpZiAoYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4g
KDEwMjQgKiAxMDI0ICogMTAyNCAvIFBBR0VfU0laRSkpDQo+ICAJCQluZl9jb25udHJhY2tfaHRh
YmxlX3NpemUgPSAxNjM4NDsNCj4gIAkJaWYgKG5mX2Nvbm50cmFja19odGFibGVfc2l6ZSA8IDMy
KQ0KPiAgCQkJbmZfY29ubnRyYWNrX2h0YWJsZV9zaXplID0gMzI7DQo+IGRpZmYgLS1naXQgYS9u
ZXQvbmV0ZmlsdGVyL3h0X2hhc2hsaW1pdC5jIGIvbmV0L25ldGZpbHRlci94dF9oYXNobGltaXQu
Yw0KPiBpbmRleCAzZTdkMjU5Li4zYzc5YTBmIDEwMDY0NA0KPiAtLS0gYS9uZXQvbmV0ZmlsdGVy
L3h0X2hhc2hsaW1pdC5jDQo+ICsrKyBiL25ldC9uZXRmaWx0ZXIveHRfaGFzaGxpbWl0LmMNCj4g
QEAgLTI3OSw5ICsyNzksOSBAQCBzdGF0aWMgaW50IGh0YWJsZV9jcmVhdGUoc3RydWN0IG5ldCAq
bmV0LCBzdHJ1Y3QgaGFzaGxpbWl0X2NmZzMgKmNmZywNCj4gIAlpZiAoY2ZnLT5zaXplKSB7DQo+
ICAJCXNpemUgPSBjZmctPnNpemU7DQo+ICAJfSBlbHNlIHsNCj4gLQkJc2l6ZSA9ICh0b3RhbHJh
bV9wYWdlcyA8PCBQQUdFX1NISUZUKSAvIDE2Mzg0IC8NCj4gKwkJc2l6ZSA9IChhdG9taWNfbG9u
Z19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPDwgUEFHRV9TSElGVCkgLyAxNjM4NCAvDQo+ICAJCSAg
ICAgICBzaXplb2Yoc3RydWN0IGhsaXN0X2hlYWQpOw0KPiAtCQlpZiAodG90YWxyYW1fcGFnZXMg
PiAxMDI0ICogMTAyNCAqIDEwMjQgLyBQQUdFX1NJWkUpDQo+ICsJCWlmIChhdG9taWNfbG9uZ19y
ZWFkKCZ0b3RhbHJhbV9wYWdlcykgPiAxMDI0ICogMTAyNCAqIDEwMjQgLyBQQUdFX1NJWkUpDQo+
ICAJCQlzaXplID0gODE5MjsNCj4gIAkJaWYgKHNpemUgPCAxNikNCj4gIAkJCXNpemUgPSAxNjsN
Cj4gZGlmZiAtLWdpdCBhL25ldC9zY3RwL3Byb3RvY29sLmMgYi9uZXQvc2N0cC9wcm90b2NvbC5j
DQo+IGluZGV4IDliMjc3YmQuLjRjYTRkZWYgMTAwNjQ0DQo+IC0tLSBhL25ldC9zY3RwL3Byb3Rv
Y29sLmMNCj4gKysrIGIvbmV0L3NjdHAvcHJvdG9jb2wuYw0KPiBAQCAtMTQyNiwxMCArMTQyNiwx
MCBAQCBzdGF0aWMgX19pbml0IGludCBzY3RwX2luaXQodm9pZCkNCj4gIAkgKiBUaGUgbWV0aG9k
b2xvZ3kgaXMgc2ltaWxhciB0byB0aGF0IG9mIHRoZSB0Y3AgaGFzaCB0YWJsZXMuDQo+ICAJICog
VGhvdWdoIG5vdCBpZGVudGljYWwuICBTdGFydCBieSBnZXR0aW5nIGEgZ29hbCBzaXplDQo+ICAJ
ICovDQo+IC0JaWYgKHRvdGFscmFtX3BhZ2VzID49ICgxMjggKiAxMDI0KSkNCj4gLQkJZ29hbCA9
IHRvdGFscmFtX3BhZ2VzID4+ICgyMiAtIFBBR0VfU0hJRlQpOw0KPiArCWlmIChhdG9taWNfbG9u
Z19yZWFkKCZ0b3RhbHJhbV9wYWdlcykgPj0gKDEyOCAqIDEwMjQpKQ0KPiArCQlnb2FsID0gYXRv
bWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+ICgyMiAtIFBBR0VfU0hJRlQpOw0KPiAg
CWVsc2UNCj4gLQkJZ29hbCA9IHRvdGFscmFtX3BhZ2VzID4+ICgyNCAtIFBBR0VfU0hJRlQpOw0K
PiArCQlnb2FsID0gYXRvbWljX2xvbmdfcmVhZCgmdG90YWxyYW1fcGFnZXMpID4+ICgyNCAtIFBB
R0VfU0hJRlQpOw0KPiAgDQo+ICAJLyogVGhlbiBjb21wdXRlIHRoZSBwYWdlIG9yZGVyIGZvciBz
YWlkIGdvYWwgKi8NCj4gIAlvcmRlciA9IGdldF9vcmRlcihnb2FsKTsNCj4gZGlmZiAtLWdpdCBh
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL2ltYV9rZXhlYy5jDQo+IGluZGV4IDE2YmQxODcuLjhiYjMyYWQgMTAwNjQ0DQo+IC0tLSBh
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMNCj4gKysrIGIvc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYw0KPiBAQCAtMTA2LDcgKzEwNiw3IEBAIHZvaWQgaW1hX2Fk
ZF9rZXhlY19idWZmZXIoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQo+ICAJCWtleGVjX3NlZ21lbnRf
c2l6ZSA9IEFMSUdOKGltYV9nZXRfYmluYXJ5X3J1bnRpbWVfc2l6ZSgpICsNCj4gIAkJCQkJICAg
UEFHRV9TSVpFIC8gMiwgUEFHRV9TSVpFKTsNCj4gIAlpZiAoKGtleGVjX3NlZ21lbnRfc2l6ZSA9
PSBVTE9OR19NQVgpIHx8DQo+IC0JICAgICgoa2V4ZWNfc2VnbWVudF9zaXplID4+IFBBR0VfU0hJ
RlQpID4gdG90YWxyYW1fcGFnZXMgLyAyKSkgew0KPiArCSAgICAoKGtleGVjX3NlZ21lbnRfc2l6
ZSA+PiBQQUdFX1NISUZUKSA+IGF0b21pY19sb25nX3JlYWQoJnRvdGFscmFtX3BhZ2VzKSAvIDIp
KSB7DQo+ICAJCXByX2VycigiQmluYXJ5IG1lYXN1cmVtZW50IGxpc3QgdG9vIGxhcmdlLlxuIik7
DQo+ICAJCXJldHVybjsNCj4gIAl9DQo=
