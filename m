Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C1951DE071
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 22:26:38 +1000 (EST)
Date: Thu, 28 Aug 2008 14:26:30 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
In-Reply-To: <1219925555.7107.276.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0808281425400.28552@vixen.sonytel.be>
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<1219925555.7107.276.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-721297833-1219926390=:28552"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-721297833-1219926390=:28552
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 28 Aug 2008, David Woodhouse wrote:
> On Wed, 2008-08-13 at 11:27 +1000, Paul Mackerras wrote:
> > The following series of patches implement support for a relocatable
> > kernel by building it as a position-independent executable (PIE).
> > When the linker is given the -pie flag, it creates an executable that
> > contains dynamic relocations which can be used to relocate the image
> > at boot time for any desired base address.  This patch series adds a
> > CONFIG_RELOCATABLE config option for 64-bit which links the kernel
> > with -pie and arranges to process the relocations in early boot.
> > 
> > With the first 4 patches applied, a relocatable kernel will still copy
> > itself down to real address 0.  The last patch changes things so that
> > a relocatable kernel will run wherever it was loaded.  This last patch
> > is pretty much just a proof of concept since it doesn't do anything to
> > ensure appropriate alignment of the base address (the base address
> > needs to be 16kB aligned).  We probably want to work out whether we
> > are a kdump kernel and run in-place if so, or copy down to 0 if not.
> 
> Is this mature enough for us to consider putting it in Fedora? We'd
> _love_ to stop building a separate kdump kernel for ppc64...

I tried CONFIG_RELOCATABLE=y on PS3 a while ago, and the resulting kernel
locked up during early boot.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-721297833-1219926390=:28552--
