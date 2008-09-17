Return-Path: <caner.altinbasak@gmail.com>
Message-ID: <2246c2320809170526i3a3ee3c0tc1303a0c039dbf88@mail.gmail.com>
Date: Wed, 17 Sep 2008 15:26:58 +0300
From: "Caner Altinbasak" <caner.altinbasak@gmail.com>
To: "Marco Stornelli" <marco.stornelli@coritel.it>
Subject: Re: spinlock problem
In-Reply-To: <48D0F0C5.8010806@coritel.it>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8874_9666288.1221654418788"
References: <2246c2320809170444j66aef147w638b44eb2f978410@mail.gmail.com>
	<48D0F031.8040801@coritel.it> <48D0F0C5.8010806@coritel.it>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8874_9666288.1221654418788
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If I do not compile with soft lockup debug option checked, I do not see the
debug messages but system freezes.

It is the same in both case, it just freezes after these messages. Soft lock
debug option only shows me call trace, instruction dump when soft lock up
happens.

There is a strange thing in call trace. I tried to follow the code, but call
trace is meaningless, most of those functions are not calling the one in
next stack. It seems just like an recursive function creating a buffer
overflow. But I think, the main reason is, handle_IRQ_event function does
not handle the IRQ, so it just enters the IRQ over and over? Any ideas? Am I
wrong? Can you suggest me a path to follow?


2008/9/17 Marco Stornelli <marco.stornelli@coritel.it>

> Oops, I meant soft lockup...
>
> Marco Stornelli ha scritto:
> > But does the test work? Maybe the kernel is configured with softlook
> > check (see the kernel menu under kernel hacking), try to disable it and
> > recompile. However there's something strange...
> >
> > Caner Altinbasak ha scritto:
> >> Hi!
> >> I am using a Curtiss Wright DY4-183 board with PPC7447 CPU. I've a pci
> >> graphics card with a M9 GPU on it. There is a transparent bridge between
> the
> >> GPU and my PCI bus. My problem a trouble with radeon_dri driver. I want
> to
> >> run a miniglx application to see how the graphics performance is but I
> am
> >> having the following error. I think there is a problem with unhandled
> >> interrupts! Have an idea?
> >>
> >> -bash-3.2# ./sample_server &
> >> [1] 1082
> >> -bash-3.2# [miniglx] probed chipset 0x4c66
> >> got MMIOAddress 0x1801e000 offset 67108864
> >> shared virtual width is 1024
> >> [drm] added 8192 byte SAREA at 0x61036000
> >> [drm] mapped SAREA 0x61036000 to 0x18026000, size 8192
> >> [drm] framebuffer handle = 0x80000000
> >> [drm] register handle = 0x70000000
> >> [pci] 8192 kB allocated with handle 0x62187000
> >> [pci] ring handle = 0x62187000
> >> [pci] ring read ptr handle = 0x62288000
> >> [pci] vertex/indirect buffers handle = 0x62289000
> >> [pci] GART texture map handle = 0x62489000
> >> Using 8 MB AGP aperture
> >> Using 1 MB for the ring buffhStart = 1040, hEnd = 1136, hTotal = 1312
> >> vStart = 769, vEnd = 772, vTotal = 800
> >> h_total_disp = 0x7f00a3    hsync_strt_wid = 0x8c040d
> >> v_total_disp = 0x2ff031f           vsync_strt_wid = 0x830300
> >> pixclock = 12699
> >> freq = 7874
> >> freq = 7874, PLL min = 12000, PLL max = 35000
> >> ref_div = 5, ref_clk = 2700, output_freq = 15748
> >> ref_div = 5, ref_clk = 2700, output_freq = 15748
> >> post div = 0x1
> >> fb_div = 0x1d
> >> ppll_div_3 = 0x1001d
> >> er
> >> Using 2 MB for BUG: soft lockup detected on CPU#0!
> >> NIP: 40042044 LR: 40042140 CTR: 400185B4
> >> REGS: 5e25bbb0 TRAP: 0901   Not tainted  (2.6.16.13.CWCEC.K)
> >> MSR: 00009032 <EE,ME,IR,DR>  CR: 2490C142  XER: 20000000
> >> TASK = 40aa78b0[1082] 'sample_server' THREAD: 5e25a000
> >> NIP [40042044] handle_IRQ_event+0x34/0xb8
> >> LR [40042140] __do_IRQ+0x78/0x1a0
> >> Call Trace:
> >> [5E25BC60] [400188A8] cw_pic_unmask_irq_183+0x118/0x138 (unreliable)
> >> [5E25BC80] [40042140] __do_IRQ+0x78/0x1a0
> >> [5E25BCB0] [4000B1E4] do_IRQ+0x44/0x88
> >> [5E25BCD0] [40004F1C] ret_from_except+0x0/0x14
> >> [5E25BD90] [40049DDC] __alloc_pages+0x70/0x2a4
> >> [5E25BDA0] [40042074] handle_IRQ_event+0x64/0xb8
> >> [5E25BDC0] [40042140] __do_IRQ+0x78/0x1a0
> >> [5E25BDF0] [4000B1E4] do_IRQ+0x44/0x88
> >> [5E25BE10] [40004F1C] ret_from_except+0x0/0x14
> >> [5E25BED0] [400244CC] __do_softirq+0x50/0x120
> >> [5E25BF00] [40024614] do_softirq+0x78/0x80
> >> [5E25BF10] [4002478C] irq_exit+0x60/0x78
> >> [5E25BF20] [4000B1E8] do_IRQ+0x48/0x88
> >> [5E25BF40] [40004F1C] ret_from_except+0x0/0x14
> >> Instruction dump:
> >> 9421ffe0 bf61000c 7cbf2b78 7c7b1b78 7c9d2378 90010024 80050004 74092000
> >> 40820010 7c0000a6 60008000 7c000124 <3bc00000> 3b800000 48000010
> 83ff0014
> >> vertex/indirect buffers
> >> Using 1 MB for AGP textures
> >> Will use back buffer at offset 0x300000
> >> Will use depth buffer at offset 0x600000
> >> Will use 56320 kb for textures at offset 0x900000
> >> [drm] Added 32 65536 byte vertex/indirect buffers
> >> [drm] dma control initialized, using IRQ 16
> >> [drm] Initialized kernel gart heap manager, 5111808
> >> color tiling disabled
> >> page flipping disabled
> >> [miniglx] Setting mode: visible 1024x768 virtual 1024x768x32
> >> [miniglx] Readback mode: visible 1024x768 virtual 1024x768x32
> >> RADEONEngineRestore
> >>
> >>
> >>
> >> ------------------------------------------------------------------------
> >>
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
> --
> Marco Stornelli
> Embedded Software Engineer
> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
> http://www.coritel.it
>
> marco.stornelli@coritel.it
> +39 06 72582838
>

