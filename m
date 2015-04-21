Return-Path: <timur@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEF031A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 13:42:08 +1000 (AEST)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2FFF814012F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 13:42:06 +1000 (AEST)
Message-ID: <5535C70A.9070607@codeaurora.org>
Date: Mon, 20 Apr 2015 22:42:02 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>	
 <1429232060.22546.7.camel@ellerman.id.au>	
 <1429244000.32545.51.camel@freescale.com>	
 <1429251526.22546.8.camel@ellerman.id.au>	
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>	
 <1429296759.4352.8.camel@freescale.com>	
 <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>	
 <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>	
 <1429561902.4352.29.camel@freescale.com>	
 <CAOZdJXWnh3PbZ8FRFzJ9=h+bFF3_Uqeu=hzoqD6GYF8acQ21kQ@mail.gmail.com>
 <1429582152.4352.73.camel@freescale.com>
In-Reply-To: <1429582152.4352.73.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Richard Schmitt <richard.schmitt@freescale.com>,
 Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> >
>> >Why do you need a powerpc-specific way to use merge_config.sh?  Other
>> >architectures have the same problem with defconfigs.

> What are you perceiving as "powerpc-specific" about what we're
> proposing?

Well, there's the subject of this thread, which is "new way of writing 
defconfigs for freescale's powerpc platforms".

 > Are you complaining about the actual content of which
> fragments to use to produce which defconfigs going in arch/powerpc?

No, I'm just trying to figure out what's powerpc-specific about Lijun's 
proposal.

>> >Besides, wouldn't it make more sense to define a new defconfig type,
>> >like p1_defconfig.merge, and if you do "make p1_defconfig.merge" it
>> >knows to call merge_config.sh?

> That's already there.  "make <foo>.config".

Ok, so I'm definitely confused now.  I have no idea what's actually 
being proposed, since apparently the ability to have merge configs 
already exists.

Wouldn't it just be simpler to pass multiple defconfigs to 'make', and 
then 'make' will know to call merge_config.sh on them?  So instead of

make ./scripts/kconfig/merge_config.sh 
arch/powerpc/configs/fsl_basic_config p1_defconfig
make

we can just do

make fsl_basic_config p1_defconfig
make


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
