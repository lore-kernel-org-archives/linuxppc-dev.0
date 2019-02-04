Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C8C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEB82082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEB82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tbWV2bWwzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tbT65hmxzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 05:14:34 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x14I9Ofm070612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Feb 2019 13:14:32 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qet3w921k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 13:14:32 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 4 Feb 2019 18:14:30 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 4 Feb 2019 18:14:26 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x14IEPKa23592984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Feb 2019 18:14:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3D27AE05F;
 Mon,  4 Feb 2019 18:14:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3270AE05C;
 Mon,  4 Feb 2019 18:14:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.235.178])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon,  4 Feb 2019 18:14:22 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190129134750-mutt-send-email-mst@kernel.org>
Date: Mon, 04 Feb 2019 16:14:20 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19020418-0072-0000-0000-000003F491CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010536; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01156338; UDB=6.00603144; IPR=6.00936797; 
 MB=3.00025434; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-04 18:14:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020418-0073-0000-0000-00004B0F3B28
Message-Id: <877eefxvyb.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-04_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040140
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
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello Michael,

Michael S. Tsirkin <mst@redhat.com> writes:

> On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
>>
>> Fixing address of powerpc mailing list.
>>
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>
>> > Hello,
>> >
>> > With Christoph's rework of the DMA API that recently landed, the patch
>> > below is the only change needed in virtio to make it work in a POWER
>> > secure guest under the ultravisor.
>> >
>> > The other change we need (making sure the device's dma_map_ops is NULL
>> > so that the dma-direct/swiotlb code is used) can be made in
>> > powerpc-specific code.
>> >
>> > Of course, I also have patches (soon to be posted as RFC) which hook up
>> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
>> >
>> > What do you think?
>> >
>> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
>> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> > Date: Thu, 24 Jan 2019 22:08:02 -0200
>> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
>> >
>> > The host can't access the guest memory when it's encrypted, so using
>> > regular memory pages for the ring isn't an option. Go through the DMA API.
>> >
>> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Well I think this will come back to bite us (witness xen which is now
> reworking precisely this path - but at least they aren't to blame, xen
> came before ACCESS_PLATFORM).
>
> I also still think the right thing would have been to set
> ACCESS_PLATFORM for all systems where device can't access all memory.

I understand. The problem with that approach for us is that because we
don't know which guests will become secure guests and which will remain
regular guests, QEMU would need to offer ACCESS_PLATFORM to all guests.

And the problem with that is that for QEMU on POWER, having
ACCESS_PLATFORM turned off means that it can bypass the IOMMU for the
device (which makes sense considering that the name of the flag was
IOMMU_PLATFORM). And we need that for regular guests to avoid
performance degradation.

So while ACCESS_PLATFORM solves our problems for secure guests, we can't
turn it on by default because we can't affect legacy systems. Doing so
would penalize existing systems that can access all memory. They would
all have to unnecessarily go through address translations, and take a
performance hit.

The semantics of ACCESS_PLATFORM assume that the hypervisor/QEMU knows
in advance - right when the VM is instantiated - that it will not have
access to all guest memory. Unfortunately that assumption is subtly
broken on our secure-platform. The hypervisor/QEMU realizes that the
platform is going secure only *after the VM is instantiated*. It's the
kernel running in the VM that determines that it wants to switch the
platform to secure-mode.

Another way of looking at this issue which also explains our reluctance
is that the only difference between a secure guest and a regular guest
(at least regarding virtio) is that the former uses swiotlb while the
latter doens't. And from the device's point of view they're
indistinguishable. It can't tell one guest that is using swiotlb from
one that isn't. And that implies that secure guest vs regular guest
isn't a virtio interface issue, it's "guest internal affairs". So
there's no reason to reflect that in the feature flags.

That said, we still would like to arrive at a proper design for this
rather than add yet another hack if we can avoid it. So here's another
proposal: considering that the dma-direct code (in kernel/dma/direct.c)
automatically uses swiotlb when necessary (thanks to Christoph's recent
DMA work), would it be ok to replace virtio's own direct-memory code
that is used in the !ACCESS_PLATFORM case with the dma-direct code? That
way we'll get swiotlb even with !ACCESS_PLATFORM, and virtio will get a
code cleanup (replace open-coded stuff with calls to existing
infrastructure).

> But I also think I don't have the energy to argue about power secure
> guest anymore.  So be it for power secure guest since the involved
> engineers disagree with me.  Hey I've been wrong in the past ;).

Yeah, it's been a difficult discussion. Thanks for still engaging!
I honestly thought that this patch was a good solution (if the guest has
encrypted memory it means that the DMA API needs to be used), but I can
see where you are coming from. As I said, we'd like to arrive at a good
solution if possible.

> But the name "sev_active" makes me scared because at least AMD guys who
> were doing the sensible thing and setting ACCESS_PLATFORM

My understanding is, AMD guest-platform knows in advance that their
guest will run in secure mode and hence sets the flag at the time of VM
instantiation. Unfortunately we dont have that luxury on our platforms.

> (unless I'm
> wrong? I reemember distinctly that's so) will likely be affected too.
> We don't want that.
>
> So let's find a way to make sure it's just power secure guest for now
> pls.

Yes, my understanding is that they turn ACCESS_PLATFORM on. And because
of that, IIUC this patch wouldn't affect them because in their platform
vring_use_dma_api() returns true earlier in the
"if !virtio_has_iommu_quirk(vdev)" condition.

> I also think we should add a dma_api near features under virtio_device
> such that these hacks can move off data path.

Sorry, I don't understand this.

> By the way could you please respond about virtio-iommu and
> why there's no support for ACCESS_PLATFORM on power?

There is support for ACCESS_PLATFORM on POWER. We don't enable it
because it causes a performance hit.

> I have Cc'd you on these discussions.

I'm having a look at the spec and the patches, but to be honest I'm not
the best powerpc guy for this. I'll see if I can get others to have a
look.

> Thanks!

Thanks as well!

--
Thiago Jung Bauermann
IBM Linux Technology Center

