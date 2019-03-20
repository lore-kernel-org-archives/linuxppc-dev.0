Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B1C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8DC2183E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8DC2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PZlX3XQ8zDqQn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:15:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PZjg4YJGzDqNQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 03:13:59 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2KG93aQ070883
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 12:13:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rbrr70dbp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 12:13:55 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Wed, 20 Mar 2019 16:13:54 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 16:13:49 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2KGDmSd16384054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2019 16:13:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8598778066;
 Wed, 20 Mar 2019 16:13:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E3737805F;
 Wed, 20 Mar 2019 16:13:44 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.191.231])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Mar 2019 16:13:44 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190204144048-mutt-send-email-mst@kernel.org>
Date: Wed, 20 Mar 2019 13:13:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19032016-0016-0000-0000-0000099510E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177137; UDB=6.00615761; IPR=6.00957832; 
 MB=3.00026075; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 16:13:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032016-0017-0000-0000-0000428556B5
Message-Id: <87ef71seve.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200122
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
Cc: Mike Anderson <andmike@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello Michael,

Sorry for the delay in responding. We had some internal discussions on
this.

Michael S. Tsirkin <mst@redhat.com> writes:

> On Mon, Feb 04, 2019 at 04:14:20PM -0200, Thiago Jung Bauermann wrote:
>>
>> Hello Michael,
>>
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>
>> > On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
>> So while ACCESS_PLATFORM solves our problems for secure guests, we can't
>> turn it on by default because we can't affect legacy systems. Doing so
>> would penalize existing systems that can access all memory. They would
>> all have to unnecessarily go through address translations, and take a
>> performance hit.
>
> So as step one, you just give hypervisor admin an option to run legacy
> systems faster by blocking secure mode. I don't see why that is
> so terrible.

There are a few reasons why:

1. It's bad user experience to require people to fiddle with knobs for
obscure reasons if it's possible to design things such that they Just
Work.

2. "User" in this case can be a human directly calling QEMU, but could
also be libvirt or one of its users, or some other framework. This means
having to adjust and/or educate an open-ended number of people and
software. It's best avoided if possible.

3. The hypervisor admin and the admin of the guest system don't
necessarily belong to the same organization (e.g., cloud provider and
cloud customer), so there may be some friction when they need to
coordinate to get this right.

4. A feature of our design is that the guest may or may not decide to
"go secure" at boot time, so it's best not to depend on flags that may
or may not have been set at the time QEMU was started.

>> The semantics of ACCESS_PLATFORM assume that the hypervisor/QEMU knows
>> in advance - right when the VM is instantiated - that it will not have
>> access to all guest memory.
>
> Not quite. It just means that hypervisor can live with not having
> access to all memory. If platform wants to give it access
> to all memory that is quite all right.

Except that on powerpc it also means "there's an IOMMU present" and
there's no way to say "bypass IOMMU translation". :-/

>> Another way of looking at this issue which also explains our reluctance
>> is that the only difference between a secure guest and a regular guest
>> (at least regarding virtio) is that the former uses swiotlb while the
>> latter doens't.
>
> But swiotlb is just one implementation. It's a guest internal thing. The
> issue is that memory isn't host accessible.

From what I understand of the ACCESS_PLATFORM definition, the host will
only ever try to access memory addresses that are supplied to it by the
guest, so all of the secure guest memory that the host cares about is
accessible:

    If this feature bit is set to 0, then the device has same access to
    memory addresses supplied to it as the driver has. In particular,
    the device will always use physical addresses matching addresses
    used by the driver (typically meaning physical addresses used by the
    CPU) and not translated further, and can access any address supplied
    to it by the driver. When clear, this overrides any
    platform-specific description of whether device access is limited or
    translated in any way, e.g. whether an IOMMU may be present.

All of the above is true for POWER guests, whether they are secure
guests or not.

Or are you saying that a virtio device may want to access memory
addresses that weren't supplied to it by the driver?

>> And from the device's point of view they're
>> indistinguishable. It can't tell one guest that is using swiotlb from
>> one that isn't. And that implies that secure guest vs regular guest
>> isn't a virtio interface issue, it's "guest internal affairs". So
>> there's no reason to reflect that in the feature flags.
>
> So don't. The way not to reflect that in the feature flags is
> to set ACCESS_PLATFORM.  Then you say *I don't care let platform device*.
>
>
> Without ACCESS_PLATFORM
> virtio has a very specific opinion about the security of the
> device, and that opinion is that device is part of the guest
> supervisor security domain.

Sorry for being a bit dense, but not sure what "the device is part of
the guest supervisor security domain" means. In powerpc-speak,
"supervisor" is the operating system so perhaps that explains my
confusion. Are you saying that without ACCESS_PLATFORM, the guest
considers the host to be part of the guest operating system's security
domain? If so, does that have any other implication besides "the host
can access any address supplied to it by the driver"? If that is the
case, perhaps the definition of ACCESS_PLATFORM needs to be amended to
include that information because it's not part of the current
definition.

>> That said, we still would like to arrive at a proper design for this
>> rather than add yet another hack if we can avoid it. So here's another
>> proposal: considering that the dma-direct code (in kernel/dma/direct.c)
>> automatically uses swiotlb when necessary (thanks to Christoph's recent
>> DMA work), would it be ok to replace virtio's own direct-memory code
>> that is used in the !ACCESS_PLATFORM case with the dma-direct code? That
>> way we'll get swiotlb even with !ACCESS_PLATFORM, and virtio will get a
>> code cleanup (replace open-coded stuff with calls to existing
>> infrastructure).
>
> Let's say I have some doubts that there's an API that
> matches what virtio with its bag of legacy compatibility exactly.

Ok.

>> > But the name "sev_active" makes me scared because at least AMD guys who
>> > were doing the sensible thing and setting ACCESS_PLATFORM
>>
>> My understanding is, AMD guest-platform knows in advance that their
>> guest will run in secure mode and hence sets the flag at the time of VM
>> instantiation. Unfortunately we dont have that luxury on our platforms.
>
> Well you do have that luxury. It looks like that there are existing
> guests that already acknowledge ACCESS_PLATFORM and you are not happy
> with how that path is slow. So you are trying to optimize for
> them by clearing ACCESS_PLATFORM and then you have lost ability
> to invoke DMA API.
>
> For example if there was another flag just like ACCESS_PLATFORM
> just not yet used by anyone, you would be all fine using that right?

Yes, a new flag sounds like a great idea. What about the definition
below?

VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
    VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
    exception that the IOMMU is explicitly defined to be off or bypassed
    when accessing memory addresses supplied to the device by the
    driver. This flag should be set by the guest if offered, but to
    allow for backward-compatibility device implementations allow for it
    to be left unset by the guest. It is an error to set both this flag
    and VIRTIO_F_ACCESS_PLATFORM.

> Is there any justification to doing that beyond someone putting
> out slow code in the past?

The definition of the ACCESS_PLATFORM flag is generic and captures the
notion of memory access restrictions for the device. Unfortunately, on
powerpc pSeries guests it also implies that the IOMMU is turned on even
though pSeries guests have never used IOMMU for virtio devices. Combined
with the lack of a way to turn off or bypass the IOMMU for virtio
devices, this means that existing guests in the field are compelled to
use the IOMMU even though that never was the case before, and said
guests having no mechanism to turn it off.

Therefore, we need a new flag to signal the memory access restriction
present in secure guests which doesn't also imply turning on the IOMMU.

--
Thiago Jung Bauermann
IBM Linux Technology Center

