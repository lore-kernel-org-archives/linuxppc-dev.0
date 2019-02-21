Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:59:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62002077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62002077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4457fC6NQDzDqTd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 08:58:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4457cZ353VzDqSK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 08:57:33 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LLp494014816
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 16:57:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qt489g7c5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 16:57:31 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 21 Feb 2019 21:57:30 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 21:57:24 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LLvNcR11927674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Feb 2019 21:57:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A5E112062;
 Thu, 21 Feb 2019 21:57:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDFCF112061;
 Thu, 21 Feb 2019 21:57:19 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.181.131])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Feb 2019 21:57:19 +0000 (GMT)
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190118103235-mutt-send-email-mst@kernel.org>
 <0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com>
 <20190129135345-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
In-reply-to: <20190129135345-mutt-send-email-mst@kernel.org>
Date: Thu, 21 Feb 2019 18:57:17 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19022121-0052-0000-0000-0000038E1FAB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164435; UDB=6.00608078; IPR=6.00945021; 
 MB=3.00025687; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 21:57:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022121-0053-0000-0000-00005FECFE1A
Message-Id: <87a7ioby9u.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210148
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 tnowicki@caviumnetworks.com, virtio-dev@lists.oasis-open.org,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, jasowang@redhat.com, linuxppc-dev@lists.ozlabs.org,
 will.deacon@arm.com, frowand.list@gmail.com,
 virtualization@lists.linux-foundation.org, marc.zyngier@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com,
 robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> On Mon, Jan 21, 2019 at 11:29:05AM +0000, Jean-Philippe Brucker wrote:
>> Hi,
>>
>> On 18/01/2019 15:51, Michael S. Tsirkin wrote:
>> >
>> > On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
>> >> Implement the virtio-iommu driver, following specification v0.9 [1].
>> >>
>> >> This is a simple rebase onto Linux v5.0-rc2. We now use the
>> >> dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing
>> >> dev->iommu_fwspec, but there aren't any functional change from v6 [2].
>> >>
>> >> Our current goal for virtio-iommu is to get a paravirtual IOMMU working
>> >> on Arm, and enable device assignment to guest userspace. In this
>> >> use-case the mappings are static, and don't require optimal performance,
>> >> so this series tries to keep things simple. However there is plenty more
>> >> to do for features and optimizations, and having this base in v5.1 would
>> >> be good. Given that most of the changes are to drivers/iommu, I believe
>> >> the driver and future changes should go via the IOMMU tree.
>> >>
>> >> You can find Linux driver and kvmtool device on v0.9.2 branches [3],
>> >> module and x86 support on virtio-iommu/devel. Also tested with Eric's
>> >> QEMU device [4]. Please note that the series depends on Robin's
>> >> probe-deferral fix [5], which will hopefully land in v5.0.
>> >>
>> >> [1] Virtio-iommu specification v0.9, sources and pdf
>> >>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>> >>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
>> >>
>> >> [2] [PATCH v6 0/7] Add virtio-iommu driver
>> >>     https://lists.linuxfoundation.org/pipermail/iommu/2018-December/032127.html
>> >>
>> >> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2
>> >>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2
>> >>
>> >> [4] [RFC v9 00/17] VIRTIO-IOMMU device
>> >>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
>> >>
>> >> [5] [PATCH] iommu/of: Fix probe-deferral
>> >>     https://www.spinics.net/lists/arm-kernel/msg698371.html
>> >
>> > Thanks for the work!
>> > So really my only issue with this is that there's no
>> > way for the IOMMU to describe the devices that it
>> > covers.
>> >
>> > As a result that is then done in a platform-specific way.
>> >
>> > And this means that for example it does not solve the problem that e.g.
>> > some power people have in that their platform simply does not have a way
>> > to specify which devices are covered by the IOMMU.
>>
>> Isn't power using device tree? I haven't looked much at power because I
>> was told a while ago that they already paravirtualize their IOMMU and
>> don't need virtio-iommu, except perhaps for some legacy platforms. Or
>> something along those lines. But I would certainly be interested in
>> enabling the IOMMU for more architectures.
>
> I have CC'd the relevant ppc developers, let's see what do they think.

I'm far from being an expert, but what could be very useful for us is to
have a way for the guest to request IOMMU bypass for a device.

From what I understand, the pSeries platform used by POWER guests always
puts devices behind an IOMMU, so at least for current systems a
description of which devices are covered by the IOMMU would always say
"all of them".

>> As for the enumeration problem, I still don't think we can get much
>> better than DT and ACPI as solutions (and IMO they are necessary to make
>> this device portable). But I believe that getting DT and ACPI support is
>> just a one-off inconvenience. That is, once the required bindings are
>> accepted, any future extension can then be done at the virtio level with
>> feature bits and probe requests, without having to update ACPI or DT.

There is a device tree binding that can specify devices connected to a
given IOMMU in Documentation/devicetree/bindings/iommu/iommu.txt.
I don't believe POWER machines use it though.

>> Thanks,
>> Jean
>>
>> > Solving that problem would make me much more excited about
>> > this device.
>> >
>> > On the other hand I can see that while there have been some
>> > developments most of the code has been stable for quite a while now.
>> >
>> > So what I am trying to do right about now, is making a small module that
>> > loads early and pokes at the IOMMU sufficiently to get the data about
>> > which devices use the IOMMU out of it using standard virtio config
>> > space.  IIUC it's claimed to be impossible without messy changes to the
>> > boot sequence.
>> >
>> > If I succeed at least on some platforms I'll ask that this design is
>> > worked into this device, minimizing info that goes through DT/ACPI.  If
>> > I see I can't make it in time to meet the next merge window, I plan
>> > merging the existing patches using DT (barring surprises).
>> >
>> > As I only have a very small amount of time to spend on this attempt, If
>> > someone else wants to try doing that in parallel, that would be great!

--
Thiago Jung Bauermann
IBM Linux Technology Center

