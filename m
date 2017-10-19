Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHnKl5LN7zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 22:50:03 +1100 (AEDT)
Subject: Re: [PATCH 3/5] powerpc-pseries: Delete an unnecessary variable
 initialisation in iommu_pseries_alloc_group()
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
 <9c71e3e0-8998-fd02-e3a3-ef219d82ee32@users.sourceforge.net>
 <20171019133718.5bdab33c@kitsune.suse.cz>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c5905c07-6127-685d-98b0-5c2bbeabe5ea@users.sourceforge.net>
Date: Thu, 19 Oct 2017 13:49:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171019133718.5bdab33c@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>>  {
>> -	struct iommu_table_group *table_group = NULL;
>> +	struct iommu_table_group *table_group;
>>  	struct iommu_table *tbl = NULL;
>>  	struct iommu_table_group_link *tgl = NULL;
>>  
> 
> I think initializing pointers to NULL is generally a good idea.

This one would also not be needed if the call of the function “kzalloc_node”
could be specified in the same statement.


> Removing these initializers adds no value, to the contrary.

This small update step is just a “preparation” for the subsequent two suggestions
in this patch series.

Regards,
Markus
