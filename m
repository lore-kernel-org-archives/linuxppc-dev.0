Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFFFC1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 14:37:45 +1100 (AEDT)
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00BBA140327
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 14:37:44 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id 129so28671348pfw.1
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Mar 2016 19:37:44 -0800 (PST)
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
To: Petr Mladek <pmladek@suse.com>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308160259.GF10940@pathway.suse.cz>
Cc: linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 mpe@ellerman.id.au, jikos@kernel.org, Torsten Duwe <duwe@suse.de>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56DF9A7E.4070101@gmail.com>
Date: Wed, 9 Mar 2016 14:37:34 +1100
MIME-Version: 1.0
In-Reply-To: <20160308160259.GF10940@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/03/16 03:02, Petr Mladek wrote:
> On Tue 2016-03-08 18:33:57, Balbir Singh wrote:
>> Changelog v5:
>> 	1. Removed the mini-stack frame created for klp_return_helper.
>> 	   As a result of the mini-stack frame, function with > 8
>> 	   arguments could not be patched
>> 	2. Removed camel casing in the comments
> I tested this patch and it fails when I call a patched printk()
> from a module.
>
> You might try it with the test patch below. It is a bit twisted
> because it calls the patched printk from livepatch_cmdline_proc_show()
> that it added by the same patch module. Please, look at
> livepatch_cmdline_proc_show(), it does:
>
> 	static int count;
>
> 	if (!count++)
> 		trace_printk("%s\n", "this has been live patched");
> 	else
> 		printk("%s\n", "this has been live patched");
>
>
> It means that calls only trace_printk() when called first time.
> It calls the patched printk when called second time.
>
>
> I have tested it the following way:
>
>
> # booted kernel with the changes below
> # applied the patch:
> $> modprobe livepatch-sample
>
> # trigger the pached printk()
> $>cat /sys/kernel/livepatch/livepatch_sample/enabled
> 1
>
> # look into both dmesg and trace buffer
> $> dmesg | tail -n 1
> [  727.537307] patch enabled: 1
> $> cat /sys/kernel/debug/tracing/trace | tail -n 1
>              cat-3588  [003] ....   727.537448: livepatch_printk: patch enabled: 1
>
> # trigger livepatch_cmdline_proc_show() 1st time
> c79:~ # cat /proc/cmdline 
> this has been live patched
>
> # the message appeared only in trace buffer
> $> dmesg | tail -n 1
> [  727.537307] patch enabled: 1
> c79:~ # cat /sys/kernel/debug/tracing/trace | tail -n 1
>              cat-3511  [000] ....    862.958383:	     livepatch_cmdline_proc_show: this has been live patched
>
>
> # trigger livepatch_cmdline_proc_show() 2nd time
> c79:~ # cat /proc/cmdline 
>
> !!! KABOOM !!!
>
> It is becaused it tried to call the patched printk()?
>
Yes, the situation is that we restored the r2 for the kernel (from ftrace_caller, it is now kernel_toc),
whereas the LR points to the module. The difference between r2 and r0 > 4GB.

Very good test case. Did it work with v4? I presume it did because we have enough space to save both

Thanks,
Balbir Singh
