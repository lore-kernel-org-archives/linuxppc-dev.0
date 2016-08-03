Return-Path: <millerjo@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4Jnd4wbBzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 02:44:37 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73GY9F3117672
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 12:44:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkafu8vm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 12:44:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Wed, 3 Aug 2016 10:44:34 -0600
From: Jack Miller <jack@codezen.org>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH] powernv: Search for new flash DT node location
Date: Wed,  3 Aug 2016 11:44:11 -0500
In-Reply-To: <147020859492.19099.3536038186529840354@concordia>
References: <147020859492.19099.3536038186529840354@concordia>
Message-Id: <20160803164412.7039-1-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 03, 2016 at 05:16:34PM +1000, Michael Ellerman wrote:
> We could instead just search for all nodes that are compatible with
> "ibm,opal-flash". We do that for i2c, see opal_i2c_create_devs().
> 
> Is there a particular reason not to do that?

I'm actually surprised that this is preferred. Jeremy mentioned something
similar, but I guess I just don't like the idea of finding devices in weird
places in the tree. Then again, if we can't trust the DT we're in bigger
trouble than erroneous flash nodes =).

If we really just want to find compatible nodes anywhere, let's simplify i2c
and pdev_init into one function and make that behavior consistent with this
new patch.

- Jack
