Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68CCEB72C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 00:39:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8FEEDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 00:39:01 +1000 (EST)
Message-Id: <C81AEED1-5CEC-42B8-A893-5E6BDDD4EC54@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: killing use of ppc_md.init
Date: Thu, 18 Jun 2009 09:38:50 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc_md.init only exists on ppc32 and seems like its pretty useless  
today.  The users seem to fall into two classes:

1. called to do of_platform_bus_probe() - most platforms use  
machine_device_initcall() for this
2. some platform init code which seems like it could move into  
setup_arch().

The second one seems to only be on amigaone and chrp.  Anyone know if  
there is any harm in moving the amigaone_init() into  
amigaone_setup_arch() and similarly on chrp chrp_init2() into  
chrp_setup_arch().

- k
