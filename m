Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F1C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 10:12:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC920840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 10:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rwgl5zqczF3N9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 21:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rwdg3dmnzF3Z6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 21:00:53 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA9A0kVX153697
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Nov 2018 05:00:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nn4p4q4tk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 05:00:48 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Fri, 9 Nov 2018 09:59:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 9 Nov 2018 09:59:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA99xUfS4850034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Nov 2018 09:59:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7B5542045;
 Fri,  9 Nov 2018 09:59:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9913E4203F;
 Fri,  9 Nov 2018 09:59:29 +0000 (GMT)
Received: from dhcp-9-193-110-205.in.ibm.com (unknown [9.193.110.205])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Nov 2018 09:59:29 +0000 (GMT)
Date: Fri, 9 Nov 2018 15:29:26 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] powerpc: Add KVM guest defconfig
References: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
 <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18110909-0008-0000-0000-00000290192C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110909-0009-0000-0000-000021FA19F6
Message-Id: <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=766 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090094
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 08, 2018 at 04:23:07PM -0200, Breno Leitao wrote:
> hi Satheesh,
> 
> On 11/08/2018 03:08 AM, sathnaga@linux.vnet.ibm.com wrote:
> > --- /dev/null
> > +++ b/arch/powerpc/configs/guest.config
> > @@ -0,0 +1,14 @@
> > +CONFIG_VIRTIO_BLK=y
> > +CONFIG_VIRTIO_BLK_SCSI=y
> > +CONFIG_SCSI_VIRTIO=y
> > +CONFIG_VIRTIO_NET=y
> > +CONFIG_NET_FAILOVER=y
> > +CONFIG_VIRTIO_CONSOLE=y
> > +CONFIG_VIRTIO=y
> > +CONFIG_VIRTIO_PCI=y
> > +CONFIG_KVM_GUEST=y
> > +CONFIG_EPAPR_PARAVIRT=y
> > +CONFIG_XFS_FS=y
> 
> Why a guest kernel needs to have XFS integrated in the core image? I am
> wondering if it is a requirement from another CONFIG_ option.

Idea is to have a working config which would boot guest without initramfs,
other FS(like EXT4) is already integrated in the core image, 
thought this would be helpful for distributions, which default XFS as root disk.

Hope this should be fine?

> 
> If it is not a strict requirement from another config, I think we can keep it
> as defined at ppc64_defconfig, which defines it as module (CONFIG_XFS_FS=m).
> 
> Thanks for this patch, very useful.

Thanks Breno! :-)

-Satheesh.

> Breno
> 

