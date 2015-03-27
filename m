Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DD161A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 21:39:27 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 27 Mar 2015 10:39:23 -0000
Message-ID: <55153358.9010804@fr.ibm.com>
Date: Fri, 27 Mar 2015 11:39:20 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [Skiboot] [v2, 1/3] powerpc/powernv: convert codes returned by
 OPAL calls
References: <20150327095936.50A921400A0@ozlabs.org>
 <1427452587.20500.0.camel@kernel.crashing.org>
In-Reply-To: <1427452587.20500.0.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2015 11:36 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2015-03-27 at 20:59 +1100, Michael Ellerman wrote:
>>
>> Can you put it in opal.h and give it a better name, maybe
>> opal_error_code() ?
> 
> Do we want it to be inlined all the time ? Feels more like something we
> should have in opal.c
> 
> Also we only want to call it when we "forward" the error code up the
> food chain, there are a number of cases where we look for specific OPAL
> error codes.

yes. the forward is not systematic. opal.c looks like a better place.

-ERANGE looks also better when the return code is unexpected. 

C.
