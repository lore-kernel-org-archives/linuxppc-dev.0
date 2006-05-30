Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48C4D67B2D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 07:12:52 +1000 (EST)
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060530204151.GA31567@mag.az.mvista.com>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
	<20060530204151.GA31567@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 17:12:37 -0400
Message-Id: <1149023558.6507.15.camel@brick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-30 at 13:41 -0700, Mark A. Greer wrote:
> On Mon, May 29, 2006 at 10:01:03PM -0400, mostrows@watson.ibm.com wrote:
> > zImage will store the builtin command-line in a dedicated section, allowing
> > it to be easily identified and edited with user-space tools.
> >
> > zImage will set /chosen/bootargs to the stored builtin command-line setting,
> > if /chosen/bootargs is empty (emulating the behavior in prom_init.c).
> > 
> > Use of this mechanism avoids the need to modify firmware or rely on a
> > bootloader to customize kernel arguments (and overall system
> > behavior).  The command line can be edited as needed when a zImage is
> > copied to a TFTP staging area for download by firmware.




> Why do this?  Why not get rid of storing the cmdline in the zImage altogether?  
> 

The CONFIG_CMDLINE that we have now is very useful if I want the
behavior of the system to be dependent on the kernel/command line I
specify that it used (particularly in BOOTP/TFTP scenarios).  For such
systems I configure their firmware to not provide any arguments and to
always download via TFTP a designated kernel image.

What this scenario does, is it allows me to specify system behavior by
putting the right kernel with the right command line in the magic
location from where it will be downloaded.

The problem is, that if I have some large number of machines and I want
to use the same kernel for all of them (and simply change the command
line between them) then I have to effectively build a custom kernel for
each.  This patch allows me to build one kernel and then simply edit the
command line embedded within it.

The key point is that the command line changes and I don't want to have
to require a firmware interaction every time I change it.



> We already have equivalent functionality by storing it in the dt's
> /chosen/bootargs so why this unnecessary complexity?
> 


> Add some code to edit the /chosen/bootargs at zImage runtime (just like
> arch/ppc used to) and we're covered.

That is what this patch is doing.

>   AFAICT, we're already adding a tool
> to tack on flat dt's to an already existing zImage so you're not doing
> anything we can't--or won't--do already.
> 

Can you please point me at this code so that I can evaluate it in
detail?

I'm curious how the tacked-on dt is expected to interact with the real
FW dt, and in particular how you would expect the interrogation
of /chosen/bootargs in prom_init.c (using prom_getprop()) to pick up the
command line value I specify in the tacked-on dt.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
