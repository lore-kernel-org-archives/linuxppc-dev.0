Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4821C67B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 17:45:16 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 25 Oct 2006 09:45:14 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <17726.63354.839675.689493@cargo.ozlabs.ibm.com>
Message-ID: <20061025074514.236980@gmx.net>
MIME-Version: 1.0
References: <20060628202753.198630@gmx.net>	<s5hfyhopb0s.wl%tiwai@suse.de>
	<20060629211513.64980@gmx.net>	<s5hwtaz9fdr.wl%tiwai@suse.de>
	<20060630182144.27980@gmx.net>	<20061019132423.270440@gmx.net>
	<1161474692.10524.266.camel@localhost.localdomain>
	<20061023185714.22630@gmx.net>
	<17726.63354.839675.689493@cargo.ozlabs.ibm.com>
Subject: Re: Crash with highmem support enabled
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Wed, 25 Oct 2006 15:34:50 +1000
Von: Paul Mackerras <paulus@samba.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Betreff: Re: Crash with highmem support enabled

> Gerhard Pircher writes:
> 
> > I guess this has something to do with the IO block mapping, which is
> > implemented in the amigaone_setup.c file and looks like this:
> 
> Why on earth are you still using io_block_mapping?

What should be used instead? ioremap()? The io_block_mapping() code was copied over from the PReP platform code in arch/ppc/platforms/.

In the meantime I found out that highmem failed due to the IO block mapping (sometimes it is good to look at the code ;). The mapping is needed for the AmigaOne/U-boot framebuffer to be able to access the ISA memory and I/O. Where and when can I savely remap (no 1:1 remapping) the ISA space so that the framebuffer survives the MMU initialization?

thanks!

Gerhard

-- 
GMX DSL-Flatrate 0,- Euro* - Überall, wo DSL verfügbar ist!
NEU: Jetzt bis zu 16.000 kBit/s! http://www.gmx.net/de/go/dsl
