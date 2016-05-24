Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDPPm1B52zDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 15:40:12 +1000 (AEST)
Subject: Re: [PATCH] powerpc: inline current_stack_pointer()
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20160523084602.53F771A239A@localhost.localdomain>
 <20160523202214.GB11583@gate.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <61305e9e-ed63-6915-709c-dd8797ff1fba@c-s.fr>
Date: Tue, 24 May 2016 07:39:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160523202214.GB11583@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 23/05/2016 à 22:22, Segher Boessenkool a écrit :
> On Mon, May 23, 2016 at 10:46:02AM +0200, Christophe Leroy wrote:
>> +static inline unsigned long current_stack_pointer(void)
>> +{
>> +	register unsigned long *ptr asm("r1");
>> +
>> +	return *ptr;
>> +}
> Register asm is only guaranteed to work as input to inline asm.  NAK.
>
Does it mean that the following declaration in 
arch/powerpc/include/asm/paca.h is wrong too ?

register struct paca_struct *local_paca asm("r13");

Christophe
