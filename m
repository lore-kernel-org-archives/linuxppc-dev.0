Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 3C782DDF03
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 18:27:28 +1000 (EST)
Date: Mon, 8 Oct 2007 10:27:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <20071006213542.954029915@am.sony.com>
Message-ID: <Pine.LNX.4.62.0710081019030.21197@pademelon.sonytel.be>
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-259390643-1191831656=:21197"
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

---584337861-259390643-1191831656=:21197
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0710081021241.21197@pademelon.sonytel.be>

On Sat, 6 Oct 2007 geoffrey.levand@am.sony.com wrote:
> --- a/arch/powerpc/platforms/ps3/os-area.c
> +++ b/arch/powerpc/platforms/ps3/os-area.c
> @@ -112,10 +114,91 @@ struct os_area_params {
>  	u8 _reserved_5[8];
>  };
>  
> +/**
> + * struct os_area_db - Shared flash memory database.
> + * @magic_num: Always '-db-' = 0x2d64622d.
                                  ^^^^^^^^^^
#define?

> @@ -242,6 +325,303 @@ static int __init verify_header(const st
>  	return 0;
>  }
>  
> +static int db_verify(const struct os_area_db *db)
> +{
> +	if (db->magic_num != 0x2d64622dU) {
                             ^^^^^^^^^^^
#define?

> +static void os_area_db_init(struct os_area_db *db)
> +{
> +	/*
> +	 * item      | start | size
> +	 * ----------+-------+-------
> +	 * header    | 0     | 24
> +	 * index_64  | 24    | 64
> +	 * values_64 | 88    | 57*8 = 456
> +	 * index_32  | 544   | 64
> +	 * values_32 | 609   | 57*4 = 228
> +	 * index_16  | 836   | 64
> +	 * values_16 | 900   | 57*2 = 114
> +	 * end       | 1014  | -
> +	 */

Lots of #defines and calculations?

> +
> +	memset(db, 0, sizeof(struct os_area_db));
> +
> +	db->magic_num = 0x2d64622dU;
                        ^^^^^^^^^^^
#define?

> +	db->version = 1;
> +	db->index_64 = 24;
                       ^^
> +	db->count_64 = 57;
                       ^^
> +	db->index_32 = 544;
                       ^^^
> +	db->count_32 = 57;
                       ^^
> +	db->index_16 = 836;
                       ^^^
> +	db->count_16 = 57;
                       ^^
#defines?

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

Ah, file operations from kernel space...

> @@ -264,6 +644,9 @@ static void os_area_queue_work_handler(s
>  		pr_debug("%s:%d of_find_node_by_path failed\n",
>  			__func__, __LINE__);
>  
> +#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
> +	update_flash_db();
> +#endif

Is this #ifdef needed? You don't reference ps3flash symbols directly, only by
opening /dev/ps3flash. If you always call update_flash_db(), you can print an
error message and the user will notice things haven't been written to flash.

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
---584337861-259390643-1191831656=:21197--
