Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A65922C010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:53:51 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:42:41 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 96FA62CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:53:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDbrUk3801214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:37:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JDrl6q016985
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:53:48 +1000
Message-ID: <52122369.2030903@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:53:45 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/8] powerpc/pseries: make dlpar_configure_connector parent
 node aware
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-7-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-7-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2013 12:23 AM, Tyrel Datwyler wrote:
> Currently the device nodes created in the device subtree returned by a call to
> dlpar_configure_connector are all named in the root node. This is because the
> the node name in the work area returned by ibm,configure-connector rtas call
> only contains the node name and not the entire node path. Passing the parent
> node where the new subtree will be created to dlpar_configure_connector allows
> the correct node path to be prefixed in the full_name field.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/dlpar.c    | 55 ++++++++++++++++---------------
>  arch/powerpc/platforms/pseries/mobility.c | 11 +++----
>  arch/powerpc/platforms/pseries/pseries.h  |  2 +-
>  3 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index c855233..4ea667d 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -63,21 +63,24 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
>  	return prop;
>  }
>  
> -static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa)
> +static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
> +					       const char *path)
>  {
>  	struct device_node *dn;
>  	char *name;
>  
> +	/* If parent node path is "/" advance path to NULL terminator to
> +	 * prevent double leading slashs in full_name.
> +	 */
> +	if (!path[1])
> +		path++;
> +
>  	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
>  	if (!dn)
>  		return NULL;
>  
> -	/* The configure connector reported name does not contain a
> -	 * preceding '/', so we allocate a buffer large enough to
> -	 * prepend this to the full_name.
> -	 */
>  	name = (char *)ccwa + ccwa->name_offset;
> -	dn->full_name = kasprintf(GFP_KERNEL, "/%s", name);
> +	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
>  	if (!dn->full_name) {
>  		kfree(dn);
>  		return NULL;
> @@ -123,7 +126,8 @@ void dlpar_free_cc_nodes(struct device_node *dn)
>  #define CALL_AGAIN	-2
>  #define ERR_CFG_USE     -9003
>  
> -struct device_node *dlpar_configure_connector(u32 drc_index)
> +struct device_node *dlpar_configure_connector(u32 drc_index,
> +					      struct device_node *parent)
>  {
>  	struct device_node *dn;
>  	struct device_node *first_dn = NULL;
> @@ -132,6 +136,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index)
>  	struct property *last_property = NULL;
>  	struct cc_workarea *ccwa;
>  	char *data_buf;
> +	const char *parent_path = parent->full_name;
>  	int cc_token;
>  	int rc = -1;
>  
> @@ -165,7 +170,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index)
>  			break;
>  
>  		case NEXT_SIBLING:
> -			dn = dlpar_parse_cc_node(ccwa);
> +			dn = dlpar_parse_cc_node(ccwa, parent_path);
>  			if (!dn)
>  				goto cc_error;
>  
> @@ -175,13 +180,17 @@ struct device_node *dlpar_configure_connector(u32 drc_index)
>  			break;
>  
>  		case NEXT_CHILD:
> -			dn = dlpar_parse_cc_node(ccwa);
> +			if (first_dn)
> +				parent_path = last_dn->full_name;
> +
> +			dn = dlpar_parse_cc_node(ccwa, parent_path);
>  			if (!dn)
>  				goto cc_error;
>  
> -			if (!first_dn)
> +			if (!first_dn) {
> +				dn->parent = parent;
>  				first_dn = dn;
> -			else {
> +			} else {
>  				dn->parent = last_dn;
>  				if (last_dn)
>  					last_dn->child = dn;
> @@ -205,6 +214,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index)
>  
>  		case PREV_PARENT:
>  			last_dn = last_dn->parent;
> +			parent_path = last_dn->parent->full_name;
>  			break;
>  
>  		case CALL_AGAIN:
> @@ -383,9 +393,8 @@ out:
>  
>  static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  {
> -	struct device_node *dn;
> +	struct device_node *dn, *parent;
>  	unsigned long drc_index;
> -	char *cpu_name;
>  	int rc;
>  
>  	cpu_hotplug_driver_lock();
> @@ -395,25 +404,19 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  		goto out;
>  	}
>  
> -	dn = dlpar_configure_connector(drc_index);
> -	if (!dn) {
> -		rc = -EINVAL;
> +	parent = of_find_node_by_path("/cpus");
> +	if (!parent) {
> +		rc = -ENODEV;
>  		goto out;
>  	}
>  
> -	/* configure-connector reports cpus as living in the base
> -	 * directory of the device tree.  CPUs actually live in the
> -	 * cpus directory so we need to fixup the full_name.
> -	 */
> -	cpu_name = kasprintf(GFP_KERNEL, "/cpus%s", dn->full_name);
> -	if (!cpu_name) {
> -		dlpar_free_cc_nodes(dn);
> -		rc = -ENOMEM;
> +	dn = dlpar_configure_connector(drc_index, parent);
> +	if (!dn) {
> +		rc = -EINVAL;
>  		goto out;
>  	}
>  
> -	kfree(dn->full_name);
> -	dn->full_name = cpu_name;
> +	of_node_put(parent);
>  
>  	rc = dlpar_acquire_drc(drc_index);
>  	if (rc) {
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index ed5426f..ff102e2 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -216,17 +216,14 @@ static int add_dt_node(u32 parent_phandle, u32 drc_index)
>  	struct device_node *parent_dn;
>  	int rc;
>  
> -	dn = dlpar_configure_connector(drc_index);
> -	if (!dn)
> +	parent_dn = of_find_node_by_phandle(parent_phandle);
> +	if (!parent_dn)
>  		return -ENOENT;
>  
> -	parent_dn = of_find_node_by_phandle(parent_phandle);
> -	if (!parent_dn) {
> -		dlpar_free_cc_nodes(dn);
> +	dn = dlpar_configure_connector(drc_index, parent_dn);
> +	if (!dn)
>  		return -ENOENT;
> -	}
>  
> -	dn->parent = parent_dn;
>  	rc = dlpar_attach_node(dn);
>  	if (rc)
>  		dlpar_free_cc_nodes(dn);
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index c2a3a25..defb3c9 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -56,7 +56,7 @@ extern void hvc_vio_init_early(void);
>  /* Dynamic logical Partitioning/Mobility */
>  extern void dlpar_free_cc_nodes(struct device_node *);
>  extern void dlpar_free_cc_property(struct property *);
> -extern struct device_node *dlpar_configure_connector(u32);
> +extern struct device_node *dlpar_configure_connector(u32, struct device_node *);
>  extern int dlpar_attach_node(struct device_node *);
>  extern int dlpar_detach_node(struct device_node *);
>  
> 
