Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 0580967C56
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 06:14:20 +1000 (EST)
Date: Fri, 25 Aug 2006 22:14:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Mike Strosaker <strosake@austin.ibm.com>
Subject: Re: [PATCH] reboot when panic_timout is set
Message-ID: <20060825201402.GA28214@aepfle.de>
References: <20060821161132.GA31085@aepfle.de>
	<44EF428B.8010100@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <44EF428B.8010100@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 25, Mike Strosaker wrote:

> Olaf Hering wrote:
> 
> >Only call into RTAS when booted with panic=0 because the RTAS call does 
> >not return.
> >The system has to be rebooted via the HMC or via the management console 
> >right now.
> >This is cumbersome and not what the default panic=180 is supposed to do.
> > 
> >
> The os-term call is supposed to indicate to the platform that it should 
> follow it's abnormal OS termination policy.  I normally set my 
> partitions to reboot immediately after an os-term call.  I believe that 
> "/usr/sbin/serv_config -b" (installed with powerpc-utils-papr) is used 
> to set that policy from the command line.

That doesnt help me at all if the kernel crashes before it reaches
/init. And if one has to call a binary anyway to set or upgrade the
policy, this binary can also set /proc/sys/kernel/panic to 0.

Do I have to set it for each boot, or is a change permanent?
