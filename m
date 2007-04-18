Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ramdisk - machine check exception
Date: Tue, 17 Apr 2007 21:15:09 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D75A7895@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am getting Machine Check exception due to the following scenario.

I am trying to use ramdisk for the file system with physical memory from
0x40000000 (instead of the regular 0x00000000). Of course this starts
the run_init_process with ramdisk_execute_command ("/init"). This
eventually calls load_elf_binary -> padzero -> __clear_user(addr, size).
This addr value for __clear_user came in as 0x101b2f98, accessing which
I got the exception.

Now my question is, why am I getting 0x101b2f98. I tried to do some
research and found that this is coming from elf_phdata->p_vaddr
(0x10000000) from routine load_elf_binary. This just kernel_read's from
file pointer of "/init", which I don't completely understand. Shouldn't
this value be greater than 0xc0000000. Where is this value coming from?

Also I don't understand how this would work even in regular memory
systems starting at 0x00000000, as MMU is enabled and mapped to
0xc0000000.

Appreciate any help.

Thanks
Siva
