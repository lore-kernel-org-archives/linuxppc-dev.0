Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.3.234]) by ozlabs.org (Postfix) with ESMTP id 4C22E2BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 08:39:54 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iAULdcR3022671
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 22:39:39 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (178-119.240.81.adsl.skynet.be
	[81.240.119.178])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iAULdW0g022624
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 22:39:32 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 10D1E8C651
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 22:38:42 +0100 (CET)
Message-ID: <41ACE8B0.8090307@246tNt.com>
Date: Tue, 30 Nov 2004 22:40:00 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Implementing PowerManagment for a ppc target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to implement Deep Sleep support for a ppc platform based on 
5200 and I have some questions :

 - How should I "integrate" it to linux, what the proper way ? I've been 
trying #defining CONFIG_PM and
   using the set_pm_ops operation but my call backs never get called 
when doing a echo standby > /sys/power/state

It justs says :

$ echo standby > 
/sys/power/state                                                                     

Stopping tasks: 
===                                                                                   

 stopping tasks failed (2 tasks 
remaining)                                                           
Restarting tasks...<6> Strange, init not 
stopped                                                     
 Strange, sh not 
stopped                                                                              

 done                                                                                                 

Stopping tasks: 
===                                                                                   

 stopping tasks failed (2 tasks 
remaining)                                                           
Restarting tasks...<6> Strange, init not 
stopped                                                     
 Strange, sh not 
stopped                                                                              

 done                 

I've been trying to look at Documentation/ and the sources but still I'm 
not sure ...


 - How can I ensure that one of my function runs out of I Cache ? Some 
pieces of assembler needs to not
   acces memory when the last 'orders' are sent. Does just keeping it 
small and aligned enough ?
 

Thanks,

    Sylvain Munaut
