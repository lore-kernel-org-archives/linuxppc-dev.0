Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E20FDDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 18:23:37 +1000 (EST)
In-Reply-To: <1179209013.32247.147.camel@localhost.localdomain>
References: <20070515041705.CCC00DDFC9@ozlabs.org>
	<20070515143042.987cba34.sfr@canb.auug.org.au>
	<1179209013.32247.147.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6F0D3EB-F560-4875-B506-F917F60EF442@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix warning in pci_64.c
Date: Tue, 15 May 2007 03:22:36 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2007, at 1:03 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2007-05-15 at 14:30 +1000, Stephen Rothwell wrote:
>> On Tue, 15 May 2007 14:16:35 +1000 Benjamin Herrenschmidt  
>> <benh@kernel.crashing.org> wrote:
>>>
>>>  void pcibios_add_platform_entries(struct pci_dev *pdev)
>>>  {
>>> -	device_create_file(&pdev->dev, &dev_attr_devspec);
>>> +	int rc = device_create_file(&pdev->dev, &dev_attr_devspec);
>>> +	WARN_ON(rc != 0);
>>
>> If we really don't care if the file is not created, then it is  
>> probably
>> worth a comment as to why ...
>
> Well, if it's not created, then something is badly wrong thus a
> WARN_ON ... Do you think I should do more ?

Yes, fix the pci_32.c version of this as well (if it hasn't been) :)

- k
