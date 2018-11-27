Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CFC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:51:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD242086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD242086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434HXf2rZJzDqm6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 08:50:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434HVP2CM2zDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 08:49:00 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARLifCM138397
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 16:48:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p18jfp1dj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 16:48:58 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Tue, 27 Nov 2018 21:48:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 21:48:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARLmmru53215338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 21:48:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61160A405F;
 Tue, 27 Nov 2018 21:48:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A298A4054;
 Tue, 27 Nov 2018 21:48:48 +0000 (GMT)
Received: from [9.148.204.175] (unknown [9.148.204.175])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 27 Nov 2018 21:48:47 +0000 (GMT)
Date: Tue, 27 Nov 2018 23:48:45 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181127211600.GB3235@lianli.shorne-pla.net>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
 <20181127211600.GB3235@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] openrisc: simplify pte_alloc_one_kernel()
To: Stafford Horne <shorne@gmail.com>
From: Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112721-0008-0000-0000-0000029973B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112721-0009-0000-0000-00002203B917
Message-Id: <7843DE67-DCC3-48BF-873F-71D87B08EDA8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_18:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270183
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On November 27, 2018 11:16:00 PM GMT+02:00, Stafford Horne <shorne@gmail=
=2Ecom> wrote:
>On Sun, Nov 25, 2018 at 11:44:36PM +0200, Mike Rapoport wrote:
>> The pte_alloc_one_kernel() function allocates a page using
>> __get_free_page(GFP_KERNEL) when mm initialization is complete and
>> memblock_phys_alloc() on the earlier stages=2E The physical address of
>the
>> page allocated with memblock_phys_alloc() is converted to the virtual
>> address and in the both cases the allocated page is cleared using
>> clear_page()=2E
>>=20
>> The code is simplified by replacing __get_free_page() with
>> get_zeroed_page() and by replacing memblock_phys_alloc() with
>> memblock_alloc()=2E
>
>Hello Mike,
>
>This looks fine to me=2E  How do you plan to get this merged?  Will you
>be taking
>care of the whole series or so you want me to queue this openrisc part?

I was thinking about merging via the -mm tree=2E
Andrew, would that be ok?

>> Signed-off-by: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>
>Acked-by: Stafford Horne <shorne@gmail=2Ecom>

Thanks!

>> ---
>>  arch/openrisc/mm/ioremap=2Ec | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/openrisc/mm/ioremap=2Ec b/arch/openrisc/mm/ioremap=2E=
c
>> index c969752=2E=2Ecfef989 100644
>> --- a/arch/openrisc/mm/ioremap=2Ec
>> +++ b/arch/openrisc/mm/ioremap=2Ec
>> @@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct
>mm_struct *mm,
>>  {
>>  	pte_t *pte;
>> =20
>> -	if (likely(mem_init_done)) {
>> -		pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
>> -	} else {
>> -		pte =3D (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
>> -	}
>> +	if (likely(mem_init_done))
>> +		pte =3D (pte_t *)get_zeroed_page(GFP_KERNEL);
>> +	else
>> +		pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> =20
>> -	if (pte)
>> -		clear_page(pte);
>>  	return pte;
>>  }
>> --=20
>> 2=2E7=2E4
>>=20

--=20
Sincerely yours,
Mike=2E

