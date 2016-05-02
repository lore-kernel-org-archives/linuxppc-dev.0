Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qynfL3bw9zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 12:03:54 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 2 May 2016 12:03:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 478CA3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 12:03:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4223fxi31195382
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 12:03:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4223FQ6018039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 12:03:17 +1000
Date: Mon, 2 May 2016 12:02:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru, dja@axtens.net,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
Message-ID: <20160502020221.GA16612@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 08:30:42AM -0600, Rob Herring wrote:
>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> The function unflatten_dt_node() is called recursively to unflatten
>> device nodes and properties in the FDT blob. It looks complicated
>> and hard to be understood.
>>
>> This splits the function into 3 functions: populate_properties(),
>> populate_node() and unflatten_dt_node(). populate_properties(),
>> which is called by populate_node(), creates properties for the
>> indicated device node. The later one creates the device nodes
>> from FDT blob. populate_node() gets the offset in FDT blob for
>> next device nodes and then calls populate_node(). No logical
>> changes introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/of/fdt.c | 249 ++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 147 insertions(+), 102 deletions(-)
>
>One nit, otherwise:
>
>Acked-by: Rob Herring <robh@kernel.org>
>
>[...]
>
>> +               /* And we process the "ibm,phandle" property
>> +                * used in pSeries dynamic device tree
>> +                * stuff
>> +                */
>> +               if (!strcmp(pname, "ibm,phandle"))
>> +                       np->phandle = be32_to_cpup(val);
>> +
>> +               pp->name   = (char *)pname;
>> +               pp->length = sz;
>> +               pp->value  = (__be32 *)val;
>
>This cast should not be needed.
>

It's needed. Otherwise, we will have warning. So I will keep it. I just
went through this one for next revision and sorry for late response.

drivers/of/fdt.c:225:14: warning: assignment discards ‘const’ qualifier from pointer target type
   pp->value  = val;
              ^

Thanks,
Gavin

>> +               *pprev     = pp;
>> +               pprev      = &pp->next;
>> +       }
>
