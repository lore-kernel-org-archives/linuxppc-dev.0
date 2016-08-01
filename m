Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s30g06S7WzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 23:34:20 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71DTN8Q109658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 09:34:16 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gn5x2j5b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 09:34:16 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 14:34:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id DAE0C17D8067
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 14:35:47 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71DYCHm56230088
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 13:34:12 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71DYBV2011255
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 09:34:12 -0400
Subject: Re: [PATCH] cxl: replace loop with for_each_child_of_node(), remove
 unneeded of_node_put()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <601fb58c-7aee-91ce-2a3d-7a29787968fc@au1.ibm.com>
 <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87fuqsllmf.fsf@concordia.ellerman.id.au>
Cc: clombard@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
 imunsie@au1.ibm.com, elfring@users.sourceforge.net
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 1 Aug 2016 15:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <87fuqsllmf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f4252894-4f35-e296-6a72-e29200d6dcd1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 29/07/2016 à 13:38, Michael Ellerman a écrit :
> But who does keep a reference on the device_node? I can't see it anywhere. Which
> means in theory the device_node can be freed out from under you.
>
> You have a reference for afu_np as part of for_each_child_of_node(), but it's
> dropped as soon as you go around the loop.
>
> The typical pattern would be that cxl_guest_init_afu() takes an additional
> reference once it's done all its setup and can't fail.
>
> That way at the end of the loop when the loop construct has dropped all
> references, the nodes you actually init'ed have their reference count
> incremented by 1.


We don't keep a reference on the AFU device_node. Once we've read the 
config of the AFU, the AFU device_node is never accessed again. So I 
guess it's possible (though unexpected) that it's freed from under us, 
but it should not affect the driver.

The AFU is really dependent on the adapter itself, which is one level up 
in the device tree, and for which we create a device through 
of_platform_device_create(). The properties under the AFU device node 
are read directly from the PCI config space in the bare-metal case, 
where the cxl adapter is a PCI device.

Do we really have a problem here?

   Fred
