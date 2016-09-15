Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZgq7548mzDsYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 00:32:19 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FESIwX130971
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 10:32:17 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fk2wqpgx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 10:32:17 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 08:32:16 -0600
Date: Thu, 15 Sep 2016 09:31:57 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] drivers/of: recognize status property of dt
 memory nodes
References: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1473883618-14998-2-git-send-email-arbab@linux.vnet.ibm.com>
 <CAL_JsqK5ngY-eJggPSo5AGcv4CC2b8Y1X_aYzr06_Zf6Kv-u=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAL_JsqK5ngY-eJggPSo5AGcv4CC2b8Y1X_aYzr06_Zf6Kv-u=w@mail.gmail.com>
Message-Id: <20160915143157.mi7xhxfedbic6m63@arbab-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2016 at 08:43:08AM -0500, Rob Herring wrote:
>On Wed, Sep 14, 2016 at 3:06 PM, Reza Arbab <arbab@linux.vnet.ibm.com> wrote:
>> +       status = of_get_flat_dt_prop(node, "status", NULL);
>> +       add_memory = !status || !strcmp(status, "okay");
>
>Move this into it's own function to mirror the unflattened version
>(of_device_is_available). Also, make sure the logic is the same. IIRC,
>"ok" is also allowed.

Will do. 

>> @@ -1057,6 +1062,9 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>>                 pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
>>                     (unsigned long long)size);
>>
>> +               if (!add_memory)
>> +                       continue;
>
>There's no point in checking this in the loop. status applies to the
>whole node. Just return up above.

I was trying to preserve that pr_debug output for these nodes, but I'm 
also fine with skipping it.

Thanks for your feedback! I'll spin a v3 of this patchset soon.

-- 
Reza Arbab
