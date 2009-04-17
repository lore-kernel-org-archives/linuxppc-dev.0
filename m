Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 540AEDE238
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:40:37 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:38:27 +0200
Message-Id: <1239953907.7443.45.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 14:27 -0500, Kumar Gala wrote:
> On Apr 16, 2009, at 2:25 PM, Scott Wood wrote:
> 
> > Kumar Gala wrote:
> >> [root:~] cat /proc/1/maps
> >> 00100000-00103000 r-xp 00100000 00:00 0          [vdso]
> >> 0feab000-0ffbe000 r-xp 00000000 00:0d 7127086    /lib/libc-2.2.5.so
> >> 0ffbe000-0ffcb000 ---p 00113000 00:0d 7127086    /lib/libc-2.2.5.so
> >> 0ffcb000-0ffeb000 rw-p 00110000 00:0d 7127086    /lib/libc-2.2.5.so
> >
> > IIRC, this libc is old enough to execute out of non-exec memory in  
> > some cases.
> 
> Yeah, I'm going to that realization.  The question is are we ok with  
> breaking older versions of libc like this.

I'm pretty sure they are broken already when running off a 64-bit
kernel, but yeah, as I said, we may want a .config option to enable
support for that old junk which also disables support from per-page
execute permission.

Ben.
