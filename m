Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhvn533f5zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 10:52:41 +1100 (AEDT)
Date: Tue, 14 Mar 2017 07:52:25 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Till Smejkal <till.smejkal@googlemail.com>
Cc: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Felipe Balbi <balbi@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Benjamin LaHaise <bcrl@kvack.org>,
 Nadia Yvette Chambers <nyc@holomorphy.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 10/13] mm: Introduce first class virtual address spaces
Message-ID: <20170313235225.GA15359@kroah.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
 <20170313221415.9375-11-till.smejkal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313221415.9375-11-till.smejkal@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 13, 2017 at 03:14:12PM -0700, Till Smejkal wrote:

There's no way with that many cc: lists and people that this is really
making it through very many people's filters and actually on a mailing
list.  Please trim them down.

Minor sysfs questions/issues:

> +struct vas {
> +	struct kobject kobj;		/* < the internal kobject that we use *
> +					 *   for reference counting and sysfs *
> +					 *   handling.                        */
> +
> +	int id;				/* < ID                               */
> +	char name[VAS_MAX_NAME_LENGTH];	/* < name                             */

The kobject has a name, why not use that?

> +
> +	struct mutex mtx;		/* < lock for parallel access.        */
> +
> +	struct mm_struct *mm;		/* < a partial memory map containing  *
> +					 *   all mappings of this VAS.        */
> +
> +	struct list_head link;		/* < the link in the global VAS list. */
> +	struct rcu_head rcu;		/* < the RCU helper used for          *
> +					 *   asynchronous VAS deletion.       */
> +
> +	u16 refcount;			/* < how often is the VAS attached.   */

The kobject has a refcount, use that?  Don't have 2 refcounts in the
same structure, that way lies madness.  And bugs, lots of bugs...

And if this really is a refcount (hint, I don't think it is), you should
use the refcount_t type.

> +/**
> + * The sysfs structure we need to handle attributes of a VAS.
> + **/
> +struct vas_sysfs_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct vas *vas, struct vas_sysfs_attr *vsattr,
> +			char *buf);
> +	ssize_t (*store)(struct vas *vas, struct vas_sysfs_attr *vsattr,
> +			 const char *buf, size_t count);
> +};
> +
> +#define VAS_SYSFS_ATTR(NAME, MODE, SHOW, STORE)				\
> +static struct vas_sysfs_attr vas_sysfs_attr_##NAME =			\
> +	__ATTR(NAME, MODE, SHOW, STORE)

__ATTR_RO and __ATTR_RW should work better for you.  If you really need
this.

Oh, and where is the Documentation/ABI/ updates to try to describe the
sysfs structure and files?  Did I miss that in the series?

> +static ssize_t __show_vas_name(struct vas *vas, struct vas_sysfs_attr *vsattr,
> +			       char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%s", vas->name);

It's a page size, just use sprintf() and be done with it.  No need to
ever check, you "know" it will be correct.

Also, what about a trailing '\n' for these attributes?

Oh wait, why have a name when the kobject name is already there in the
directory itself?  Do you really need this?

> +/**
> + * The ktype data structure representing a VAS.
> + **/
> +static struct kobj_type vas_ktype = {
> +	.sysfs_ops = &vas_sysfs_ops,
> +	.release = __vas_release,

Why the odd __vas* naming?  What's wrong with vas_release?


> +	.default_attrs = vas_default_attr,
> +};
> +
> +
> +/***
> + * Internally visible functions
> + ***/
> +
> +/**
> + * Working with the global VAS list.
> + **/
> +static inline void vas_remove(struct vas *vas)

<snip>

You have a ton of inline functions, for no good reason.  Make them all
"real" functions please.  Unless you can measure the size/speed
differences?  If so, please say so.


thanks,

greg k-h
