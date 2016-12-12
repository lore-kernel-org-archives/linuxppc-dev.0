Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcn7q2knxzDt0L
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:39:18 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCFYWc8023103
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:39:15 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 279swamjqs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:39:15 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 08:39:14 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9569019D8053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 08:38:31 -0700 (MST)
Subject: Re: [PATCH V9 6/8] hotplug/drc-info: Add code to search new devtree
 properties
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
 <148109492041.193207.5015385765773698832.stgit@powerkvm6.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 09:39:11 -0600
MIME-Version: 1.0
In-Reply-To: <148109492041.193207.5015385765773698832.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <fa8d0e6d-a2a4-431d-0da0-22a512d028e9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2016 01:15 AM, Michael Bringmann wrote:
> rpadlpar_core.c: Provide parallel routines to search the older device-
> tree properties ("ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
> and "ibm,drc-power-domains"), or the new property "ibm,drc-info".
> 
> The interface to examine the DRC information is changed from a "get"
> function that returns values for local verification elsewhere, to a
> "check" function that validates the 'name' and/or 'type' of a device
> node.  This update hides the format of the underlying device-tree
> properties, and concentrates the value checks into a single function
> without requiring the user to verify whether a search was successful.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> Changes in V9:
>   -- Remove unnecessary code from rpaphp_check_drc_props_v2()
> ---
>  drivers/pci/hotplug/rpadlpar_core.c |   13 ++--
>  drivers/pci/hotplug/rpaphp.h        |    4 +
>  drivers/pci/hotplug/rpaphp_core.c   |  108 +++++++++++++++++++++++++++--------
>  3 files changed, 90 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index dc67f39..bea9723 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -27,6 +27,7 @@
>  #include <linux/mutex.h>
>  #include <asm/rtas.h>
>  #include <asm/vio.h>
> +#include <linux/firmware.h>
> 
>  #include "../pci.h"
>  #include "rpaphp.h"
> @@ -44,15 +45,14 @@ static struct device_node *find_vio_slot_node(char *drc_name)
>  {
>  	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
>  	struct device_node *dn = NULL;
> -	char *name;
>  	int rc;
> 
>  	if (!parent)
>  		return NULL;
> 
>  	while ((dn = of_get_next_child(parent, dn))) {
> -		rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
> -		if ((rc == 0) && (!strcmp(drc_name, name)))
> +		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
> +		if (rc == 0)
>  			break;
>  	}
> 
> @@ -64,15 +64,12 @@ static struct device_node *find_php_slot_pci_node(char *drc_name,
>  						  char *drc_type)
>  {
>  	struct device_node *np = NULL;
> -	char *name;
> -	char *type;
>  	int rc;
> 
>  	while ((np = of_find_node_by_name(np, "pci"))) {
> -		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
> +		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
>  		if (rc == 0)
> -			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
> -				break;
> +			break;
>  	}
> 
>  	return np;
> diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
> index 7db024e..8db5f2e 100644
> --- a/drivers/pci/hotplug/rpaphp.h
> +++ b/drivers/pci/hotplug/rpaphp.h
> @@ -91,8 +91,8 @@ struct slot {
> 
>  /* rpaphp_core.c */
>  int rpaphp_add_slot(struct device_node *dn);
> -int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
> -		char **drc_name, char **drc_type, int *drc_power_domain);
> +int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
> +		char *drc_type);
> 
>  /* rpaphp_slot.c */
>  void dealloc_slot_struct(struct slot *slot);
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 8d13202..f9c9ce5 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -30,6 +30,7 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/vmalloc.h>
> +#include <asm/firmware.h>
>  #include <asm/eeh.h>       /* for eeh_add_device() */
>  #include <asm/rtas.h>		/* rtas_call */
>  #include <asm/pci-bridge.h>	/* for pci_controller */
> @@ -196,25 +197,21 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
>  	return 0;
>  }
> 
> -/* To get the DRC props describing the current node, first obtain it's
> - * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
> - * the my-drc-index for correlation, and obtain the requested properties.
> +
> +/* Verify the existence of 'drc_name' and/or 'drc_type' within the
> + * current node.  First obtain it's my-drc-index property.  Next,
> + * obtain the DRC info from it's parent.  Use the my-drc-index for
> + * correlation, and obtain/validate the requested properties.
>   */
> -int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
> -		char **drc_name, char **drc_type, int *drc_power_domain)
> +
> +static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
> +				char *drc_type, unsigned int my_index)
>  {
> +	char *name_tmp, *type_tmp;
>  	const int *indexes, *names;
>  	const int *types, *domains;
> -	const unsigned int *my_index;
> -	char *name_tmp, *type_tmp;
>  	int i, rc;
> 
> -	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> -	if (!my_index) {
> -		/* Node isn't DLPAR/hotplug capable */
> -		return -EINVAL;
> -	}
> -
>  	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
>  	if (rc < 0) {
>  		return -EINVAL;
> @@ -225,24 +222,85 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
> 
>  	/* Iterate through parent properties, looking for my-drc-index */
>  	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
> -		if ((unsigned int) indexes[i + 1] == *my_index) {
> -			if (drc_name)
> -				*drc_name = name_tmp;
> -			if (drc_type)
> -				*drc_type = type_tmp;
> -			if (drc_index)
> -				*drc_index = be32_to_cpu(*my_index);
> -			if (drc_power_domain)
> -				*drc_power_domain = be32_to_cpu(domains[i+1]);
> -			return 0;
> -		}
> +		if ((unsigned int) indexes[i + 1] == my_index)
> +			break;
> +
>  		name_tmp += (strlen(name_tmp) + 1);
>  		type_tmp += (strlen(type_tmp) + 1);
>  	}
> 
> +	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
> +	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
> +		return 0;
> +
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
> +
> +static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
> +				char *drc_type, unsigned int my_index)
> +{
> +	int *info = (int *)dn;
> +	unsigned int entries;
> +	unsigned long int drc_index_start = 0, last_drc_index = 0;
> +	unsigned long int num_sequential_elems = 0, sequential_inc = 0;
> +	char *name_tmp, *type_tmp;
> +	int j;
> +
> +	info = (int *)of_get_property(dn->parent, "ibm,drc-info", NULL);
> +	if (info == NULL)
> +		return -EINVAL;
> +
> +	entries = be32_to_cpu(*info++);
> +
> +	for (j = 0; j < entries; j++) {
> +		read_one_drc_info(&info, &type_tmp, &name_tmp,
> +				&drc_index_start, &num_sequential_elems,
> +				&sequential_inc, &last_drc_index);
> +
> +		/* Should now know end of current entry */
> +
> +		last_drc_index = drc_index_start +
> +				((num_sequential_elems-1)*sequential_inc);
> +
> +		WARN_ON((my_index < drc_index_start) ||
> +			(((my_index-drc_index_start)%sequential_inc) != 0));
> +
> +		if (my_index > last_drc_index)
> +			continue;
> +
> +		break;
> +	}
> +	/* Found it */
> +
> +	if (((drc_name == NULL) ||
> +	     (drc_name && !strcmp(drc_name, name_tmp))) &&
> +	    ((drc_type == NULL) ||
> +	     (drc_type && !strcmp(drc_type, type_tmp))))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
> +			char *drc_type)
> +{
> +	const unsigned int *my_index;
> +
> +	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> +	if (!my_index) {
> +		/* Node isn't DLPAR/hotplug capable */
> +		return -EINVAL;
> +	}
> +
> +	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
> +		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
> +						*my_index);
> +	else
> +		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
> +						*my_index);
> +}
> +EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
> +
> 
>  static int is_php_type(char *drc_type)
>  {
> 
