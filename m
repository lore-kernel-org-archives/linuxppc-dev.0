Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D79872C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 20:11:48 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <8761pdk6x5.fsf@linux.vnet.ibm.com>
Date: Mon, 27 Jan 2014 10:11:40 +0100
Message-Id: <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Liu Ping Fan <kernelfans@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.01.2014, at 10:42, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Liu Ping Fan <kernelfans@gmail.com> writes:
>=20
>> To make sure that on host, the pages marked with _PAGE_NUMA result in =
a fault
>> when guest access them, we should force the checking when guest uses =
hypercall
>> to setup hpte.
>>=20
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>=20
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>=20
> When we mark pte with _PAGE_NUMA we already call =
mmu_notifier_invalidate_range_start and
> mmu_notifier_invalidate_range_end, which will mark existing guest hpte
> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting =
new
> guest hpte entries. This patch does that.=20

So what happens next? We insert a page into the HTAB without =
HPTE_V_VALID set, so the guest will fail to use it. If the guest does an =
H_READ on it it will suddenly turn to V_VALID though?

I might need a crash course in the use of HPTE_V_ABSENT.


Alex
