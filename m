Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73359B7123
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 23:30:51 +1100 (EST)
In-Reply-To: <4CD918C2.4090400@aimvalley.nl>
References: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>	<AE90C24D6B3A694183C094C60CF0A2F6D8AB9A@saturn3.aculab.com>
	<OF068D03E2.B4929626-ONC12577D5.0056CBDF-C12577D5.00571CBD@transmode.se>
	<4CD918C2.4090400@aimvalley.nl>
Subject: Re: INFO: task snmpd:398 blocked for more than 120 seconds.
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Message-ID: <OF5EDFAE59.55B90327-ONC12577D6.004462D7-C12577D6.0044BB62@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 9 Nov 2010 13:30:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Laight <David.Laight@ACULAB.COM>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Norbert van Bolhuis <nvbolhuis@aimvalley.nl> wrote on 2010/11/09 10:47:46:
>
> Joakim Tjernlund wrote:
> >>> I can't make out what is causing this hang every now an then:
> >>>
> >>> INFO: task snmpd:398 blocked for more than 120 seconds.
> >> My problem with that 'error' message is that there is no way
> >> for a driver to disable it on a per-process basis.
> >> We have some processes whose 'normal state' is to sleep
> >> uninterruptibly in the kernel. Shutdown is handled by
> >> an explicit request (not by sending a signal).
> >> The processes could be kernel worker threads (except that
> >> is is ~impossible to handle them exiting from a loadble
> >> kernel module) so are actually children of a daemon sat
> >> inside an ioctl() request that never terminates!
> >>
> >> However, on the face of it, your case does look as though
> >> the mutex is fubar'ed.
> >>
> >> Might be worth (somehow) dumping the mutex state.
> >
> > ehh, it is locked, isn't it? How to find who locked it
> > and forgot to release it?
> >
>
> You could add show_state to check_hung_task
>
> It worked for me while solving some (application) task hangups.

Will have a look at that too, thanks.

Meanwhile i have tried to turn on various LOCK debug and
that results in an unbootable kernel.
Somewhere the dev. tree. gets mangled and it happens when
DEBUG_LOCK_ALLOC is set.
Don't know why and I must move on.
Someone else might want to try if DEBUG_LOCK_ALLOC works
on embedded ppc boards, especially 83xx.

    Jocke
