Return-Path: <albert_herranz@yahoo.es>
Received: from smtp129.mail.ukl.yahoo.com (smtp129.mail.ukl.yahoo.com
	[77.238.184.60]) by ozlabs.org (Postfix) with SMTP id 1CD49B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:21:09 +1100 (EST)
Message-ID: <4B0AE0A3.8040104@yahoo.es>
Date: Mon, 23 Nov 2009 20:21:07 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 17/19] powerpc: wii: bootmii starlet 'mini' firmware
	support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<200911222348.20652.arnd@arndb.de>
In-Reply-To: <200911222348.20652.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Sunday 22 November 2009, Albert Herranz wrote:
>> + *
>> + */
>> +struct mipc_device {
>> +	void __iomem *io_base;
>> +	int irq;
>> +
>> +	struct device *dev;
>> +
>> +	spinlock_t call_lock;	/* serialize firmware calls */
>> +	spinlock_t io_lock;	/* serialize access to io registers */
>> +
>> +	struct mipc_infohdr *hdr;
>> +
>> +	struct mipc_req *in_ring;
>> +	size_t in_ring_size;
>> +	volatile u16 intail_idx;
>> +
>> +	struct mipc_req *out_ring;
>> +	size_t out_ring_size;
>> +	volatile u16 outhead_idx;
>> +
>> +	u32 tag;
>> +};
> 
> The 'volatile' here seems out of place. What are you trying to protect
> against?

Nothing. I'll get rid of it.
It slipped through from ancient versions of the patch.

> The rest of the patch seems to be made up of layers of wrappers. They
> are all well coded, but I got a feeling that the same could be achieved
> with less of it.

The code provides a complete emulation layer of hardware accessors via ipc calls to the firmware.
This was a requirement to access part of the hardware until a "magic" register was found allowing direct hardware access from the PowerPC side.

I can get rid of the currently unused infrastructure and leave the strictly needed code (i.e. code to make sure that the firmware SDHC driver is shutdown and that the ahbprot register is properly setup).

I'll look into that. Thanks.

Cheers,
Albert
