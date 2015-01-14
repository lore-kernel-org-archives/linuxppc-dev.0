Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C91051A073B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 15:44:09 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 19A26140213
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 15:44:08 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 10:14:07 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 557BFE0053
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 10:15:12 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0E4i33753674114
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 10:14:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0E4i0cX020346
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 10:14:03 +0530
Message-ID: <54B5F410.2030002@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 10:14:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
In-Reply-To: <54A50094.5070902@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, Ulrich Weigand <uweigand@de.ibm.com>,
 shuahkh@osg.samsung.com, oleg@redhat.com, dhowells@redhat.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/01/2015 01:38 PM, Anshuman Khandual wrote:
>> > Also, we've noticed that the 'misc' regset contains registers from different ISA
>> > versions (dscr and ppr appear in ISA 2.05, tar is from 2.07). I'm not sure if
>> > there is a way to detect presence/validity of such registers, but perhaps it
>> > might be a good idea to separate registers from different ISAs in different
>> > regsets.
> Thats right, will use feature CPU_FTR_ARCH_207S (which checks whether we are v2.07
> compliant) to detect whether TAR register is available or not. 
> 

Need to correct something here. Run time detection of the presence of TAR register
through the feature bit CPU_FTR_ARCH_207S as I had mentioned before is not required.
Right now we take care of the compile time availability of the individual registers
the same way it is present on the thread struct. In the systems which do not have the
TAR register, thread.tar is always going to be 0 which is exactly the same value we
would get by excluding tar register copy after the run time detection of the feature.
