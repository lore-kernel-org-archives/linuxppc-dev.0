Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 209621A0866
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 17:22:23 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id A2C3A1401F6
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 17:22:22 +1000 (EST)
Message-ID: <540810CE.7070107@daenzer.net>
Date: Thu, 04 Sep 2014 16:12:14 +0900
From: =?windows-1252?Q?Michel_D=E4nzer?= <michel@daenzer.net>
MIME-Version: 1.0
To: Jerome Glisse <j.glisse@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com>
In-Reply-To: <20140904015548.GB4835@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@ozlabs.org,
 Christian Koenig <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.09.2014 10:55, Jerome Glisse wrote:
>
> While i agree about the issue of incoherent double map of same page, i
> think we have more issue. For instance lattely AMD have been pushing a
> lot of patches to move things to use uncached memory for radeon and as
> usual thoses patches comes with no comment to the motivations of those
> changes.

That would have been a fair review comment...


> What i understand is that uncached mapping for some frequently use buffer
> give a significant performance boost (i am assuming this has to do with
> all the snoop pci transaction overhead).

Exactly, although it's a win even if the data is written by the CPU only 
once and read by the GPU only once.


> This also means that we need to fix ttm_tt_set_placement_caching so that
> when it returns an error it switches to cached mapping. Which will always
> work.

GTT with AGP being one exception.


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer
