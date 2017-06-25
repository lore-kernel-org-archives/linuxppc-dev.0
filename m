Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwmqY38WGzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 08:21:13 +1000 (AEST)
Date: Sun, 25 Jun 2017 23:21:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 4.6.3 miscompile on ppc32 (was Re: Regression in kernel
 4.12-rc1 for Powerpc 32 - bisected to commit 3448890c32c3)
Message-ID: <20170625222106.GX10672@ZenIV.linux.org.uk>
References: <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
 <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
 <20170625095351.GU10672@ZenIV.linux.org.uk>
 <20170625111404.GV10672@ZenIV.linux.org.uk>
 <20170625205324.GW10672@ZenIV.linux.org.uk>
 <20170625214408.GT16550@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170625214408.GT16550@gate.crashing.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 25, 2017 at 04:44:09PM -0500, Segher Boessenkool wrote:

> Do you have a short stand-alone testcase?  4.6 is ancient, of course, but
> the actual problem may still exist in more recent compilers (if it _is_
> a compiler problem; if it's not, you *really* want to know :-) )

Enjoy.  At least 6.3 doesn't step into that.  Look for mtctr in the resulting
asm...

cat <<'EOF' >a.c
struct iovec
{
 void *iov_base;
 unsigned iov_len;
};

unsigned long v;

extern void * barf(void *,int,unsigned);

extern unsigned long bar(void *to, const void *from, unsigned long size);

static inline unsigned long __bar(void *to, const void *from, unsigned long n)
{
 unsigned long res = n;
 if (__builtin_expect(!!(((void)0, (((( unsigned long)(from)) <= v) && ((((n)) == 0) || ((((n)) - 1) <= (v - (( unsigned long)(from)))))))), 1))
  res = bar(to, from, n);
 if (res)
  barf(to + (n - res), 0, res);
 return res;
}

int foo(int type, const struct iovec * uvector,
         unsigned long nr_segs, unsigned long fast_segs,
         struct iovec *iov,
         struct iovec **ret_pointer)
{
 unsigned long seg;
 int ret;
 if (nr_segs == 0) {
  ret = 0;
  goto out;
 }
 if (nr_segs > 1024) {
  ret = -22;
  goto out;
 }
 if (__bar(iov, uvector, nr_segs*sizeof(*uvector))) {
  ret = -14;
  goto out;
 }
 ret = 0;
 for (seg = 0; seg < nr_segs; seg++) {
  void *buf = iov[seg].iov_base;
  int len = (int)iov[seg].iov_len;
  if (len < 0) {
   ret = -22;
   goto out;
  }
  if (type >= 0
      && __builtin_expect(!!(!((void)0, (((( unsigned long)(buf)) <= v) && ((((len)) == 0) || ((((len)) - 1) <= (v - (( unsigned long)(buf)))))))), 0)) {
   ret = -14;
   goto out;
  }
  ret += len;
 }
out:
 *ret_pointer = iov;
 return ret;
}
EOF
powerpc-linux-gcc -m32 -fno-strict-aliasing -fno-common -std=gnu89 -fno-PIE -msoft-float -pipe -ffixed-r2 -mmultiple -mno-altivec -mno-vsx -mno-spe -mspe=no -funit-at-a-time -fno-dwarf2-cfi-asm -mno-string -mcpu=powerpc -Wa,-maltivec -mbig-endian -fno-delete-null-pointer-checks -Os -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking-assignments -femit-struct-debug-baseonly -fno-var-tracking -fno-strict-overflow -fconserve-stack -fverbose-asm -S a.c
