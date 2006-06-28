Return-Path: <akpm@osdl.org>
Date: Wed, 28 Jun 2006 12:49:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.17-mm2
Message-Id: <20060628124906.b289e80b.akpm@osdl.org>
In-Reply-To: <44A2D6DA.1050607@goop.org>
References: <449D5D36.3040102@google.com> <449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
	<44A29582.7050403@google.com>
	<20060628121102.638f08d9.akpm@osdl.org> <44A2D6DA.1050607@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: drfickle@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
	mbligh@google.com, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Jun 2006 12:22:02 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
> > tight loop.  With that happening, a little two-way wasn't able to make
> > it through `dbench 4' without soiling the upholstery.  Then bisection-searching.
> >   
> It's surprising it was so subtle.  I'd been running with that code for a 
> month or so without a peep of problem...
> 

It'll only bite if someone does snprintf() into a too-short buffer.  That's
rare (it's usually a bug).  But it looks like the seq_file() code does it
when someone is trying to generate more than PAGE_SIZE's worth of data. 
Like /proc/slabinfo.
