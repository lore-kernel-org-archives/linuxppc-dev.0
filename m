Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D5384DDF0B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:46:32 +1100 (EST)
Date: Mon, 4 Feb 2008 16:46:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] [POWERPC] qe_lib: fix few fluffy negligences (was: Re: [PATCH
	1/5] [POWERPC] qe_lib and users: get rid of most device_types
	and model)
Message-ID: <20080204134617.GA10377@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124153959.GA23246@localhost.localdomain>
	<20080205001318.5fbc60fa.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080205001318.5fbc60fa.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 05, 2008 at 12:13:18AM +1100, Stephen Rothwell wrote:
> Hi Anton,
> 
> I know this is late, but a couple of comments anyway.
> 
> On Thu, 24 Jan 2008 18:39:59 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> > @@ -65,17 +65,22 @@ static phys_addr_t qebase = -1;
> >  phys_addr_t get_qe_base(void)
> >  {
> >  	struct device_node *qe;
> > +	unsigned int size;
> > +	const void *prop;
> >  
> >  	if (qebase != -1)
> >  		return qebase;
> >  
> > -	qe = of_find_node_by_type(NULL, "qe");
> > -	if (qe) {
> > -		unsigned int size;
> > -		const void *prop = of_get_property(qe, "reg", &size);
> > -		qebase = of_translate_address(qe, prop);
> > -		of_node_put(qe);
> > -	};
> > +	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
> > +	if (!qe) {
> > +		qe = of_find_node_by_type(NULL, "qe");
> > +		if (!qe)
> > +			return qebase;
> > +	}
> > +
> > +	prop = of_get_property(qe, "reg", &size);
> > +	qebase = of_translate_address(qe, prop);
> 
> If you don't care about the returned length (argument three to
> of_get_property), you can just pass NULL (and dispense with "size").
> Also, what happens if prop is NULL?

All this was in the old code already, I just didn't fix that.

> > @@ -153,16 +158,26 @@ static unsigned int brg_clk = 0;
> >  unsigned int get_brg_clk(void)
> >  {
> >  	struct device_node *qe;
> > +	unsigned int size;
> > +	const u32 *prop;
> > +
> >  	if (brg_clk)
> >  		return brg_clk;
> >  
> > -	qe = of_find_node_by_type(NULL, "qe");
> > -	if (qe) {
> > -		unsigned int size;
> > -		const u32 *prop = of_get_property(qe, "brg-frequency", &size);
> > -		brg_clk = *prop;
> > -		of_node_put(qe);
> > -	};
> > +	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
> > +	if (!qe) {
> > +		qe = of_find_node_by_type(NULL, "qe");
> > +		if (!qe)
> > +			return brg_clk;
> > +	}
> > +
> > +	prop = of_get_property(qe, "brg-frequency", &size);
> > +	if (!prop || size != sizeof(*prop))
> > +		return brg_clk;
> 
> You need an of_node_put(qe) before the return ...

This is new. :-) Thanks.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] qe_lib: fix few fluffy negligences

One is intoduced by me (of_node_put() absence) and another was
present already (not checking for NULL).

Found by Stephen Rothwell.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 5ef844d..6efbd5e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -66,7 +66,7 @@ phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
 	unsigned int size;
-	const void *prop;
+	const u32 *prop;
 
 	if (qebase != -1)
 		return qebase;
@@ -79,7 +79,8 @@ phys_addr_t get_qe_base(void)
 	}
 
 	prop = of_get_property(qe, "reg", &size);
-	qebase = of_translate_address(qe, prop);
+	if (prop && size >= sizeof(*prop))
+		qebase = of_translate_address(qe, prop);
 	of_node_put(qe);
 
 	return qebase;
@@ -172,10 +173,9 @@ unsigned int get_brg_clk(void)
 	}
 
 	prop = of_get_property(qe, "brg-frequency", &size);
-	if (!prop || size != sizeof(*prop))
-		return brg_clk;
+	if (prop && size == sizeof(*prop))
+		brg_clk = *prop;
 
-	brg_clk = *prop;
 	of_node_put(qe);
 
 	return brg_clk;
-- 
1.5.2.2
