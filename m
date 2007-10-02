Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 0EC32DDF3A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 21:42:13 +1000 (EST)
Date: Tue, 2 Oct 2007 13:42:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: mem_init_done (was: Re: [PATCH] [POWERPC] Limit range of __init_ref_ok
	somewhat)
In-Reply-To: <20071002133753.662397db.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.62.0710021334360.9607@pademelon.sonytel.be>
References: <20071002133753.662397db.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1901354232-1191325325=:9607"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1901354232-1191325325=:9607
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Oct 2007, Stephen Rothwell wrote:
> +void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
> +{
> +	void *p;
> +
> +	if (mem_init_done)
> +		p = kzalloc(size, mask);
> +	else {
> +		p = alloc_bootmem(size);
> +		if (p)
> +			memset(p, 0, size);
> +	}
> +	return p;
> +}

BTW, is this `mem_init_done' flag the recommended(TM) way to handle this?
Or is it just something that always stayed under the radar of the reviewers, as
only PPC has it (and Atari)?

I remember we had something similar globally when __init was introduced,
which was used by the frame buffer code to determine whether to draw the
penguin logo (which is __initdata) or not. This code had to be ripped out (and
was replaced by the FBINFO_MODULE logic), because people didn't like
mem_init_done flags...

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1901354232-1191325325=:9607--