------=_Part_8874_9666288.1221654418788
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">If I do not compile with soft lockup debug option checked, I do not see the debug messages but system freezes. <br><br>It
is the same in both case, it just freezes after these messages. Soft
lock debug option only shows me call trace, instruction dump when soft
lock up happens. <br>
<br>There is a strange thing in call trace. I tried to follow the code,
but call trace is meaningless, most of those functions are not calling
the one in next stack. It seems just like an recursive function
creating a buffer overflow. But I think, the main reason is,
handle_IRQ_event function does not handle the IRQ, so it just enters
the IRQ over and over? Any ideas? Am I wrong? Can you suggest me a path
to follow? <br>
<br><br><div class="gmail_quote">2008/9/17 Marco Stornelli <span dir="ltr">&lt;<a href="mailto:marco.stornelli@coritel.it">marco.stornelli@coritel.it</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Oops, I meant soft lockup...<br>
<font color="#888888"><br>
Marco Stornelli ha scritto:<br>
</font><div><div></div><div class="Wj3C7c">&gt; But does the test work? Maybe the kernel is configured with softlook<br>
&gt; check (see the kernel menu under kernel hacking), try to disable it and<br>
&gt; recompile. However there&#39;s something strange...<br>
&gt;<br>
&gt; Caner Altinbasak ha scritto:<br>
&gt;&gt; Hi!<br>
&gt;&gt; I am using a Curtiss Wright DY4-183 board with PPC7447 CPU. I&#39;ve a pci<br>
&gt;&gt; graphics card with a M9 GPU on it. There is a transparent bridge between the<br>
&gt;&gt; GPU and my PCI bus. My problem a trouble with radeon_dri driver. I want to<br>
&gt;&gt; run a miniglx application to see how the graphics performance is but I am<br>
&gt;&gt; having the following error. I think there is a problem with unhandled<br>
&gt;&gt; interrupts! Have an idea?<br>
&gt;&gt;<br>
&gt;&gt; -bash-3.2# ./sample_server &amp;<br>
&gt;&gt; [1] 1082<br>
&gt;&gt; -bash-3.2# [miniglx] probed chipset 0x4c66<br>
&gt;&gt; got MMIOAddress 0x1801e000 offset 67108864<br>
&gt;&gt; shared virtual width is 1024<br>
&gt;&gt; [drm] added 8192 byte SAREA at 0x61036000<br>
&gt;&gt; [drm] mapped SAREA 0x61036000 to 0x18026000, size 8192<br>
&gt;&gt; [drm] framebuffer handle = 0x80000000<br>
&gt;&gt; [drm] register handle = 0x70000000<br>
&gt;&gt; [pci] 8192 kB allocated with handle 0x62187000<br>
&gt;&gt; [pci] ring handle = 0x62187000<br>
&gt;&gt; [pci] ring read ptr handle = 0x62288000<br>
&gt;&gt; [pci] vertex/indirect buffers handle = 0x62289000<br>
&gt;&gt; [pci] GART texture map handle = 0x62489000<br>
&gt;&gt; Using 8 MB AGP aperture<br>
&gt;&gt; Using 1 MB for the ring buffhStart = 1040, hEnd = 1136, hTotal = 1312<br>
&gt;&gt; vStart = 769, vEnd = 772, vTotal = 800<br>
&gt;&gt; h_total_disp = 0x7f00a3 &nbsp; &nbsp;hsync_strt_wid = 0x8c040d<br>
&gt;&gt; v_total_disp = 0x2ff031f &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; vsync_strt_wid = 0x830300<br>
&gt;&gt; pixclock = 12699<br>
&gt;&gt; freq = 7874<br>
&gt;&gt; freq = 7874, PLL min = 12000, PLL max = 35000<br>
&gt;&gt; ref_div = 5, ref_clk = 2700, output_freq = 15748<br>
&gt;&gt; ref_div = 5, ref_clk = 2700, output_freq = 15748<br>
&gt;&gt; post div = 0x1<br>
&gt;&gt; fb_div = 0x1d<br>
&gt;&gt; ppll_div_3 = 0x1001d<br>
&gt;&gt; er<br>
&gt;&gt; Using 2 MB for BUG: soft lockup detected on CPU#0!<br>
&gt;&gt; NIP: 40042044 LR: 40042140 CTR: 400185B4<br>
&gt;&gt; REGS: 5e25bbb0 TRAP: 0901 &nbsp; Not tainted &nbsp;(2.6.16.13.CWCEC.K)<br>
&gt;&gt; MSR: 00009032 &lt;EE,ME,IR,DR&gt; &nbsp;CR: 2490C142 &nbsp;XER: 20000000<br>
&gt;&gt; TASK = 40aa78b0[1082] &#39;sample_server&#39; THREAD: 5e25a000<br>
&gt;&gt; NIP [40042044] handle_IRQ_event+0x34/0xb8<br>
&gt;&gt; LR [40042140] __do_IRQ+0x78/0x1a0<br>
&gt;&gt; Call Trace:<br>
&gt;&gt; [5E25BC60] [400188A8] cw_pic_unmask_irq_183+0x118/0x138 (unreliable)<br>
&gt;&gt; [5E25BC80] [40042140] __do_IRQ+0x78/0x1a0<br>
&gt;&gt; [5E25BCB0] [4000B1E4] do_IRQ+0x44/0x88<br>
&gt;&gt; [5E25BCD0] [40004F1C] ret_from_except+0x0/0x14<br>
&gt;&gt; [5E25BD90] [40049DDC] __alloc_pages+0x70/0x2a4<br>
&gt;&gt; [5E25BDA0] [40042074] handle_IRQ_event+0x64/0xb8<br>
&gt;&gt; [5E25BDC0] [40042140] __do_IRQ+0x78/0x1a0<br>
&gt;&gt; [5E25BDF0] [4000B1E4] do_IRQ+0x44/0x88<br>
&gt;&gt; [5E25BE10] [40004F1C] ret_from_except+0x0/0x14<br>
&gt;&gt; [5E25BED0] [400244CC] __do_softirq+0x50/0x120<br>
&gt;&gt; [5E25BF00] [40024614] do_softirq+0x78/0x80<br>
&gt;&gt; [5E25BF10] [4002478C] irq_exit+0x60/0x78<br>
&gt;&gt; [5E25BF20] [4000B1E8] do_IRQ+0x48/0x88<br>
&gt;&gt; [5E25BF40] [40004F1C] ret_from_except+0x0/0x14<br>
&gt;&gt; Instruction dump:<br>
&gt;&gt; 9421ffe0 bf61000c 7cbf2b78 7c7b1b78 7c9d2378 90010024 80050004 74092000<br>
&gt;&gt; 40820010 7c0000a6 60008000 7c000124 &lt;3bc00000&gt; 3b800000 48000010 83ff0014<br>
&gt;&gt; vertex/indirect buffers<br>
&gt;&gt; Using 1 MB for AGP textures<br>
&gt;&gt; Will use back buffer at offset 0x300000<br>
&gt;&gt; Will use depth buffer at offset 0x600000<br>
&gt;&gt; Will use 56320 kb for textures at offset 0x900000<br>
&gt;&gt; [drm] Added 32 65536 byte vertex/indirect buffers<br>
&gt;&gt; [drm] dma control initialized, using IRQ 16<br>
&gt;&gt; [drm] Initialized kernel gart heap manager, 5111808<br>
&gt;&gt; color tiling disabled<br>
&gt;&gt; page flipping disabled<br>
&gt;&gt; [miniglx] Setting mode: visible 1024x768 virtual 1024x768x32<br>
&gt;&gt; [miniglx] Readback mode: visible 1024x768 virtual 1024x768x32<br>
&gt;&gt; RADEONEngineRestore<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------------<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Linuxppc-embedded mailing list<br>
&gt;&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
&gt;&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
&gt;<br>
<br>
--<br>
Marco Stornelli<br>
Embedded Software Engineer<br>
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni<br>
<a href="http://www.coritel.it" target="_blank">http://www.coritel.it</a><br>
<br>
<a href="mailto:marco.stornelli@coritel.it">marco.stornelli@coritel.it</a><br>
+39 06 72582838<br>
</div></div></blockquote></div><br></div>

------=_Part_8874_9666288.1221654418788--
