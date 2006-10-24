Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Date: Tue, 24 Oct 2006 21:07:43 +0200
References: <20061024160140.452484000@arndb.de>
	<20061024160406.923275000@arndb.de>
	<84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
In-Reply-To: <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610242107.44115.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 October 2006 20:42, Pekka Enberg wrote:
> On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > =A0 =A0 =A0 =A0 spu_acquire(ctx);
> > - =A0 =A0 =A0 for (count =3D 0; count <=3D len; count +=3D 4, udata++) {
> > + =A0 =A0 =A0 for (count =3D 0; (count + 4) <=3D len; count +=3D 4, uda=
ta++) {
>
> Wouldn't this be more obvious as
>
> =A0 for (count =3D 0, count < (len / 4); count++, udata++) {
>
> And then do count * 4 if you need the actual index somewhere. Hmm?

Count is the return value from a write() file operation. I find it
more readable to update that every time I do one put_user(), to
the exact value, than calculating the return code later.

	Arnd <><=20
