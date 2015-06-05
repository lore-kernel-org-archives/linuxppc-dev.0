Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FD411A089C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 10:43:23 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 18:43:21 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4A1103E40048
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 18:43:19 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t550f46f34471972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 17:41:04 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t550hIRv008965
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 18:43:19 -0600
Message-ID: <5570F0A3.7010404@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 19:43:15 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: of/dynamic: Fix test for PPC_PSERIES
References: <20150604105732.77DFE140273@ozlabs.org>
In-Reply-To: <20150604105732.77DFE140273@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2015 05:57 AM, Michael Ellerman wrote:
> On Thu, 2015-04-06 at 09:34:41 UTC, Geert Uytterhoeven wrote:
>> "IS_ENABLED(PPC_PSERIES)" always evaluates to false, as IS_ENABLED() is
>> supposed to be used with the full Kconfig symbol name, including the
>> "CONFIG_" prefix.
>>
>> Add the missing "CONFIG_" prefix to fix this.
>>
>> Fixes: a25095d451ece23b ("of: Move dynamic node fixups out of powerpc and into common code")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
> 
>> Did this bug cause any breakage?
>> If yes, the fix should go to stable (for v3.17 and later).
> 
> Yikes. Not that I've heard of. But it's reasonably new so possibly it's not hit
> distros that folks tend to run on those machines.

I think we do have some distros that have picked this up.

> 
> I'm also not clear how it would break, it could be subtle and we've not noticed.
> 

The only place I can find that this might cause an issue is during device tree
updating that pseries does after a live migration or suspend/resume. When
removing or updating a device tree node we look up the node by ibm,phandle and
without this patch we wouldn't find these nodes.

I have not seen any issues because of this but I think pushing this to stable
would be good.

-Nathan
