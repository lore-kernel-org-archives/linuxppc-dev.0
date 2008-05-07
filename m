Return-Path: <glikely@secretlab.ca>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 4C2FBDE46C
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:27:35 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so321097ugf.0
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 12:27:29 -0700 (PDT)
Message-ID: <fa686aa40805071227q11a9462fvc99945c725e945c0@mail.gmail.com>
Date: Wed, 7 May 2008 13:27:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] Add null pointer check to of_find_property
In-Reply-To: <1210187999-20274-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210187999-20274-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 7, 2008 at 1:19 PM, Timur Tabi <timur@freescale.com> wrote:
> Update function of_find_property() to return NULL if the device_node passed
>  to it is also NULL.  Otherwise, passing NULL will cause a null pointer
>  dereference.
>
>  Signed-off-by: Timur Tabi <timur@freescale.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

>  ---
>
>  This patch allows callers to do this:
>
>  np = of_find_compatible_node(...);
>  prop = of_get_property(np);
>  if (!prop)
>      goto error;
>
>  Today, we need a np==NULL check between the two of_ calls.  Some callers may
>  not care whether the node is missing or the property is missing.
>
>   drivers/of/base.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
>  diff --git a/drivers/of/base.c b/drivers/of/base.c
>  index 9bd7c4a..23ffb7c 100644
>  --- a/drivers/of/base.c
>  +++ b/drivers/of/base.c
>  @@ -65,6 +65,9 @@ struct property *of_find_property(const struct device_node *np,
>   {
>         struct property *pp;
>
>  +       if (!np)
>  +               return NULL;
>  +
>         read_lock(&devtree_lock);
>         for (pp = np->properties; pp != 0; pp = pp->next) {
>                 if (of_prop_cmp(pp->name, name) == 0) {
>  --
>  1.5.5
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
