Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNtgc5Ck2zDw1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:07:08 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAN746fD060201
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 02:07:06 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w09a9es6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 02:07:05 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 23 Nov 2016 17:07:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3A4FB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:07:01 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAN771kb29884666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:07:01 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAN770RJ022682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:07:00 +1100
Subject: Re: [PATCH] cxl: fix coccinelle warnings
To: Ian Munsie <imunsie@au1.ibm.com>
References: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
 <1479883732-sup-5050@x230.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 fbarrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 23 Nov 2016 18:06:59 +1100
MIME-Version: 1.0
In-Reply-To: <1479883732-sup-5050@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <72ee4e44-af7d-2351-91ae-4f3f28999bce@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/11/16 17:49, Ian Munsie wrote:
> Most of these look fine
>
>> -    return debugfs_create_file(name, mode, parent, (void __force *)value, &fops_io_x64);
>> +    return debugfs_create_file_unsafe(name, mode, parent,
>> +                      (void __force *)value, &fops_io_x64);
>
> Just wondering what this one is about?

See explanation at https://lkml.org/lkml/2016/3/6/75 - when we use 
DEFINE_DEBUGFS_ATTRIBUTE() rather than DEFINE_SIMPLE_ATTRIBUTE(), we 
don't need the "lifetime managing proxy" that debugfs_create_file() sets up.

coccinelle proposed that change based on 
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
