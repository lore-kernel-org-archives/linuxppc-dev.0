Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D786F1A0668
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 04:05:28 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8] replace memset by memzero_explicit
Date: Sun, 30 Nov 2014 17:59:26 +0100
Message-Id: <1417366774-32412-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: linux-cifs@vger.kernel.org, herbert@gondor.apana.org.au,
 samba-technical@lists.samba.org, linux-usb@vger.kernel.org,
 kernel-janitors@vger.kernel.org, dm-devel@redhat.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, dborkman@redhat.com,
 linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memset on a local variable may be removed when it is called just before the
variable goes out of scope.  Using memzero_explicit defeats this
optimization.  The complete semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
local idexpression e;
type T,T1;
@@

{
... when any
T x[...];
... when any
    when exists
(
e = (T1)x
|
e = (T1)&x[0]
)
... when any
    when exists
- memset
+ memzero_explicit
  (x,
-0,
  ...)
... when != x
    when != e
    when strict
}

@@
identifier i,x;
local idexpression e;
type T;
@@

{
... when any
struct i x;
... when any
    when exists
e = (T)&x
... when any
    when exists
- memset
+ memzero_explicit
  (&x,
-0,
  ...)
... when != x
    when != e
    when strict
}

// ------------------------------------------------------------------------

@@
identifier x;
type T,T1;
expression e;
@@

{
... when any
T x[...];
... when any
    when exists
    when != e = (T1)x
    when != e = (T1)&x[0]
- memset
+ memzero_explicit
  (x,
-0,
  ...)
... when != x
    when strict
}

@@
identifier i,x;
expression e;
type T;
@@

{
... when any
struct i x;
... when any
    when exists
    when != e = (T)&x
- memset
+ memzero_explicit
  (&x,
-0,
  ...)
... when != x
    when strict
}
// </smpl>
