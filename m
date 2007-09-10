Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 8AC38DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 01:44:59 +1000 (EST)
Date: Mon, 10 Sep 2007 10:44:43 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
Message-ID: <20070910154443.GK32388@localdomain>
References: <20070905020733.GA25900@lixom.net>
	<20070905020945.GF25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020945.GF25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> commit 6a30bd1e2160e921a8fb051b472dfaf068f4f386
> Author: Olof Johansson <olof@lixom.net>
> Date:   Tue Sep 4 21:53:30 2007 -0500
> 
>     [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
>     
>     Move pasemi_idle_init() to be a late_initcall instead of being called from
>     setup_arch(). This way the cpufreq driver has a chance to initialize and
>     save away the boot time astate before we go to idle for the first time.

The patch looks fine, but while I was reviewing this I noticed that
the pasemi cpufreq code is bool in Kconfig, but it has stuff like
module_init() etc in it.  It's not hurting anything, but it did
temporarily make me wonder "what happens if the cpufreq driver is
modular"?
