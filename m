Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AAD9EDDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 02:00:08 +1000 (EST)
Date: Mon, 10 Sep 2007 11:00:52 -0500
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
Message-ID: <20070910160052.GA23616@lixom.net>
References: <20070905020733.GA25900@lixom.net>
	<20070905020945.GF25900@lixom.net>
	<20070910154443.GK32388@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070910154443.GK32388@localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2007 at 10:44:43AM -0500, Nathan Lynch wrote:
> Olof Johansson wrote:
> > commit 6a30bd1e2160e921a8fb051b472dfaf068f4f386
> > Author: Olof Johansson <olof@lixom.net>
> > Date:   Tue Sep 4 21:53:30 2007 -0500
> > 
> >     [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
> >     
> >     Move pasemi_idle_init() to be a late_initcall instead of being called from
> >     setup_arch(). This way the cpufreq driver has a chance to initialize and
> >     save away the boot time astate before we go to idle for the first time.
> 
> The patch looks fine, but while I was reviewing this I noticed that
> the pasemi cpufreq code is bool in Kconfig, but it has stuff like
> module_init() etc in it.  It's not hurting anything, but it did
> temporarily make me wonder "what happens if the cpufreq driver is
> modular"?

Good point. I actually kept it from being modular for the very reason
that it's needed in the idle loop to restore the cpu frequency when
coming out of power savings modes.

The whole idle/cpufreq dependencies should be overhauled at some point,
to avoid this, or at least allow the cpufreq driver to be a module
(and make idle default to spin when it's not loaded).


-Olof
