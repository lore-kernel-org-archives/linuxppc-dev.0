Date: Tue, 4 Jun 2002 09:57:20 -0700
From: Matt Porter <porter@cox.net>
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020604095720.A15252@home.com>
References: <20020603075322.GI6765@zax> <15612.47259.378190.93509@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15612.47259.378190.93509@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Jun 04, 2002 at 10:54:51PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 10:54:51PM +1000, Paul Mackerras wrote:
>
> Looks like Ben and I have found the problem; Ben added an isync and a
> sync to set_context() after setting the PID register and that seems to
> have fixed it.  It makes sense, as isync invalidates the shadow DTLB
> and ITLB.  (The sync may be unnecessary.)

Makes sense, I was telling some folks at work that it had to be a
40x specific code problem.  The 440 has had an isync in set_context()
and doesn't see this problem (and by default uses pinned TLBs).
Changing the PID is a context changing event that requires a context
synchronization.  The sync shouldn't be necessary per the UM and
seems to be true in practice from my 440 testing.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
