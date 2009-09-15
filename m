Return-Path: <brking@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F2F6DB7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:49:00 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F04DDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 00:49:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FEg04n024658
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:42:00 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FEmvnS230220
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:48:57 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FEmtoo024351
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:48:57 -0400
Message-ID: <4AAFA952.3050204@linux.vnet.ibm.com>
Date: Tue, 15 Sep 2009 09:48:50 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/5] kernel handling of CPU DLPAR
References: <4AAABC55.4070207@austin.ibm.com> <4AAABDF5.4090604@austin.ibm.com>
In-Reply-To: <4AAABDF5.4090604@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot wrote:
> +static ssize_t cpu_probe_store(struct class *class, const char *buf,
> +                   size_t count)
> +{
> +    struct device_node *dn;
> +    u32 drc_index;
> +    char *cpu_name;
> +    int rc;
> +
> +    drc_index = simple_strtoull(buf, NULL, 0);

Can just use simple_strtoul here instead.

> +    if (!drc_index)
> +        return -EINVAL;
> +
> +    rc = acquire_drc(drc_index);
> +    if (rc)
> +        return rc;
> +
> +    dn = configure_connector(drc_index);
> +    if (!dn) {
> +        release_drc(drc_index);
> +        return rc;
> +    }
> +
> +    /* fixup dn name */
> +    cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
> +               GFP_KERNEL);
> +    sprintf(cpu_name, "/cpus/%s", dn->full_name);
> +    kfree(dn->full_name);
> +    dn->full_name = cpu_name;
> +
> +    rc = add_device_tree_nodes(dn);
> +    if (rc)
> +        release_drc(drc_index);
> +
> +    return rc ? rc : count;
> +}
> +


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
