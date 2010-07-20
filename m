Return-Path: <dave@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0BD71007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 05:18:08 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6KJ4aR6026464
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:04:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6KJI4ea508070
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:18:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6KJI3pH000653
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:18:04 -0400
Subject: Re: [PATCH 4/8] v3 Allow memory_block to span multiple memory sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C451E1C.8070907@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451E1C.8070907@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 20 Jul 2010 12:18:01 -0700
Message-ID: <1279653481.9785.4.camel@nimitz>
Mime-Version: 1.0
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

On Mon, 2010-07-19 at 22:55 -0500, Nathan Fontenot wrote:
> +static int add_memory_section(int nid, struct mem_section *section,
> +                       unsigned long state, enum mem_add_context context)
> +{
> +       struct memory_block *mem;
> +       int ret = 0;
> +
> +       mem = find_memory_block(section);
> +       if (mem) {
> +               atomic_inc(&mem->section_count);
> +               kobject_put(&mem->sysdev.kobj);
> +       } else
> +               ret = init_memory_block(&mem, section, state);
> +
>         if (!ret) {
> -               if (context == HOTPLUG)
> +               if (context == HOTPLUG &&
> +                   atomic_read(&mem->section_count) == sections_per_block)
>                         ret = register_mem_sect_under_node(mem, nid);
>         } 

I think the atomic_inc() can race with the atomic_dec_and_test() in
remove_memory_block().

Thread 1 does:

	mem = find_memory_block(section);

Thread 2 does 

	atomic_dec_and_test(&mem->section_count);

and destroys the memory block,  Thread 1 runs again:
	
       if (mem) {
               atomic_inc(&mem->section_count);
               kobject_put(&mem->sysdev.kobj);
       } else

but now mem got destroyed by Thread 2.  You probably need to change
find_memory_block() to itself take a reference, and to use
atomic_inc_unless().

-- Dave
