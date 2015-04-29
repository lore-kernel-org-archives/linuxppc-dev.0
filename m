Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2FC1A186C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:34:01 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 11:33:57 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7C67138C8067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 11:33:53 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3TFXpUC54853758
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:33:51 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3TFXpfU019751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 11:33:51 -0400
Message-ID: <5540F9DE.5080404@linux.vnet.ibm.com>
Date: Wed, 29 Apr 2015 10:33:50 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] Correct cpu affinity for dlpar added cpus
References: <553FA94D.2000608@linux.vnet.ibm.com>
 <1430283207.12906.1.camel@ellerman.id.au>
In-Reply-To: <1430283207.12906.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2015 11:53 PM, Michael Ellerman wrote:
> Subject should be "powerpc/pseries: ..." please.

ok

> 
> On Tue, 2015-04-28 at 10:37 -0500, Nathan Fontenot wrote:
>> The incorrect ordering of operations during cpu dlpar causes the affinity
>> of cpus being added to be invalid. Phyp does not assign affinity information
>> for a cpu until the rtas set-indicator calls are made to set the isolation
>> and allocation state. In the current code we call rtas configure-connector
>> before making the set-indicator calls which results in invalid data in the
>> ibm,associativity property for the cpu we're adding.
> 
> Invalid and benign? Or invalid and causes an oops or ..?
>

Invalid and benign. I'll add this to the description.
 
>> This patch corrects the order of operations to make the set-indicator
>> calls (done in acquire_drc) before calling configure-connector.
> 
> Which commit added the code and/or caused it to be wrong?
> 
>   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n187
> 

And the commit that this fixes..

> 
> While looking at the code I notice it looks like we leak a reference if
> dlpar_configure_connector() fails:
> 
> 	parent = of_find_node_by_path("/cpus");
> 	if (!parent)
> 		return -ENODEV;
> 
> 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
> 	if (!dn)
> 		return -EINVAL;
> 
> 	of_node_put(parent);
> 
> 
> Please send a separate patch to fix that.

Yep, saw that too.

New patches on their way.

Thanks for the feedback,
-Nathan
