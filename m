Date: Tue, 11 Jun 2002 14:39:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: ppc4xx_pm.c
Message-ID: <20020611043926.GW25800@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've just been looking at this file.  As far as I can tell it's almost
completely pointless.  First most of the interesting stuff is only
enabled with CONFIG_APM, which is an x86 specific config option,
instead of CONFIG_PM.  If CONFIG_APM ever was defined it wouldn't
compile.  Second the callback function registered by pm_register()
does nothing except demultiplex the power management callback, we have
no default power management stuff.  The only thing which uses it is
the GPIO driver.  Anything which wants to do power management might as
well call pm_register() directly itself.

The only function with any use at all is ppc4xx_pm_init(), which
should probably move into ppc4xx_setup.c.  Also a bunch of the #ifdefs
could be removed from it - just turn most things off here, then the
driver can turn them back on when it starts.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
