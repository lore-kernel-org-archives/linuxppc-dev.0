Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 45C862C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 00:34:57 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 10676-09 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 13 Feb 2013 13:28:14 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
Date: Wed, 13 Feb 2013 13:27:21 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7148@saturn3.aculab.com>
In-Reply-To: <87pq04jvb4.fsf@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360701185.2035.10.camel@pasglop> <87sj50kian.fsf@linux.vnet.ibm.com>
 <1360727211.2035.30.camel@pasglop> <87pq04jvb4.fsf@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 <phileas-fogg@mail.ru>, <geoff@infradead.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#define CONTEXT_BITS		19
> +#define USER_ESID_BITS		18
> +#define USER_ESID_BITS_1T	6
> +
> +/*
> + * 256MB segment
> + * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 =
segments
> + * available for user + kernel mapping. The top 4 contexts are used =
for
> + * kernel mapping. Each segment contains 2^28 bytes. Each
> + * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
> + * (19 =3D=3D 37 + 28 - 46).
> + */

I can't help feeling this would be easier to understand if a full
64? 80? bit address was shown with the various bit ranges identified.

Given the comment, I'd have expected CONTEXT_BITS to be calculated
from three other named constants - rather than being set to 19.

	David
