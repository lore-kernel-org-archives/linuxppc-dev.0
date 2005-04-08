Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id AD89267B27
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 21:54:37 +1000 (EST)
Message-ID: <33467.82.10.231.190.1112960162.squirrel@82.10.231.190>
In-Reply-To: <20050406185049.GF3396@smtp.west.cox.net>
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net> <42533FA1.1070001@gmx.net>
	<20050406185049.GF3396@smtp.west.cox.net>
Date: Fri, 8 Apr 2005 12:36:02 +0100 (BST)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to
 2.6.9-rc1-bk1	introduced residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini said:
> On Wed, Apr 06, 2005 at 03:47:13AM +0200, Christian wrote:
>> Tom Rini wrote:
>> > Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
>> > command-line works?  Thanks.
>>
>> i booted vanilla 2.6.11.6 with noresidual (and "nopresidual" too, as
>> Sven
>> sugggested), but the scsi errors did not went away :(
>>
>> on a side note, and perhaps totally unrelated: i always have
>> PROC_PREPRESIDUAL=y in my .config, but i never had /proc/residual as
>> promised from the help text.
>
> Odd.  I thought that only happened if you had no residual data at all
> (which can happen on Powerstacks, esp if netbooting the kernel).  But in
> that case the new code shouldn't be hit at all.  Leigh?

Hi, I'm back from my holidays, and have had a look at this.  As I spent
lots of time understanding the horrendous mess that was
prep_pcibios_fixup(), I'd be loath to back out the changes I made
(especially as they work so well for me ;-) ).

It turns out that prep_pib_init() is the culprit.  Although it would
appear to be coded for the non-openpic case, it obviously doesn't work.
The old version of prep_pcibios_fixup() only called it if there is an
openpic on the machine.  We can restore that behaviour with the
following patch:

--- prep_pci.c.orig	2005-04-08 11:49:25.743718088 +0000
+++ prep_pci.c	2005-04-08 12:23:00.541422280 +0000
@@ -1245,8 +1245,13 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}

-	/* Setup the Winbond or Via PIB */
-	prep_pib_init();
+	/* Setup the Winbond or Via PIB - prep_pib_init() is coded for
+	 * the non-openpic case, but it breaks (at least) the Utah
+	 * (Powerstack II Pro4000), so only call it if we have an
+	 * openpic.
+	 */
+	if (have_openpic)
+		prep_pib_init();
 }

 static void __init

I've no idea even what machines would be affected by this, but it
fixes Sven's problem and restores the old behaviour, so that
can't be bad.

I guess fixing prep_pib_init() would be the better solution but
I wouldn't know where to start.  If this band-aid is good enough
I can submit a proper patch, if you like.

Cheers,

Leigh.
