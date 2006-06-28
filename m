Return-Path: <akpm@osdl.org>
Date: Wed, 28 Jun 2006 12:11:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: 2.6.17-mm2
Message-Id: <20060628121102.638f08d9.akpm@osdl.org>
In-Reply-To: <44A29582.7050403@google.com>
References: <449D5D36.3040102@google.com> <449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
	<44A29582.7050403@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jeremy@goop.org, drfickle@us.ibm.com, linux-kernel@vger.kernel.org,
	mbligh@mbligh.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Jun 2006 07:43:14 -0700
"Martin J. Bligh" <mbligh@google.com> wrote:

> Andrew Morton wrote:
> > On Wed, 28 Jun 2006 03:42:15 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > 
> >>his is caused by the vsprintf() changes.  Right now, if you do
> >>
> >>	snprintf(buf, 4, "1111111111111");
> >>
> >>the memory at `buf' gets [31 31 31 31 00], which is not good.
> >>
> >>This'll plug it, but I didn't check very hard whether it still has any
> >>off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..
> 
> Aha, you're a genius!

That's not what my kids say.

> How the hell did you figure that one out?

Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
tight loop.  With that happening, a little two-way wasn't able to make
it through `dbench 4' without soiling the upholstery.  Then bisection-searching.
