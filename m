Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 82336DDFC1
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 22:16:26 +1000 (EST)
Date: Mon, 8 Oct 2007 14:16:24 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <20071006213542.954029915@am.sony.com>
Message-ID: <Pine.LNX.4.62.0710081412260.31455@pademelon.sonytel.be>
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-366485648-1191845784=:31455"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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

---584337861-366485648-1191845784=:31455
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 6 Oct 2007 geoffrey.levand@am.sony.com wrote:
> --- a/arch/powerpc/platforms/ps3/os-area.c
> +++ b/arch/powerpc/platforms/ps3/os-area.c

> +static int db_get_video_mode(const struct os_area_db *db,
> +	unsigned int *video_mode)
        ^^^^^^^^^^^^^^
> +{
> +	return db_get_64(db, &os_area_db_id_video_mode, (uint64_t*)video_mode);
                                                        ^^^^^^^^^^^
> +}

Woops, memory corruption, when writing a 64-bit value to a 32-bit variable.

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
---584337861-366485648-1191845784=:31455--
