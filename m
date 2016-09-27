Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjpCX6kjTzDrSj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 14:44:40 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8R4gpv1128382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 00:44:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qh5aj1yq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 00:44:38 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 00:44:37 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jack Miller <jack@codezen.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powernv: Search for new flash DT node location
In-Reply-To: <87vazhb4cb.fsf@concordia.ellerman.id.au>
References: <147020859492.19099.3536038186529840354@concordia>
 <20160803164412.7039-1-jack@codezen.org>
 <87vazhb4cb.fsf@concordia.ellerman.id.au>
Date: Tue, 27 Sep 2016 14:44:25 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737kmx87q.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Jack Miller <jack@codezen.org> writes:
>
>> On Wed, Aug 03, 2016 at 05:16:34PM +1000, Michael Ellerman wrote:
>>> We could instead just search for all nodes that are compatible with
>>> "ibm,opal-flash". We do that for i2c, see opal_i2c_create_devs().
>>> 
>>> Is there a particular reason not to do that?
>>
>> I'm actually surprised that this is preferred. Jeremy mentioned something
>> similar, but I guess I just don't like the idea of finding devices in weird
>> places in the tree.
>
> But where is "weird". Arguably "/opal/flash" is weird. What does it
> mean? There's a bus called "opal" and a device on it called "flash"? No.
>
> Point being the structure is fairly arbitrary, or at least debatable, so
> tying the code 100% to the structure is inflexible. As we have discovered.
>
> Our other option is to tell skiboot to get stuffed, and leave the flash
> node where it was on P8.
>
>> Then again, if we can't trust the DT we're in bigger
>> trouble than erroneous flash nodes =).
>
> Quite :)
>
>> If we really just want to find compatible nodes anywhere, let's simplify i2c
>> and pdev_init into one function and make that behavior consistent with this
>> new patch.
>
> That seems OK to me.
>
> We should get an ack from Stewart though for the other node types.

For finding nodes based on compatible no matter where they are in the tree,

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

(and yes, includes other nodes too)

The exact location then isn't too important, and having a /flash that's
ibm,opal-flash and allows for some other driver to bind to it I think is
also something we shouldn't rule out.

-- 
Stewart Smith
OPAL Architect, IBM.
