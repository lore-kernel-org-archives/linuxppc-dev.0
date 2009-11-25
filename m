Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19212.41387.37749.652776@cargo.ozlabs.ibm.com>
Date: Wed, 25 Nov 2009 14:16:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/3] Kernel DLPAR infrastructure
In-Reply-To: <4B0C8CE3.4010207@austin.ibm.com>
References: <4B0C8B45.6080804@austin.ibm.com> <4B0C8CE3.4010207@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot writes:

> This patch provides the kernel DLPAR infrastructure in a new filed named
> dlpar.c.  The functionality provided is for acquiring and releasing a resource
> from firmware and the parsing of information returned from the
> ibm,configure-connector rtas call.  Additionally this exports the pSeries
> reconfiguration notifier chain so that it can be invoked when device tree 
> updates are made.

Mostly looks great.

> +static struct device_node *derive_parent(const char *path)
> +{
> +	struct device_node *parent;
> +	char parent_path[128];
> +	int parent_path_len;
> +
> +	parent_path_len = strrchr(path, '/') - path + 1;
> +	strlcpy(parent_path, path, parent_path_len);

This looks a bit fragile if path could possibly not contain any '/' or
if the '/' is more than 128 characters from the start of path.  Please
fix this to check if strrchr returns NULL and to cope in some
reasonable fashion if the path happens to be very long.

> +#ifdef CONFIG_PROC_DEVICETREE
> +	ent = proc_mkdir(strrchr(dn->full_name, '/') + 1, dn->parent->pde);
> +	if (ent)
> +		proc_device_tree_add_node(dn, ent);

Also assumes that dn->full_name contains a '/'.  If for some reason it
couldn't possibly not contain a '/', put in a comment explaining that.

Thanks,
Paul.
