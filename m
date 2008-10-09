Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id E958EDE433
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 02:59:05 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so28732qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 08:59:04 -0700 (PDT)
Message-ID: <48EE2A49.10405@genesi-usa.com>
Date: Thu, 09 Oct 2008 10:59:05 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223495845-14149-1-git-send-email-timur@freescale.com>		<1223496186.8157.82.camel@pasglop>		<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>	<1223498380.8157.86.camel@pasglop>
	<48ED1B9E.3020907@freescale.com>
In-Reply-To: <48ED1B9E.3020907@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
>> I'm happy with -all- platforms for a given CPU type defaulting to y. 
> 
> I'm not sure I understand.  The current Kconfigs defaults to Y for CHRP and PMAC
> on *all* PowerPC systems, including those that are neither CHRP nor PMAC.  Are
> you saying that's a good thing?

Timur,

You do realise it's entirely possible to build a kernel which supports 50
different Freescale CPUs all in one?

Enabling CHRP, PMAC support *AND* non-CHRP platforms is possible in the same
binary. The relevant code that differentiates them is in the boot wrapper
and this is selected by *how you compile the kernel* and not which objects
are compiled in. make zImage and make cuImage on the same kernel objects
will give you an 'identical' image just packaged in a different way.

If you really want to build a single-cpu single-board kernel, disable CHRP
and PMAC for those board configs, but the default definitely should be to
enable them all within reason (obviously coherent and non-coherent designs
cannot coexist in the same kernel, 32-bit and 64-bit do not play well in
the same kernel..)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
