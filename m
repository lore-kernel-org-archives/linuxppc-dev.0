Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6A50EDDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:09:43 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2JF9e1N020204
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 08:09:40 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2JF9dDO027534
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 10:09:39 -0500 (CDT)
Message-ID: <45FEA7B3.9090304@freescale.com>
Date: Mon, 19 Mar 2007 10:09:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
In-Reply-To: <20070318115656.GA12765@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

>> The problem with this version is that it only updates local-mac-address, 
>> and only if it already exists.  
> 
> Uh.. no.  Both my version and Scott's use setprop. 

Sorry, I was reading the code wrong.  I saw "if (devp)" and I thought devp was a pointer 
to the local-mac-address node.

> Second, I don't think the zImage should be setting
> mac-address anyway.  

Normally, that's true.  The problem is that device drivers first check mac-address and 
then local-mac-address (see of_get_mac_address()).  If the DTS define mac-address as 
something other than 00-00-00-00-00-00, the drivers are going to see mac-address that and 
use it.

Obviously, the DTS files shouldn't have mac-address in them.  But I haven't gotten around 
to cleaning that up, because I'm still waiting for the U-Boot maintainers to apply my 
pre-requisite patches.

 > In OF that property is based on what the
> interface has been used for during booting, which the zImage doesn't
> know.  The kernel doesn't need mac-address if local-mac-address is
> present, so we should just leave it out.

Perhaps mac-address should be deleted instead of just ignored?  I don't know if that 
breaks kexec.

> I don't think that's really a good idea.  The bootloader certainly
> should be able to add the property if it's not there, but it seems
> silly to make the bootloader do memmove()s to insert a new property
> when it's basically just as easy to set up the device tree to allow an
> in-place edit.

I think it's better if the DTS only specifies properties that the bootloader can't.  We 
already need the ability to insert properties, so what's wrong with using that?  I think 
it doesn't make sense for the DTS to specify a MAC address.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
