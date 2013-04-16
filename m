Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 335502C0137
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 03:22:54 +1000 (EST)
In-Reply-To: <1366127650-1952-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366127650-1952-3-git-send-email-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AAEA07FE-7530-46D3-B2FC-B3FD8EC2C6E2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V2 2/5] powerpc,
 perf: Add basic assembly code to read BHRB entries on POWER8
Date: Tue, 16 Apr 2013 19:23:19 +0200
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/* r3 = n  (where n = [0-1023])
> + * The maximum number of BHRB entries supported with PPC_MFBHRBE  
> instruction
> + * is 1024. We have limited number of table entries here as POWER8  
> implements
> + * 32 BHRB entries.
> + */
> +
> +/* .global read_bhrb */
> +_GLOBAL(read_bhrb)
> +	cmpldi	r3,1023

This should be 31, since that is the last entry in the table below.

> +	bgt	1f
> +	ld	r4,bhrb_table@got(r2)
> +	sldi	r3,r3,3
> +	add	r3,r4,r3
> +	mtctr	r3
> +	bctr
> +1:	li	r3,0
> +	blr
> +
> +#define MFBHRB_TABLE1(n) PPC_MFBHRBE(R3,n); blr
> +#define MFBHRB_TABLE2(n) MFBHRB_TABLE1(n); MFBHRB_TABLE1(n+1)
> +#define MFBHRB_TABLE4(n) MFBHRB_TABLE2(n); MFBHRB_TABLE2(n+2)
> +#define MFBHRB_TABLE8(n) MFBHRB_TABLE4(n); MFBHRB_TABLE4(n+4)
> +#define MFBHRB_TABLE16(n) MFBHRB_TABLE8(n); MFBHRB_TABLE8(n+8)
> +#define MFBHRB_TABLE32(n) MFBHRB_TABLE16(n); MFBHRB_TABLE16(n+16)
> +
> +bhrb_table:
> +	MFBHRB_TABLE32(0)


Segher
