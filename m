Return-Path: <w90p710@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A5AB2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 20:07:45 +1100 (EST)
Received: by mail-pd0-f177.google.com with SMTP id q10so7790698pdj.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 01:07:40 -0800 (PST)
Message-ID: <52BBF1CB.3070006@gmail.com>
Date: Thu, 26 Dec 2013 17:07:23 +0800
From: wyang <w90p710@gmail.com>
MIME-Version: 1.0
To: Ashish Khetan <curieux.khetan@gmail.com>,
 kernelnewbies@kernelnewbies.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC8641 based custom board kernel Bug
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
In-Reply-To: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------040307000404080502090705"
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040307000404080502090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/26/2013 01:09 PM, Ashish Khetan wrote:
> Hi,
> I was trying to port Linux-3.12 for MPC8641 based custom designed 
> board for evaluation purpose. I have been facing a kernel bug at mpic 
> initialization. Is somebody have faced this kind of bugs or can give 
> me any pointer for further steps how to solve kernel bugs will be 
> really helpful. here is the snapshot for the bug that may be helpful 
> to address the bug.
> Using MPC86xx HPCN machine description
> Total memory = 512MB; using 1024kB for hash table (at cff00000)
> Linux version 3.12.0 (ashish@ashish-VirtualBox) (gcc version 4.7.2 
> (GCC) ) #2 We
> d Dec 25 16:04:36 IST 2013
> Found initrd at 0xde975000:0xdfec428a
> bootconsole [udbg0] enabled
> setup_arch: bootmem
> mpc86xx_hpcn_setup_arch()
> MPC86xx HPCN board from Freescale Semiconductor
> arch: exit
> Zone ranges:
>   DMA      [mem 0x00000000-0x1fffffff]
>   Normal   empty
>   HighMem  empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x00000000-0x1fffffff]
> Built 1 zonelists in Zone order, mobility grouping on. Total pages: 130048
> Kernel command line: root=/dev/ram0 rw rootfs console=ttyS0,115200
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Sorting __ex_table...
> Memory: 424980K/524288K available (4172K kernel code, 208K rwdata, 
> 1304K rodata,
>  196K init, 149K bss, 99308K reserved, 0K highmem)
> Kernel virtual memory layout:
>   * 0xfffcf000..0xfffff000  : fixmap
>   * 0xff800000..0xffc00000  : highmem PTEs
>   * 0xff7fe000..0xff800000  : early ioremap
>   * 0xe1000000..0xff7fe000  : vmalloc & ioremap
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:512 nr_irqs:512 16
> ------------[ cut here ]------------
> kernel BUG at arch/powerpc/platforms/86xx/pic.c:42!

It hints that mpic_alloc() fails. Maybe, you should spend some time 
investigating why it fails.:-)

