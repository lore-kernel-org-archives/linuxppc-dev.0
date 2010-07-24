Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id B2158B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 25 Jul 2010 05:34:05 +1000 (EST)
Received: by pwi6 with SMTP id 6so5095526pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 12:34:03 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
References: <1279910564-17887-1-git-send-email-stuart.yoder@freescale.com>
In-Reply-To: <1279910564-17887-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D=5Bv2=5D_fix_of=5Fflat=5Fdt=5Fis=5Fcompa?=
	=?US-ASCII?Q?tible_to_match_the_full_compatible=09string?=
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 24 Jul 2010 13:34:29 -0600
To: Stuart Yoder <stuart.yoder@freescale.com>,linuxppc-dev@lists.ozlabs.org
Message-ID: <c1d83b47-1185-4b51-b35f-10b914e1515e@email.android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



"Stuart Yoder" <stuart.yoder@freescale.com> wrote:

>From: Stuart Yoder <stuart.yoder@freescale.com>
>
>With the previous string comparison, a device tree
>compatible of "foo-bar" would match as compatible
>with a driver looking for "foo".
>
>Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

Hi Stewart. 

Patch looks good.  I'll test it this afternoon.

However, please remember to cc: me and devicetree-discuss if you want patches picked up remotely quickly (I know, I'm slow anyway, but I'm even slower when I don't see something.  I only came across this one by chance.)

g.

>---
> drivers/of/fdt.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>index dee4fb5..28c0c2b 100644
>--- a/drivers/of/fdt.c
>+++ b/drivers/of/fdt.c
>@@ -169,7 +169,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> 	if (cp == NULL)
> 		return 0;
> 	while (cplen > 0) {
>-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
>+		if (!strcasecmp(cp, compat))
> 			return 1;
> 		l = strlen(cp) + 1;
> 		cp += l;
>-- 
>1.6.2.5
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
