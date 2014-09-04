Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7805E1A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:00:03 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 03590140271
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 18:00:02 +1000 (EST)
Message-ID: <54081BFE.6020509@daenzer.net>
Date: Thu, 04 Sep 2014 16:59:58 +0900
From: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
 <1409797523.25089.8.camel@pasglop> <20140904023117.GD4835@gmail.com>
 <20140904023656.GF4835@gmail.com> <54081282.3040005@daenzer.net>
 <1409817275.4246.40.camel@pasglop> <54081BC5.8000703@daenzer.net>
In-Reply-To: <54081BC5.8000703@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@ozlabs.org,
 =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.09.2014 16:59, Michel Dänzer wrote:
> On 04.09.2014 16:54, Benjamin Herrenschmidt wrote:
>> On Thu, 2014-09-04 at 16:19 +0900, Michel Dänzer wrote:
>>>> +#else /* CONFIG_X86 */
>>>> +int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t
>>> *placement)
>>>> +{
>>>> +     if (*placement & (TTM_PL_TT | TTM_PL_FLAG_SYSTEM)) {
>>>> +             ttm->caching_state = tt_cached;
>>>> +             *placement &= ~TTM_PL_MASK_CACHING;
>>>> +             *placement |= TTM_PL_FLAG_CACHED;
>>>
>>> NAK, this will break AGP on PowerMacs.
>>
>>   ... which doesn't work reliably anyway with DRI2 :-)
>
> Define 'not reliably'. I have uptimes of weeks, and I'm pretty sure I'm
> not alone, at least with AGP 1x it seems to work quite well for most
> people. So I don't see the justification for intentionally breaking it
> completely for all of us.

Even more so because PCI GART is unusably slow in general.


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer
