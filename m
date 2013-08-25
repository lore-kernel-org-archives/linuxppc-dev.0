Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 3472D2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 04:16:14 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87haeh13s2.fsf@linux.vnet.ibm.com>
Date: Sun, 25 Aug 2013 19:16:09 +0100
Message-Id: <527D8312-EA18-4962-9069-B54FA738F5FA@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.08.2013, at 04:31, Aneesh Kumar K.V wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
>>=20
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>=20
>> Isn't this you?
>=20
> Yes. The patches are generated using git format-patch and sent by
> git send-email. That's how it always created patches for me. I am not =
sure if
> there is a config I can change to avoid having From:
>=20
>>=20
>>>=20
>>> We should be able to copy upto count bytes
>>=20
>> Why?
>>=20
>=20
> Without this we end up doing
>=20
> +    struct kvm_get_htab_buf {
> +        struct kvm_get_htab_header header;
> +        /*
> +         * Older kernel required one extra byte.
> +         */
> +        unsigned long hpte[3];
> +    } hpte_buf;
>=20
>=20
> even though we are only looking for one hpte entry.

Ok, please give me an example with real numbers and why it breaks.


Alex

>=20
> =
http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.=
vnet.ibm.com
>=20
>>=20
>> Alex
>>=20
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>> arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>> index 710d313..0ae6bb6 100644
>>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>> @@ -1362,7 +1362,7 @@ static ssize_t kvm_htab_read(struct file =
*file, char __user *buf,
>>> 	lbuf =3D (unsigned long __user *)buf;
>>>=20
>>> 	nb =3D 0;
>>> -	while (nb + sizeof(hdr) + HPTE_SIZE < count) {
>>> +	while (nb + sizeof(hdr) + HPTE_SIZE <=3D count) {
>>> 		/* Initialize header */
>>> 		hptr =3D (struct kvm_get_htab_header __user *)buf;
>>> 		hdr.n_valid =3D 0;
>>> @@ -1385,7 +1385,7 @@ static ssize_t kvm_htab_read(struct file =
*file, char __user *buf,
>>> 		/* Grab a series of valid entries */
>>> 		while (i < kvm->arch.hpt_npte &&
>>> 		       hdr.n_valid < 0xffff &&
>>> -		       nb + HPTE_SIZE < count &&
>>> +		       nb + HPTE_SIZE <=3D count &&
>>> 		       record_hpte(flags, hptp, hpte, revp, 1, =
first_pass)) {
>>> 			/* valid entry, write it out */
>>> 			++hdr.n_valid;
>>> --=20
>>> 1.8.1.2
>>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
