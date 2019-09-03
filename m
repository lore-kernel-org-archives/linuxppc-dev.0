Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78576C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 12:20:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3C621881
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 12:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3C621881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N5df3NzszDqkS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 22:20:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=185.176.76.210; helo=huawei.com;
 envelope-from=salil.mehta@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N5WY5C0xzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 22:15:30 +1000 (AEST)
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 753D7BB2B3393EB50659;
 Tue,  3 Sep 2019 13:15:25 +0100 (IST)
Received: from lhreml706-chm.china.huawei.com (10.201.108.55) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Sep 2019 13:15:24 +0100
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 3 Sep 2019 13:15:24 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1713.004; 
 Tue, 3 Sep 2019 13:15:24 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, linyunsheng <linyunsheng@huawei.com>
Subject: RE: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Thread-Topic: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Thread-Index: AQHVX8GNBL5oIOBXa0SEJvQofbg/+KcU43KAgAAUrYCAAGV1gIACdciAgAAbngCAAFO8AIAACMEAgAEjOgCAAA6PgIAAYoGQ
Date: Tue, 3 Sep 2019 12:15:24 +0000
Message-ID: <3bc19c01095545ddbe2ba424f5488b4d@huawei.com>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
 <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
 <20190831161247.GM2369@hirez.programming.kicks-ass.net>
 <ae64285f-5134-4147-7b02-34bb5d519e8c@huawei.com>
 <20190902072542.GN2369@hirez.programming.kicks-ass.net>
 <5fa2aa99-89fa-cd41-b090-36a23cfdeb73@huawei.com>
 <20190902125644.GQ2369@hirez.programming.kicks-ass.net>
 <1f48081c-c9d6-8f3e-9559-8b0bec98f125@huawei.com>
 <20190903071111.GU2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190903071111.GU2369@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 03 Sep 2019 22:17:45 +1000
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
Cc: "dalias@libc.org" <dalias@libc.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 Linuxarm <linuxarm@huawei.com>,
 "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mwb@linux.vnet.ibm.com" <mwb@linux.vnet.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "chenhc@lemote.com" <chenhc@lemote.com>, "will@kernel.org" <will@kernel.org>,
 "cai@lca.pw" <cai@lca.pw>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
 "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "jhogan@kernel.org" <jhogan@kernel.org>,
 "nfont@linux.vnet.ibm.com" <nfont@linux.vnet.ibm.com>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "len.brown@intel.com" <len.brown@intel.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "rth@twiddle.net" <rth@twiddle.net>, "axboe@kernel.dk" <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "tbogendoerfer@suse.de" <tbogendoerfer@suse.de>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Peter Zi=
jlstra
> Sent: Tuesday, September 3, 2019 8:11 AM
>=20
> On Tue, Sep 03, 2019 at 02:19:04PM +0800, Yunsheng Lin wrote:
> > On 2019/9/2 20:56, Peter Zijlstra wrote:
> > > On Mon, Sep 02, 2019 at 08:25:24PM +0800, Yunsheng Lin wrote:
> > >> On 2019/9/2 15:25, Peter Zijlstra wrote:
> > >>> On Mon, Sep 02, 2019 at 01:46:51PM +0800, Yunsheng Lin wrote:
> > >>>> On 2019/9/1 0:12, Peter Zijlstra wrote:
> > >>>
> > >>>>> 1) because even it is not set, the device really does belong to a=
 node.
> > >>>>> It is impossible a device will have magic uniform access to memor=
y when
> > >>>>> CPUs cannot.
> > >>>>
> > >>>> So it means dev_to_node() will return either NUMA_NO_NODE or a
> > >>>> valid node id?
> > >>>
> > >>> NUMA_NO_NODE :=3D -1, which is not a valid node number. It is also,=
 like> I
> > >>> said, not a valid device location on a NUMA system.
> > >>>
> > >>> Just because ACPI/BIOS is shit, doesn't mean the device doesn't hav=
e a
> > >>> node association. It just means we don't know and might have to gue=
ss.
> > >>
> > >> How do we guess the device's location when ACPI/BIOS does not set it=
?
> > >
> > > See device_add(), it looks to the device's parent and on NO_NODE, put=
s
> > > it there.
> > >
> > > Lacking any hints, just stick it to node0 and print a FW_BUG or
> > > something.
> > >
> > >> It seems dev_to_node() does not do anything about that and leave the
> > >> job to the caller or whatever function that get called with its retu=
rn
> > >> value, such as cpumask_of_node().
> > >
> > > Well, dev_to_node() doesn't do anything; nor should it. It are the
> > > callers of set_dev_node() that should be taking care.
> > >
> > > Also note how device_add() sets the device node to the parent device'=
s
> > > node on NUMA_NO_NODE. Arguably we should change it to complain when i=
t
> > > finds NUMA_NO_NODE and !parent.
> >
> > Is it possible that the node id set by device_add() become invalid
> > if the node is offlined, then dev_to_node() may return a invalid
> > node id.
>=20
> In that case I would expect the device to go away too. Once the memory
> controller goes away, the PCI bus connected to it cannot continue to
> function.

I am not sure if this is *exactly* true on our system as NUMA nodes are
part of the SoCs and devices could still be used even if all the memory
and CPUs part of the node are turned off. Although, it is highly unlikely
anybody would do that(maybe could be debated for the Power Management case?=
)=20

Best Regards
Salil

