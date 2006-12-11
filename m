Return-Path: <info@schihei.de>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A65B679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:28:40 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id kBBGSSZG041796
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 16:28:31 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBBGSRFE3277002
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:28:27 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBBGSQNU014811
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:28:26 +0100
In-Reply-To: <200612111525.50044.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
	<200612111525.50044.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C6AF45B-CD26-449B-B12C-1A89D8537463@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 17:28:35 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Dec 11, 2006, at 3:25 PM, Arnd Bergmann wrote:

> device-type = ipmi
> compatible = ipmi-kcs

If I understood you comments an example OFDT node for IPMI could look  
like the following:

name = "ipmi"
device_type = "ipmi"
compatible = "ipmi-kcs"

reg = XXXXXXX8 00000008
reg-spacing = 4
reg-size    = 1
reg-shift   = 0

In this example the Data_In / Data_out sitting at address XXXXXXX8  
and Status / Command is sitting at XXXXXXXC. Does this layout look  
good to everybody?

Is the "8" of the reg property correct?

I'm still worried what happens when we have a BT or SMIC interface an  
the registers sitting at XXXXXXX4, XXXXXXX6, XXXXXXXA. In this case  
the reg-spacing property can't be used anymore. Can this happen in  
reality?

Regards,
	Heiko
