Return-Path: <akpm@osdl.org>
Date: Wed, 28 Jun 2006 03:47:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: mbligh@mbligh.org, jeremy@goop.org, mbligh@google.com,
	linux-kernel@vger.kernel.org, apw@shadowen.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060628034748.018eecac.akpm@osdl.org>
In-Reply-To: <20060628034215.c3008299.akpm@osdl.org>
References: <449D5D36.3040102@google.com> <449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Jun 2006 03:42:15 -0700
Andrew Morton <akpm@osdl.org> wrote:

> his is caused by the vsprintf() changes.  Right now, if you do
> 
> 	snprintf(buf, 4, "1111111111111");
> 
> the memory at `buf' gets [31 31 31 31 00], which is not good.
> 
> This'll plug it, but I didn't check very hard whether it still has any
> off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..

That diff was against an older kernel and doesn't apply.  This is against
mainline:

--- a/lib/vsprintf.c~vsnprintf-fix
+++ a/lib/vsprintf.c
@@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
 	int len;
 	unsigned long long num;
 	int i, base;
-	char *str, *end, c;
+	char *str;		/* Where we're writing to */
+	char *end;		/* The last byte we can write to */
+	char c;
 	const char *s;
 
 	int flags;		/* flags to number() */
@@ -283,12 +285,12 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size;
+	end = buf + size - 1;
 
 	/* Make sure end is always >= buf */
-	if (end < buf) {
+	if (end < buf - 1) {
 		end = ((void *)-1);
-		size = end - buf;
+		size = end - buf + 1;
 	}
 
 	for (; *fmt ; ++fmt) {
@@ -494,7 +496,6 @@ int vsnprintf(char *buf, size_t size, co
 	/* the trailing null byte doesn't count towards the total */
 	return str-buf;
 }
-
 EXPORT_SYMBOL(vsnprintf);
 
 /**
_
