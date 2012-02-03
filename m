Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A458104792
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 21:15:11 +1100 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1RtFw3-000178-Ab
 for linuxppc-dev@ozlabs.org; Fri, 03 Feb 2012 11:00:03 +0100
Received: from 212.199.94.201.static.012.net.il ([212.199.94.201])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Feb 2012 11:00:03 +0100
Received: from yaniv_abraham by 212.199.94.201.static.012.net.il with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Feb 2012 11:00:03 +0100
To: linuxppc-dev@ozlabs.org
From: Abraham Yaniv <yaniv_abraham@yahoo.com>
Subject: Re: P2020 with BCM53115
Date: Fri, 3 Feb 2012 09:54:01 +0000 (UTC)
Message-ID: <loom.20120203T104415-195@post.gmane.org>
References: <690FFE9537DC4C47854ABD6C16FA141945A2AC3D5F@CHM-MBX1.ad.mc.com>
 <20101220124911.141ce72d@udp111988uds.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Scott Wood <scottwood <at> freescale.com> writes:
> 
> On Mon, 20 Dec 2010 13:08:55 -0500
> "Dry, Craig" <cdry <at> mc.com> wrote:
> 
> > I am trying to bring up a P2020 board which uses the Broadcom BCM53115 
switch in unmanaged mode.  The board is
> patterned after the P2020RDB, except the Vitesse switch has been replaced with 
a BCM53115. There is no
> MDIO connection to the switch, but there is  an SPI connection available if 
needed.
> > 
> > When running Uboot, the BCM53115 works just fine, as I am able to 
download the Linux Kernel and
> P2020RDB.dtb across the network without issue.   But as Linux is booting up, I 
get the message:
> > 
> > mdio_bus mdio <at> ffe24520: error probing PHY at address 0
> > mdio_bus mdio <at> ffe24520: error probing PHY at address 1
> > 
> > I expect these errors occur because the P2020RDB.dts file has these entries.
> > 
> > I'm not sure what to try next to get Linux to use the BCM53115 switch in 
unmanaged mode.
> 
> See the fixed-link property in
> Documentation/powerpc/dts-bindings/fsl/tsec.txt
> 
> -Scott
> 

Hi there Craig!
I have the same setup (Freescale P2020 CPU with Broadcom BCM53115 switch) 
but I'm having a hard time bringing it up.
The P2020's eTSEC2 is connected to port 5 (WAN) of the BCM53115.
I managed to make a link up status on the BCM53115 port 5 but I believe this is a
false link up because no traffic is passing between the P2020 and the BCM53115
and the BCM53115 SerDes/SGMII status register says there is a False Carrier 
situation.
The P2020 eTSEC is configured to SGMII/TBI (ECNTRL[SGMIIM]=1, 
ECNTRL[TBIM]=1, and MACCFG2[I/F]=10).
Is there a chance you can share with me what is the configuration required 
to my BCM53115 to make a true link up?
Thanks a million,
Yaniv
