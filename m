Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B24701A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 16:04:41 +1100 (AEDT)
Message-ID: <1422421480.2728.1.camel@ellerman.id.au>
Subject: Re: [PATCH] CXL: Fix device_node reference counting
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Wed, 28 Jan 2015 16:04:40 +1100
In-Reply-To: <1422417621-sup-4057@delenn.ozlabs.ibm.com>
References: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
 <1422417621-sup-4057@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 15:02 +1100, Ian Munsie wrote:
> Excerpts from Ian Munsie's message of 2015-01-07 16:41:18 +1100:
> > From: Ryan Grimm <grimm@linux.vnet.ibm.com>
> > 
> > When unbinding and rebinding the driver on a system with a card in PHB0, this
> > error condition is reached after a few attempts:
> 
> Hey mpe,
> 
> I just wanted to check the status of this one? I can't see it in your
> tree and wanted to make sure you didn't simply miss it.

It looked fishy, but I never got around to replying.

The second sentence in the explanation should never be true:

  But, if while loop is not entered, of_node_put get called
  on np without an of_node_get.

You shouldn't have np unless you did an of_node_get() to get it, otherwise it's
pointing at something you don't have a reference for and it might go away at
any time.

So the patch may fix the bug but I don't think it's correct.

I think pnv_pci_to_phb_node() should be doing a get for you, before returning
the pointer.

See as a comparison pcibios_get_phb_of_node().

cheers
