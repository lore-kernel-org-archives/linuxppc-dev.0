Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4C0F1A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 17:19:35 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 38E681401F6
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 17:19:35 +1000 (EST)
Message-ID: <54081282.3040005@daenzer.net>
Date: Thu, 04 Sep 2014 16:19:30 +0900
From: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
MIME-Version: 1.0
To: Jerome Glisse <j.glisse@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
 <1409797523.25089.8.camel@pasglop> <20140904023117.GD4835@gmail.com>
 <20140904023656.GF4835@gmail.com>
In-Reply-To: <20140904023656.GF4835@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 04.09.2014 11:36, Jerome Glisse wrote:
> On Wed, Sep 03, 2014 at 10:31:18PM -0400, Jerome Glisse wrote:
>> On Thu, Sep 04, 2014 at 12:25:23PM +1000, Benjamin Herrenschmidt wrote:
>>> On Wed, 2014-09-03 at 22:07 -0400, Jerome Glisse wrote:
>>>
>>>> So in the meantime the attached patch should work, it just silently ignore
>>>> the caching attribute request on non x86 instead of pretending that things
>>>> are setup as expected and then latter the radeon ou nouveau hw unsetting
>>>> the snoop bit.
>>>>
>>>> It's not tested but i think it should work.
>>>
>>> I'm still getting placements with !CACHED going from bo_memcpy in
>>> ttm_io_prot() though ... I'm looking at filtering the placement
>>> attributes instead.
>>>
>>> Ben.
>>
>> Ok so this one should do the trick.
>
> Ok final version ... famous last word.

[...]

> +#else /* CONFIG_X86 */
> +int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t *placement)
> +{
> +	if (*placement & (TTM_PL_TT | TTM_PL_FLAG_SYSTEM)) {
> +		ttm->caching_state = tt_cached;
> +		*placement &= ~TTM_PL_MASK_CACHING;
> +		*placement |= TTM_PL_FLAG_CACHED;

NAK, this will break AGP on PowerMacs.


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer
