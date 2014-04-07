Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 12B88140101
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 18:36:28 +1000 (EST)
Message-ID: <53426385.2010102@suse.de>
Date: Mon, 07 Apr 2014 10:36:21 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.com>, Liu ping fan <kernelfans@gmail.com>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
 <CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>
 <533D47CD.906@suse.com> <87bnwdshzu.fsf@linux.vnet.ibm.com>
In-Reply-To: <87bnwdshzu.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.04.14 09:42, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.com> writes:
>
>> On 03.04.14 04:36, Liu ping fan wrote:
>>> Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
>>> enable numa fault for powerpc.
>> What bad happens without this patch? We map a page even though it was
>> declared to get NUMA migrated? What happens next?
> Nothing much, we won't be properly accounting the numa access in the
> host.  What we want to achieve is to convert a guest access of the page to
> a host fault so that we can do proper numa access accounting in the
> host. This would enable us to migrate the page to the correct numa
> node.

Ok, so no breakages, just less performance. I wouldn't consider it 
stable material then :).


Alex
