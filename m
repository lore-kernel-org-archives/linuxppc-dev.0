Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94A63DDF30
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 07:18:42 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lASKKJPj017406
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:20:19 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lASKIcoP423040
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:18:38 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lASKIcWV005094
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:18:38 -0500
Date: Wed, 28 Nov 2007 14:18:38 -0600
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-ID: <20071128201838.GH19584@austin.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196208960.11297.26.camel@farscape.rchland.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 06:15:59PM -0600, Will Schmidt wrote:
> (resending with the proper "from" addr this time). 
> 
> 
> I'm seeing some funky behavior on power5/power6 partitions with this
> patch.    A "/sbin/reboot" is now behaving much more like a
> "/sbin/halt".
> 
> Anybody else seeing this, or is it time for me to call an exorcist for
> my boxes? 

I beleive the patch
http://www.nabble.com/-PATCH--powerpc-pseries:-tell-phyp-to-auto-restart-t4847604.html

will cure this problem.

>From that patch:

+/**
+ * pSeries_auto_restart - tell hypervisor that boot succeeded.
+ *
+ * The pseries hypervisor attempts to detect and prevent an
+ * infinite loop of kernel crashes and auto-reboots. It does
+ * so by refusing to auto-reboot unless we indicate that the
+ * current boot was sucessful.  So, indicate success late in
+ * the boot sequence.
+ */ 

FYI, I am leaving IBM in just a few days now, and won't really
have much of a chance to debug this, if there are other problems.

This pair of patches was required to make hypervisor-assisted 
dump work, viz, we need to tell the hypervisor about when we 
crashed, or didn't crash, so that if we crashed, the dump can 
be taken appropriately.

It occurs to me that, as I write this, that maybe xmon 'zr'
command should be modified to call pSeries_auto_restart just
in case, so that it actually reboots.  There might be another
funky code path that I can't think of right now.

--linas
