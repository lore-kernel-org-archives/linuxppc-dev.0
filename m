Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlx0l2GXYzF0ZV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 20:59:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michal
 =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
In-Reply-To: <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 20:59:18 +1100
Message-ID: <87lgforngp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> writes:

> Hi Michal and Michael,
>
> On 02/15/2018 05:13 AM, Michal Such=C3=A1nek wrote:
>>> From: Michael Ellerman<mpe@ellerman.id.au>
>>>
>>> For PowerVM migration we want to be able to call setup_rfi_flush()
>>> again after we've migrated the partition.
>>>
>>> To support that we need to check that we're not trying to allocate the
>>> fallback flush area after memblock has gone away. If so we just fail,
>>> we don't support migrating from a patched to an unpatched machine. Or
>>> we do support it, but there will be no RFI flush enabled on the
>>> destination.
>>>
>> This sounds bad to me. Either we support RFI flush or we don't.
>>=20
>> If we do the fallback area should be allocated at boot so it is always
>> available. [snip]
>
> I think the problem with this is the size of the fallback area might
> have to be different between the origin and destination systems, say,
> a larger L1 data cache at the destination.
>
> In that case, the original size might not be enough to fully flush
> the L1 data cache.
>
> Michael, is that the reason it is done that way?  I thought of that,
> but don't know for sure.

No, supporting different cache sizes is a good idea though :)

I did it the way I did because otherwise we waste memory on every system
on earth just to support a use case that we don't actually intend for
anyone to ever use - ie. migrating from a patched machine to an
unpatched machine.

In fact without further checks we'd be allocating the fallback area on
powernv machines which don't even support LPM.

So that just seemed a bit gross.

I think I'm inclined to leave it the way it is, unless you feel strongly
about it Michal?

cheers
