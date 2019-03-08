Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCB6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 16:03:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F6D20868
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 16:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44GC2w20sgzDqHV
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 03:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=svaidy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44GC0f4KNtzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2019 03:01:21 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28FxthJ099026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2019 11:01:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r3sgweh53-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Mar 2019 11:01:17 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 8 Mar 2019 16:01:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Mar 2019 16:01:11 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x28G1A6737355686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2019 16:01:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9BCD4C040;
 Fri,  8 Mar 2019 16:01:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA0CC4C05E;
 Fri,  8 Mar 2019 16:01:08 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.68.185])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri,  8 Mar 2019 16:01:08 +0000 (GMT)
Date: Fri, 8 Mar 2019 21:31:06 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/energy: Use OF accessor functions to read
 ibm,drc-indexes
References: <1552059204-18626-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1552059204-18626-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19030816-4275-0000-0000-00000318A81D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030816-4276-0000-0000-0000382706D3
Message-Id: <20190308160106.GA5263@drishya.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-08_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080110
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
Reply-To: svaidy@linux.vnet.ibm.com
Cc: "Pavithra R. Prakash" <pavrampu@in.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2019-03-08 21:03:24]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In cpu_to_drc_index() in the case when FW_FEATURE_DRC_INFO is absent,
> we currently use of_read_property() to obtain the pointer to the array
> corresponding to the property "ibm,drc-indexes". The elements of this
> array are of type __be32, but are accessed without any conversion to
> the OS-endianness, which is buggy on a Little Endian OS.
> 
> Fix this by using of_property_read_u32_index() accessor function to
> safely read the elements of the array.
> 
> Fixes: commit e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
> Cc: <stable@vger.kernel.org> #v4.16+
> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/pseries_energy.c | 27 ++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 6ed2212..1c4d1ba 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -77,18 +77,27 @@ static u32 cpu_to_drc_index(int cpu)
> 
>  		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
>  	} else {
> -		const __be32 *indexes;
> -
> -		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -		if (indexes == NULL)
> -			goto err_of_node_put;
> +		u32 nr_drc_indexes, thread_drc_index;
> 
>  		/*
> -		 * The first element indexes[0] is the number of drc_indexes
> -		 * returned in the list.  Hence thread_index+1 will get the
> -		 * drc_index corresponding to core number thread_index.
> +		 * The first element of ibm,drc-indexes array is the
> +		 * number of drc_indexes returned in the list.  Hence
> +		 * thread_index+1 will get the drc_index corresponding
> +		 * to core number thread_index.
>  		 */
> -		ret = indexes[thread_index + 1];
> +		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
> +						0, &nr_drc_indexes);
> +		if (rc)
> +			goto err_of_node_put;
> +
> +		WARN_ON(thread_index > nr_drc_indexes);
> +		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
> +						thread_index + 1,
> +						&thread_drc_index);
> +		if (rc)
> +			goto err_of_node_put;
> +
> +		ret = thread_drc_index;

Oops!  Good bugfix.  We should use device tree accessors like this in
all places for correct and safe code.

Thanks!

--Vaidy

