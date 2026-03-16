Return-Path: <linuxppc-dev+bounces-18219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2F7F013F0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ8R04RhYz2ygh;
	Mon, 16 Mar 2026 20:09:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773649803;
	cv=none; b=RGvlevSPKBdW3YBPVGDVqJsowhu7ZYaVVh2S0+XB1dEZ218pH+a9tl12SHxI3PDMHhhaecS/t0KlLUqXfU/PWSHfxEHGiG5tQcWGTxvnKJbjndAz+Y87EDDr+CEj9LGGOZ83Jw5Onc2OEKxAoqG0dLopRtl7VSSc2gVRBCecN8bPuhI63sfKYZnXGHLZCO09DALVF2TlKMDBBpSFF4hw0D0MwKsj4aCC8k/PhvAQqDFyFDzDSmfH9SKt5wNrzuGxrBiYR5KNEsOf+4kFo9nKGuBj85j2JMEr/4/qmWldYIvanXAOpzOBeqW23ltDuNO1ByJqAPv6GAdQfCEZ2OATjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773649803; c=relaxed/relaxed;
	bh=TkOoSQ6xnhNsEXymDnt/JlPwMCjTrRpZyzgc4ICmXUU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C1GovOmqs/ddp1JVQIxS1oatyNdv4BPPWs89rUE2cv+Wa5BpWME98rZmuyftVu69IBvtI842J8e/nRf7c6+3E1iazmv0woX5UivcQegMAnUg9E0F4ZY/Ql3rz8khlY6ichD4BgBiVlncI2Kii4H5d7+4Lv95DcghRFhPeLJntSRB5ULS4vlIWLwvBVV2yFW7Bo/xQMFkgvQjj40+Wf/rXnpCr/VqYX17DP+LwRgjHGCWQI8lsdfe8zASwfhtsKanuv2aU+DhdJs4HkiGt5gSiZsyI1DUwXTj1vXPiBXZlVM5lzi04qKYwsuRRUq+spLmtZprxcnX6j4XT8qiTtyHgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kdnn4047; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kdnn4047;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7Z23jpHz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 19:30:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 96A2960131;
	Mon, 16 Mar 2026 08:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870B9C19421;
	Mon, 16 Mar 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773649799;
	bh=ZleLRHDOHBip+HjzKZfgbCdexqRYELee4obevGjagA4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=kdnn4047r/PTpjAKHd4omIMsOpl4ztjzFI5kQfAUHqX34ZPsmSn81reSSVgRSu89L
	 23+I9JxdTSXW1Dtu8OD62Jknq6sVuNAgNgFFG5QTKl3P9oWtSnR5TnzkAib8OoB80m
	 IzP0p4pdzZwAEvZFrBftxiPl0XRkbYaXutmNVoJUxk14TYt9HSiD/Ud4M8rgJcJiWt
	 Jjrsf0NhBzFKRsgH1b9oxEFZjq0Jv4BOfLXqL4n6qn8PVHGsXaQwxoXgwDZYY2uT7Z
	 eOGFtrH4AuPzlfaTtRpXuNRMih137kjkvsYvuaEcu1V5czsaiYolnUDslf/GhryY+g
	 z99YJ8m1u/W0Q==
Message-ID: <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org>
Date: Mon, 16 Mar 2026 09:29:52 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2 01/13] media: saa7134: rename i2c_dbg() to
 saa7134_i2c_dbg()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Khalil Blaiech <kblaiech@nvidia.com>,
 Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
 Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bartosz,

Apologize, the earlier patches for this fell through the cracks so never
made it to v7.0.

For this v2:

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Do you want to merge this through the i2c subsystem? Or do you want me to
merge this patch through the media subsystem?

Regards,

	Hans

