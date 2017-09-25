Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0zMy1qqmzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 19:30:34 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'wei.guo.simon@gmail.com'" <wei.guo.simon@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>, Christophe LEROY
 <christophe.leroy@c-s.fr>
Subject: RE: [PATCH v2 3/3] powerpc:selftest update memcmp_64 selftest for
 VMX implementation
Date: Mon, 25 Sep 2017 09:30:28 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD007F112@AcuExch.aculab.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505950480-14830-4-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: wei.guo.simon@gmail.com
> Sent: 21 September 2017 00:35
> This patch adjust selftest memcmp_64 so that memcmp selftest can be
> compiled successfully.
...
>  #define ITERATIONS 10000
>=20
> +#define LARGE_SIZE (5 * 1024)
> +#define LARGE_ITERATIONS 1000
...

Measuring performance by doing a lot of iterations isn't ideal
and is pretty pointless.
Cold cache performance can be more useful.
Also you don't really want any dynamic branch prediction logic
tuned to the exact test you keep doing.

	David
