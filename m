Return-Path: <julia@diku.dk>
Date: Tue, 31 Aug 2010 18:08:19 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 1/7] drivers/macintosh/via-pmu-led.c: Add of_node_put to
	avoid memory leak
In-Reply-To: <4C7D247F.4060500@bfs.de>
Message-ID: <Pine.LNX.4.64.1008311807470.2668@ask.diku.dk>
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
	<1283075566-27441-2-git-send-email-julia@diku.dk>
	<4C7D247F.4060500@bfs.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 Aug 2010, walter harms wrote:

> 
> 
> Julia Lawall schrieb:
> > Add a call to of_node_put in the error handling code following a call to
> > of_find_node_by_path.
> > 
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @r exists@
> > local idexpression x;
> > expression E,E1;
> > statement S;
> > @@
> > 
> > *x = 
> > (of_find_node_by_path
> > |of_find_node_by_name
> > |of_find_node_by_phandle
> > |of_get_parent
> > |of_get_next_parent
> > |of_get_next_child
> > |of_find_compatible_node
> > |of_match_node
> > )(...);
> > ...
> > if (x == NULL) S
> > <... when != x = E
> > *if (...) {
> >   ... when != of_node_put(x)
> >       when != if (...) { ... of_node_put(x); ... }
> > (
> >   return <+...x...+>;
> > |
> > *  return ...;
> > )
> > }
> > ...>
> > of_node_put(x);
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> > 
> > ---
> >  drivers/macintosh/via-pmu-led.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
> > index d242976..19c3718 100644
> > --- a/drivers/macintosh/via-pmu-led.c
> > +++ b/drivers/macintosh/via-pmu-led.c
> > @@ -92,8 +92,10 @@ static int __init via_pmu_led_init(void)
> >  	if (dt == NULL)
> >  		return -ENODEV;
> >  	model = of_get_property(dt, "model", NULL);
> > -	if (model == NULL)
> > +	if (model == NULL) {
> > +		of_node_put(dt);
> >  		return -ENODEV;
> > +	}
> >  	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
> >  	    strncmp(model, "iBook", strlen("iBook")) != 0 &&
> >  	    strcmp(model, "PowerMac7,2") != 0 &&
> > 
> 
> is there any rule that says when to use strncmp ? it seems perfecly valid to use strcpy here
> (what is done in the last cmp).

Perhaps there are some characters after eg PowerBook that one doesn't want 
to compare with?

julia
