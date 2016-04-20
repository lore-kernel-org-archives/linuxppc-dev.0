Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqRQl3Sf6zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:58:23 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 12:58:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 87DD62BB0061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:58:03 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K2vttA34734332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:58:03 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K2vTlU003221
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:57:29 +1000
Date: Wed, 20 Apr 2016 12:38:49 +1000
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
Message-ID: <20160420023848.GB3754@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Rob, very sorry to response so lately. I will fix it up in next revision.

>> +               *pprev     = pp;
>> +               pprev      = &pp->next;
>> +       }
>
