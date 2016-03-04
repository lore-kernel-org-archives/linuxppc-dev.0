Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D79AE1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 14:46:14 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 3 Mar 2016 20:46:12 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A8E6119D8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 20:33:39 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u243jhTs35258592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 20:45:43 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u243jhTm025590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 20:45:43 -0700
Subject: Re: [3/3] powerpc/pseries: Cleanup property cloning in memory dlpar
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20160301230231.DA2A81402D8@ozlabs.org>
 <1456883226.24490.4.camel@ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56D904E5.1030904@linux.vnet.ibm.com>
Date: Thu, 3 Mar 2016 21:45:41 -0600
MIME-Version: 1.0
In-Reply-To: <1456883226.24490.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2016 07:47 PM, Michael Ellerman wrote:
> On Wed, 2016-03-02 at 10:02 +1100, Michael Ellerman wrote:
>> On Wed, 2016-10-02 at 17:13:29 UTC, Nathan Fontenot wrote:
>>> Now that the DLPAR add/remove flow updates the ibm,dynamic-memory device
>>> tree property each time we add or remove a LMB the work needed to clone
>>> this property can be reduced.
>>>
>>> Prior to performing any memory DLPAR operation we now clone the device
>>> tree property once and convert it to cpu format. This copy is then used
>>> to walk through LMBs as we process them and is thrown away when we
>>> are finished. There is no longer a need to convert the entire property to
>>> cpu format and then back to BE every time we update it, we can just parse
>>> it in its native BE format and update the one LMB we need to modify
>>> before updating the property.
>>>
>>> This patch removes the BE => cpu conversion step in the clone routine and
>>> creates a drconf_property_to_cpu() routine to make this conversion for the
>>> one time we need to convert the entire property. This then allows us
>>> to remove dlpar_update_drconf_property() since we can now do everything
>>> in dlpar_update_device_tree_lmb().
>>
>> Hi Nathan,
>>
>> This sounds like a good cleanup on the face of it.
>>
>> But even with it applied I still see a boat load of endian errors from sparse
>> in this file. That worries me, can you please try and fix them.
> 
> I can merge patches 1 and 2 if you like, and leave this one for you to fixup?
> Or I can just wait for a v2 of the whole series. Let me know which you'd
> prefer.
> 

If you don't mind merging patches 1 and 2 I will send out a new cleanup patch
to fix the issues with patch 3 of the series.

Thanks,
-Nathan
