Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3227F1A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 18:16:19 +1100 (AEDT)
Date: Fri, 16 Oct 2015 09:15:52 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kernel-janitors@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mpc5xxx: Avoid dereferencing potentially
 freed memory
Message-ID: <20151016071552.GB20310@visitor2.iram.es>
References: <20151014040011.8AB1514110A@ozlabs.org>
 <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1444890977.5970.4.camel@ellerman.id.au>
 <5620971D.8040103@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5620971D.8040103@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2015 at 08:20:13AM +0200, Christophe JAILLET wrote:
> Le 15/10/2015 08:36, Michael Ellerman a écrit :
> >On Thu, 2015-10-15 at 07:56 +0200, Christophe JAILLET wrote:
> >>Use 'of_property_read_u32()' instead of 'of_get_property()'+pointer
> >>dereference in order to avoid access to potentially freed memory.
> >>
> >>Use 'of_get_next_parent()' to simplify the while() loop and avoid the
> >>need of a temp variable.
> >>
> >>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >>---
> >>v2: Use of_property_read_u32 instead of of_get_property+pointer dereference
> >>*** Untested ***
> >Thanks.
> >
> >Can someone with an mpc5xxx test this?
> >
> >cheers
> >
> 
> Hi,
> I don't think it is an issue, but while looking at another similar
> patch, I noticed that the proposed patch adds a call to
> be32_to_cpup() (within of_property_read_u32).
> Apparently, powerPC is a BE architecture, so this call should be a no-op.

Sadly no more. 32 bit is BE only, but 64 bit can be either BEtter or
LEsser.

    Gabriel
