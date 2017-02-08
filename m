Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJLWN6srTzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 23:44:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, benh@kernel.crashing.org
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 00/12]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
In-Reply-To: <43cad35a-e19b-49e0-b4d1-9372c8a2d372@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <43cad35a-e19b-49e0-b4d1-9372c8a2d372@linux.vnet.ibm.com>
Date: Wed, 08 Feb 2017 23:44:31 +1100
Message-ID: <87y3xg97io.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> Hi mpe,
>
> Any update on this series. Have also fixed the naming issue with patch 12
> and with this series applied,
>
> "paca->soft_enabled"  becomes "paca->soft_disabled_mask"

Yeah sorry I've been putting off dealing with it.

Ideally we'd do the naming change earlier in the series, but maybe
that's not worth it.

The one thing I wanted to make sure was that regs->softe is never
exposed to userspace. Because we're changing its semantics, and user
space has no business knowing about it.

So I just checked the code, and we do allow userspace to see the softe
value. So I think we should fix that before this goes in.

The safest option is to just hardwire it to 1, as that's the value it
should always have in a userspace pt_regs.

cheers
