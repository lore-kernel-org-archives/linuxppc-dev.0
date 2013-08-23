Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A5042C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 13:31:50 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 13:28:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 080B92CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 13:31:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7N3VZ7p62783682
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 13:31:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7N3VjwL026839
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 13:31:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
In-Reply-To: <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
Date: Fri, 23 Aug 2013 09:01:41 +0530
Message-ID: <87haeh13s2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Isn't this you?

Yes. The patches are generated using git format-patch and sent by
git send-email. That's how it always created patches for me. I am not sure if
there is a config I can change to avoid having From:

>
>> 
>> We should be able to copy upto count bytes
>
> Why?
>

Without this we end up doing

 +    struct kvm_get_htab_buf {
 +        struct kvm_get_htab_header header;
 +        /*
 +         * Older kernel required one extra byte.
 +         */
 +        unsigned long hpte[3];
 +    } hpte_buf;


even though we are only looking for one hpte entry.

http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com

>
> Alex
>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> index 710d313..0ae6bb6 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> @@ -1362,7 +1362,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>> 	lbuf = (unsigned long __user *)buf;
>> 
>> 	nb = 0;
>> -	while (nb + sizeof(hdr) + HPTE_SIZE < count) {
>> +	while (nb + sizeof(hdr) + HPTE_SIZE <= count) {
>> 		/* Initialize header */
>> 		hptr = (struct kvm_get_htab_header __user *)buf;
>> 		hdr.n_valid = 0;
>> @@ -1385,7 +1385,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>> 		/* Grab a series of valid entries */
>> 		while (i < kvm->arch.hpt_npte &&
>> 		       hdr.n_valid < 0xffff &&
>> -		       nb + HPTE_SIZE < count &&
>> +		       nb + HPTE_SIZE <= count &&
>> 		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
>> 			/* valid entry, write it out */
>> 			++hdr.n_valid;
>> -- 
>> 1.8.1.2
>> 
