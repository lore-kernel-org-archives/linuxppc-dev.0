Return-Path: <grant.likely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EC9AB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 05:26:18 +1100 (EST)
Received: by iakh37 with SMTP id h37so1311845iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 11:26:15 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: linux-next: manual merge of the devicetree tree with the powerpc
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20120313160100.c8cc3fd2b3d1f485ef7e7954@canb.auug.org.au>
References: <20120313160100.c8cc3fd2b3d1f485ef7e7954@canb.auug.org.au>
Date: Tue, 13 Mar 2012 12:26:11 -0600
Message-Id: <20120313182612.0546D3E053B@localhost>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Mar 2012 16:01:00 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Grant,
> 
> Today's linux-next merge of the devicetree tree got a conflict in
> include/linux/of.h between commit eb740b5f3e65 ("powerpc/eeh: Introduce
> EEH device") from the powerpc tree and commit 0f22dd395fc4 ("of: Only
> compile OF_DYNAMIC on PowerPC pseries and iseries") from the devicetree
> tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --cc include/linux/of.h
> index bdb1c07,533603e..0000000
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@@ -75,14 -72,10 +75,17 @@@ struct of_phandle_args 
>   	uint32_t args[MAX_PHANDLE_ARGS];
>   };
>   
>  +#if defined(CONFIG_EEH)
>  +static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
>  +{
>  +	return dn->edev;
>  +}
>  +#endif

Ben, What is this?  I don't want the eeh_dev pointer in struct device_node.  Up to
now we've avoided putting any reverse references into device_nodes.  For everything
else we use a reverse lookup, particularly for devices, to avoid growing the
device_node for each new type of lookup.

g.
