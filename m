Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0A389DE02F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 11:08:33 +1000 (EST)
Message-ID: <470AD48B.5060102@am.sony.com>
Date: Mon, 08 Oct 2007 18:08:27 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<Pine.LNX.4.62.0710081019030.21197@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710081019030.21197@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Sat, 6 Oct 2007 geoffrey.levand@am.sony.com wrote:
>> --- a/arch/powerpc/platforms/ps3/os-area.c
>> +++ b/arch/powerpc/platforms/ps3/os-area.c
>> @@ -112,10 +114,91 @@ struct os_area_params {
>>  	u8 _reserved_5[8];
>>  };
>>  
>> +/**
>> + * struct os_area_db - Shared flash memory database.
>> + * @magic_num: Always '-db-' = 0x2d64622d.
>                                   ^^^^^^^^^^
> #define?


Well, this is a comment, and when debugging it is handy to
know the value.


>> @@ -242,6 +325,303 @@ static int __init verify_header(const st
>>  	return 0;
>>  }
>>  
>> +static int db_verify(const struct os_area_db *db)
>> +{
>> +	if (db->magic_num != 0x2d64622dU) {
>                              ^^^^^^^^^^^
> #define?


Sure, it is OK here.


>> +static void os_area_db_init(struct os_area_db *db)
>> +{
>> +	/*
>> +	 * item      | start | size
>> +	 * ----------+-------+-------
>> +	 * header    | 0     | 24
>> +	 * index_64  | 24    | 64
>> +	 * values_64 | 88    | 57*8 = 456
>> +	 * index_32  | 544   | 64
>> +	 * values_32 | 609   | 57*4 = 228
>> +	 * index_16  | 836   | 64
>> +	 * values_16 | 900   | 57*2 = 114
>> +	 * end       | 1014  | -
>> +	 */
> 
> Lots of #defines and calculations?


OK.


>> +
>> +	memset(db, 0, sizeof(struct os_area_db));
>> +
>> +	db->magic_num = 0x2d64622dU;
>                         ^^^^^^^^^^^
> #define?
> 
>> +	db->version = 1;
>> +	db->index_64 = 24;
>                        ^^
>> +	db->count_64 = 57;
>                        ^^
>> +	db->index_32 = 544;
>                        ^^^
>> +	db->count_32 = 57;
>                        ^^
>> +	db->index_16 = 836;
>                        ^^^
>> +	db->count_16 = 57;
>                        ^^
> #defines?
> 
>> +static void update_flash_db(void)
>> +{
>> +	int result;
>> +	int file;
>> +	off_t offset;
>> +	ssize_t count;
>> +	static const unsigned int buf_len = 8 * OS_AREA_SEGMENT_SIZE;
>> +	const struct os_area_header *header;
>> +	struct os_area_db* db;
>> +
>> +	/* Read in header and db from flash. */
>> +
>> +	file = sys_open("/dev/ps3flash", O_RDWR, 0);
> 
> Ah, file operations from kernel space...


Yes.  I was thinking we could make an interface to the flash driver.

 
>> @@ -264,6 +644,9 @@ static void os_area_queue_work_handler(s
>>  		pr_debug("%s:%d of_find_node_by_path failed\n",
>>  			__func__, __LINE__);
>>  
>> +#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
>> +	update_flash_db();
>> +#endif
> 
> Is this #ifdef needed? You don't reference ps3flash symbols directly, only by
> opening /dev/ps3flash. If you always call update_flash_db(), you can print an
> error message and the user will notice things haven't been written to flash.


My thinking was that the file I/O code would be removed by the optimizer
when not needed.  I added a message.
