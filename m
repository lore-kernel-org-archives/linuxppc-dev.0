Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHngR23XlzDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:05:22 +1100 (AEDT)
Subject: Re: [PATCH 4/5] powerpc-pseries: Return directly after a failed
 kzalloc_node() in iommu_pseries_alloc_group()
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Doug Ledford <dledford@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Rob Herring <robh@kernel.org>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
 <a824fe65-1708-16ba-68d6-df0f73e0f49a@users.sourceforge.net>
 <20171019134148.52b890b4@kitsune.suse.cz>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2f1e61bd-9d79-1b9f-e686-f9d13a6f0afc@users.sourceforge.net>
Date: Thu, 19 Oct 2017 14:04:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171019134148.52b890b4@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> @@ -61,7 +61,7 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node) 
>>  	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL,
>> node); if (!table_group)
>> -		goto fail_exit;
>> +		return NULL;
>>  
>>  	tbl = kzalloc_node(sizeof(*tbl), GFP_KERNEL, node);
>>  	if (!tbl)
> 
> I have seen quite a few fixes that do inverse of this patch after a
> piece of code allocating some extra piece of memory was added before
> code that just returns on fail because it is the first allocation in
> the function.
> 
> This is not useful.

How do you think about an information from the section “7) Centralized exiting
of functions” in the document “coding-style.rst” then?

“…
If there is no cleanup needed then just return directly.
…”


> A final fail_exit that frees everything that could have been allocated
> is much better.

I got an other software development opinion for such use cases.
I prefer only required function calls there.

Regards,
Markus
