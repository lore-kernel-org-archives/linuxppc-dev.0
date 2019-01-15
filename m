Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E854C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:31:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B8920657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeGm/TwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B8920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43drq54P40zDqX7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:30:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="UeGm/TwQ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43drmt64DjzDqWL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 11:29:02 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A24820657;
 Tue, 15 Jan 2019 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547512140;
 bh=yypfHHv39pjqymrLz6VKVevFi6wpl/m+LFImi5MVFH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UeGm/TwQOIi+Cl9e3uz6kwsgm+EfQaZP1EZofUEY9RrZOOQWnHYYe6taoFgkEZnIQ
 wg4HiTtTBgsEmMhyQorFWgKIXSYFQrW4VCHDGnbh8mA0qmqEcvXr+qfeiBsbkD0hcA
 2XwrucHzJhXAJqqPAN64w/36NYqB6tWE57YLW1tY=
Date: Mon, 14 Jan 2019 18:28:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [RFC 5/6] powerpc/pci/hotplug: Use common drcinfo parsing
Message-ID: <20190115002857.GG33971@google.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214205120.16435.46952.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214205120.16435.46952.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 14, 2018 at 02:51:31PM -0600, Michael Bringmann wrote:
> The implementation of the pseries-specific drc info properties
> is currently implemented in pseries-specific and non-pseries-specific
> files.  This patch set uses a new implementation of the device-tree
> parsing code for the properties.
> 
> This patch refactors parsing of the pseries-specific drc-info properties
> out of rpaphp_core.c to use the common parser.  In the case where an
> architecture does not use these properties, an __weak copy of the
> function is provided with dummy return values.  Changes include creating
> appropriate callback functions and passing callback-specific data
> blocks into arch_find_drc_match.  All functions that were used just
> to support the previous parsing implementation have been moved.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

This is fine with me.  Any rpaphp_core.c maintainers want to comment?
Tyrel?

$ ./scripts/get_maintainer.pl -f drivers/pci/hotplug/rpaphp_core.c
Tyrel Datwyler <tyreld@linux.vnet.ibm.com> (supporter:IBM Power PCI Hotplug Driver for RPA-compliant...)
Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))

