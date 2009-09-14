Return-Path: <pazke@centrinvest.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3B3EB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 16:51:11 +1000 (EST)
Received: from centrinvest.ru (centrinvest.ru [94.25.115.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73234DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 16:51:11 +1000 (EST)
From: "Andrey Panin" <pazke@centrinvest.ru>
Date: Mon, 14 Sep 2009 10:39:11 +0400
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/5] kernel handling of memory DLPAR
Message-ID: <20090914063911.GB13139@centrinvest.ru>
References: <4AAABC55.4070207@austin.ibm.com> <4AAABDBB.7010400@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AAABDBB.7010400@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 254, 09 11, 2009 at 04:14:35PM -0500, Nathan Fontenot wrote:
> This adds the capability to DLPAR add and remove memory from the kernel.  The
> patch extends the powerpc handling of memory_add_physaddr_to_nid(), which is
> called from the sysfs memory 'probe' file to first ensure that the memory
> has been added to the system.  This is done by creating a platform specific
> callout from the routine.  The pseries implementation of this handles the
> DLPAR work to add the memory to the system and update the device tree.
> 
> The patch also creates a pseries only 'release' sys file,
> /sys/devices/system/memory/release.  This file handles the DLPAR
> release of
> memory back to firmware and updating of the device-tree.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

> +static struct property *clone_property(struct property *old_prop)
> +{
> +	struct property *new_prop;
> +
> +	new_prop = kzalloc((sizeof *new_prop), GFP_KERNEL);
> +	if (!new_prop)
> +		return NULL;
> +
> +	new_prop->name = kzalloc(strlen(old_prop->name) + 1, GFP_KERNEL);
> +	new_prop->value = kzalloc(old_prop->length + 1, GFP_KERNEL);

Memory leak here. What if one kzalloc() succeeded and another failed ?

> +	if (!new_prop->name || !new_prop->value) {
> +		free_property(new_prop);
> +		return NULL;
> +	}
> +
> +	strcpy(new_prop->name, old_prop->name);
> +	memcpy(new_prop->value, old_prop->value, old_prop->length);
> +	new_prop->length = old_prop->length;
> +
> +	return new_prop;
> +}
