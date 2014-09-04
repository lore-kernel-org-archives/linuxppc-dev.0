Return-Path: <thellstrom@vmware.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78F881A0699
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 20:24:05 +1000 (EST)
Received: from smtp-outbound-1.vmware.com (smtp-outbound-1.vmware.com
 [208.91.2.12])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B44FB140116
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 20:24:04 +1000 (EST)
Message-ID: <54083DB4.1050009@vmware.com>
Date: Thu, 4 Sep 2014 12:23:48 +0200
From: Thomas Hellstrom <thellstrom@vmware.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop> <54081844.7000604@vmware.com>
 <20140904093454.GG15520@phenom.ffwll.local>
 <1409823823.4246.61.camel@pasglop>
In-Reply-To: <1409823823.4246.61.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2014 11:43 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-09-04 at 11:34 +0200, Daniel Vetter wrote:
>> On Thu, Sep 04, 2014 at 09:44:04AM +0200, Thomas Hellstrom wrote:
>>> Last time I tested, (and it seems like Michel is on the same track),
>>> writing with the CPU to write-combined memory was substantially faster
>>> than writing to cached memory, with the additional side-effect that CPU
>>> caches are left unpolluted.
>>>
>>> Moreover (although only tested on Intel's embedded chipsets), texturing
>>> from cpu-cache-coherent PCI memory was a real GPU performance hog
>>> compared to texturing from non-snooped memory. Hence, whenever a buffer
>>> could be classified as GPU-read-only (or almost at least), it should be
>>> placed in write-combined memory.
>> Just a quick comment since this explicitly referes to intel chips: On
>> desktop/laptop chips with the big shared l3/l4 caches it's the other way
>> round. Cached uploads are substantially faster than wc and not using
>> coherent access is a severe perf hit for texturing. I guess the hw guys
>> worked really hard to hide the snooping costs so that the gpu can benefit
>> from the massive bandwidth these caches can provide.
> This is similar to modern POWER chips as well. We have pretty big L3's
> (though not technically shared they are in a separate quadrant and we
> have a shared L4 in the memory buffer) and our fabric is generally
> optimized for cachable/coherent access performance. In fact, we only
> have so many credits for NC accesses on the bus...
>

Thanks both of you for the update. I haven't dealt with real hardware
for a while..

/Thomas
