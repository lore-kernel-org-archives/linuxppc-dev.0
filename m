Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8808FB70F6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 02:51:35 +1100 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AB9A@saturn3.aculab.com>
References: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AB9A@saturn3.aculab.com>
Subject: RE: INFO: task snmpd:398 blocked for more than 120 seconds.
To: "David Laight" <David.Laight@ACULAB.COM>
Message-ID: <OF068D03E2.B4929626-ONC12577D5.0056CBDF-C12577D5.00571CBD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Nov 2010 16:51:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> > I can't make out what is causing this hang every now an then:
> >
> > INFO: task snmpd:398 blocked for more than 120 seconds.
>
> My problem with that 'error' message is that there is no way
> for a driver to disable it on a per-process basis.
> We have some processes whose 'normal state' is to sleep
> uninterruptibly in the kernel. Shutdown is handled by
> an explicit request (not by sending a signal).
> The processes could be kernel worker threads (except that
> is is ~impossible to handle them exiting from a loadble
> kernel module) so are actually children of a daemon sat
> inside an ioctl() request that never terminates!
>
> However, on the face of it, your case does look as though
> the mutex is fubar'ed.
>
> Might be worth (somehow) dumping the mutex state.

ehh, it is locked, isn't it? How to find who locked it
and forgot to release it?

       Jocke
