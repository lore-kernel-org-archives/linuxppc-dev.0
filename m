Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfkDz0SYjzDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 14:35:15 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 6so3225961pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 21:35:14 -0700 (PDT)
Date: Thu, 22 Sep 2016 14:35:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <20160922143500.21809b98@roar.ozlabs.ibm.com>
In-Reply-To: <20160921142343.GA10734@htj.duckdns.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
 <20160921142343.GA10734@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Sep 2016 10:23:43 -0400
Tejun Heo <tj@kernel.org> wrote:

> Hello, Nick.
>=20
> How have you been? :)

Hey Tejun,

Well thank you, how about you?
=20
> On Wed, Sep 21, 2016 at 08:57:11PM +1000, Nicholas Piggin wrote:
> > On Wed, 21 Sep 2016 18:51:37 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >  =20
> > > Some architectures require an additional load to find the address of
> > > percpu pointers. In some implemenatations, the C aliasing rules do not
> > > allow the result of that load to be kept over the store that modifies
> > > the percpu variable, which causes additional loads. =20
> >=20
> > Sorry I picked up an old patch here. This one should be better.
> >=20
> > From d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Wed, 21 Sep 2016 18:23:43 +1000
> > Subject: [PATCH] percpu: improve generic percpu modify-return implement=
ations
> >=20
> > Some architectures require an additional load to find the address of
> > percpu pointers. In some implemenatations, the C aliasing rules do not
> > allow the result of that load to be kept over the store that modifies
> > the percpu variable, which causes additional loads.
> >=20
> > Work around this by finding the pointer first, then operating on that.
> >=20
> > It's also possible to mark things as restrict and those kind of games,
> > but that can require larger and arch specific changes.
> >=20
> > On powerpc, __this_cpu_inc_return compiles to:
> >=20
> >         ld 10,48(13)
> >         ldx 9,3,10
> >         addi 9,9,1
> >         stdx 9,3,10
> >         ld 9,48(13)
> >         ldx 3,9,3
> >=20
> > With this patch it compiles to:
> >=20
> >         ld 10,48(13)
> >         ldx 9,3,10
> >         addi 9,9,1
> >         stdx 9,3,10
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com> =20
>=20
> Patch looks good to me but seems QP encoded.  Can you please resend?
>=20
> Thanks and it's great to see you again!
>=20

Trying a new mail client, sorry. It *seems* to be working now, how's
this?

=46rom d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 21 Sep 2016 18:23:43 +1000
Subject: [PATCH] percpu: improve generic percpu modify-return implementatio=
ns

Some architectures require an additional load to find the address of
percpu pointers. In some implemenatations, the C aliasing rules do not
allow the result of that load to be kept over the store that modifies
the percpu variable, which causes additional loads.

Work around this by finding the pointer first, then operating on that.

It's also possible to mark things as restrict and those kind of games,
but that can require larger and arch specific changes.

On powerpc, __this_cpu_inc_return compiles to:

        ld 10,48(13)
        ldx 9,3,10
        addi 9,9,1
        stdx 9,3,10
        ld 9,48(13)
        ldx 3,9,3

With this patch it compiles to:

        ld 10,48(13)
        ldx 9,3,10
        addi 9,9,1
        stdx 9,3,10

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

To: Tejun Heo <tj@kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/percpu.h | 53 +++++++++++++++++++++++++---------------=
----
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 4d9f233..40e8870 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -65,6 +65,11 @@ extern void setup_per_cpu_areas(void);
 #define PER_CPU_DEF_ATTRIBUTES
 #endif
=20
+#define raw_cpu_generic_read(pcp)					\
+({									\
+	*raw_cpu_ptr(&(pcp));						\
+})
+
 #define raw_cpu_generic_to_op(pcp, val, op)				\
 do {									\
 	*raw_cpu_ptr(&(pcp)) op val;					\
@@ -72,34 +77,39 @@ do {									\
=20
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	raw_cpu_add(pcp, val);						\
-	raw_cpu_read(pcp);						\
+	typeof(&(pcp)) __p =3D raw_cpu_ptr(&(pcp));			\
+									\
+	*__p +=3D val;							\
+	*__p;								\
 })
=20
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
+	typeof(&(pcp)) __p =3D raw_cpu_ptr(&(pcp));			\
 	typeof(pcp) __ret;						\
-	__ret =3D raw_cpu_read(pcp);					\
-	raw_cpu_write(pcp, nval);					\
+	__ret =3D *__p;							\
+	*__p =3D nval;							\
 	__ret;								\
 })
=20
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
+	typeof(&(pcp)) __p =3D raw_cpu_ptr(&(pcp));			\
 	typeof(pcp) __ret;						\
-	__ret =3D raw_cpu_read(pcp);					\
+	__ret =3D *__p;							\
 	if (__ret =3D=3D (oval))						\
-		raw_cpu_write(pcp, nval);				\
+		*__p =3D nval;						\
 	__ret;								\
 })
=20
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nv=
al2) \
 ({									\
+	typeof(&(pcp1)) __p1 =3D raw_cpu_ptr(&(pcp1));			\
+	typeof(&(pcp2)) __p2 =3D raw_cpu_ptr(&(pcp2));			\
 	int __ret =3D 0;							\
-	if (raw_cpu_read(pcp1) =3D=3D (oval1) &&				\
-			 raw_cpu_read(pcp2)  =3D=3D (oval2)) {		\
-		raw_cpu_write(pcp1, nval1);				\
-		raw_cpu_write(pcp2, nval2);				\
+	if (*__p1 =3D=3D (oval1) && *__p2  =3D=3D (oval2)) {			\
+		*__p1 =3D nval1;						\
+		*__p2 =3D nval2;						\
 		__ret =3D 1;						\
 	}								\
 	(__ret);							\
@@ -109,7 +119,7 @@ do {									\
 ({									\
 	typeof(pcp) __ret;						\
 	preempt_disable();						\
-	__ret =3D *this_cpu_ptr(&(pcp));					\
+	__ret =3D raw_cpu_generic_read(pcp);				\
 	preempt_enable();						\
 	__ret;								\
 })
@@ -118,17 +128,17 @@ do {									\
 do {									\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	*raw_cpu_ptr(&(pcp)) op val;					\
+	raw_cpu_generic_to_op(pcp, val, op);				\
 	raw_local_irq_restore(__flags);					\
 } while (0)
=20
+
 #define this_cpu_generic_add_return(pcp, val)				\
 ({									\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	raw_cpu_add(pcp, val);						\
-	__ret =3D raw_cpu_read(pcp);					\
+	__ret =3D raw_cpu_generic_add_return(pcp, val);			\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -138,8 +148,7 @@ do {									\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	__ret =3D raw_cpu_read(pcp);					\
-	raw_cpu_write(pcp, nval);					\
+	__ret =3D raw_cpu_generic_xchg(pcp, nval);			\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -149,9 +158,7 @@ do {									\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	__ret =3D raw_cpu_read(pcp);					\
-	if (__ret =3D=3D (oval))						\
-		raw_cpu_write(pcp, nval);				\
+	__ret =3D raw_cpu_generic_cmpxchg(pcp, oval, nval);		\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -168,16 +175,16 @@ do {									\
 })
=20
 #ifndef raw_cpu_read_1
-#define raw_cpu_read_1(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_1(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_2
-#define raw_cpu_read_2(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_2(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_4
-#define raw_cpu_read_4(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_4(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_8
-#define raw_cpu_read_8(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_8(pcp)		raw_cpu_generic_read(pcp)
 #endif
=20
 #ifndef raw_cpu_write_1
--=20
2.9.3
