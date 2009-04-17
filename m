Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99587DDF9E
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 07:32:38 +1000 (EST)
Message-Id: <2FE62872-EB54-41DE-8D3F-5C75E03AE2AD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
In-Reply-To: <49E8F2D7.3050603@embeddedarm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PowerPC iotable_init equivalent?
Date: Fri, 17 Apr 2009 16:32:29 -0500
References: <49E8F2D7.3050603@embeddedarm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2009, at 4:21 PM, Eddie Dawydiuk wrote:

> Hello,
>
> In the past I've worked with ARM architectures where I could setup  
> virtual / physical address mappings so I don't have to ioremap then  
> pass around pointers. Does PowerPC have an equivalent abstraction?  
> If not whats the recommended approach?
>
> That is, is there a better approach to the following...
>
> volatile static unsigned char *my_reg = NULL;
>
> static inline void read_func() {
>
> 	if (!my_reg)
>        	my_reg = (unsigned char *)
> 			ioremap(REG_PHYS_BASE, REG_SIZE);
> //do something with the reg
> }
>
>
> static inline void write_func() {
>
> 	if (!my_reg)
>        	my_reg = (unsigned char *)
> 			ioremap(REG_PHYS_BASE, REG_SIZE);
> //do something with the reg
> }

Yes have a struct that keeps track of the virt addr and do the mapping  
once at init time.  This is what most drivers do.

- k
