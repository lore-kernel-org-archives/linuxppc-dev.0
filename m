Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com
 [IPv6:2a00:1450:400c:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 625CB1A0551
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 01:49:10 +1000 (AEST)
Received: by wicmx19 with SMTP id mx19so21849546wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 08:49:05 -0700 (PDT)
Message-ID: <55688A72.7000306@gmail.com>
Date: Fri, 29 May 2015 17:49:06 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: convert bus code to use dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<s5hwpzs7qrz.wl-tiwai@suse.de>	<55671F56.6080402@gmail.com>	<s5hsiag7q0p.wl-tiwai@suse.de>	<55672980.4010904@gmail.com>
 <s5hh9qw7nlj.wl-tiwai@suse.de>
In-Reply-To: <s5hh9qw7nlj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/05/2015 17:01, Takashi Iwai wrote:
>>> Also, it'd be better to move ATTRIBUTE_GROUPS(soundbus_dev) into
>>> soundbus/sysfs.c, and make it this global instead of
>>> soundbus_dev_attrs[].
>> Ok, I need to find a nice way to do that because ATTRIBUTE_GROUPS
>> declares the
>> structure as static.
>
> If it results in an ungly code, it's fine with the original code,
> too.  But, maybe with a comment indicating that xxx_dev_attrs[] is
> defined in xxx.c.
>
>
Since sound/aoa/soundbus/sysfs is small, a solution would be
to merge sound/aoa/soundbus/sysfs.c and sound/aoa/soundus/core.c.
Moreover all 172 other usages of the ATTRIBUTE_GROUPS macro
define the struct attribute *xxx_attrs[] in the same file
they assign the .dev_groups field.

I'm not sure about this change as it seems way more important than
adding a comment line as you suggested.

Should I send a patch merging these two files?

Quentin
