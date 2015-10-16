Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9A561A064D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 20:49:40 +1100 (AEDT)
Message-ID: <1444988979.12954.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/mpc5xxx: Avoid dereferencing potentially
 freed memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Fri, 16 Oct 2015 20:49:39 +1100
In-Reply-To: <5620971D.8040103@wanadoo.fr>
References: <20151014040011.8AB1514110A@ozlabs.org>
 <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1444890977.5970.4.camel@ellerman.id.au> <5620971D.8040103@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-16 at 08:20 +0200, Christophe JAILLET wrote:
> Le 15/10/2015 08:36, Michael Ellerman a écrit :
> > On Thu, 2015-10-15 at 07:56 +0200, Christophe JAILLET wrote:
> > > Use 'of_property_read_u32()' instead of
> > > 'of_get_property()'+pointer
> > > dereference in order to avoid access to potentially freed memory.
> > > 
> > > Use 'of_get_next_parent()' to simplify the while() loop and avoid
> > > the
> > > need of a temp variable.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > v2: Use of_property_read_u32 instead of of_get_property+pointer
> > > dereference
> > > *** Untested ***
> > Thanks.
> > 
> > Can someone with an mpc5xxx test this?
> 
> Hi,
> I don't think it is an issue, but while looking at another similar 
> patch, I noticed that the proposed patch adds a call to
> be32_to_cpup() 
> (within of_property_read_u32).
> Apparently, powerPC is a BE architecture, so this call should be a no
> -op.
> 
> Just wanted to point it out, in case of.

Hi Christoph,

I'm not sure I follow.

The device tree is always big endian, but of_property_read_u32() does
the
conversion to CPU endian for you already. That is one of the advantages
of
using it.

cheers
