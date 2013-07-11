Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 95EAA2C030A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:11:23 +1000 (EST)
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373545982.19894.82.camel@pasglop>
Date: Thu, 11 Jul 2013 15:11:15 +0200
Message-Id: <55F96DD9-50B1-41CA-9257-FBF7DED90966@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru> <51DC4228.7010607@suse.de>
 <51DCEA76.9070808@ozlabs.ru> <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de>
 <51DE3ECB.7080803@ozlabs.ru> <1373545982.19894.82.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.07.2013, at 14:33, Benjamin Herrenschmidt wrote:

> On Thu, 2013-07-11 at 15:12 +1000, Alexey Kardashevskiy wrote:
>>>> Any debug code is prohibited? Ok, I'll remove.
>>>=20
>>> Debug code that requires code changes is prohibited, yes.
>>> Debug code that is runtime switchable (pr_debug, trace points, etc)
>>> are allowed.
>=20
> Bollox.
>=20
> $ grep DBG\( arch/powerpc/ -r | wc -l
> 418
>=20
> Also pr_devel is not runtime switchable in normal kernels either and
> still an "official" kernel interface.
>=20
>> Is there any easy way to enable just this specific udbg_printf (not =
all of
>> them at once)? Trace points do not work in real mode as we figured =
out.
>=20
> The cleaner way to do it is to use some kind of local macro that you
> enable/disable by changing a #define at the top of the function, =
possibly
> several.

If you do that in a way that doesn't bitrot, that's acceptable, yes. =
Something that leaves cpp compile checks working while optimizing out =
the debug code.


Alex
