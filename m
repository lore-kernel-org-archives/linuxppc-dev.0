Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7C59DDDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:25:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 1/3] cryptoapi: AES with AltiVec support
Date: Wed, 11 Apr 2007 20:24:50 +0200
References: <20070411164910.657151000@linux.vnet.ibm.com>
	<20070411164910.657151000@linux.vnet.ibm.com>>
	<20070411165702.256910000@linux.vnet.ibm.com>>
In-Reply-To: <20070411165702.256910000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704112024.51124.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a few things I noticed in this version:

On Wednesday 11 April 2007, Sebastian Siewior wrote:
> +#ifdef CONFIG_CRYPTO_AES_ALTIVEC_TABLE
> +
> +	/* 19 operations, 1x 8 memory loads */
> +	imm_04h = vec_splat_u8(0x04);
> +	imm_0fh = vec_splat_u8(0x0f);
> +
> +	state_high = vec_sr(state, imm_04h);
> +	state_low  = vec_and(state, imm_0fh);

Why do you need to and with 0x0f here? I thought vec_perm simply ignored
the high bits anyway.

> +	mul_08_hi = vec_perm(gf_mul_8_high, gf_mul_8_high, state_high);
> +	mul_0a_hi = vec_perm(gf_mul_a_high, gf_mul_a_high, state_high);
> +	mul_0c_hi = vec_perm(gf_mul_c_high, gf_mul_c_high, state_high);
> +	mul_0e_hi = vec_perm(gf_mul_e_high, gf_mul_e_high, state_high);
> +
> +	mul_08_lo = vec_perm(gf_mul_8_low, gf_mul_8_low, state_low);
> +	mul_0a_lo = vec_perm(gf_mul_a_low, gf_mul_a_low, state_low);
> +	mul_0c_lo = vec_perm(gf_mul_c_low, gf_mul_c_low, state_low);
> +	mul_0e_lo = vec_perm(gf_mul_e_low, gf_mul_e_low, state_low);
> +
> +	mul_08 = vec_xor(mul_08_hi, mul_08_lo);
> +	mul_0a = vec_xor(mul_0a_hi, mul_0a_lo);
> +	mul_0c = vec_xor(mul_0c_hi, mul_0c_lo);
> +	mul_0e = vec_xor(mul_0e_hi, mul_0e_lo);
> +
> +	mul_09 = vec_xor(mul_08, state);
> +	mul_0b = vec_xor(mul_0a, state);
> +	mul_0d = vec_xor(mul_0c, state);

What are the last three xor used for? I'd think you can have the values
for 0x9, 0xb and 0xd in the table directly.


> +int aes_decrypt_altivec(const unsigned char *in, unsigned char *out,
> +		const unsigned char *kp, unsigned char key_len)
> +{
> +	unsigned char i;
> +	vector unsigned char pstate;
> +	const vector unsigned char *key;
> +	unsigned char tmpbuf[16]  __attribute__ ((aligned (16)));

My understanding is that gcc will not align the latter on the stack
now does it warn about the fact that the attribute gets ignored.
Have you checked that the variable is really put into a 16 byte
aligned stack slot? Does it even make a difference?

> +	memcpy(tmpbuf, in, sizeof(tmpbuf));
> +	pstate = vec_ld(0, tmpbuf);
> +
> +	key = (const vector unsigned char*) kp;
> +
> +	pstate = vec_xor(pstate, *key++);
> +
> +	switch (key_len) {
> +		case 32: /* 14 rounds */
> +			pstate = InvNormalRound(pstate, *key++);
> +			pstate = InvNormalRound(pstate, *key++);
> +
> +		case 24: /* 12 rounds */
> +			pstate = InvNormalRound(pstate, *key++);
> +			pstate = InvNormalRound(pstate, *key++);
> +
> +		case 16: /* 10 rounds */
> +			for (i=0; i<9; i++)
> +				pstate = InvNormalRound(pstate, *key++);
> +
> +			break;
> +
> +		default:
> +			BUG();
> +	}

Did this manual partial unrolling actually make a difference compared
this?

	for (i=0; i<(5 + key_len / 8); i++)
		pstate = InvNormalRound(pstate, *key++);

If they are the same speed, there should probably be no unrolling,
because the larger object code will be bad for the instruction
cache.


> ===================================================================
> --- ps3-linux.orig/crypto/Makefile
> +++ ps3-linux/crypto/Makefile
> @@ -48,3 +48,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
>  obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
>  
>  obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
> +
> +CFLAGS_aes-altivec.o += -O3  -maltivec -mcpu=cell

mcpu=cell probably breaks on most compilers. This needs some
experiments, but most systems should either leave this out
or specify the cpu they are actually compiling for.

Some time ago, I did a patch to extend the CPU selection in
Kconfig so you can choose sensible mcpu= and mtune= flags
semi-automatically.

	Arnd <><
