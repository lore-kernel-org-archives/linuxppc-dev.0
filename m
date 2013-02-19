Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7B3D2C0099
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 06:48:06 +1100 (EST)
Date: Tue, 19 Feb 2013 13:47:58 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
To: Diana Craciun <diana.craciun@freescale.com>
References: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
 <1360887119.22260.10.camel@pasglop> <511E513F.7090103@freescale.com>
In-Reply-To: <511E513F.7090103@freescale.com> (from
 diana.craciun@freescale.com on Fri Feb 15 09:16:15 2013)
Message-ID: <1361303278.29654.7@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2013 09:16:15 AM, Diana Craciun wrote:
> On 02/15/2013 02:11 AM, Benjamin Herrenschmidt wrote:
>> On Thu, 2013-02-14 at 14:56 +0200, Diana Craciun wrote:
>>> From: Diana Craciun <Diana.Craciun@freescale.com>
>>>=20
>>> On Freescale e6500 cores EPCR[DGTMI] controls whether guest =20
>>> supervisor
>>> state can execute TLB management instructions. If EPCR[DGTMI]=3D0
>>> tlbwe and tlbilx are allowed to execute normally in the guest state.
>>>=20
>>> A hypervisor may choose to virtualize TLB1 and for this purpose it
>>> may use IPROT to protect the entries for being invalidated by the
>>> guest. However, because tlbwe and tlbilx execution in the guest =20
>>> state
>>> are sharing the same bit, it is not possible to have a scenario =20
>>> where
>>> tlbwe is allowed to be executed in guest state and tlbilx traps. =20
>>> When
>>> guest TLB management instructions are allowed to be executed in =20
>>> guest
>>> state the guest cannot use tlbilx to invalidate TLB1 guest entries.
>> Sorry, I don't understand the explanation... can you be more =20
>> detailed ?
>=20
> TLB1 supports huge page sizes. The guest may see the memory as =20
> contiguous but it sees the guest physical memory as presented by the =20
> hypervisor. In reality the real physical memory may be fragmented. In =20
> this case the hypervisor can add more than one TLB1 entry for one =20
> guest request and the hypervisor will keep track of all fragments. =20
> When the guest performs a tlbilx, the hypervisor will correctly =20
> invalidate all the corresponding fragments because both tlbwe and =20
> tlbilx trap and has full control of tlb management instructions =20
> targeting TLB1.
>=20
> For e6500 a single bit controls if tlbwe and tlbilx trap to the =20
> Hypervisor. tlbwe targeting TLB1 always traps. But if we want to use =20
> LRAT for TLB0, we have to configure tlbwe (targeting TLB 0) to go =20
> directly to the guest. But in this case tlbilx (which is targeting =20
> both TLBs) will never trap.
>=20
> If the tlbilx does not trap, the guest can invalidate only one of =20
> (possible more) fragments and furthermore the synchronization between =20
> what entries the hypervisor thinks there are in the TLB1 and what are =20
> the actual entries is lost.

This patch addresses boot-time invalidations only.  How will you handle =20
hugetlb invalidations (or indirect entry invalidations, once that =20
becomes supported)?

-Scott=
