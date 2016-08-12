Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9jWF1jlczDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 21:35:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7CBXhkM084537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:35:50 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24s2unf0vp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:35:50 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 08:35:48 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3C4241DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:35:37 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7CBZjUg33751398
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 08:35:45 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7CBZjSu002727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 08:35:45 -0300
Subject: Re: [PATCH v4] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160812055448.GA4393@gwshan>
 <fd9c2b76-cb67-750d-db62-fd820c9a028f@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2016 08:35:42 -0300
MIME-Version: 1.0
In-Reply-To: <fd9c2b76-cb67-750d-db62-fd820c9a028f@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <184de91d-7604-c65f-2b6d-68675a054289@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2016 03:03 AM, Andrew Donnellan wrote:
> On 12/08/16 15:54, Gavin Shan wrote:
>> It might be nicer for users to implement their own
>> pcibios_free_controller_deferred(),
>> meaning pSeries needs its own implementation for now. The reason is
>> more user (pSeries)
>> specific objects can be released together with the PHB. However, I'm
>> still fine without
>> the comment to be covered.
>
> That's probably not a bad idea, though from a cxl perspective I'm fine
> with using the current version.

I agree, but in that case the user _still_ can use another function.
This patch just provides an implementation that defaults to what was
already done, in a deferred manner.

If some users need something more specific, they can wire it up too :)
the same way we did - and it's explained in the function's comments.

Thanks for the review, suggestions and reaching a better and much more
interesting patch.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
