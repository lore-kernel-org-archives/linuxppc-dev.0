Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB9052C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 21:56:07 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 3 May 2013 08:55:53 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 34A4D1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 07:55:50 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43BsjFE28967140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 08:54:46 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43Btl9N003824
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 08:55:49 -0300
Message-ID: <5183A5C4.4030706@linux.vnet.ibm.com>
Date: Fri, 03 May 2013 08:55:48 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
MIME-Version: 1.0
To: tony@bakeyournoodle.com
Subject: Re: [PATCHv4 1/2] ppc64: perform proper max_bus_speed detection
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20130424234838.GA1971@thor.bakeyournoodle.com>
 <51796928.2050406@linux.vnet.ibm.com> <51828481.2090406@linux.vnet.ibm.com>
 <20130503064008.GB4260@thor.bakeyournoodle.com>
In-Reply-To: <20130503064008.GB4260@thor.bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2013 03:40 AM, Tony Breeds wrote:
> On Thu, May 02, 2013 at 12:21:37PM -0300, Kleber Sacilotto de Souza wrote:
> 
>> Hi Tony,
>>
>> It seems Lucas' change is a bit incomplete and is not handling the reference counter to
>> the device_node correctly. Is the following change what you had in mind?
> 
> Ahh Sorry I expected there would be a for_each_parent_of_node macro.
> I did a quick grep and it seems that's not very common, so open coding
> it should be fine.
>  
>>
>> 	dn = pcibios_get_phb_of_node(bus);
>> 	if (!dn)
>> 		return 0;
>>
>> 	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
>> 		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
>> 			"ibm,pcie-link-speed-stats", NULL);
>> 		if (pcie_link_speed_stats)
>> 			break;
>> 	}
>>
>> 	of_node_put(pdn);
> 
> I think you need the of_node_put() in the body of the loop, otherwise
> aren't you leaking refcounts?

of_get_next_parent() takes care of that. It does of_node_put() on the
current node after doing of_node_get() on the parent.


Thanks,
-- 
Kleber Sacilotto de Souza
IBM Linux Technology Center
