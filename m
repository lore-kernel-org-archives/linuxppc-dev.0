Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5EF7367A7D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 06:01:48 +1100 (EST)
Date: Tue, 18 Jan 2005 11:01:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050118190146.GB31308@gate.ebshome.net>
References: <41EC29A8.1040703@mvista.com>
	<Pine.GSO.4.61.0501181017110.20681@waterleaf.sonytel.be>
	<41ED5832.2040602@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41ED5832.2040602@mvista.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 11:40:50AM -0700, Mark A. Greer wrote:
> However, it does rely on a startup script to do a 'hwclock 
> --hctosys' which happen after driver initialization.  From what I can 
> tell sysvinit used to do the hwclock but doesn't anymore so you need a 
> script.  The mvl userland has a startup script that does this; others 
> probably do too.  Note that using a startup script to do a hwclock is 
> pretty standard AFAICT.

You can always call do_settimeofday from your i2c driver 
initialization. No scripts will be required and system behavior will 
be similar to the case when ppc_md.get_rtc_time is called during init 
to get correct time from RTC.

--
Eugene
