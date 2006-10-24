Return-Path: <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200610242107.44115.arnd@arndb.de>
References: <20061024160140.452484000@arndb.de>
	<20061024160406.923275000@arndb.de>
	<84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
	<200610242107.44115.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 14:53:22 -0500
Message-Id: <1161719603.8946.84.camel@farscape>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-24-10 at 21:07 +0200, Arnd Bergmann wrote:
> On Tuesday 24 October 2006 20:42, Pekka Enberg wrote:
> > On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > >         spu_acquire(ctx);
> > > -       for (count = 0; count <= len; count += 4, udata++) {
> > > +       for (count = 0; (count + 4) <= len; count += 4, udata++) {
> >
> > Wouldn't this be more obvious as
> >
> >   for (count = 0, count < (len / 4); count++, udata++) {
> >
> > And then do count * 4 if you need the actual index somewhere. Hmm?
> 
> Count is the return value from a write() file operation. I find it
> more readable to update that every time I do one put_user(), to
> the exact value, than calculating the return code later.

Hey Arnd, 
   just curiosity..   What was the behavior before this patch?   just
leaving a few (0 - 3) characters behind?


> 
> 	Arnd <>< 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
