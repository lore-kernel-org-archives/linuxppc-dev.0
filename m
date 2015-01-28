Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5056B1A0B55
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 16:54:45 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28EF914027A
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 16:54:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 28 Jan 2015 15:54:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 033652CE8054
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 16:54:42 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S5sXXn36896900
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 16:54:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S5s8Gx012201
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 16:54:08 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH] CXL: Fix device_node reference counting
In-reply-to: <1422421480.2728.1.camel@ellerman.id.au>
References: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
 <1422417621-sup-4057@delenn.ozlabs.ibm.com>
 <1422421480.2728.1.camel@ellerman.id.au>
Date: Wed, 28 Jan 2015 16:53:44 +1100
Message-Id: <1422423577-sup-6588@delenn.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-01-28 16:04:40 +1100:
> > I just wanted to check the status of this one? I can't see it in your
> > tree and wanted to make sure you didn't simply miss it.
> 
> It looked fishy, but I never got around to replying.
> 
> The second sentence in the explanation should never be true:

Right, that was the point of the fix ;)

> You shouldn't have np unless you did an of_node_get() to get it, otherwise it's
> pointing at something you don't have a reference for and it might go away at
> any time.
> 
> So the patch may fix the bug but I don't think it's correct.
> 
> I think pnv_pci_to_phb_node() should be doing a get for you, before returning
> the pointer.

Agreed - we should probably also rename it to have 'get' in the name,
like pnv_pci_get_phb_node().

> See as a comparison pcibios_get_phb_of_node().

We could almost use that instead, except it's not exported for modules
and I'm not sure if that even works with __weak functions?


Ryan - do you want to respin this, or would you rather I take it?

Cheers,
-Ian
