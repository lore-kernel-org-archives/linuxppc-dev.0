Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nMcS5FtJzF295
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 19:02:00 +1000 (AEST)
Date: Fri, 18 May 2018 11:01:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 "Darren Hart (VMware)" <dvhart@infradead.org>,
 linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-xtensa@linux-xtensa.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 4.9 27/33] futex: Remove duplicated code and fix
 undefined behaviour
Message-ID: <20180518090141.GA10227@kroah.com>
References: <20180518081535.096308218@linuxfoundation.org>
 <20180518081536.166573281@linuxfoundation.org>
 <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 10:30:24AM +0200, Jiri Slaby wrote:
> On 05/18/2018, 10:16 AM, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jiri Slaby <jslaby@suse.cz>
> > 
> > commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.
> ...
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -1458,6 +1458,45 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> 
> 12 is wrong here – wherever you apply this, you need also a follow-up fix:
> commit d70ef22892ed6c066e51e118b225923c9b74af34
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Nov 30 15:35:44 2017 +0100
> 
>     futex: futex_wake_op, fix sign_extend32 sign bits

Thanks for letting me know, I've now queued it up to the needed trees.

greg k-h
