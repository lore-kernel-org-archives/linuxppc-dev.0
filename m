Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqKyR6z0nzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 23:52:15 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DDn99e040199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:52:12 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2455fcyqsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:52:12 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 10:52:10 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3458A3520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:51:50 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DDq8kb4816934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:52:08 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DDq7cn014330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:52:08 -0300
Subject: Re: [PATCH] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467687331.13965.27.camel@kernel.crashing.org>
 <5785782D.3010407@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2016 10:52:05 -0300
MIME-Version: 1.0
In-Reply-To: <5785782D.3010407@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57864785.1090309@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2016 08:07 PM, Mauricio Faria de Oliveira wrote:
> Can you clarify which are the devices that should be tracked w/ krefs to
> the PHB?

Last night I had forgotten about the fundamental point of krefs - track 
references to pointers - and this answers the question.

I'm looking at the holders of pointers to the phb struct, and it seems
I wasn't too far off w/ the child buses and devices idea -- as the root 
bus (phb->bus) is assigned the phb pointer in the bus->sysdata field,
and it's inherited from parent by child buses and devices.

I'll continue here. Comments always welcome.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
