Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF40CB7BE5
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 03:59:09 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nA3Gx5QJ003166
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Nov 2009 09:59:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nA3H2B3c007045
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Nov 2009 11:02:12 -0600 (CST)
Message-ID: <4AF06172.6060407@freescale.com>
Date: Tue, 03 Nov 2009 10:59:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<20091030171607.GA781@loki.buserror.net>
	<20091030173749.GA855@loki.buserror.net>
	<OFD5642C2D.808C2FF1-ONC1257663.004A341C-C1257663.004A6C26@transmode.se>
In-Reply-To: <OFD5642C2D.808C2FF1-ONC1257663.004A341C-C1257663.004A6C26@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
>> and things seem to work.  You could probably replace the rlwinm by
>> subtracting PAGE_OFFSET from swapper_pg_dir instead.
> 
> Just guessing here, do you mean:
> 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@h
> 	ori	r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
> 	rlwimi	r11, r10, 22, 0xffc
> or
> 	lis	r11, swapper_pg_dir@h
> 	ori	r11, r11, swapper_pg_dir@l
> 	subis	r11, r11 PAGE_OFFSET
> 	rlwimi	r11, r10, 22, 0xffc

The former.

-Scott
