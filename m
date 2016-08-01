Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s30wX57ybzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 23:46:04 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: fix csum_partial_copy_generic()
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20160801125605.410371A23A2@localhost.localdomain>
 <20160801131505.GA1742@gate.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, antoine.blangy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cf1cb854-053b-a468-f683-dc752f3fda35@c-s.fr>
Date: Mon, 1 Aug 2016 15:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160801131505.GA1742@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/08/2016 à 15:15, Segher Boessenkool a écrit :
> On Mon, Aug 01, 2016 at 02:56:05PM +0200, Christophe Leroy wrote:
>> --- a/arch/powerpc/lib/checksum_32.S
>> +++ b/arch/powerpc/lib/checksum_32.S
>> @@ -127,7 +127,8 @@ _GLOBAL(csum_partial_copy_generic)
>>  	stw	r7,12(r1)
>>  	stw	r8,8(r1)
>>
>> -	andi.	r0,r4,1			/* is destination address even ? */
>> +	rlwinm	r0,r4,3,0x8		/* is destination address even ? */
>> +	rlwnm	r6,r6,r0,0,31		/* swap bytes for odd destination */
>>  	cmplwi	cr7,r0,0
>>  	addic	r12,r6,0
>>  	addi	r6,r4,-4
>
> That does not "swap bytes"; it shifts the word up by 8 bits, instead.
> That may or may not do what is intended.
>

Indeed it does what is intended, similar to what is done at the end of 
the function:

	...
	beqlr+	cr7
	rlwinm	r3,r3,8,0,31	/* swap bytes for odd destination */
  	blr

Should I fix the (both) comment(s) ?

Christophe
