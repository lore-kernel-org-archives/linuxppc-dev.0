Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZxg45swQzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:56:00 +1000 (AEST)
Received: by mail-yw0-x232.google.com with SMTP id i12so65123193ywa.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:56:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <576BAEE2.4060202@linux.vnet.ibm.com>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com> <576BAEE2.4060202@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 23 Jun 2016 19:55:57 +1000
Message-ID: <CAKTCnznr-cmrAciekQxSC-=b7O01=YQu4EF5B6Z=ShVqcPbRzQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> This is still a rounding error but at a different site. I see we saved
>> a division by doing a >> 10, but we added it right back by doing a /20
>> later in the platform code.
>
> While a >> 10 is done at every idle exit, div by 20 is done once during
> boot, so this doesn't negate the previous optimization.
>

Yes, fair point

>> Shouldn't the rounding affect other
>> platforms as well? Can't we fix it in cpuidle_enter_state().
>
> This does affect all platforms, but I'm guessing no other place relied
> on the precision of last_residency calculations.
> Daniel can perhaps comment on this.
>
