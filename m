To: Jonas Smedegaard <js@debian.org>
Cc: debian@jones.dk, linuxppc-dev@lists.linuxppc.org,
	debian-powerpc@lists.debian.org
Subject: Re: IrDA-patched binaries
References: <Pine.LNX.4.33.0111012312360.888-100000@auryn.jones.dk>
From: jason@openinformatics.com (Jason E. Stewart)
Date: 11 Nov 2001 16:10:00 -0700
In-Reply-To: <Pine.LNX.4.33.0111012312360.888-100000@auryn.jones.dk>
Message-ID: <87y9lc6h13.fsf@openinformatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jonas Smedegaard" <dr@jones.dk> writes:

> I have made available kernel and irda-packages with the irda-hacks added
> to make .

I was totally thrilled to see this. Because of reiserfs, I need to
compile my own kernel, so I grabbed the patches a couple of weeks
ago. I just had time to look at them and it seems that parameters.h
has changed a *lot* since this patch was made.

>From BenH's latest kernel:

typedef union {
	char   *c;
	__u32   i;
	__u32 *ip;
} irda_pv_t;

from the patch:

+#if   defined(__BIG_ENDIAN) 	/* TODO: not 64bit safe (when casting __u32 to ptr) */
 typedef union {
 	char   *c;
-	__u8    b;
-	__u16   s;
+	struct {
+	__u8    mm,ml,lm,ll;	/* most to least significant */
+	}       b;
+	struct {
+	__u16   m,l;		/* most to least significant */
+	}       s;
 	__u32   i;
 	__u8  *bp;
 	__u16 *sp;
 	__u32 *ip;
 } irda_pv_t;
+#elif defined(__LITTLE_ENDIAN) 	/* TODO: not 64bit safe */
+typedef union {
+	char   *c;
+	struct {
+	__u8    ll,lm,ml,mm;	/* least to most significant */
+	}       b;
+	struct {
+	__u16   l,m;		/* least to most significant */
+	}       s;
+	__u32   i;
+	__u8  *bp;
+	__u16 *sp;
+	__u32 *ip;
+} irda_pv_t;
+#else
+#error "unknown endianness"
+#endif


So it looks like the irda_pv_t has lost the *sp,*bp,s, and b fields
since the patch was made. Since the primary change of the patch is to
make the b and s fields into structs, I don't really have a clue how
to procede.

Can someone suggest anything?

Thanks,
jas.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
