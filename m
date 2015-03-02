Return-Path: <cyrilbur@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E8781A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 16:20:35 +1100 (AEDT)
Received: by pdjz10 with SMTP id z10so36680941pdj.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2015 21:20:33 -0800 (PST)
Message-ID: <1425273624.2919.47.camel@cyril>
Subject: Re: [PATCH 2/3] powerpc/pseries: Little endian fixes for post
 mobility device tree update
From: Cyril Bur <cyrilbur@gmail.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 02 Mar 2015 16:20:24 +1100
In-Reply-To: <1425090283-27694-3-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-3-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
> We currently use the device tree update code in the kernel after resuming
> from a suspend operation to re-sync the kernels view of the device tree with
> that of the hypervisor. The code as it stands is not endian safe as it relies
> on parsing buffers returned by RTAS calls that thusly contains data in big
> endian format.
> 
> This patch annotates variables and structure members with __be types as well
> as performing necessary byte swaps to cpu endian for data that needs to be
> parsed.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/mobility.c | 36 ++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 29e4f04..0b1f70e 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -25,10 +25,10 @@
>  static struct kobject *mobility_kobj;
>  
>  struct update_props_workarea {
> -	u32 phandle;
> -	u32 state;
> -	u64 reserved;
> -	u32 nprops;
> +	__be32 phandle;
> +	__be32 state;
> +	__be64 reserved;
> +	__be32 nprops;
>  } __packed;
>  
>  #define NODE_ACTION_MASK	0xff000000
> @@ -127,7 +127,7 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
>  	return 0;
>  }
>  
> -static int update_dt_node(u32 phandle, s32 scope)
> +static int update_dt_node(__be32 phandle, s32 scope)
>  {

On line 153 of this function:
   dn = of_find_node_by_phandle(phandle);

You're passing a __be32 to device tree code, if we can treat the phandle
as a opaque value returned to us from the rtas call and pass it around
like that then all good.
Its also hard to be sure if these need to be BE and have always been
that way because we've always run BE so they've never actually wanted
CPU endian its just that CPU endian has always been BE (I think I
started rambling...)

Just want to check that *not* converting them is done on purpose.

And having read on, I'm assuming the answer is yes since this
observation is true for your changes which affect:
	delete_dt_node()
	update_dt_node()
        add_dt_node()
Worth noting that you didn't change the definition of delete_dt_node()

I'll have a look once you address the non compiling in patch 1/3 (I'm
getting blocked the unused var because somehow Werror is on, odd it
didn't trip you up) but I also suspect this will have sparse go a bit
nuts. 
I wonder if there is a nice way of shutting sparse up.

>  	struct update_props_workarea *upwa;
>  	struct device_node *dn;
> @@ -136,6 +136,7 @@ static int update_dt_node(u32 phandle, s32 scope)
>  	char *prop_data;
>  	char *rtas_buf;
>  	int update_properties_token;
> +	u32 nprops;
>  	u32 vd;
>  
>  	update_properties_token = rtas_token("ibm,update-properties");
> @@ -162,6 +163,7 @@ static int update_dt_node(u32 phandle, s32 scope)
>  			break;
>  
>  		prop_data = rtas_buf + sizeof(*upwa);
> +		nprops = be32_to_cpu(upwa->nprops);
>  
>  		/* On the first call to ibm,update-properties for a node the
>  		 * the first property value descriptor contains an empty
> @@ -170,17 +172,17 @@ static int update_dt_node(u32 phandle, s32 scope)
>  		 */
>  		if (*prop_data == 0) {
>  			prop_data++;
> -			vd = *(u32 *)prop_data;
> +			vd = be32_to_cpu(*(__be32 *)prop_data);
>  			prop_data += vd + sizeof(vd);
> -			upwa->nprops--;
> +			nprops--;
>  		}
>  
> -		for (i = 0; i < upwa->nprops; i++) {
> +		for (i = 0; i < nprops; i++) {
>  			char *prop_name;
>  
>  			prop_name = prop_data;
>  			prop_data += strlen(prop_name) + 1;
> -			vd = *(u32 *)prop_data;
> +			vd = be32_to_cpu(*(__be32 *)prop_data);
>  			prop_data += sizeof(vd);
>  
>  			switch (vd) {
> @@ -212,7 +214,7 @@ static int update_dt_node(u32 phandle, s32 scope)
>  	return 0;
>  }
>  
> -static int add_dt_node(u32 parent_phandle, u32 drc_index)
> +static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>  {
>  	struct device_node *dn;
>  	struct device_node *parent_dn;
> @@ -237,7 +239,7 @@ static int add_dt_node(u32 parent_phandle, u32 drc_index)
>  int pseries_devicetree_update(s32 scope)
>  {
>  	char *rtas_buf;
> -	u32 *data;
> +	__be32 *data;
>  	int update_nodes_token;
>  	int rc;
>  
> @@ -254,17 +256,17 @@ int pseries_devicetree_update(s32 scope)
>  		if (rc && rc != 1)
>  			break;
>  
> -		data = (u32 *)rtas_buf + 4;
> -		while (*data & NODE_ACTION_MASK) {
> +		data = (__be32 *)rtas_buf + 4;
> +		while (be32_to_cpu(*data) & NODE_ACTION_MASK) {
>  			int i;
> -			u32 action = *data & NODE_ACTION_MASK;
> -			int node_count = *data & NODE_COUNT_MASK;
> +			u32 action = be32_to_cpu(*data) & NODE_ACTION_MASK;
> +			u32 node_count = be32_to_cpu(*data) & NODE_COUNT_MASK;
>  
>  			data++;
>  
>  			for (i = 0; i < node_count; i++) {
> -				u32 phandle = *data++;
> -				u32 drc_index;
> +				__be32 phandle = *data++;
> +				__be32 drc_index;
>  
>  				switch (action) {
>  				case DELETE_DT_NODE:

The patch looks good, no nonsense endian fixing. 
Worth noting that it leaves existing bugs in place, which is fine, I'll
rebase my patches which address endian and bugs on top of these so as to
address the bugs.
