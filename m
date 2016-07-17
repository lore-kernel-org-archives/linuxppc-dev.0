Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsZSl0xR4zDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 15:22:46 +1000 (AEST)
Date: Sun, 17 Jul 2016 15:22:12 +1000
From: Anton Blanchard <anton@samba.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Aneesh Kumar K.V'" <aneesh.kumar@linux.vnet.ibm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH for-4.8 03/12] powerpc/mm: use _raw variant of page
 table accessors
Message-ID: <20160717152212.78f008bb@kryten>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4F8E51@AcuExch.aculab.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4F8E51@AcuExch.aculab.com>
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

Hi David,

> > This switch few of the page table accessor to use the __raw variant
> > and does the cpu to big endian conversion of constants. This helps
> > in generating better code.  
> 
> It might be better to say that checks for a value being 0 don't depend
> on the endianness.
> 
> In which case you want a function that return !!xxx_raw() itself.
> 
> OTOH it might be worth finding out why the cpu's byteswapping memory
> accessors aren't used - which might save the byteswap instruction
> sequence in all paths.

There was a discussion about this on the list. In short, we found a
couple of reasons. Accesses often use READ_ONCE() which might cause
problems. The bigger issue is if the pte is accessed via larx/stcx. We
have no byte reversed larx/stcx instructions.

Anton
