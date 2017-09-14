Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0zX2g7GzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:18:48 +1000 (AEST)
Received: by mail-pg0-x234.google.com with SMTP id i130so3578361pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 18:18:48 -0700 (PDT)
Date: Thu, 14 Sep 2017 11:18:25 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 3/7] powerpc: Free up four 64K PTE bits in 4K backed
 HPTE pages
Message-ID: <20170914111825.5a8aed1e@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:44:43 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6,
> in the 4K backed HPTE pages.These bits continue to be used
> for 64K backed HPTE pages in this patch, but will be freed
> up in the next patch. The  bit  numbers are big-endian  as
> defined in the ISA3.0
> 
> The patch does the following change to the 4k htpe backed
> 64K PTE's format.
> 
> H_PAGE_BUSY moves from bit 3 to bit 9 (B bit in the figure
> 		below)
> V0 which occupied bit 4 is not used anymore.
> V1 which occupied bit 5 is not used anymore.
> V2 which occupied bit 6 is not used anymore.
> V3 which occupied bit 7 is not used anymore.
> 
> Before the patch, the 4k backed 64k PTE format was as follows
> 
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
> 
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x|B|V0|V1|V2|V3|x| | |x|x|................|x|x|x|x| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> |S|G|I|X|S |G |I |X |S|G|I|X|..................|S|G|I|X| <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> 
> After the patch, the 4k backed 64k PTE format is as follows
> 
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
> 
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x| |  |  |  |  |x|B| |x|x|................|.|.|.|.| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> |S|G|I|X|S |G |I |X |S|G|I|X|..................|S|G|I|X| <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> 
> the four  bits S,G,I,X (one quadruplet per 4k HPTE) that
> cache  the  hash-bucket  slot  value, is initialized  to
> 1,1,1,1 indicating -- an invalid slot.   If  a HPTE gets
> cached in a 1111  slot(i.e 7th  slot  of  secondary hash
> bucket), it is  released  immediately. In  other  words,
> even  though 1111   is   a valid slot  value in the hash
> bucket, we consider it invalid and  release the slot and
> the HPTE.  This  gives  us  the opportunity to determine
> the validity of S,G,I,X  bits  based on its contents and
> not on any of the bits V0,V1,V2 or V3 in the primary PTE
> 
> When   we  release  a    HPTE    cached in the 1111 slot
> we also    release  a  legitimate   slot  in the primary
> hash bucket  and  unmap  its  corresponding  HPTE.  This
> is  to  ensure   that  we do get a HPTE cached in a slot
> of the primary hash bucket, the next time we retry.
> 
> Though  treating  1111  slot  as  invalid,  reduces  the
> number of  available  slots  in the hash bucket and  may
> have  an  effect   on the performance, the probabilty of
> hitting a 1111 slot is extermely low.
> 
> Compared  to  the   current    scheme,  the above scheme
> reduces  the   number  of   false   hash  table  updates
> significantly and  has the  added advantage of releasing
> four  valuable  PTE bits for other purpose.
> 
> NOTE:even though bits 3, 4, 5, 6, 7 are  not  used  when
> the  64K  PTE is backed by 4k HPTE,  they continue to be
> used  if  the  PTE  gets  backed  by 64k HPTE.  The next
> patch will decouple that aswell, and truely  release the
> bits.
> 
> This idea was jointly developed by Paul Mackerras,
> Aneesh, Michael Ellermen and myself.
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>
