Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxDw81klPzDr1s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 02:26:47 +1000 (AEST)
To: Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-ntb@googlegroups.com,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-7-logang@deltatee.com>
 <504da99a-838c-48ec-c5b2-6b611d587a10@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 David Airlie <airlied@linux.ie>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3ffb5648-00f6-26cb-116a-370085038a0d@deltatee.com>
Date: Mon, 26 Jun 2017 10:26:35 -0600
MIME-Version: 1.0
In-Reply-To: <504da99a-838c-48ec-c5b2-6b611d587a10@ti.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 6/7] drm/tilcdc: clean up ifdef hacks around iowrite64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jyri,

Thanks for the ack. However, I'm reworking this patch set to use the
include/linux/io-64-nonatomic* headers which will explicitly devolve
into two 32-bit transfers. It's not clear whether this is appropriate
for the tilcdc driver as it was never setup to use 32-bit transfers
(unlike the others I had patched).

If you think it's ok, I can still patch this driver to use the
non-atomic headers. Otherwise I can leave it out. Please let me know.

Thanks,

Logan


On 26/06/17 02:55 AM, Jyri Sarha wrote:
> Acked-by: Jyri Sarha <jsarha@ti.com>
> 
> And thanks!
> 
>> ---
>>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
>> index e9ce725698a9..0b901405f30a 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
>> @@ -133,13 +133,7 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
>>  	struct tilcdc_drm_private *priv = dev->dev_private;
>>  	void __iomem *addr = priv->mmio + reg;
>>  
>> -#ifdef iowrite64
>>  	iowrite64(data, addr);
>> -#else
>> -	__iowmb();
>> -	/* This compiles to strd (=64-bit write) on ARM7 */
>> -	*(u64 __force *)addr = __cpu_to_le64(data);
>> -#endif
>>  }
>>  
>>  static inline u32 tilcdc_read(struct drm_device *dev, u32 reg)
>>
> 
