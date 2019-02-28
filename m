Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE0DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:53:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD7A2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD7A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4497DG4LmwzDq9y
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4497BN2d0RzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:52:11 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S9nTHf002993
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:52:08 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qxce8ah89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:52:08 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Feb 2019 09:52:07 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 09:52:04 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S9q39T19923098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Feb 2019 09:52:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66361112067;
 Thu, 28 Feb 2019 09:52:03 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4E78112063;
 Thu, 28 Feb 2019 09:52:02 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.84])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 09:52:02 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id D25832E2D5F; Thu, 28 Feb 2019 15:22:00 +0530 (IST)
Date: Thu, 28 Feb 2019 15:22:00 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: powercap: Add hard minimum powercap
References: <1551260002-26792-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <871s3s34jb.fsf@dja-thinkpad.axtens.net>
 <57fc8253-c5c3-6103-77cd-34aa4ec250a3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fc8253-c5c3-6103-77cd-34aa4ec250a3@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19022809-0052-0000-0000-0000039229C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010679; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167519; UDB=6.00609945; IPR=6.00948132; 
 MB=3.00025777; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 09:52:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022809-0053-0000-0000-00005FFF1717
Message-Id: <20190228095200.GB24751@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280070
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
Reply-To: ego@linux.vnet.ibm.com
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shilpa,

On Thu, Feb 28, 2019 at 11:25:25AM +0530, Shilpasri G Bhat wrote:
> Hi,
> 
> On 02/28/2019 10:14 AM, Daniel Axtens wrote:
> > Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> > 
> >> In POWER9, OCC(On-Chip-Controller) provides for hard and soft system
> >> powercapping range. The hard powercap range is guaranteed while soft
> >> powercap may or may not be asserted due to various power-thermal
> >> reasons based on system configuration and workloads. This patch adds
> >> a sysfs file to export the hard minimum powercap limit to allow the
> >> user to set the appropriate powercap value that can be managed by the
> >> system.
> > 
> > Maybe it's common terminology and I'm just not aware of it, but what do
> > you mean by "asserted"? It doesn't appear elsewhere in the documentation
> > you're patching, and it's not a use of assert that I'm familiar with...
> > 
> > Regards,
> > Daniel
> > 
> 
> I meant to say powercap will not be assured in the soft powercap range, i.e,
> system may or may not be throttled of CPU frequency to remain within the powercap.
> 
> I can reword the document and commit message.

I agree with Daniel. How about replacing "asserted" with "enforced by
the OCC"?


> 
> Thanks and Regards,
> Shilpa

--
Thanks and Regards
gautham.

