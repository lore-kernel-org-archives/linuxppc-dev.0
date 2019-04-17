Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591CC282DC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 21:44:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFEE21850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 21:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFEE21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kwk73s0QzDqC0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:44:31 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kwgc0HT7zDqNW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 07:42:19 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HLY8nP119588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 17:42:16 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rxabtw7hf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 17:42:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Wed, 17 Apr 2019 22:42:15 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 22:42:11 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HLg9h29568440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 21:42:09 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94A37C6059;
 Wed, 17 Apr 2019 21:42:09 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C26A0C6055;
 Wed, 17 Apr 2019 21:42:05 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.230.182])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 17 Apr 2019 21:42:05 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190323165456-mutt-send-email-mst@kernel.org>
Date: Wed, 17 Apr 2019 18:42:00 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041721-0016-0000-0000-000009A2014C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010946; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190543; UDB=6.00623874; IPR=6.00971342; 
 MB=3.00026490; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 21:42:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041721-0017-0000-0000-000042DA68A3
Message-Id: <87a7go71hz.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170137
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


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
>>
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>
>> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
>> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
>> >> only ever try to access memory addresses that are supplied to it by the
>> >> guest, so all of the secure guest memory that the host cares about is
>> >> accessible:
>> >>
>> >>     If this feature bit is set to 0, then the device has same access to
>> >>     memory addresses supplied to it as the driver has. In particular,
>> >>     the device will always use physical addresses matching addresses
>> >>     used by the driver (typically meaning physical addresses used by the
>> >>     CPU) and not translated further, and can access any address supplied
>> >>     to it by the driver. When clear, this overrides any
>> >>     platform-specific description of whether device access is limited or
>> >>     translated in any way, e.g. whether an IOMMU may be present.
>> >>
>> >> All of the above is true for POWER guests, whether they are secure
>> >> guests or not.
>> >>
>> >> Or are you saying that a virtio device may want to access memory
>> >> addresses that weren't supplied to it by the driver?
>> >
>> > Your logic would apply to IOMMUs as well.  For your mode, there are
>> > specific encrypted memory regions that driver has access to but device
>> > does not. that seems to violate the constraint.
>>
>> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
>> the device can ignore the IOMMU for all practical purposes I would
>> indeed say that the logic would apply to IOMMUs as well. :-)
>>
>> I guess I'm still struggling with the purpose of signalling to the
>> driver that the host may not have access to memory addresses that it
>> will never try to access.
>
> For example, one of the benefits is to signal to host that driver does
> not expect ability to access all memory. If it does, host can
> fail initialization gracefully.

But why would the ability to access all memory be necessary or even
useful? When would the host access memory that the driver didn't tell it
to access?

>> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
>> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
>> >> >>
>> >> >> My understanding is, AMD guest-platform knows in advance that their
>> >> >> guest will run in secure mode and hence sets the flag at the time of VM
>> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
>> >> >
>> >> > Well you do have that luxury. It looks like that there are existing
>> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
>> >> > with how that path is slow. So you are trying to optimize for
>> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
>> >> > to invoke DMA API.
>> >> >
>> >> > For example if there was another flag just like ACCESS_PLATFORM
>> >> > just not yet used by anyone, you would be all fine using that right?
>> >>
>> >> Yes, a new flag sounds like a great idea. What about the definition
>> >> below?
>> >>
>> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
>> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
>> >>     exception that the IOMMU is explicitly defined to be off or bypassed
>> >>     when accessing memory addresses supplied to the device by the
>> >>     driver. This flag should be set by the guest if offered, but to
>> >>     allow for backward-compatibility device implementations allow for it
>> >>     to be left unset by the guest. It is an error to set both this flag
>> >>     and VIRTIO_F_ACCESS_PLATFORM.
>> >
>> > It looks kind of narrow but it's an option.
>>
>> Great!
>>
>> > I wonder how we'll define what's an iommu though.
>>
>> Hm, it didn't occur to me it could be an issue. I'll try.

I rephrased it in terms of address translation. What do you think of
this version? The flag name is slightly different too:


VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
    meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
    with the exception that address translation is guaranteed to be
    unnecessary when accessing memory addresses supplied to the device
    by the driver. Which is to say, the device will always use physical
    addresses matching addresses used by the driver (typically meaning
    physical addresses used by the CPU) and not translated further. This
    flag should be set by the guest if offered, but to allow for
    backward-compatibility device implementations allow for it to be
    left unset by the guest. It is an error to set both this flag and
    VIRTIO_F_ACCESS_PLATFORM.

>> > Another idea is maybe something like virtio-iommu?
>>
>> You mean, have legacy guests use virtio-iommu to request an IOMMU
>> bypass? If so, it's an interesting idea for new guests but it doesn't
>> help with guests that are out today in the field, which don't have A
>> virtio-iommu driver.
>
> I presume legacy guests don't use encrypted memory so why do we
> worry about them at all?

They don't use encrypted memory, but a host machine will run a mix of
secure and legacy guests. And since the hypervisor doesn't know whether
a guest will be secure or not at the time it is launched, legacy guests
will have to be launched with the same configuration as secure guests.

>> >> > Is there any justification to doing that beyond someone putting
>> >> > out slow code in the past?
>> >>
>> >> The definition of the ACCESS_PLATFORM flag is generic and captures the
>> >> notion of memory access restrictions for the device. Unfortunately, on
>> >> powerpc pSeries guests it also implies that the IOMMU is turned on
>> >
>> > IIUC that's really because on pSeries IOMMU is *always* turned on.
>> > Platform has no way to say what you want it to say
>> > which is bypass the iommu for the specific device.
>>
>> Yes, that's correct. pSeries guests running on KVM are in a gray area
>> where theoretically they use an IOMMU but in practice KVM ignores it.
>> It's unfortunate but it's the reality on the ground today. :-/
>
> Well it's not just the reality, virt setups need something that
> emulated IOMMUs don't provide. That is not uncommon, e.g.
> intel's VTD has a "cache mode" field which AFAIK is only used for virt.

That's good to know. Thanks for this example.

--
Thiago Jung Bauermann
IBM Linux Technology Center

