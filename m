Return-Path: <amodra@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC72F140090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 21:04:58 +1100 (EST)
Received: by mail-pd0-f180.google.com with SMTP id v10so1663239pde.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 03:04:56 -0700 (PDT)
Date: Wed, 26 Mar 2014 20:34:49 +1030
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 15/33] powerpc: Fix ABIv2 issues with stack offsets in
 assembly code
Message-ID: <20140326100449.GN18201@bubble.grove.modra.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-16-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395747879-5948-16-git-send-email-anton@samba.org>
Cc: mikey@neuling.org, rusty@rustcorp.com.au, ulrich.weigand@de.ibm.com,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 10:44:21PM +1100, Anton Blanchard wrote:
> Fix STK_PARAM and use it instead of hardcoding ABIv1 offsets.

>  _GLOBAL(memcpy)
>  BEGIN_FTR_SECTION
> -	std	r3,48(r1)	/* save destination pointer for return value */
> +	std	r3,STK_PARAM(R3)(r1)	/* save destination pointer for return value */

Here and elsewhere you're assuming you have a parameter save area.
That won't be true with ELFv2 for calls to functions like memcpy.

typedef __SIZE_TYPE__ size_t;
extern void *memcpy (void *dest, const void *src, size_t n);

void foo (void *dest, const void *src, size_t n)
{
  memcpy (dest, src, n);
}

foo:
0:	addis 2,12,.TOC.-0b@ha
	addi 2,2,.TOC.-0b@l
	.localentry	foo,.-foo
	mflr 0
	std 0,16(1)
	stdu 1,-32(1)   # <========
	bl memcpy
	nop
	addi 1,1,32
	ld 0,16(1)
	mtlr 0
	blr

-- 
Alan Modra
Australia Development Lab, IBM
