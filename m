Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKkGM6wk4zDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 10:38:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6U0cVQS085558
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 20:38:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c13s71vgt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 20:38:31 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 29 Jul 2017 20:38:30 -0400
Date: Sat, 29 Jul 2017 17:38:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 15/62] powerpc: helper functions to initialize AMR, IAMR
 and UMOR registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
 <877eyt4nqr.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877eyt4nqr.fsf@linux.vnet.ibm.com>
Message-Id: <20170730003819.GI5664@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 27, 2017 at 05:40:44PM -0300, Thiago Jung Bauermann wrote:
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Introduce helper functions that can initialize the bits in the AMR,
> > IAMR and UMOR register; the bits that correspond to the given pkey.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> 
> s/UMOR/UAMOR/ here and in the subject as well.

yes. fixed it.

> 
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -16,3 +16,47 @@
> >  #include <linux/pkeys.h>                /* PKEY_*                       */
> >
> >  bool pkey_inited;
> > +#define pkeyshift(pkey) ((arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY)
> > +
> > +static inline void init_amr(int pkey, u8 init_bits)
> > +{
> > +	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> > +	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> > +
> > +	write_amr(old_amr | new_amr_bits);
> > +}
> > +
> > +static inline void init_iamr(int pkey, u8 init_bits)
> > +{
> > +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> > +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> > +
> > +	write_amr(old_iamr | new_iamr_bits);
> > +}
> 
> init_iamr should call write_iamr, not write_amr.

excellent catch. thanks.
RP