> 
> >>
> >> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> >> ---
> >>  .../ABI/testing/sysfs-firmware-opal-powercap       | 10 ++++
> >>  arch/powerpc/platforms/powernv/opal-powercap.c     | 66 +++++++++-------------
> >>  2 files changed, 37 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> >> index c9b66ec..65db4c1 100644
> >> --- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> >> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> >> @@ -29,3 +29,13 @@ Description:	System powercap directory and attributes applicable for
> >>  		  creates a request for setting a new-powercap. The
> >>  		  powercap requested must be between powercap-min
> >>  		  and powercap-max.
> >> +
> >> +What:		/sys/firmware/opal/powercap/system-powercap/powercap-hard-min
> >> +Date:		Feb 2019
> >> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> >> +Description:	Hard minimum powercap
> >> +
> >> +		This file provides the hard minimum powercap limit in
> >> +		Watts. The powercap value above hard minimum is always
> >> +		guaranteed to be asserted and the powercap value below
> >> +		the hard minimum limit may or may not be guaranteed.
> >> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> >> index d90ee4f..38408e7 100644
> >> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
> >> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> >> @@ -139,10 +139,24 @@ static void powercap_add_attr(int handle, const char *name,
> >>  	attr->handle = handle;
> >>  	sysfs_attr_init(&attr->attr.attr);
> >>  	attr->attr.attr.name = name;
> >> -	attr->attr.attr.mode = 0444;
> >> +
> >> +	if (!strncmp(name, "powercap-current", strlen(name))) {
> >> +		attr->attr.attr.mode = 0664;
> >> +		attr->attr.store = powercap_store;
> >> +	} else {
> >> +		attr->attr.attr.mode = 0444;
> >> +	}
> >> +
> >>  	attr->attr.show = powercap_show;
> >>  }
> >>  
> >> +static const char * const powercap_strs[] = {
> >> +	"powercap-max",
> >> +	"powercap-min",
> >> +	"powercap-current",
> >> +	"powercap-hard-min",
> >> +};
> >> +
> >>  void __init opal_powercap_init(void)
> >>  {
> >>  	struct device_node *powercap, *node;
> >> @@ -167,60 +181,34 @@ void __init opal_powercap_init(void)
> >>  
> >>  	i = 0;
> >>  	for_each_child_of_node(powercap, node) {
> >> -		u32 cur, min, max;
> >> -		int j = 0;
> >> -		bool has_cur = false, has_min = false, has_max = false;
> >> +		u32 id;
> >> +		int j, count = 0;
> >>  
> >> -		if (!of_property_read_u32(node, "powercap-min", &min)) {
> >> -			j++;
> >> -			has_min = true;
> >> -		}
> >> -
> >> -		if (!of_property_read_u32(node, "powercap-max", &max)) {
> >> -			j++;
> >> -			has_max = true;
> >> -		}
> >> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++)
> >> +			if (!of_property_read_u32(node, powercap_strs[j], &id))
> >> +				count++;
> >>  
> >> -		if (!of_property_read_u32(node, "powercap-current", &cur)) {
> >> -			j++;
> >> -			has_cur = true;
> >> -		}
> >> -
> >> -		pcaps[i].pattrs = kcalloc(j, sizeof(struct powercap_attr),
> >> +		pcaps[i].pattrs = kcalloc(count, sizeof(struct powercap_attr),
> >>  					  GFP_KERNEL);
> >>  		if (!pcaps[i].pattrs)
> >>  			goto out_pcaps_pattrs;
> >>  
> >> -		pcaps[i].pg.attrs = kcalloc(j + 1, sizeof(struct attribute *),
> >> +		pcaps[i].pg.attrs = kcalloc(count + 1,
> >> +					    sizeof(struct attribute *),
> >>  					    GFP_KERNEL);
> >>  		if (!pcaps[i].pg.attrs) {
> >>  			kfree(pcaps[i].pattrs);
> >>  			goto out_pcaps_pattrs;
> >>  		}
> >>  
> >> -		j = 0;
> >>  		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
> >> -		if (has_min) {
> >> -			powercap_add_attr(min, "powercap-min",
> >> -					  &pcaps[i].pattrs[j]);
> >> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> >> -			j++;
> >> -		}
> >> -
> >> -		if (has_max) {
> >> -			powercap_add_attr(max, "powercap-max",
> >> -					  &pcaps[i].pattrs[j]);
> >> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> >> -			j++;
> >> -		}
> >> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++) {
> >> +			if (of_property_read_u32(node, powercap_strs[j], &id))
> >> +				continue;
> >>  
> >> -		if (has_cur) {
> >> -			powercap_add_attr(cur, "powercap-current",
> >> +			powercap_add_attr(id, powercap_strs[j],
> >>  					  &pcaps[i].pattrs[j]);
> >> -			pcaps[i].pattrs[j].attr.attr.mode |= 0220;
> >> -			pcaps[i].pattrs[j].attr.store = powercap_store;
> >>  			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> >> -			j++;
> >>  		}
> >>  
> >>  		if (sysfs_create_group(powercap_kobj, &pcaps[i].pg)) {
> >> -- 
> >> 1.8.3.1
> > 

