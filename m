Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60630C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B729F6199F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B729F6199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4cJh6jTxz3bvb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Mar 2021 03:29:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-xilinx-onmicrosoft-com header.b=K1XVlOJn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xilinx.com (client-ip=40.107.220.59;
 helo=nam11-co1-obe.outbound.protection.outlook.com;
 envelope-from=michals@xilinx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-xilinx-onmicrosoft-com
 header.b=K1XVlOJn; dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4cJ84ttQz301l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Mar 2021 03:28:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4h58ml4kThb89neCjlOY5Ic95bk7SILq7JcY816ivYAiPt5hQNbzT51P0+bdeOSXoC/4q6R5fumo46Qwu8AYSF/mgAgqE5a1xnLGJf4MVVLGgHE3WOHoMxLNgiv+hK15ee8VTKsM/JDpWDxpFObPOIbpOHmTbMZNdPn/Nz9KCKnpWvBQHASoYjoFUC9KNhFYJZXwd2b+ZEUfV//Y+GQfmtyWfxhSRiHJOtVbrwnqnuEY/wo5rNrUlq/hWcOIYoXVypqy8X3y+VgVO3X7WhTPlE3XQWpSkupzLtnI75/v5PhaPVhg6M6+pjpnTA8cZXorRecLGqpICgdHQ4SClGCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhsk6AL94YBbLzmn/zCho12U/YJ2GFpVoXVWB5GXAN8=;
 b=jMvoQ9Dw9KApFQfey/4iMeXgeScqiWspKFL5VgR566E2zHh2RgHtpPizJe7bkPqRvbshelRjR950vGJFZuSvqd1Hl1CNHIz3M1pv4XWPIGoTGyE9AUAwe4abD/xDfwhgvGWm3SLjX88Yx/NPXZcJFXoDwYHea+JrRczUzqPe5etN80/I2+rzYrb+BxdpX4FZ/DwAcN6SW5ulZiDr5gVKmlDOE4WAhmzvLdd3L2GBE2UVbKdZEieso5/YZY9Wy9YlzFgARSBztjqS9a2ALYS4GTIzZe/osLBEkUrFHKGorivvSPP8CvU0oOLFmYs9ZI8z50qeGUJMuQRCNYjvGSXyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhsk6AL94YBbLzmn/zCho12U/YJ2GFpVoXVWB5GXAN8=;
 b=K1XVlOJnGr3OjElBtBy98bqnUMbWJkNBSC1Hx2ZmwsybQ4CnM4HaqB6XWP0xOUxZiAVCWlPXnXwuExv8DTAW2rgvfyoIKxhSDiyzF+gxi/bfQdInoKtsQ8N/v6lipYkG3aUSJCfE6CWl0fgPv6Rp2o+pPJoGCGQKpuearBT93DY=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) by CH2PR02MB6903.namprd02.prod.outlook.com
 (2603:10b6:610:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 16:28:50 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::bc) by SN4PR0201CA0070.outlook.office365.com
 (2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 16:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 16:28:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 09:28:47 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 09:28:47 -0700
Envelope-to: git@xilinx.com, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org, devicetree@vger.kernel.org,
 yuehaibing@huawei.com, robh+dt@kernel.org, paulus@samba.org,
 mpe@ellerman.id.au, chris.packham@alliedtelesis.co.nz,
 benh@kernel.crashing.org, monstr@monstr.eu,
 linux-kernel@vger.kernel.org, dave@stgolabs.net, axboe@kernel.dk
Received: from [172.30.17.109] (port=50090)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <michal.simek@xilinx.com>)
 id 1lOjte-0003T2-GO; Tue, 23 Mar 2021 09:28:46 -0700
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To: Jens Axboe <axboe@kernel.dk>, Michal Simek <michal.simek@xilinx.com>,
 Davidlohr Bueso <dave@stgolabs.net>
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
 <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
 <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
 <66a774e3-f068-984e-e69f-b55667a494cf@kernel.dk>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <f3ecc92d-9f53-6a25-9e40-74efba199da6@xilinx.com>
Date: Tue, 23 Mar 2021 17:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <66a774e3-f068-984e-e69f-b55667a494cf@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560c4081-5f3d-4f0a-c6f1-08d8ee18bcee
X-MS-TrafficTypeDiagnostic: CH2PR02MB6903:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB6903CD76CAE27CF1CD49C520C6649@CH2PR02MB6903.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqaIdtuRCwqGi1EnUFdDbHeHIkwF3KfQI5/RY3qA5P3xHf4BWCJXdjXM6wQtRjZD5x6xtlziKaHu3lXE81V927bUJ+WTnxnvnIXriT5CcDqTZ5c3XKeah1JuHBFzL1bTHQv0f/xz8h1/IP34eEMbOhcD+6nJCBuRH1LE+SRkDLPOXoqrpMjN3Z5d62/1S9CUo9X4UelXtXSwp0ReZfFYzNSjRxCSHZ6PR2WZtBtbramUYp3PMwVJVkUmhMyNi3VeyJV4ktzgsMc5SbGGL4xy2Qwkfd8DK7TH20MhG4NgwBm1r821F7BFKImSQXp7I6i7VoPvntqwanPKc/iO6Efg/5hRR3E1Tywpxw6ELZyk9quK/sinOEu1pxAhIpe/Xmtms0FZfukUtlXcZoTpqh24T203XtLUGJI6JeWyITtZUd05TJpGrvrmQtD7Qs3lADiBhm2HyV6gZAlKICOmbODJt3EEiaLlYrkNEmwaEuhHHC+Ik5NECXEhwhtZCQyTlRPYz3cgN41/ue6PvzyrfAta4v0auljZ7vwyPS7wDfkxR5yjTyNrvO+nJPFXckeebwoAzacQBEknszBtHxxAvpjM/IbOr4D45tGHwoZukqvrLoLl9bNjm92hcZnpF1UIsZV7mctqkUjeddIpiwyvGjVENAY4Ubng32AoYj7RE6fs2aXcQFMLGyBRnLbiQh4oULR9VPD3LN3bxRqyo43Hru13dw==
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(36840700001)(46966006)(31696002)(5660300002)(7636003)(478600001)(36860700001)(82310400003)(36756003)(356005)(4326008)(82740400003)(53546011)(2906002)(36906005)(47076005)(316002)(70586007)(110136005)(26005)(4744005)(31686004)(8936002)(8676002)(44832011)(7416002)(70206006)(54906003)(6666004)(336012)(2616005)(426003)(9786002)(186003)(50156003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 16:28:48.8516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560c4081-5f3d-4f0a-c6f1-08d8ee18bcee
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6903
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
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-block@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Paul Mackerras <paulus@samba.org>, git@xilinx.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 3/23/21 5:28 PM, Jens Axboe wrote:
> On 3/23/21 10:25 AM, Michal Simek wrote:
>>
>>
>> On 3/23/21 5:23 PM, Jens Axboe wrote:
>>> On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
>>>> Hi,
>>>>
>>>> On Mon, 09 Nov 2020, Michal Simek wrote:
>>>>
>>>>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>>>>> systems. The driver is not regularly tested and very likely not working for
>>>>> quite a long time that's why remove it.
>>>>
>>>> Is there a reason this patch was never merged? can the driver be
>>>> removed? I ran into this as a potential tasklet user that can be
>>>> replaced/removed.
>>>
>>> I'd be happy to merge it for 5.13.
>>>
>>
>> Can you just take this version? Or do you want me to send it again?
> 
> Minor edits needed for fuzz, but I've applied this version.

Thanks,
Michal

