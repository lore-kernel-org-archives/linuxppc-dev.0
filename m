Return-Path: <julia@diku.dk>
Date: Mon, 22 Aug 2011 14:31:46 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 2/2] arch/powerpc/platforms/powermac/setup.c: add missing
	of_node_put
In-Reply-To: <4E522AD0.7030907@bfs.de>
Message-ID: <Pine.LNX.4.64.1108221430320.10948@ask.diku.dk>
References: <1313943001-12884-2-git-send-email-julia@diku.dk>
	<4E522AD0.7030907@bfs.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 22 Aug 2011, walter harms wrote:

> 
> 
> Am 21.08.2011 18:10, schrieb Julia Lawall:
> > From: Julia Lawall <julia@diku.dk>
> > 
> > np is initialized to the result of calling a function that calls
> > of_node_get, so of_node_put should be called before the pointer is dropped.
> > 
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @@
> > expression e,e1,e2;
> > @@
> > 
> > * e = \(of_find_node_by_type\|of_find_node_by_name\)(...)
> >   ... when != of_node_put(e)
> >       when != true e == NULL
> >       when != e2 = e
> >   e = e1
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> > 
> > ---
> >  arch/powerpc/platforms/powermac/setup.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> > index 96580b1..970ea1d 100644
> > --- a/arch/powerpc/platforms/powermac/setup.c
> > +++ b/arch/powerpc/platforms/powermac/setup.c
> > @@ -494,11 +494,15 @@ static int __init pmac_declare_of_platform_devices(void)
> >  		return -1;
> >  
> >  	np = of_find_node_by_name(NULL, "valkyrie");
> > -	if (np)
> > +	if (np) {
> >  		of_platform_device_create(np, "valkyrie", NULL);
> > +		of_node_put(np);
> > +	}
> >  	np = of_find_node_by_name(NULL, "platinum");
> > -	if (np)
> > +	if (np) {
> >  		of_platform_device_create(np, "platinum", NULL);
> > +		of_node_put(np);
> > +	}
> >          np = of_find_node_by_type(NULL, "smu");
> >          if (np) {
> >  		of_platform_device_create(np, "smu", NULL);
> > 
> 
> 
> hi,
> it seems save to call of_node_put(np) with np==NULL, i assume the same is true
> for of_platform_device_create().
> 
> so the code collapses to:
> 
> _test_node(char *name)
> {
>  struct device_node *np;
>  np = of_find_node_by_name(NULL, name);
>  of_platform_device_create(np, name, NULL);
>  of_node_put(np);
>  return NULL?:0:1;
> }
> 
> maybe there is already something like find_node() ?

of_platform_device_create is not much used, and one might want to use it 
with other functions than of_find_node_by_name, as indeed is done here.  
Is the problem just a missing else between the calls?  Is it certain that 
all of the cases are disjoint?

julia
