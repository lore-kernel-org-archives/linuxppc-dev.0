Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 6CD9867D0A
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:20:05 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAD3K3mD012511
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:20:04 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAD3K30l012492
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:20:03 +0900 (JST)
Message-ID: <4557E45C.10703@am.sony.com>
Date: Sun, 12 Nov 2006 19:19:56 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 14/16] powerpc: add ps3 platform OS params support
References: <4554DB20.9020200@am.sony.com>
	<1163381393.7410.39.camel@localhost.localdomain>
In-Reply-To: <1163381393.7410.39.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> +++ cell--common--6/arch/powerpc/platforms/ps3pf/Makefile
>> @@ -1,2 +1,2 @@
>>  obj-$(CONFIG_PS3PF) += setup.o mm.o smp.o time.o hvcall.o htab.o repository.o
>> -obj-$(CONFIG_PS3PF) += interrupt.o exports.o
>> +obj-$(CONFIG_PS3PF) += interrupt.o exports.o os-area.o
> 
> You don't need CONFIG_PS3PF in this Makefile, it'll only be built if
> CONFIG_PS3PF is already set, just add to obj-y. See the other platform
> Makefiles for example.


Good point, thanks.


>> +enum {
>> +	segment_size = 0x200,
>> +	ldr_format_raw = 0,
>> +	ldr_format_gzip = 1,
>> +	boot_flag_game_os = 0,
>> +	boot_flag_other_os = 1,
>> +	av_multi_out_ntsc = 0,
>> +	av_multi_out_pal_rgb = 1,
>> +	av_multi_out_pal_ycbcr = 2,
>> +	av_multi_out_secam = 3,
>> +	ctrl_button_o_is_yes = 0,
>> +	ctrl_button_x_is_yes = 1,
>> +};
> 
> I know you've got a lot of code to get reviewed and merged, but this
> still irks me. These aren't related constants, so I don't think they
> belong in an enum together, ctrl_button_o_is_yes == boot_flag_game_os ?
> 
> CodingStyle says the labels should be capitalised. 


I'll do that.


> Is it an offset (from something) or a segment number?
> 
>> + * @ldr_format: ldr_format flag.
>> + * @ldr_size: Size of bootloader image in bytes.
> 
> If these three all describe the same thing, the bootloader, it'd be good
> if the names were similar, eg: bootloader_offset, bootloader_format,
> bootloader_size.


These names came from the docs.  I think it would be best to keep them the
same to avoid confusion.

It is not so convenient to view, but the other os area is documented in the
iso image CELL-Linux-CL_20061110-ADDON.iso at
http://ftp.uk.linux.org/pub/linux/Sony-PS3/.


>> + */
>> +
>> +struct header {
>> +	s8 magic_num[16];
> 
> You compare this later to "cell_ext_os_area", so it's not really a magic
> number at all, it's a string?


Same thing, the name from the docs.


>> +static int __init verify_header(const struct header *header)
>> +{
>> +	if (memcmp(header->magic_num, "cell_ext_os_area", 16)) {
>> +		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
>> +		return -1;
>> +	}
>> +
>> +	if (header->hdr_version != 1) {
>> +		pr_debug("%s:%d hdr_version failed\n", __func__, __LINE__);
>> +		return -1;
>> +	}
> 
> Is version 2 not going to be backward compatible? Could it be >= 1 ?


I have absolutely no clue what the next version number will be, nor the
compatibility, etc.  I'll set this when the version changes.


>> +	dump_header(header);
>> +	dump_params(params);
>> +
>> +	os_params.rtc_diff = params->rtc_diff;
>> +	os_params.av_multi_out = params->av_multi_out;
>> +	if (0) { /* currently not used */
> 
> Why not?


The drivers aren't ported yet.  I suppose I could take this out though.


-Geoff
