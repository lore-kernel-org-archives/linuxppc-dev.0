Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 298D8B7BC8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Oct 2009 00:02:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: 64bit kernel is huge
Date: Wed, 30 Sep 2009 15:57:42 +0200
References: <20090928074503.GB16073@kryten>
In-Reply-To: <20090928074503.GB16073@kryten>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200909301557.42625.arnd@arndb.de>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 28 September 2009, Anton Blanchard wrote:

> 262144  kstat_irqs_all
> 131072  irq_desc
> 16384   irq_stat
> 
> Could we dynamically allocate our irq structures?

There were patches floating around for that a few years ago,
but I haven't seen anyone working on it since.
 
> 131072  lppaca
> 65536   paca
> 
> I think we've attacked these before, not sure if there is anything left
> we can trim.

well, it essentially comes down to CONFIG_NR_CPUS. If you build with NR_CPUS=4,
this is really small.
 
> 131072  __log_buf
> 
> Looks like we can dynamically allocate a large log buf at runtime. Perhaps
> we should default to a small log_buf and grow it at boot based on machine size
> (eg max cpus).

I like the idea of being able to very easily find the log buffer in
dump files or in hw debuggers for bringup, but it's probably not
worth it for production systems. A config option might be nice.

> 101160  powerpc_opcodes
> 
> xmon instruction disassembly. I'd probably prefer to cut off my right hand and
> debug one handed before losing this though.

This should be very compressible though, which will help binary size, but not
runtime memory footprint.

> 77452   _fw_acenic_tg2_bin_bin
> 
> We could probably change acenic to be a module, 

CONFIG_FIRMWARE_IN_KERNEL ?

> 17784   ioctl_start

I have a patch for this one that I need to submit some day.

	Arnd <><