> ---
>  drivers/pci/hotplug/rpaphp_core.c |  232 ++++---------------------------------
>  1 file changed, 28 insertions(+), 204 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d35..9ad7384 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -154,182 +154,18 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
>  	return speed;
>  }
>  
> -static int get_children_props(struct device_node *dn, const int **drc_indexes,
> -		const int **drc_names, const int **drc_types,
> -		const int **drc_power_domains)
> -{
> -	const int *indexes, *names, *types, *domains;
> -
> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -	names = of_get_property(dn, "ibm,drc-names", NULL);
> -	types = of_get_property(dn, "ibm,drc-types", NULL);
> -	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
> -
> -	if (!indexes || !names || !types || !domains) {
> -		/* Slot does not have dynamically-removable children */
> -		return -EINVAL;
> -	}
> -	if (drc_indexes)
> -		*drc_indexes = indexes;
> -	if (drc_names)
> -		/* &drc_names[1] contains NULL terminated slot names */
> -		*drc_names = names;
> -	if (drc_types)
> -		/* &drc_types[1] contains NULL terminated slot types */
> -		*drc_types = types;
> -	if (drc_power_domains)
> -		*drc_power_domains = domains;
> -
> -	return 0;
> -}
> -
> -
>  /* Verify the existence of 'drc_name' and/or 'drc_type' within the
> - * current node.  First obtain it's my-drc-index property.  Next,
> - * obtain the DRC info from it's parent.  Use the my-drc-index for
> - * correlation, and obtain/validate the requested properties.
> + * current node.
>   */
>  
> -static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
> -				char *drc_type, unsigned int my_index)
> -{
> -	char *name_tmp, *type_tmp;
> -	const int *indexes, *names;
> -	const int *types, *domains;
> -	int i, rc;
> -
> -	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
> -	if (rc < 0) {
> -		return -EINVAL;
> -	}
> -
> -	name_tmp = (char *) &names[1];
> -	type_tmp = (char *) &types[1];
> -
> -	/* Iterate through parent properties, looking for my-drc-index */
> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
> -		if ((unsigned int) indexes[i + 1] == my_index)
> -			break;
> -
> -		name_tmp += (strlen(name_tmp) + 1);
> -		type_tmp += (strlen(type_tmp) + 1);
> -	}
> -
> -	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
> -	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
> -				char *drc_type, unsigned int my_index)
> -{
> -	struct property *info;
> -	unsigned int entries;
> -	struct of_drc_info drc;
> -	const __be32 *value;
> -	char cell_drc_name[MAX_DRC_NAME_LEN];
> -	int j, fndit;
> -
> -	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
> -	if (info == NULL)
> -		return -EINVAL;
> -
> -	value = of_prop_next_u32(info, NULL, &entries);
> -	if (!value)
> -		return -EINVAL;
> -
> -	for (j = 0; j < entries; j++) {
> -		of_read_drc_info_cell(&info, &value, &drc);
> -
> -		/* Should now know end of current entry */
> -
> -		if (my_index > drc.last_drc_index)
> -			continue;
> -
> -		fndit = 1;
> -		break;
> -	}
> -	/* Found it */
> -
> -	if (fndit)
> -		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
> -			my_index);
> -
> -	if (((drc_name == NULL) ||
> -	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
> -	    ((drc_type == NULL) ||
> -	     (drc_type && !strcmp(drc_type, drc.drc_type))))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
>  int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
>  			char *drc_type)
>  {
> -	const unsigned int *my_index;
> -
> -	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> -	if (!my_index) {
> -		/* Node isn't DLPAR/hotplug capable */
> -		return -EINVAL;
> -	}
> -
> -	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
> -		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
> -						*my_index);
> -	else
> -		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
> -						*my_index);
> +	return arch_find_drc_match(dn, NULL, drc_type, drc_name,
> +				true, false, NULL);
>  }
>  EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
>  
> -
> -static int is_php_type(char *drc_type)
> -{
> -	unsigned long value;
> -	char *endptr;
> -
> -	/* PCI Hotplug nodes have an integer for drc_type */
> -	value = simple_strtoul(drc_type, &endptr, 10);
> -	if (endptr == drc_type)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -/**
> - * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
> - * @dn: target &device_node
> - * @indexes: passed to get_children_props()
> - * @names: passed to get_children_props()
> - * @types: returned from get_children_props()
> - * @power_domains:
> - *
> - * This routine will return true only if the device node is
> - * a hotpluggable slot. This routine will return false
> - * for built-in pci slots (even when the built-in slots are
> - * dlparable.)
> - */
> -static int is_php_dn(struct device_node *dn, const int **indexes,
> -		const int **names, const int **types, const int **power_domains)
> -{
> -	const int *drc_types;
> -	int rc;
> -
> -	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
> -	if (rc < 0)
> -		return 0;
> -
> -	if (!is_php_type((char *) &drc_types[1]))
> -		return 0;
> -
> -	*types = drc_types;
> -	return 1;
> -}
> -
>  /**
>   * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
>   * @dn: device node of slot
> @@ -346,54 +182,42 @@ static int is_php_dn(struct device_node *dn, const int **indexes,
>   *
>   * To remove a slot, it suffices to call rpaphp_deregister_slot().
>   */
> -int rpaphp_add_slot(struct device_node *dn)
> +
> +static int rpaphp_add_slot_cb(struct device_node *dn,
> +			u32 drc_index, char *drc_name, char *drc_type,
> +			u32 drc_power_domain, void *data)
>  {
>  	struct slot *slot;
>  	int retval = 0;
> -	int i;
> -	const int *indexes, *names, *types, *power_domains;
> -	char *name, *type;
> -
> -	if (!dn->name || strcmp(dn->name, "pci"))
> -		return 0;
> -
> -	/* If this is not a hotplug slot, return without doing anything. */
> -	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
> -		return 0;
> -
> -	dbg("Entry %s: dn=%pOF\n", __func__, dn);
>  
> -	/* register PCI devices */
> -	name = (char *) &names[1];
> -	type = (char *) &types[1];
> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
> -		int index;
> +	slot = alloc_slot_struct(dn, drc_index, drc_name, drc_power_domain);
> +	if (!slot)
> +		return -ENOMEM;
>  
> -		index = be32_to_cpu(indexes[i + 1]);
> -		slot = alloc_slot_struct(dn, index, name,
> -					 be32_to_cpu(power_domains[i + 1]));
> -		if (!slot)
> -			return -ENOMEM;
> +	slot->type = simple_strtoul(drc_type, NULL, 10);
> +	if (retval)
> +		return -EINVAL;
>  
> -		slot->type = simple_strtoul(type, NULL, 10);
> +	dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
> +		drc_index, drc_name, drc_type);
>  
> -		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
> -				index, name, type);
> +	retval = rpaphp_enable_slot(slot);
> +	if (!retval)
> +		retval = rpaphp_register_slot(slot);
>  
> -		retval = rpaphp_enable_slot(slot);
> -		if (!retval)
> -			retval = rpaphp_register_slot(slot);
> +	if (retval)
> +		dealloc_slot_struct(slot);
>  
> -		if (retval)
> -			dealloc_slot_struct(slot);
> +	return retval;
> +}
>  
> -		name += strlen(name) + 1;
> -		type += strlen(type) + 1;
> -	}
> -	dbg("%s - Exit: rc[%d]\n", __func__, retval);
> +int rpaphp_add_slot(struct device_node *dn)
> +{
> +	if (!dn->name || strcmp(dn->name, "pci"))
> +		return 0;
>  
> -	/* XXX FIXME: reports a failure only if last entry in loop failed */
> -	return retval;
> +	return arch_find_drc_match(dn, rpaphp_add_slot_cb,
> +			NULL, NULL, false, true, NULL);
>  }
>  EXPORT_SYMBOL_GPL(rpaphp_add_slot);
>  
> 
