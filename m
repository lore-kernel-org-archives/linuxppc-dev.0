Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCE631A1147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 17:25:50 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSA0090QHI4Z660@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 30 Jul 2015 08:15:40 +0100 (BST)
Message-id: <55B9CF1A.1070107@samsung.com>
Date: Thu, 30 Jul 2015 09:15:38 +0200
From: Robert Baldyga <r.baldyga@samsung.com>
MIME-version: 1.0
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, Peter.Chen@freescale.com,
 johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com,
 cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org,
 haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com,
 m.szyprowski@samsung.com, stern@rowland.harvard.edu, petr.cvek@tul.cz
Subject: Re: [PATCH v4 04/46] staging: emxx_udc: add ep capabilities support
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
 <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
 <20150729152029.GB32418@saruman.tx.rr.com>
In-reply-to: <20150729152029.GB32418@saruman.tx.rr.com>
Content-type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2015 05:20 PM, Felipe Balbi wrote:
> On Mon, Jul 27, 2015 at 11:16:14AM +0200, Robert Baldyga wrote:
>> Convert endpoint configuration to new capabilities model.
>>
>> Fixed typo in "epc-nulk" to "epc-bulk".
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> ---
>>  drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++-------------------
>>  1 file changed, 29 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
>> index 3b7aa36..0d64bee 100644
>> --- a/drivers/staging/emxx_udc/emxx_udc.c
>> +++ b/drivers/staging/emxx_udc/emxx_udc.c
>> @@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadget_ops = {
>>  	.ioctl			= nbu2ss_gad_ioctl,
>>  };
>>  
>> -static const char g_ep0_name[] = "ep0";
>> -static const char g_ep1_name[] = "ep1-bulk";
>> -static const char g_ep2_name[] = "ep2-bulk";
>> -static const char g_ep3_name[] = "ep3in-int";
>> -static const char g_ep4_name[] = "ep4-iso";
>> -static const char g_ep5_name[] = "ep5-iso";
>> -static const char g_ep6_name[] = "ep6-bulk";
>> -static const char g_ep7_name[] = "ep7-bulk";
>> -static const char g_ep8_name[] = "ep8in-int";
>> -static const char g_ep9_name[] = "ep9-iso";
>> -static const char g_epa_name[] = "epa-iso";
>> -static const char g_epb_name[] = "epb-bulk";
>> -static const char g_epc_name[] = "epc-nulk";
>> -static const char g_epd_name[] = "epdin-int";
>> -
>> -static const char *gp_ep_name[NUM_ENDPOINTS] = {
>> -	g_ep0_name,
>> -	g_ep1_name,
>> -	g_ep2_name,
>> -	g_ep3_name,
>> -	g_ep4_name,
>> -	g_ep5_name,
>> -	g_ep6_name,
>> -	g_ep7_name,
>> -	g_ep8_name,
>> -	g_ep9_name,
>> -	g_epa_name,
>> -	g_epb_name,
>> -	g_epc_name,
>> -	g_epd_name,
>> +static const struct {
>> +	const char *name;
>> +	const struct usb_ep_caps caps;
>> +} ep_info[NUM_ENDPOINTS] = {
>> +#define EP_INFO(_name, _type, _dir) \
>> +	{ \
>> +		.name = _name, \
>> +		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
>> +				USB_EP_CAPS_DIR_ ## _dir), \
>> +	}
>> +
>> +	EP_INFO("ep0",		CONTROL, ALL),
>> +	EP_INFO("ep1-bulk",	BULK,	ALL),
>> +	EP_INFO("ep2-bulk",	BULK,	ALL),
>> +	EP_INFO("ep3in-int",	INT,	IN),
>> +	EP_INFO("ep4-iso",	INT,	ALL),
>> +	EP_INFO("ep5-iso",	ISO,	ALL),
>> +	EP_INFO("ep6-bulk",	ISO,	ALL),
>> +	EP_INFO("ep7-bulk",	BULK,	ALL),
>> +	EP_INFO("ep8in-int",	INT,	IN),
>> +	EP_INFO("ep9-iso",	ISO,	ALL),
>> +	EP_INFO("epa-iso",	ISO,	ALL),
>> +	EP_INFO("epb-bulk",	BULK,	ALL),
>> +	EP_INFO("epc-bulk",	BULK,	ALL),
>> +	EP_INFO("epdin-int",	INT,	IN),
> 
> IMO, this is pointless obfuscation. It just makes it a pain to grep
> source around. Why don't you have UDC drivers initialize the 1-bit flags
> directly ?
> 

Do you mean something like this? It just makes it a pain to scroll this
source ;)

static const struct {
	const char *name;
	const struct usb_ep_caps caps;
} ep_info[NUM_ENDPOINTS] = {
	{
		.name = "ep0",
		.caps = {
			.type_control = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep1-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep2-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep3in-int",
		.caps = {
			.type_int = true,
			.dir_in = true,
		},
	},
	{
		.name = "ep4-iso",
		.caps = {
			.type_iso = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep5-iso",
		.caps = {
			.type_iso = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep6-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep7-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "ep8in-int",
		.caps = {
			.type_int = true,
			.dir_in = true,
		},
	},
	{
		.name = "ep9-iso",
		.caps = {
			.type_iso = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "epa-iso",
		.caps = {
			.type_iso = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "epb-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = "epc-bulk",
		.caps = {
			.type_bulk = true,
			.dir_in = true,
			.dir_out = true,
		},
	},
	{
		.name = epdin-int,
		.caps = {
			.type_int = true,
			.dir_in = true,
		},
	},
};

Thanks,
Robert
