Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67C951A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 07:03:03 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 13:03:01 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 135ED1FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:51:08 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OK2v0K30408824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 20:02:57 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OK2vv6016700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 15:02:57 -0500
Received: from [9.41.250.246] (manoj.austin.ibm.com [9.41.250.246])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1OK2n9w015363
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 15:02:50 -0500
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 14/18] cxl: Support to flash a new image on the adapter
 from a guest
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CE0C7E.7090001@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 14:03:10 -0600
MIME-Version: 1.0
In-Reply-To: <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred, Christophe:

See comments below.

--
Manoj Kumar


On 2/23/2016 10:21 AM, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> +#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3 (dedicated/master/shared) */

Where does this limit of 4 AFUs come from?
Is this related to CXL_MAX_SLICES?
Should this be a computed value, in case the number of AFUs/slices
is increased at a future date?

> +static int update_node(__be32 phandle, s32 scope)
> +{
> +	struct update_props_workarea *upwa;
> +	struct device_node *dn;
> +	int i, rc, ret;
> +	char *prop_data;
> +	char *buf;
> +	int token;
> +	u32 nprops;
> +	u32 vd;
> +
> +	token = rtas_token("ibm,update-properties");
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return -EINVAL;
> +
> +	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	memset(buf, 0, RTAS_DATA_BUF_SIZE);

memset(0) after kzalloc() is redundant.


> +static int update_devicetree(struct cxl *adapter, s32 scope)
> +{
> +	struct update_nodes_workarea *unwa;
> +	u32 action, node_count;
> +	int token, rc, i;
> +	__be32 *data, drc_index, phandle;
> +	char *buf;
> +
> +	token = rtas_token("ibm,update-nodes");
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return -EINVAL;
> +
> +	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	memset(buf, 0, RTAS_DATA_BUF_SIZE);

Same as above
