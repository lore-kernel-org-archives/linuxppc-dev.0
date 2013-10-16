Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B55672C00E0
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 19:34:41 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 29970-06 for <linuxppc-dev@ozlabs.org>;
 Wed, 16 Oct 2013 09:27:57 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 02/10][v6] powerpc/Power7: detect load/store instructions
Date: Wed, 16 Oct 2013 09:25:35 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B738E@saturn3.aculab.com>
In-Reply-To: <1381889202-16826-3-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1381889202-16826-3-git-send-email-sukadev@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Sukadev Bhattiprolu" <sukadev@linux.vnet.ibm.com>,
 "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Implement instr_is_load_store_2_06() to detect whether a given =
instruction
> is one of the fixed-point or floating-point load/store instructions in =
the
> POWER Instruction Set Architecture v2.06.
...
> +int instr_is_load_store_2_06(const unsigned int *instr)
> +{
> +	unsigned int op, upper, lower;
> +
> +	op =3D instr_opcode(*instr);
> +
> +	if ((op >=3D 32 && op <=3D 58) || (op =3D=3D 61 || op =3D=3D 62))
> +		return true;
> +
> +	if (op !=3D 31)
> +		return false;
> +
> +	upper =3D op >> 5;
> +	lower =3D op & 0x1f;
> +
> +	/* Short circuit as many misses as we can */
> +	if (lower < 3 || lower > 23)
> +		return false;
> +
> +	if (lower =3D=3D 3) {
> +		if (upper >=3D 16)
> +			return true;
> +
> +		return false;
> +	}
> +
> +	if (lower =3D=3D 7 || lower =3D=3D 12)
> +		return true;
> +
> +	if (lower >=3D 20) /* && lower <=3D 23 (implicit) */
> +		return true;
> +
> +	return false;
> +}

I can't help feeling the code could do with some comments about
which actual instructions are selected where.

	David
