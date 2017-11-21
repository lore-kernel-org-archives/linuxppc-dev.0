Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh3H03trVzDrbb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 22:27:56 +1100 (AEDT)
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl_ssi: serialize AC'97 register
 access operations
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <9010cdad-4b05-d456-bf73-24cc48e38d69@maciej.szmigiero.name>
 <20171121015247.GE14136@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <33ec14ef-7b05-544d-58ba-0e14aa2a97d4@maciej.szmigiero.name>
Date: Tue, 21 Nov 2017 12:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171121015247.GE14136@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.11.2017 02:52, Nicolin Chen wrote:
> On Mon, Nov 20, 2017 at 11:16:07PM +0100, Maciej S. Szmigiero wrote:
(..)
>>  static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>> @@ -1287,16 +1295,18 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>>  {
>>  	struct regmap *regs = fsl_ac97_data->regs;
>>  
>> -	unsigned short val = -1;
>> +	unsigned short val = 0;
>>  	u32 reg_val;
>>  	unsigned int lreg;
>>  	int ret;
>>  
>> +	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
>> +
>>  	ret = clk_prepare_enable(fsl_ac97_data->clk);
>>  	if (ret) {
>>  		pr_err("ac97 read clk_prepare_enable failed: %d\n",
>>  			ret);
>> -		return -1;
>> +		goto ret_unlock;
> 
> It will return val (== 0) in this case. Will this be correctly
> handled by callers? I find sound/ac97/bus.c checks if ret < 0
> for ops->read().

Both 0 and -1 (0xffff really) are valid register values.

AC'97 code that is used in companion with fsl_ssi lives in sound/pci/ac97
directory and does register reads via snd_ac97_read() function in
ac97_codec.c file (located in that directory).
This function has no such check.

The reason why AC'97 specs call for unknown register read to return zero
is that if there is some capability bit in a register then this bit is
set when a CODEC has such capability.
If we return -1 then it means that in this case a CODEC would be
detected as having all possible capabilities that are exposed via this
register (including these that aren't really supported) while if we
return 0 instead then we merely wouldn't make use of some that are actually
present.

> 
> So it might be better to add "val = ret;" before goto? Or use
> val instead of ret directly?

Then we would be returning an error number from clk_prepare_enable()
as a register value which would be almost certainly wrong.

Note that this method returns unsigned short - a type with the same width
as an AC'97 register, so there are no unused values in this type which
could be reliably used to signify that an error had happened.

Maciej
