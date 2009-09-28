Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 308A0B7C20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 18:07:05 +1000 (EST)
Subject: Re: 64bit kernel is huge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090928074503.GB16073@kryten>
References: <20090928074503.GB16073@kryten>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 18:07:00 +1000
Message-Id: <1254125220.8421.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-28 at 17:45 +1000, Anton Blanchard wrote:
> Hi,
> 
> I've found at least one machine that wont boot 2.6.31-rc* with a 
> pseries_defconfig. If I move real-base from 0xc00000 to 0xd00000 it
> boots fine.
> 
> # size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 9812942	1982496	1105228	12900666	 c4d93a	vmlinux
> 
> Looks like we blow right through the 12MB mark. It desperately needs to eat
> less and lose weight.

Depends what you have enabled tho. Known killers are CONFIG_RELOCATABLE,
the FTRACE stuff.

> Here are some of the problem areas:
> 
> 788224  kallsyms_names
> 537600  kallsyms_addresses
> 
> I guess mostly CONFIG_KALLSYMS_ALL.

Yeah, those are full on. Maybe we could compress them ? It should
compress well... but then, zImage does that already.

> 262144  kstat_irqs_all
> 131072  irq_desc
> 16384   irq_stat
> 
> Could we dynamically allocate our irq structures?

We still want one big array, unless we go to sparse IRQ numbering like
x86 but we'd have to also adapt the remapping stuff. Definitely to put
on a list somewhere for people who want to pick up something to do :-)

It's hard to properly dynamically size it. I'd rather have a "capacity"
of _lots_ and sparsely populate the array (a tree ?) because we never
know with MSIs etc... how many we'll really need.

At the -very-least- we could make NR_IRQS a CONFIG option.

> 151912  __start_mcount_loc
> 131076  map_pid_to_cmdline
> 
> ftrace stuff. With a name like map_pid_to_cmdline I'm pretty sure I'm not
> going to like what it does.

:-) No idea in fact

> 131072  lppaca
> 65536   paca
> 
> I think we've attacked these before, not sure if there is anything left
> we can trim.

Doubt it.

> 131072  __log_buf
> 
> Looks like we can dynamically allocate a large log buf at runtime. Perhaps
> we should default to a small log_buf and grow it at boot based on machine size
> (eg max cpus).

Ah, it's a new feature I have missed.

> 101160  powerpc_opcodes
> 
> xmon instruction disassembly. I'd probably prefer to cut off my right hand and
> debug one handed before losing this though.

It's already a CONFIG_OPTION for those who prefer coding with their
feet :-)

> 87600   __start___bug_table
> 
> Can't do much about this.

Appart from having no bugs :-)

> 77452   _fw_acenic_tg2_bin_bin
> 
> We could probably change acenic to be a module, 

Right.

> 46464   kmalloc_caches
> 32768   read_buffers
> 32768   mem_section
> 21816   hstates
> 20480   node_devices
> 14336   bootmem_node_data
> 
> mm stuff.

Also if ftrace is enabled, -pg is going to bloat the shit our of
everything (and slow everything down, gcc becomes really silly)

Cheers,
Ben.
