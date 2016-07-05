Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkPyB5GkPzDqqL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 23:34:58 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u65DYDZh118499
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 09:34:56 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x6gk5y44-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 09:34:55 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 5 Jul 2016 10:34:53 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 2D825352005F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 09:34:33 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u65DYoj212779924
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 10:34:50 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u65DYoOu019713
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 10:34:50 -0300
Subject: Re: [PATCH] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467687331.13965.27.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 10:34:47 -0300
MIME-Version: 1.0
In-Reply-To: <1467687331.13965.27.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577BB777.2080308@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2016 11:55 PM, Benjamin Herrenschmidt wrote:
> Have you considered instead adding a kref to the PHB and only freeing
> it when all devices have been freed ? Or it's too hard to tract device
> creation ?

Yes, considered it, but felt leery of possibly leaving the PHB unfreed
(or block until it is freed) in the call that is supposed to remove it:

for example, if it's not freed yet (because of an userspace program
that holds references, maybe misbehaving or in error)...

- Should the call block? -- in the sense of what would it mean to the
   DLPAR tools (say, drmgr and hmc) that might see a timeout as failure,
   and perhaps won't retry it?
   Or if the administrator requested the adapter/PHB to be removed,
   maybe he's aware of the situation and actually wants the removal
   to happen anyway.

- If it should not block, the phb struct would be left there at mercy
   of the reference holders, and perhaps complicate things if the PHB
   is re-added later on? (say, bring the adapter back to the LPAR)
   Could the tools think it's already added/still present, and then
   stop in error?

Now, putting the complicated scenarios aside, implementing krefs would
touch several other parts of code that I'm less comfortable to change
at this moment, which would probably take a lot more time to do.

So, for simplicity and schedule/backport/time constraints, I've shot
for a less intrusive change that still resolves the problem.

Do you think it's an acceptable solution as is, or needs change or to
be implemented in a different way?

Thanks,

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