On 23/02/2026 09:59, Bartosz Golaszewski wrote:
> Ahead of introducing I2C-adapter-specific printk() helpers, preemptively
> avoid a conflict with the upcoming i2c_dbg() and rename the local macro
> in the saa7134 driver to saa7134_i2c_dbg().
> 
> Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/media/pci/saa7134/saa7134-i2c.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/pci/saa7134/saa7134-i2c.c b/drivers/media/pci/saa7134/saa7134-i2c.c
> index 04e85765373ecc0f0759eba539c20bcdc9716ca8..1164e91cbb7b7f5250dc02bc086f5cc06ea8f5a5 100644
> --- a/drivers/media/pci/saa7134/saa7134-i2c.c
> +++ b/drivers/media/pci/saa7134/saa7134-i2c.c
> @@ -28,7 +28,7 @@ static unsigned int i2c_scan;
>  module_param(i2c_scan, int, 0444);
>  MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
>  
> -#define i2c_dbg(level, fmt, arg...) do { \
> +#define saa7134_i2c_dbg(level, fmt, arg...) do { \
>  	if (i2c_debug == level) \
>  		printk(KERN_DEBUG pr_fmt("i2c: " fmt), ## arg); \
>  	} while (0)
> @@ -84,20 +84,20 @@ static inline enum i2c_status i2c_get_status(struct saa7134_dev *dev)
>  	enum i2c_status status;
>  
>  	status = saa_readb(SAA7134_I2C_ATTR_STATUS) & 0x0f;
> -	i2c_dbg(2, "i2c stat <= %s\n", str_i2c_status[status]);
> +	saa7134_i2c_dbg(2, "i2c stat <= %s\n", str_i2c_status[status]);
>  	return status;
>  }
>  
>  static inline void i2c_set_status(struct saa7134_dev *dev,
>  				  enum i2c_status status)
>  {
> -	i2c_dbg(2, "i2c stat => %s\n", str_i2c_status[status]);
> +	saa7134_i2c_dbg(2, "i2c stat => %s\n", str_i2c_status[status]);
>  	saa_andorb(SAA7134_I2C_ATTR_STATUS,0x0f,status);
>  }
>  
>  static inline void i2c_set_attr(struct saa7134_dev *dev, enum i2c_attr attr)
>  {
> -	i2c_dbg(2, "i2c attr => %s\n", str_i2c_attr[attr]);
> +	saa7134_i2c_dbg(2, "i2c attr => %s\n", str_i2c_attr[attr]);
>  	saa_andorb(SAA7134_I2C_ATTR_STATUS,0xc0,attr << 6);
>  }
>  
> @@ -160,7 +160,7 @@ static int i2c_reset(struct saa7134_dev *dev)
>  	enum i2c_status status;
>  	int count;
>  
> -	i2c_dbg(2, "i2c reset\n");
> +	saa7134_i2c_dbg(2, "i2c reset\n");
>  	status = i2c_get_status(dev);
>  	if (!i2c_is_error(status))
>  		return true;
> @@ -198,7 +198,7 @@ static inline int i2c_send_byte(struct saa7134_dev *dev,
>  //	dword |= 0x40 << 16;  /* 400 kHz */
>  	dword |= 0xf0 << 24;
>  	saa_writel(SAA7134_I2C_ATTR_STATUS >> 2, dword);
> -	i2c_dbg(2, "i2c data => 0x%x\n", data);
> +	saa7134_i2c_dbg(2, "i2c data => 0x%x\n", data);
>  
>  	if (!i2c_is_busy_wait(dev))
>  		return -EIO;
> @@ -220,7 +220,7 @@ static inline int i2c_recv_byte(struct saa7134_dev *dev)
>  	if (i2c_is_error(status))
>  		return -EIO;
>  	data = saa_readb(SAA7134_I2C_DATA);
> -	i2c_dbg(2, "i2c data <= 0x%x\n", data);
> +	saa7134_i2c_dbg(2, "i2c data <= 0x%x\n", data);
>  	return data;
>  }
>  
> @@ -237,12 +237,12 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
>  		if (!i2c_reset(dev))
>  			return -EIO;
>  
> -	i2c_dbg(2, "start xfer\n");
> -	i2c_dbg(1, "i2c xfer:");
> +	saa7134_i2c_dbg(2, "start xfer\n");
> +	saa7134_i2c_dbg(1, "i2c xfer:");
>  	for (i = 0; i < num; i++) {
>  		if (!(msgs[i].flags & I2C_M_NOSTART) || 0 == i) {
>  			/* send address */
> -			i2c_dbg(2, "send address\n");
> +			saa7134_i2c_dbg(2, "send address\n");
>  			addr  = msgs[i].addr << 1;
>  			if (msgs[i].flags & I2C_M_RD)
>  				addr |= 1;
> @@ -265,7 +265,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
>  		}
>  		if (msgs[i].flags & I2C_M_RD) {
>  			/* read bytes */
> -			i2c_dbg(2, "read bytes\n");
> +			saa7134_i2c_dbg(2, "read bytes\n");
>  			for (byte = 0; byte < msgs[i].len; byte++) {
>  				i2c_cont(1, " =");
>  				rc = i2c_recv_byte(dev);
> @@ -286,7 +286,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
>  			}
>  		} else {
>  			/* write bytes */
> -			i2c_dbg(2, "write bytes\n");
> +			saa7134_i2c_dbg(2, "write bytes\n");
>  			for (byte = 0; byte < msgs[i].len; byte++) {
>  				data = msgs[i].buf[byte];
>  				i2c_cont(1, " %02x", data);
> @@ -296,7 +296,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
>  			}
>  		}
>  	}
> -	i2c_dbg(2, "xfer done\n");
> +	saa7134_i2c_dbg(2, "xfer done\n");
>  	i2c_cont(1, " >");
>  	i2c_set_attr(dev,STOP);
>  	rc = -EIO;
> 


