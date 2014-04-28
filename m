Return-Path: <cody@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A65EC1400D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 15:00:21 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Sun, 27 Apr 2014 23:00:18 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D061F1FF003D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Apr 2014 23:00:16 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3S4xMme10551738
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 06:59:30 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3S4xiHW029963
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Apr 2014 22:59:44 -0600
Message-ID: <535DE027.5050700@linux.vnet.ibm.com>
Date: Sun, 27 Apr 2014 21:59:19 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 6/6] powerpc/perf/hv-24x7: catalog version number is
 be64, not be32
References: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
 <1397581855-4585-7-git-send-email-cody@linux.vnet.ibm.com>
 <1398660478.30694.10.camel@pasglop>
In-Reply-To: <1398660478.30694.10.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michael Ellerman <michael@ellerman.id.au>, David.Laight@aculab.com,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2014 09:47 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2014-04-15 at 10:10 -0700, Cody P Schafer wrote:
>> The catalog version number was changed from a be32 (with proceeding
>> 32bits of padding) to a be64, update the code to treat it as a be64
>>
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> --
>
> Have you tested this ?
>
> It doesn't build for me:
>
> arch/powerpc/perf/hv-24x7.c: In function 'catalog_read':
> arch/powerpc/perf/hv-24x7.c:223:3: error: format '%d' expects argument of type 'int', but argument 2 has type 'uint64_t' [-Werror=format]
> cc1: all warnings being treated as errors

I have, and I wasn't initially sure how I managed to miss that 
warning-as-error. On examination: My config (for some reason) has 
CONFIG_PPC_DISABLE_WERROR=y set (probably because it's a variation of a 
distro config). Must have been piping the warnings to a file and 
forgotten to check the file.

> I'll fix that up in my tree.

Thanks.
