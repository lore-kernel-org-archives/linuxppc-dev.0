Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9011767A73
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:40:48 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859673@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859673@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2CD98C5D-E51C-49CA-9BDC-6FE4C1B67854@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:40:42 -0500
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2006, at 2:30 PM, Rune Torgersen wrote:

> Would it be possible to have the kernel smart enough that if it gets
> passed a bd_t pointer, it updates the dts before booting fully.
> Newer u-boot versions that support dts then would pass a NULL bd_t
> pointer to a kernel that supports dts. Kernel would then not update  
> the
> dts, but use the one it gets handed.

What you are describing is the boot shim method.

U-boot is already capable of effectively doing this.  You can set a u- 
boot environment variable to make bootm do different things if you  
have flat device tree support built into u-boot.

> bootm should be able to see if the kernel has an attached dts,  
> update it
> with runtime parameters, and hand it off to the kernel. If it is an  
> old
> kernel, hand it the bd_t pointer.

We can do this w/o too much modification to what is happening in u- 
boot today.  I'd probably like to keep the ability to build a dev  
tree into the u-boot binary, but make the preferred means to pass a  
blob into the bootm command.

- kumar
