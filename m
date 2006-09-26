Return-Path: <ingvar@linpro.no>
Received: from head.linpro.no (head.linpro.no [80.232.36.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BCA767B92
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 21:05:12 +1000 (EST)
Received: from stat.linpro.no ([80.232.36.97])
	by head.linpro.no with esmtp (Exim 4.14 #1 (Debian))
	id 1GSANv-0006Zb-6Z
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:41:55 +0200
Received: from uname.e.linpro.no ([192.168.43.140])
	by stat.linpro.no with esmtp (Exim 4.50) id 1GSANu-0004Wc-Bj
	for linuxppc-dev@ozlabs.org; Tue, 26 Sep 2006 12:41:54 +0200
Received: from uname.e.linpro.no (localhost.localdomain [127.0.0.1])
	by uname.e.linpro.no (8.13.1/8.13.1) with ESMTP id k8QAfsBT030943
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:41:54 +0200
Sender: ingvar@uname.e.linpro.no
To: linuxppc-dev@ozlabs.org
Subject: DLPAR fails on SLES9
From: Ingvar Hagelund <ingvar@linpro.no>
Date: 26 Sep 2006 12:41:54 +0200
Message-ID: <83wt7qkiz1.fsf@uname.e.linpro.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: ingvar@linpro.no
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I want to do DLPAR to add a virtual network interface (ibmveth) to one
of my LPARS, running Linux. I can't make it work. Note that adding a
physical network interface works without problems.

System: IBM OpenPower 720, managed by HMC
LPAR OS: SLES9, kernel 2.6.5-7.252-pseries64
Installed magical rpms from IBM:
  DynamicRM-1.2-0
  IBMinvscout-2.2-5
  csm.client-1.4.0.12-98
  csm.core-1.4.0.12-98
  devices.chrp.base.ServiceRM-2.2.0.0-2
  diagela-2.1.5-0
  evlog-drv-tmpl-0.8-1
  librtas-1.3.0-0
  lsvpd-0.15.1-1
  ppc64-utils-2.5.3-1
  rpa-dlpar-1.0-25
  rpa-pci-hotplug-1.0-18
  rsct.core-2.4.1.2-05070
  rsct.core.utils-2.4.1.2-05070
  servicelog-0.2.2-0
  src-1.2.2.1-05054

I have tried both doing the DLPAR command via the HMC gui, and it's
cli, using this command: 

chhwres -r virtualio -m openpower1 -o a \
    -p vioserver --rsubtype eth -s 11 \
    -a "ieee_virtual_eth=1,port_vlan_id=1,is_trunk=1,\"addl_vlan_ids=690,691,692,693,694,695,696,697,698,699\"" \
    -w 5 -d 5 

When ran by the hmc cli, I only get this dumb error:

HSCL294C DLPAR ADD Virtual I/O resources failed: HMC adding Virtual I/O ......
HMC Virtual slot DLPAR operation failed. Here are the virtual slot IDs that failed and the reasons for failure:
11 The dynamic logical partitioning operation failed.

The kernel on the lpar logs nothing.

When ran by the hmc gui, I get errors like this in the trace log on the lpar:
# rpttr /var/ct/IW/log/mc/IBM.DRM/trace | perl -ne ' if ( /\|(.+)\|/ ) { $a=$1; $a =~ s/\.+//g; print $a;} ' | perl -pe 's/[^7,^3]8/\n/g;'
C=X(DRM/      C=Xd0       
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C44C        X`d$Unknown command: ioscl
Gapioscli lsmap -fmt : -plc U9124720656B78F-V1-C43C        X`d$Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C42C        X`d$Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C41C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C40C        X`Unknown command: ioscl
+Ypioscli lsmap -fmt : -plc U9124720656B78F-V1-C39C        X`Unknown command: ioscl
{pioscli lsmap -fmt : -plc U9124720656B78F-V1-C38C        X`Unknown command: ioscl
>pioscli lsmap -fmt : -plc U9124720656B78F-V1-C37C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C36C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C35C        X`Unknown command: ioscl
#pioscli lsmap -fmt : -plc U9124720656B78F-V1-C34C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C33C        X`Unknown command: ioscl
/pioscli lsmap -fmt : -plc U9124720656B78F-V1-C32C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C31C        X`Unknown command: ioscl
pioscli lsmap -fmt : -plc U9124720656B78F-V1-C30C        X`Unknown command: ioscli

The kernel logs nothing.

Why is it trying to run 'ioscli lsmap'? Isn't that only available for AIX?

I suspect this may be caused by an old hmc version. We run version
4.5.0-20050629.1. Does anyone know if there is a fix for bugs like
this in a later version?

Is it possible to update the HMC, for example to 5.x.something without
updating (read boot) the managed systems as well?

Ingvar Hagelund
Linpro AS
-- 
When everything fail: Symlink
