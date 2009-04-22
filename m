Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AEA7DDFA1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 06:30:08 +1000 (EST)
Message-ID: <49EF7E49.6060003@freescale.com>
Date: Wed, 22 Apr 2009 15:30:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<49EF7394.30606@freescale.com>
In-Reply-To: <49EF7394.30606@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR (get_immrbase() + 
>> 0x80000)
>> arch/powerpc/sysdev/cpm2.c:    cpm2_immr = ioremap(get_immrbase(), 
>> CPM_MAP_SIZE);
>>     these two are related and seem like we could look for "fsl,cpm2"
> 
> And do what with it that wouldn't be a reimplementation of get_immrbase()?

Sorry, I missed that you're referring to the CPM node rather than the 
IMMR node.  The CPM node's address points specifically to some CPM 
control registers, not to the start of a CPM "region" of IMMR/CCSR -- it 
has an empty ranges property to bypass address translation.

I think this needs more careful untangling, and some new device tree 
nodes (sorry Timur) if we want to get rid of the magic offsets and huge 
multiple-block-spanning structures.  I'm not sure it's worth it given 
the microscopic odds of a new CPM2 chip coming out, unless it's part of 
a CPM/QE merge.

-Scott
