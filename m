Return-Path: <norsk5@yahoo.com>
Received: from web50108.mail.re2.yahoo.com (web50108.mail.re2.yahoo.com
	[206.190.38.36]) by ozlabs.org (Postfix) with SMTP id ECA7BDE11D
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 07:49:30 +1000 (EST)
Message-ID: <406152.8763.qm@web50108.mail.re2.yahoo.com>
Date: Fri, 17 Apr 2009 14:42:47 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [v2 PATCH 2/3] EDAC: Add edac_device_alloc_index()
To: Harry Ciao <qingtao.cao@windriver.com>,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- On Wed, 4/15/09, Andrew Morton <akpm@linux-foundation.org> wrote:=0A=0A=
> From: Andrew Morton <akpm@linux-foundation.org>=0A> Subject: Re: [v2 PATC=
H 2/3] EDAC: Add edac_device_alloc_index()=0A> To: "Harry Ciao" <qingtao.ca=
o@windriver.com>=0A> Cc: norsk5@yahoo.com, michael@ellerman.id.au, bluesmok=
e-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org, linux-kernel@vger.k=
ernel.org=0A> Date: Wednesday, April 15, 2009, 4:27 PM=0A> On Mon, 13 Apr 2=
009 14:05:15 +0800=0A> Harry Ciao <qingtao.cao@windriver.com>=0A> wrote:=0A=
> =0A> > Add edac_device_alloc_index(), because for MAPLE=0A> platform ther=
e may=0A> > exist several EDAC driver modules that could make use=0A> of=0A=
> > edac_device_ctl_info structure at the same time. The=0A> index allocati=
on=0A> > for these structures should be taken care of by EDAC=0A> core.=0A>=
 > =0A> =0A> From: Andrew Morton <akpm@linux-foundation.org>=0A> =0A> keep =
things neat.=A0 Also avoids having global=0A> identifier device_index=0A> s=
hadowed by local identifier device_index.=0A> =0A> Cc: Benjamin Herrenschmi=
dt <benh@kernel.crashing.org>=0A=0AAcked-by: Doug Thompson <dougthompson@xm=
ission.com>=0A=0A> Cc: Harry Ciao <qingtao.cao@windriver.com>=0A> Cc: Kumar=
 Gala <galak@gate.crashing.org>=0A> Cc: Michael Ellerman <michael@ellerman.=
id.au>=0A> Cc: Paul Mackerras <paulus@samba.org>=0A> Signed-off-by: Andrew =
Morton <akpm@linux-foundation.org>=0A> ---=0A> =0A>  drivers/edac/edac_devi=
ce.c |=A0 =A0 3 ++-=0A>  1 file changed, 2 insertions(+), 1 deletion(-)=0A>=
 =0A> diff -puN=0A> drivers/edac/amd8111_edac.c~edac-add-edac_device_alloc_=
index-cleanup=0A> drivers/edac/amd8111_edac.c=0A> diff -puN=0A> drivers/eda=
c/edac_core.h~edac-add-edac_device_alloc_index-cleanup=0A> drivers/edac/eda=
c_core.h=0A> diff -puN=0A> drivers/edac/edac_device.c~edac-add-edac_device_=
alloc_index-cleanup=0A> drivers/edac/edac_device.c=0A> ---=0A> a/drivers/ed=
ac/edac_device.c~edac-add-edac_device_alloc_index-cleanup=0A> +++ a/drivers=
/edac/edac_device.c=0A> @@ -37,7 +37,6 @@=0A> =A0 */=0A>  static DEFINE_MUT=
EX(device_ctls_mutex);=0A>  static LIST_HEAD(edac_device_list);=0A> -static=
 atomic_t device_indexes =3D ATOMIC_INIT(0);=0A>  =0A>  #ifdef CONFIG_EDAC_=
DEBUG=0A>  static void edac_device_dump_device(struct=0A> edac_device_ctl_i=
nfo *edac_dev)=0A> @@ -499,6 +498,8 @@ void=0A> edac_device_reset_delay_per=
iod(stru=0A> =A0 */=0A>  int edac_device_alloc_index(void)=0A>  {=0A> +=A0=
=A0=A0 static atomic_t device_indexes =3D=0A> ATOMIC_INIT(0);=0A> +=0A>  =
=A0=A0=A0 return=0A> atomic_inc_return(&device_indexes) - 1;=0A>  }=0A>  EX=
PORT_SYMBOL_GPL(edac_device_alloc_index);=0A> _=0A> =0A> 
