Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FAECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A282083A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ns7leTQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A282083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bP7R1yMJzF3K1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 20:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="ns7leTQu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="ns7leTQu"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bP4m3SqSzF3CP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:33:59 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I9TDkH052788;
 Thu, 18 Oct 2018 09:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=E/wiXgcB7/xp80s+Lj2qwG5J8OZ/O/z8MCc6bEkHGoU=;
 b=ns7leTQu+Az/sAgKHedoxrCfc5XXc+/TBIDlJ7nAfSRr24h5kZd7C8CnzVmI5W8E9fVB
 EtDGsf9kiGrs4nTVmQdusCr0Nz1Flfw5Q3sLYOE3SnlSoIdV9f0tP1E93vYPoIFSG0jg
 oxalA5if1uZjVfj5PdrEZYISAcnxEvwuPPD9eqlJ9TKViXlbXxy9S3G6gwFN0jzkI4nk
 +Y9yWkiXotb0VeBtEt+BMqx3LALnuzOFPtfsKtleukvoxfOXNHGLFpQB63nfu40rii8b
 tUrOsxZ0qh83whR/+00zCWBbrg3+J3bsu4AWdioJKAJane2PMq+dhbsZyTpPNE5FJkeV ig== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2n384udkt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Oct 2018 09:33:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9I9XrBp008331
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Oct 2018 09:33:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9I9Xqh9030870;
 Thu, 18 Oct 2018 09:33:53 GMT
Received: from kili.mountain (/129.205.6.86)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 18 Oct 2018 02:33:52 -0700
Date: Thu, 18 Oct 2018 12:33:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: anju@linux.vnet.ibm.com
Subject: [bug report] powerpc/perf: Add nest IMC PMU support
Message-ID: <20181018093346.gw72isttyope3nxe@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180091
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Anju T Sudhakar,

The patch 885dcd709ba9: "powerpc/perf: Add nest IMC PMU support" from
Jul 19, 2017, leads to the following static checker warning:

	arch/powerpc/perf/imc-pmu.c:506 nest_imc_event_init()
	warn: 'pcni' can't be NULL.

arch/powerpc/perf/imc-pmu.c
   485          if (event->cpu < 0)
   486                  return -EINVAL;
   487  
   488          pmu = imc_event_to_pmu(event);
   489  
   490          /* Sanity check for config (event offset) */
   491          if ((config & IMC_EVENT_OFFSET_MASK) > pmu->counter_mem_size)
   492                  return -EINVAL;
   493  
   494          /*
   495           * Nest HW counter memory resides in a per-chip reserve-memory (HOMER).
   496           * Get the base memory addresss for this cpu.
   497           */
   498          chip_id = cpu_to_chip_id(event->cpu);
   499          pcni = pmu->mem_info;
                ^^^^^^^^^^^^^^^^^^^^
   500          do {
   501                  if (pcni->id == chip_id) {
   502                          flag = true;
   503                          break;
   504                  }
   505                  pcni++;
                        ^^^^^^
   506          } while (pcni);
                         ^^^^
This will loop until we crash.  I'm not sure what was intended.

   507  
   508          if (!flag)
   509                  return -ENODEV;
   510  

regards,
dan carpenter