Thanks
Wei
> Oops: Exception in kernel mode, sig: 5 [#1]
> MPC86xx HPCN
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.0 #2
> task: c05903e0 ti: c05b4000 task.ti: c05b4000
> NIP: c0567438 LR: c0567430 CTR: c0567400
> REGS: c05b5ee0 TRAP: 0700   Not tainted  (3.12.0)
> MSR: 00021032 <ME,IR,DR,RI>  CR: 24000042  XER: 20000000
>
> GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588 0000008f 
> 00000002
> GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd 11a7b4e5 
> 200c8000
> GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8 1fec59a7 
> 00000000
> GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490 c05c2628 
> c0585b60
> NIP [c0567438] mpc86xx_init_irq+0x38/0x108
> LR [c0567430] mpc86xx_init_irq+0x30/0x108
> Call Trace:
> [c05b5f90] [c0567430] mpc86xx_init_irq+0x30/0x108 (unreliable)
> [c05b5fb0] [c0562784] init_IRQ+0x24/0x38
> [c05b5fc0] [c055fde4] start_kernel+0x1bc/0x2ec
> [c05b5ff0] [00003444] 0x3444
> Instruction dump:
> 3d00c04f 38800000 38a01002 38c00000 38e00100 39088f8c 38600000 90010024
> bfa10014 4bffec35 7c690034 5529d97e <0f090000> 3fa0c04f 4bfff391 38600000
> ---[ end trace 31fd0ba7d8756001 ]---
>
> Kernel panic - not syncing: Attempted to kill the idle task!
> Rebooting in 180 seconds..
>
>
> Thanks & Regards
> Ashish Khetan
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------040307000404080502090705
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 12/26/2013 01:09 PM, Ashish Khetan
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">
        <div>
          <div>
            <div>Hi,<br>
            </div>
            I was trying to port Linux-3.12 for MPC8641 based custom
            designed board for evaluation purpose. I have been facing a
            kernel bug at mpic initialization. Is somebody have faced
            this kind of bugs or can give me any pointer for further
            steps how to solve kernel bugs will be really helpful. here
            is the snapshot for the bug that may be helpful to address
            the bug.<br>
            Using MPC86xx HPCN machine description<br>
            Total memory = 512MB; using 1024kB for hash table (at
            cff00000)<br>
            Linux version 3.12.0 (ashish@ashish-VirtualBox) (gcc version
            4.7.2 (GCC) ) #2 We<br>
            d Dec 25 16:04:36 IST 2013<br>
            Found initrd at 0xde975000:0xdfec428a<br>
            bootconsole [udbg0] enabled<br>
            setup_arch: bootmem<br>
            mpc86xx_hpcn_setup_arch()<br>
            MPC86xx HPCN board from Freescale Semiconductor<br>
            arch: exit<br>
            Zone ranges:<br>
            &nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [mem 0x00000000-0x1fffffff]<br>
            &nbsp; Normal&nbsp;&nbsp; empty<br>
            &nbsp; HighMem&nbsp; empty<br>
            Movable zone start for each node<br>
            Early memory node ranges<br>
            &nbsp; node&nbsp;&nbsp; 0: [mem 0x00000000-0x1fffffff]<br>
            Built 1 zonelists in Zone order, mobility grouping on.&nbsp;
            Total pages: 130048<br>
            Kernel command line: root=/dev/ram0 rw rootfs
            console=ttyS0,115200<br>
            PID hash table entries: 2048 (order: 1, 8192 bytes)<br>
            Dentry cache hash table entries: 65536 (order: 6, 262144
            bytes)<br>
            Inode-cache hash table entries: 32768 (order: 5, 131072
            bytes)<br>
            Sorting __ex_table...<br>
            Memory: 424980K/524288K available (4172K kernel code, 208K
            rwdata, 1304K rodata,<br>
            &nbsp;196K init, 149K bss, 99308K reserved, 0K highmem)<br>
            Kernel virtual memory layout:<br>
            &nbsp; * 0xfffcf000..0xfffff000&nbsp; : fixmap<br>
            &nbsp; * 0xff800000..0xffc00000&nbsp; : highmem PTEs<br>
            &nbsp; * 0xff7fe000..0xff800000&nbsp; : early ioremap<br>
            &nbsp; * 0xe1000000..0xff7fe000&nbsp; : vmalloc &amp; ioremap<br>
            SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1<br>
            NR_IRQS:512 nr_irqs:512 16<br>
            ------------[ cut here ]------------<br>
            kernel BUG at arch/powerpc/platforms/86xx/pic.c:42!<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    It hints that mpic_alloc() fails. Maybe, you should spend some time
    investigating why it fails.<span class="moz-smiley-s1"><span> :-) </span></span><br>
    <br>
    Thanks<br>
    Wei<br>
    <blockquote
cite="mid:CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div>Oops: Exception in kernel mode, sig: 5 [#1]<br>
            MPC86xx HPCN<br>
            Modules linked in:<br>
            CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.0 #2<br>
            task: c05903e0 ti: c05b4000 task.ti: c05b4000<br>
            NIP: c0567438 LR: c0567430 CTR: c0567400<br>
            REGS: c05b5ee0 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (3.12.0)<br>
            MSR: 00021032 &lt;ME,IR,DR,RI&gt;&nbsp; CR: 24000042&nbsp; XER:
            20000000<br>
            <br>
            GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588
            0000008f 00000002<br>
            GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd
            11a7b4e5 200c8000<br>
            GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8
            1fec59a7 00000000<br>
            GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490
            c05c2628 c0585b60<br>
            NIP [c0567438] mpc86xx_init_irq+0x38/0x108<br>
            LR [c0567430] mpc86xx_init_irq+0x30/0x108<br>
            Call Trace:<br>
            [c05b5f90] [c0567430] mpc86xx_init_irq+0x30/0x108
            (unreliable)<br>
            [c05b5fb0] [c0562784] init_IRQ+0x24/0x38<br>
            [c05b5fc0] [c055fde4] start_kernel+0x1bc/0x2ec<br>
            [c05b5ff0] [00003444] 0x3444<br>
            Instruction dump:<br>
            3d00c04f 38800000 38a01002 38c00000 38e00100 39088f8c
            38600000 90010024<br>
            bfa10014 4bffec35 7c690034 5529d97e &lt;0f090000&gt;
            3fa0c04f 4bfff391 38600000<br>
            ---[ end trace 31fd0ba7d8756001 ]---<br>
            <br>
            Kernel panic - not syncing: Attempted to kill the idle task!<br>
            Rebooting in 180 seconds..<br>
            <br>
            <br>
          </div>
          Thanks &amp; Regards<br>
        </div>
        Ashish Khetan<br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040307000404080502090705--
