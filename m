Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D645FDDF87
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 23:07:29 +1000 (EST)
Message-Id: <983C93C9-4AA8-421B-B7F8-770E2FD672E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20090506220119.7322783420E8@gemini.denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Date: Thu, 7 May 2009 08:05:02 -0500
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
	<20090506220119.7322783420E8@gemini.denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 6, 2009, at 5:01 PM, Wolfgang Denk wrote:

> Dear Grant,
>
> in message <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com 
> > you wrote:
>>
> ...
>>> #ifdef CONFIG_FS_ENET_HAS_FEC
>>> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
>>> +    {
>>> +        .compatible = "fsl,mpc5121-fec",
>>> +        .data = (void *)&fs_fec_ops,
>>> +    },
>>> +#else
>>>   {
>>>       .compatible = "fsl,pq1-fec-enet",
>>>       .data = (void *)&fs_fec_ops,
>>>   },
>>> #endif
>>> +#endif
>>
>> Hmmm.  A lot of these #ifdefs in here.  Does this have a  
>> multiplatform
>> impact?  Not to mention the fact that it's just plain ugly.  :-)
>
> Agreed that it's ugly, but duplicatio9ng the code would have been even
> worse. I don't think that it has multiplatform - at least not as long
> as you don't ask for one image that runs on 83xx and on 512x.

We do ask for that.  The fedora ppc6xx kernel should work on any 6xx/ 
7xx/7xxx based core chip.  We should NOT be breaking such capability  
in drivers.

- k
