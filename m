Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw81N3Qn7zDsyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:41:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Prevent unlikely crash in
 copro_calculate_slb()
In-Reply-To: <ee67bc79-b620-162e-811f-dccce02ce7bc@linux.vnet.ibm.com>
References: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <3e856f04-23a7-b980-a857-27b3342f1548@linux.vnet.ibm.com>
 <87h98ged3y.fsf@concordia.ellerman.id.au>
 <ee67bc79-b620-162e-811f-dccce02ce7bc@linux.vnet.ibm.com>
Date: Fri, 14 Oct 2016 11:41:44 +1100
Message-ID: <8737jzep87.fsf@concordia.ellerman.id.au>
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

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 13/10/2016 =C3=A0 12:51, Michael Ellerman a =C3=A9crit :
>> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>>
>>> ping? The patch still applies cleanly on recent trees.
>>
>> Fell through the cracks :/
>>
>> Fixes: ?
>
> Nothing obvious. Current code was introduced by=20
> 73d16a6e0e51990cbe13f8d8f43bd5329bbab30a
> but it was apparently moved from cell, where the issue may not have=20
> applied, I don't know. I guess we should use that id if really needed:
>
> Fixes: 73d16a6e0e51 ("powerpc/cell: Move data segment faulting code out o=
f cell platform")

Yeah that works, it allows us to mechanically determine that "if you
have backported 73d16a6e0e51 then you need this fix", which can be
useful.

cheers
