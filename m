Date: Wed, 30 Oct 2002 12:52:28 -0700
From: Matt Porter <porter@cox.net>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DBCR0 reset?
Message-ID: <20021030125228.A31666@home.com>
References: <1035919100.1013.1226.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1035919100.1013.1226.camel@granite.austin.ibm.com>; from hollis@austin.ibm.com on Tue, Oct 29, 2002 at 01:18:19PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 29, 2002 at 01:18:19PM -0600, Hollis Blanchard wrote:
>
> Has anyone had problems with hardware breakpoints from external
> debuggers? I'm using RISCWatch, which sets DBCR0 and IAC1 for me (yes
> I've verified that). I'm then using 'echo > /proc/sys' to invoke my
> code. However by the time I get to my sysctl proc handler, DBCR0 has
> been reset from 0x80810000 to 0x00010000, hence IAC1 is ignored.
>
> I don't see much use of DBCR0, other than initialization and then save
> during exception prologs and then restore during task restore. Can
> anyone point me to where it might be reset?

As I mentioned on IRC (and just to document it for other interested
parties):

DBCR0 is modified during initialization in ppc4xx_setup.c/ebony.c if
!CONFIG_BDI_SWITCH

DBCR0 is modified during context switching as you noted but also
in Debug trap handling.

As of 02/09/02 in the _devel tree, the DBCR context switching is
broken since the move to keeping DBCRs in the thread struct is
incomplete.  This may result in the initial DBCR value being destroyed
by a null thread struct value though I haven't looked closely at
that code (otherwise it might be fixed)...2.5 is higher on my list.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
