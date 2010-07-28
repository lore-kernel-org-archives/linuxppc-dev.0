Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFAB6B6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 23:50:18 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6SDnSST015108
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 09:49:28 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6SDoEtr381182
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 09:50:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6SDoEQw008323
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 10:50:14 -0300
Message-ID: <4C503594.7040602@linux.vnet.ibm.com>
Date: Wed, 28 Jul 2010 08:50:12 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 6/8] v3 Update the node sysfs code
References: <4C451BF5.50304@austin.ibm.com> <4C451EAF.1080505@austin.ibm.com>
In-Reply-To: <4C451EAF.1080505@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2010 10:57 PM, Nathan Fontenot wrote:
> Index: linux-2.6/include/linux/node.h
> ===================================================================
> --- linux-2.6.orig/include/linux/node.h	2010-07-19 21:10:25.000000000 -0500
> +++ linux-2.6/include/linux/node.h	2010-07-19 21:13:11.000000000 -0500
> @@ -44,7 +44,8 @@ extern int register_cpu_under_node(unsig
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int register_mem_sect_under_node(struct memory_block *mem_blk,
>  						int nid);
> -extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk);
> +extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> +					   unsigned long phys_index);

You also need to update the inline definition of unregister_mem_sect_under_nodes
for the !CONFIG_NUMA case.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
