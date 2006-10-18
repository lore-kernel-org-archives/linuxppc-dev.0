Return-Path: <nd@bplan-gmbh.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 5D62467B75
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 16:36:21 +1000 (EST)
Message-ID: <4535CADC.5010100@bplan-gmbh.de>
Date: Wed, 18 Oct 2006 08:34:04 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>	
	<4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
In-Reply-To: <1161152109.7906.6.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------000800070500020609020308"
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000800070500020609020308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Ellerman wrote:

 >>  >> +#ifdef CONFIG_PPC64
 >>  >> +#define PROCRTAS_ROOT "ppc64"
 >>  >> +#else
 >>  >> +#define PROCRTAS_ROOT "ppc"
 >>  >
 >>  > Please don't do any pathname changes.  Even if ppc64 isn't 
correct it's
 >>  > what applications expect and what we should provide for a 
coherent user
 >>  > interface.
 >>
 >> Humm, ok.
 >> However, in this case 'ppc' (could be 32 or 64 as it is not specified)
 >> is more generic than 'ppc64'.
 >
 > But it's called '/proc/ppc64' right now on lots of machines, so you
 > can't go changing it.

Ok. No problem


 >>
 >> Indeed, however I can only test on CHRP. I'll remove the check in the
 >> upcomming patch.
 >
 > That should be fine AFAICT, you should probably just check that each of
 > the proc routines checks for errors - ie. just because you have an
 > "/rtas" node doesn't mean you necessarily have "/rtas/set-indicator" or
 > whatever.

ok

 >
 >> The patch also include a small code to create the /proc/ppc/rtas entry.
 >> Should this be done here, or somewhere in arch/powerpc/chrp/setup.c ?
 >
 > That code is almost entirely the same as proc_ppc64_create(), so I think
 > you should try and merge them - we want to minimise the number of
 > foo_ppc64() and foo_ppc32() routines we have.
 >

Ok.
proc_ppc64_create() is now locate in arch/powerpc/kernel/proc_ppc64.c. 
Maybe a new file could be created (arch/powerpc/kernel/proc_ppc.c) ?

Any other suggestions?

Just indicate me the direction, and I would provide others patches.

Regards

--------------000800070500020609020308
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------000800070500020609020308--
