Return-Path: <vda.linux@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 7A2E4DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 20:20:35 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so792699ugf.0
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jul 2008 03:20:32 -0700 (PDT)
From: Denys Vlasenko <vda.linux@googlemail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: the printk problem
Date: Sat, 5 Jul 2008 12:20:25 +0200
References: <20080625131101.GA6205@digi.com>
	<20080704204252.GM14894@parisc-linux.org>
	<20080704150100.1f7b8a65.akpm@linux-foundation.org>
In-Reply-To: <20080704150100.1f7b8a65.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807051220.25418.vda.linux@googlemail.com>
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 July 2008 00:01, Andrew Morton wrote:
> > > We also jump through hoops to print things like sector_t and
> > > resource_size_t.  They always need to be cast to `unsiged long long',
> > > which generates additional stack space and text in some setups.
> > 
> > The thing is that GCC checks types.  So it's fine to add "print this
> > pointer specially", but you can't in general add new printf arguments
> > without also hacking GCC.  Unless you use -Wno-format, and require
> > sparse to check special kernel types.
> 
> It would be excellent if gcc had an extension system so that you could
> add new printf control chars and maybe even tell gcc how to check them.
> But of course, if that were to happen, we couldn't use it for 4-5 years.
> 
> What I had initially proposed was to abuse %S, which takes a wchar_t*. 
> gcc accepts `unsigned long *' for %S.
> 
> Then, we put the kernel-specific control char after the S, so we can
> print an inode (rofl) with
> 
> 	struct inode *inode;
> 
> 	printk("here is an inode: %Si\n", (unsigned long *)inode);
> 
> Downsides are:
> 
> - there's a cast, so you could accidentally do
> 
> 	printk("here is an inode: %Si\n", (unsigned long *)dentry);
> 
> - there's a cast, and they're ugly
> 
> - gcc cannot of course check that the arg matches the control string
> 
> Unfortunately (and this seems weird), gcc printf checking will not
> accept a void* for %S: it _has_ to be wchar_t*, and the checker won't
> permit void* substitution for that.

Repeating myself here...
We can add an alternative alias to printk:

 asmlinkage int printk(const char * fmt, ...)
         __attribute__ ((format (printf, 1, 2))) __cold;
+asmlinkage int custom_printk(const char * fmt, ...) __cold asm ("printk");

custom_printk() is actually just printk(), that is,
we won't need additional function, we need to teach
*printk* about MAC addresses, NIPQUADs etc;

and then use printk() if you use only standard %fmt (and have it
checked by gcc), or use custom_printk() if you have non-standard
%fmt in the format string.

The only downside that in second case, you lose gcc checking.
No big deal.
--
vda
