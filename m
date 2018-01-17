Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMJZ121nWzF0gd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 07:28:08 +1100 (AEDT)
Subject: Re: [PATCH v5 00/17] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
 <a6621849-2621-79ee-c8a4-09e23beea2c5@maciej.szmigiero.name>
 <20180117200210.GA9523@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <708b241d-43b3-96af-909c-81093f9753e9@maciej.szmigiero.name>
Date: Wed, 17 Jan 2018 21:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180117200210.GA9523@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.01.2018 21:02, Nicolin Chen wrote:
> On Wed, Jan 17, 2018 at 08:38:48PM +0100, Maciej S. Szmigiero wrote:
> 
>> However, I have a small nitpick regarding a comment newly added in
>> this version of patch 16:
>> +		/*
>> +		 * Do not set SSI dev as the parent of AC97 CODEC device since
>> +		 * it does not have a DT node. Otherwise ASoC core will assume
>> +		 * CODEC has the same DT node as the SSI, so it may return a
>> +		 * NULL pointer of CODEC when asked for SSI via the DT node
>>
>> The second part of the last sentence isn't really true, the ASoC core
>> will return a (valid, non-NULL) CODEC object pointer when asked for
>> the SSI one if we set the SSI as the parent device of a AC'97 CODEC
>> platform device.
>>
>> The NULL pointer dereference when starting a playback that I wrote
>> about in my previous message happens because in this situation the SSI
>> DAI probe callback won't ever get called and so won't setup DMA data
>> pointers (they will remain NULL).
> 
> Well, somehow the DMA data pointer of CODEC could be described
> as "a NULL pointer of CODEC" reluctantly...it confuses people
> though.
> 
>> And this in turn will cause the ASoC DMA code to dereference these
>> NULL pointers when starting a playback (the same will probably happen
>> also when starting a capture).
>>
>> Sorry if I wasn't 100% clear about these details in my previous
>> message describing this issue.
> 
> I would prefer to send an incremental patch later to update it,
> if there are no new comments against this version; Otherwise, I
> will update it in a next version once there is a need to send a
> v6 anyway.

IMHO it is such a tiny thing that it isn't worth respinning 17
patch series just for it, it can be easily improved later via
a separate patch.

> Thanks
> 

Thanks,
Maciej
