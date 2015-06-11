Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com
 [IPv6:2a00:1450:400c:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 170C21A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 22:05:13 +1000 (AEST)
Received: by wgme6 with SMTP id e6so4018084wgm.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 05:05:10 -0700 (PDT)
Message-ID: <5579795D.9080109@gmail.com>
Date: Thu, 11 Jun 2015 14:04:45 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2] ALSA: aoa: convert bus code to use
 dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<1434009818-16711-1-git-send-email-lambert.quentin@gmail.com>
 <s5hlhfqlfzu.wl-tiwai@suse.de>
In-Reply-To: <s5hlhfqlfzu.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/06/2015 12:02, Takashi Iwai wrote:
> At Thu, 11 Jun 2015 10:03:38 +0200,
> Quentin Lambert wrote:
>>
>> The dev_attrs field of struct bus_type is going away, use dev_groups instead.
>> This converts the soundbus code to use the correct field.
>>
>> Given that all other usages of the macro define the struct attribute
>> *xxx_attrs[] in the same file they assign the .dev_groups field, this patch
>> merges sysfs.c into core.c.
>>
>> These modifications were made using Coccinelle.
>>
>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
>> ---
>>   Changes since v1:
>>    - Fix the commit message to actually talk about soundbus rather than MDIO
>>    - This version attempt to fix a problem resulting from the macro
>>      ATTRIBUTE_GROUPS declaring the structure as static by merging sysfs.c into
>>      core.c. I understand that this may not be the prefered solution since
>>      Takashi suggested that adding a comment line to the previous version could
>>      be acceptable.
> Hmm, the patch doesn't look as mentioned here.
> It's rather bigger than the previous patch.  Is this intentional?
>
Well as mentionned in the change log it is bigger because it moves the 
code from sysfs.c to
core.c. I realise as I am writing this that this patch should have 
really been two patches.
The first one removing sysfs.c and the second one removing the use of 
the dev_attrs.

> Takashi
>
Quentin
