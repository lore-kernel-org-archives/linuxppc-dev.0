Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A9C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 14:38:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9970E20685
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 14:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9970E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pZzR3Jq3zF1Qn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 01:38:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pZx45rn8zDsGJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 01:36:02 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA5EYTbG193525
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Nov 2018 09:35:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2njptdbg6k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 09:35:59 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Mon, 5 Nov 2018 14:35:53 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 5 Nov 2018 14:35:50 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA5EZnQh8192354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Nov 2018 14:35:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CA9242042;
 Mon,  5 Nov 2018 14:35:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD20C4204B;
 Mon,  5 Nov 2018 14:35:47 +0000 (GMT)
Received: from MiWiFi-R3L-srv (unknown [9.122.211.233])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Nov 2018 14:35:47 +0000 (GMT)
Date: Mon, 5 Nov 2018 20:05:41 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: System not booting since dm changes? (was Linux 4.20-rc1)
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
 <87tvkvddnk.fsf@concordia.ellerman.id.au>
 <20181105135157.GA11485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105135157.GA11485@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18110514-0012-0000-0000-000002C3A00A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110514-0013-0000-0000-000020F7DF23
Message-Id: <20181105143541.GA29120@MiWiFi-R3L-srv>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-05_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050134
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
Cc: axboe@kernel.dk, satheera@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 05, 2018 at 08:51:57AM -0500, Mike Snitzer wrote:
> On Mon, Nov 05 2018 at  5:25am -0500,
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > ...
> > > Mike Snitzer (1):
> > >     device mapper updates
> > 
> > Hi Mike,
> > 
> > Replying here because I can't find the device-mapper pull or the patch
> > in question on LKML. I guess I should be subscribed to dm-devel.
> > 
> > We have a box that doesn't boot any more, bisect points at one of:
> > 
> >   cef6f55a9fb4 Mike Snitzer       dm table: require that request-based DM be layered on blk-mq devices 
> >   953923c09fe8 Mike Snitzer       dm: rename DM_TYPE_MQ_REQUEST_BASED to DM_TYPE_REQUEST_BASED 
> >   6a23e05c2fe3 Jens Axboe         dm: remove legacy request-based IO path 
> > 
> > 
> > It's a Power8 system running Rawhide, it does have multipath, but I'm
> > told it was setup by the Fedora installer, ie. nothing fancy.
> > 
> > The symptom is the system can't find its root filesystem and drops into
> > the initramfs shell. The dmesg includes a bunch of errors like below:
> > 
> >   [   43.263460] localhost multipathd[1344]: sdb: fail to get serial
> >   [   43.268762] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdb
> >   [   43.268762] localhost multipathd[1344]: uevent trigger error
> >   [   43.282065] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
> ...
> >
> > Any ideas what's going wrong here?
> 
> "table load rejected: not all devices are blk-mq request-stackable"
> speaks to the fact that you aren't using blk-mq for scsi (aka scsi-mq).
> 
> You need to use scsi_mod.use_blk_mq=Y on the kernel commandline (or set
> CONFIG_SCSI_MQ_DEFAULT in your kernel config)

Thanks Mike!, above solution worked and the system booted fine now:-)

# uname -r
4.20.0-rc1+
# cat /proc/cmdline 
root=/dev/mapper/fedora_ltc--test--ci2-root ro rd.lvm.lv=fedora_ltc-test-ci2/root rd.lvm.lv=fedora_ltc-test-ci2/swap scsi_mod.use_blk_mq=Y

CONFIG_SCSI_MQ_DEFAULT kernel was not set in my kernel config, will set in future runs.

Thanks Michael!

Regards,
-Satheesh.

> 
> Mike
> 

