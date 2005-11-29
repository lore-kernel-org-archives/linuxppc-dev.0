Return-Path: <gil-ad@myrealbox.com>
Received: from sa9.bezeqint.net (sa9.bezeqint.net [192.115.104.23])
	by ozlabs.org (Postfix) with ESMTP id 4160A68802
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 17:39:13 +1100 (EST)
From: Gil Madar <gil-ad@myrealbox.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 29 Nov 2005 08:27:43 +0200
References: <6915D0AE8B9047438F320B466AE30FDD152557@nvs0003.nedap.local>
In-Reply-To: <6915D0AE8B9047438F320B466AE30FDD152557@nvs0003.nedap.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511290827.43829.gil-ad@myrealbox.com>
Cc: Jaap de Jong <jaap.dejong@nedap.com>
Subject: Re: do_initcalls
Reply-To: gil-ad@myrealbox.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 25 November 2005 09:41, Jaap de Jong wrote:
>Hi,
>
>In linux-2.4.25/init/main.c this function is called:
>        
>        static void __init do_initcalls(void)
>        {
>                initcall_t *call;
>        
>                call = &__initcall_start;
>                do {
>                        (*call)();
>                        call++
>                } while (call < &__initcall_end);
>
>                /* Make sure there is no pending stuff from the initcall sequence */
>                flush_scheduled_tasks();
>        }
>
>What is supposed to be in the section __initcall_start ..
>__initcall_end?
>Mine is empty and therefore causing trouble...
>System.map:
>        //
>        //
>        c00ad880 A __initcall_end
>        c00ad880 A __initcall_start
>        //
>        //
>
>The fix is obvious... But I guess I've missed something else?
>
>Thanks in advance,
>        Jaap de Jong
Hi Jaap,

This is what I got on kernel 2.4.25:

c016a890 A __initcall_start
c016a890 A __setup_end
c016a890 t __initcall_abi_register_sysctl
c016a894 t __initcall_spawn_ksoftirqd
c016a898 t __initcall_uid_cache_init
c016a89c t __initcall_kmem_cpucache_init
c016a8a0 t __initcall_kswapd_init
c016a8a4 t __initcall_init_tmpfs
c016a8a8 t __initcall_bdflush_init
c016a8ac t __initcall_init_pipe_fs
c016a8b0 t __initcall_fasync_init
c016a8b4 t __initcall_filelock_init
c016a8b8 t __initcall_dnotify_init
c016a8bc t __initcall_init_script_binfmt
c016a8c0 t __initcall_init_elf_binfmt
c016a8c4 t __initcall_init_ramfs_fs
c016a8c8 t __initcall_init_devfs_fs
c016a8cc t __initcall_init_nfs_fs
c016a8d0 t __initcall_nfsd_init
c016a8d4 t __initcall_init_smb_fs
c016a8d8 t __initcall_init_devpts_fs
c016a8dc t __initcall_chr_dev_init
c016a8e0 t __initcall_raw_init
c016a8e4 t __initcall_device_init
c016a8e8 t __initcall_rd_init
c016a8ec t __initcall_loop_init
c016a8f0 t __initcall_ppp_init
c016a8f4 t __initcall_ppp_async_init
c016a8f8 t __initcall_deflate_init
c016a8fc t __initcall_netlink_proto_init
c016a900 t __initcall_inet_init
c016a904 t __initcall_ip_auto_config
c016a908 t __initcall_af_unix_init
c016a90c t __initcall_packet_init
c016a910 t __initcall_init_sunrpc
c016a914 A __initcall_end

HTH,
Gil
