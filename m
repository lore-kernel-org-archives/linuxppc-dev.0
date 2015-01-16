Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD25C1A0D5D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 14:02:41 +1100 (AEDT)
Message-ID: <1421377361.18166.2.camel@ellerman.id.au>
Subject: Re: [PATCH] pseries/le: Fix another endiannes issue in RTAS call
 from xmon
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 14:02:41 +1100
In-Reply-To: <54B85016.4080906@linux.vnet.ibm.com>
References: <1421295950.11409.3.camel@ellerman.id.au>
 <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <54B8188D.1060907@linux.vnet.ibm.com>
 <1421360377.23332.1.camel@ellerman.id.au>
 <54B85016.4080906@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-15 at 15:41 -0800, Tyrel Datwyler wrote:
> On 01/15/2015 02:19 PM, Michael Ellerman wrote:
> > On Thu, 2015-01-15 at 11:44 -0800, Tyrel Datwyler wrote:
> >> On 01/15/2015 09:23 AM, Laurent Dufour wrote:
> >>> The commit 3b8a3c010969 ("powerpc/pseries: Fix endiannes issue in RTAS
> >>> call from xmon") was fixing an endianness issue in the call made from
> >>> xmon to RTAS.
> >>>
> >>> However, as Michael Ellerman noticed, this fix was not complete, the
> >>> token value was not byte swapped. This lead to call an unexpected and
> >>> most of the time unexisting RTAS function, which is silently ignored
> >>> by RTAS.
> >>
> >> Nit. Not so much that is silently ignored by RTAS as much as
> >> disable_surveillance silently doesn't check the return status of the
> >> RTAS call. Maybe a check is warranted and reporting of non-success.
> > 
> > Yeah you're right, I added a printf of the result and got -3, which is also
> > wrong as far as I can tell, but I didn't have the energy to chase it any
> > further.
> 
> If this was on a powerkvm guest set-indicator should be present for
> hotplug (DLPAR) support. However, the surveillance indicator would not
> be implemented. I know sometimes I forget if I'm on a powervm or
> powerkvm guest. Just a thought.

Right that does explain it. I went looking for the KVM kernel/qemu code that
implements set-indicator but couldn't find it. Presumably it's in some branch
other than the one I was looking at, or I was grepping for the wrong thing.

So I guess a printf there is probably not helpful, because it will fire always
on PowerKVM (at least at the moment).

cheers
