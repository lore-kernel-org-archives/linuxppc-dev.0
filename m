Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C73FDDF28
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 23:41:32 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3CDfR7X140504
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:41:27 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3CDfRWU3989552
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 15:41:27 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3CDfQi1006724
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 15:41:27 +0200
Message-ID: <461E36CA.4030509@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2007 15:40:26 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] cryptoapi: AES with AltiVec support
References: <20070411164910.657151000@linux.vnet.ibm.com>
	<20070411164910.657151000@linux.vnet.ibm.com>>
	<20070411165702.256910000@linux.vnet.ibm.com>>
	<200704112024.51124.arnd@arndb.de>
In-Reply-To: <200704112024.51124.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Just a few things I noticed in this version:
> 
>> +	imm_04h = vec_splat_u8(0x04);
>> +	imm_0fh = vec_splat_u8(0x0f);
>> +
>> +	state_high = vec_sr(state, imm_04h);
>> +	state_low  = vec_and(state, imm_0fh);
> 
> Why do you need to and with 0x0f here? I thought vec_perm simply ignored
> the high bits anyway.

Yes it does, my bad

>> +	mul_09 = vec_xor(mul_08, state);
>> +	mul_0b = vec_xor(mul_0a, state);
>> +	mul_0d = vec_xor(mul_0c, state);
> 
> What are the last three xor used for? I'd think you can have the values
> for 0x9, 0xb and 0xd in the table directly.
Yes. With recomputing table the performance seems to be unchanged.

>> +int aes_decrypt_altivec(const unsigned char *in, unsigned char *out,
>> +		const unsigned char *kp, unsigned char key_len)
>> +{
>> +	unsigned char i;
>> +	vector unsigned char pstate;
>> +	const vector unsigned char *key;
>> +	unsigned char tmpbuf[16]  __attribute__ ((aligned (16)));
> 
> My understanding is that gcc will not align the latter on the stack
> now does it warn about the fact that the attribute gets ignored.
> Have you checked that the variable is really put into a 16 byte
> aligned stack slot? Does it even make a difference?

Quote from the PPC64 ABI [1]:
r1: The stack pointer (stored in r1) shall maintain quadword alignment.
It shall always point to the lowest allocated valid stack frame, and
grow toward low addresses.  The contents of the word at that address
always point to the previously allocated stack frame.
...

PPC32 ABI[2] page 32 contains the same sentence about r1. The compiler 
does not behave correctly on >16 byte alignment and should warn you.

>> +	switch (key_len) {
>> +		case 32: /* 14 rounds */
>> +			pstate = InvNormalRound(pstate, *key++);
>> +			pstate = InvNormalRound(pstate, *key++);
>> +
>> +		case 24: /* 12 rounds */
>> +			pstate = InvNormalRound(pstate, *key++);
>> +			pstate = InvNormalRound(pstate, *key++);
>> +
>> +		case 16: /* 10 rounds */
>> +			for (i=0; i<9; i++)
>> +				pstate = InvNormalRound(pstate, *key++);
>> +
>> +			break;
>> +
>> +		default:
>> +			BUG();
>> +	}
> 
> Did this manual partial unrolling actually make a difference compared
> this?
> 
> 	for (i=0; i<(5 + key_len / 8); i++)
> 		pstate = InvNormalRound(pstate, *key++);

The numbers for encryption change from 33mb/sec to 23mb/sec and for 
decryption from 29mb/sec to 26mb/sec. The table decryption, however, 
improves from 19mb/sec to 23mb/sec.

> If they are the same speed, there should probably be no unrolling,
> because the larger object code will be bad for the instruction
> cache.
I don't force him to unroll the code, there is no inline keyword there. 
ppu-gcc from SDK 2.1 unrolls the code, gentoo's gcc 4.1.2 doesn't.

>> +CFLAGS_aes-altivec.o += -O3  -maltivec -mcpu=cell
> 
> mcpu=cell probably breaks on most compilers. This needs some
> experiments, but most systems should either leave this out
> or specify the cpu they are actually compiling for.
> 
> Some time ago, I did a patch to extend the CPU selection in
> Kconfig so you can choose sensible mcpu= and mtune= flags
> semi-automatically.

I have no cpu selection in my current Kconfig. Will take a look on that 
patch

> 
> 	Arnd <><

Sebastian

[1] ftp://ftp.linuxppc64.org/pub/people/sjmunroe/PPC64-VMXabi.txt
[2]http://www.cloudcaptech.com/MPC555%20Resources/Programming%20Environment/SVR4abippc.pdf
