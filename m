Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F96W4GmTzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 12:32:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5Q2Sael117224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 22:32:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qejg6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 22:31:59 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 26 Jun 2018 03:31:58 +0100
Subject: Re: [PATCH 00/10] cxl: Remove abandonned capi support for the
 Mellanox CX4
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180625162406.10813-1-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 26 Jun 2018 12:31:52 +1000
MIME-Version: 1.0
In-Reply-To: <20180625162406.10813-1-fbarrat@linux.ibm.com>
Message-Id: <21307b77-9c3e-574b-e4af-e61ecc54a803@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/06/18 02:23, Frederic Barrat wrote:
> An attempt was made to add capi support for the Mellanox CX4 card, so
> that it could operate in "traditional" PCI mode or capi mode. The
> project ended up being canceled and a different approach was taken for
> CX5. Mellanox never upstreamed any capi support in their CX4 driver.
> 
> CX4 was not following exactly the CAIA 1.0 model, so some CX4-specific
> code was added. That code is now dead and hasn't been tested for a
> while, so it's probably broken anyway. Let's remove it. It has been
> agreed with engineers at Mellanox, of course.
> 
> No user API is affected. Some (unused) symbols exported by cxl are removed.
> 
> Most of the patch set consists of reverts of older patches, with
> sometimes very minor tweaking. The last patch aggregates a few changes
> where reverting was not possible easily.
> 
> Tests run to prevent regressions:
> -  memcpy tests on POWER8 and POWER9
> -  Mellanox CX5, which uses a different code path, based on cxllib
> -  cxlflash tests on POWER8

9 of these commits are missing Signed-off-bys.

git revert -s is a thing :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
