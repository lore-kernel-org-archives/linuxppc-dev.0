Date: Fri, 24 May 2002 12:20:24 -0700
From: Matt Porter <porter@cox.net>
To: Roland Dreier <roland@topspin.com>
Cc: Venkatesh Rao <rpranesh@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ZMII Code Panics on 440GP Ebony
Message-ID: <20020524122024.B21309@home.com>
References: <20020524155815.98552.qmail@web21402.mail.yahoo.com> <52y9e9ebxm.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52y9e9ebxm.fsf@topspin.com>; from roland@topspin.com on Fri, May 24, 2002 at 09:40:53AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 24, 2002 at 09:40:53AM -0700, Roland Dreier wrote:
>
> >>>>> "Venkatesh" == Venkatesh Rao <rpranesh@yahoo.com> writes:
>
>     Venkatesh> Hi, I am using a Rev B board and when i compiled the
>     Venkatesh> latest kernel (pulled yesterday after Matt's
>     Venkatesh> Checkin)and booted my ebony board, i got a panic in
>     Venkatesh> ZMII. I am including a portion of the bootup log.
>
> Yes, the linux_2_4_devel tree I pulled yesterday was not in a
> consistent state for my 440GP Ebony board.  The problem is that the
> Ebony setup code has not been updated for the new OCP handling code
> yet.  To fix it, you need to edit arch/ppc/platforms/ebony.c and
> delete the lines:

Yes, I'm lagging a little behind all the OCP updates that are
occurring.  I pushed the included patch.

> In addition, it seems to me that the EBONY_{ZMII,EMAC0,EMAC1}_{ADDR
> constants should be renamed to PPC440GP_xxx constants since they are
> not Ebony specific but rather apply to all IBM 440GP designs.  As
> further cleanup, one can probably remove the EMAC_ADDR and ZMII_ADDR
> variables.
>
> I would be happy to help with this cleanup; however, I don't want to
> step on anyone's work in progress.  However, if anyone would like
> patches to do some of this cleanup I could put some together fairly
> quickly.

I started some things but have been busy with functionality for
some time now.  I'd be interested in any cleanup patches you
would produce.  The idea is to separate ibm440.h, ibm440gp.h, and
<board>.h as appropriate.  As you've noticed, I took some shortcuts
in the interest of getting the core code in front of everybody
quickly. :)

Thanks,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
