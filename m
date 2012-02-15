Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D01EB1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 10:18:34 +1100 (EST)
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3C0A2B.9000105@freescale.com>
Date: Thu, 16 Feb 2012 00:18:29 +0100
Message-Id: <D78C51F9-089C-4922-94DA-37BF70A2045E@suse.de>
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
 <ADC42EDC-6F11-419E-9F31-B9E23D80FFE1@suse.de>
 <4F3C0A2B.9000105@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.02.2012, at 20:40, Scott Wood wrote:

> On 02/15/2012 01:36 PM, Alexander Graf wrote:
>>=20
>> On 10.01.2012, at 01:51, Scott Wood wrote:
>>> I was thinking we'd check ESR[EPID] or SRR1[IS] as appropriate, and
>>> treat it as a kernel fault (search exception table) -- but this =
works
>>> too and is a bit cleaner (could be other uses of external pid), at =
the
>>> expense of a couple extra instructions in the emulation path (but
>>> probably a slightly faster host TLB handler).
>>>=20
>>> The check wouldn't go in DO_KVM, though, since on bookehv that only
>>> deals with diverting flow when xSRR1[GS] is set, which wouldn't be =
the
>>> case here.
>>=20
>> Thinking about it a bit more, how is this different from a failed =
get_user()? We can just use the same fixup mechanism as there, right?
>=20
> The fixup mechanism can be the same (we'd like to know whether it =
failed
> due to TLB miss or DSI, so we know which to reflect

No, we only want to know "fast path failed". The reason is a different =
pair of shoes and should be evaluated in the slow path. We shouldn't =
ever fault here during normal operation btw. We already executed a guest =
instruction, so there's almost no reason it can't be read.

> -- but if necessary
> I think we can figure that out with a tlbsx).  What's different is =
that
> the page fault handler needs to know that any external pid (or AS1)
> fault is bad, same as if the address were in the kernel area, and it
> should go directly to searching the exception tables instead of trying
> to page something in.

Yes and no. We need to force it to search the exception tables. We don't =
care if the page fault handlers knows anything about external pids.

Either way, we discussed the further stuff on IRC and came to a working =
solution :). Stay tuned.


Alex
