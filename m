Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfDrQ3Pb6zDq6R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 13:30:14 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id 184so1356272pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Apr 2016 20:30:14 -0700 (PDT)
Subject: Re: [PATCH 03/65] powerpc/mm/subpage: Clear RWX bit to indicate no
 access
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56FC808B.7030704@gmail.com> <87pou5xvwj.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5703313F.6010302@gmail.com>
Date: Tue, 5 Apr 2016 13:30:07 +1000
MIME-Version: 1.0
In-Reply-To: <87pou5xvwj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/04/16 00:59, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> [ text/plain ]
>>
>>
>> On 27/03/16 19:23, Aneesh Kumar K.V wrote:
>>> Subpage protection used to depend on _PAGE_USER bit to implement no
>>> access mode. This patch switch that to use _PAGE_RWX. We clear READ,
>>> Write and Execute access from pte instead of clearing _PAGE_USER now.
>>> This was done so that we can switch to _PAGE_PRIVILEGED in later patch.
>>> subpage_protection() returns pte bits that need to be cleared.
>> Could you please clarify what bit needs to be cleared. I think the underlying
>> assumption is that when this routine is called access cannot be _PAGE_RWX
>
> I didn't follow the question. subpage_protection() returns the pte bits
> that need to be cleared for a specific access depending on the subpage
> prot mask we set using subpage_prot syscall. 
What I meant is that if the subpage protection was no access, then _PAGE_RWX cannot
be set in the access value.
>>> Instead of updating the interface to handle no-access in a separate way,
>>> it appears simple to clear RWX acecss to indicate no access.
>>>
> -aneesh
>
