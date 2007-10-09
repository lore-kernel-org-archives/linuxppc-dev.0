Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 58AC7DDF6A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 21:39:00 +1000 (EST)
Date: Tue, 9 Oct 2007 13:38:57 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch v2] PS3: Add os-area database routines
In-Reply-To: <470AD44C.5080305@am.sony.com>
Message-ID: <Pine.LNX.4.62.0710091334320.6961@pademelon.sonytel.be>
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<470AD44C.5080305@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1761651087-1191929937=:6961"
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

---584337861-1761651087-1191929937=:6961
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Oct 2007, Geoff Levand wrote:
>   o Add a KERN_WARNING message when flash driver is not available.

> --- a/arch/powerpc/platforms/ps3/os-area.c
> +++ b/arch/powerpc/platforms/ps3/os-area.c

> +static void update_flash_db(void)
> +{
> +	int result;
> +	int file;
> +	off_t offset;
> +	ssize_t count;
> +	static const unsigned int buf_len = 8 * OS_AREA_SEGMENT_SIZE;
> +	const struct os_area_header *header;
> +	struct os_area_db* db;
> +
> +	/* Read in header and db from flash. */
> +
> +	file = sys_open("/dev/ps3flash", O_RDWR, 0);
> +
> +	if (file < 0) {
> +		pr_debug("%s:%d sys_open failed\n", __func__, __LINE__);
                ^^^^^^^^
pr_warn?

If the ps3flash module is not loaded, you want to see the warning.

> @@ -264,6 +664,12 @@ static void os_area_queue_work_handler(s
>  		pr_debug("%s:%d of_find_node_by_path failed\n",
>  			__func__, __LINE__);
>  
> +#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
> +	update_flash_db();
> +#else
> +	printk(KERN_WARNING "%s:%d: No flash rom driver configured.\n",
> +		__func__, __LINE__);
> +#endif
>  	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>  }

Alternatively:

    #if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
    static int update_flash_db(void)
    {
	...
	return error;
    }
    #else
    static inline int update_flash_db(void)
    {
	return -Exxx;
    }
    #endif

	if (update_flash_db())
	    printk(KERN_WARNING ...);


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
---584337861-1761651087-1191929937=:6961--
