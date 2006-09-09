Return-Path: <urwithsudheer@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id D12C967B99
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Sep 2006 10:04:03 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so706870ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Sep 2006 17:04:01 -0700 (PDT)
Message-ID: <12c9fc1a0609081704s27240c54h797da189ae67f3bc@mail.gmail.com>
Date: Fri, 8 Sep 2006 17:04:00 -0700
From: "a sudheer" <urwithsudheer@gmail.com>
To: "Ameet Patil" <ammubhai@gmail.com>
Subject: Re: SystemAce Driver.
In-Reply-To: <45019041.2070409@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3230_17786969.1157760240283"
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>
	<44C4BE5B.3000002@gmail.com> <44D9F9DF.5020100@gmail.com>
	<44DC4F34.1070308@gmail.com> <44FFE0EC.6010603@gmail.com>
	<45019041.2070409@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3230_17786969.1157760240283
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ameet,

Today I tried the System ACE driver in interrupt mode.
The driver is connected to the processor through IRQ4 .

So, in xparameter_ml300.h , I have changed the

#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 4

Also, in "xsysace_init",  if I have xsa_device.gd = alloc_disk(16); , then
the kernel hangs.
So I have assigned alloc_disk(1), in which case the kernel boots-up fine.

But when I issue 'fdisk / mount ', it goes through - ' XSysAce_SectorRead'
which is being called from "xsysace_do_request".
And at the nd of the function it hangs. I couldn't trace exactly where it
hangs.

Could you please suggest some pointers to debug on this issue?

This is very critical for us and I am held up with this issue for the last 1
week.

Thanks so much for all your help.

Thanks
Sudheer



On 9/8/06, Ameet Patil <ammubhai@gmail.com> wrote:
>
> Hi Sudheer,
>     Ah! I never did the test for polled mode. There might be issue with
> that. Will have a look....
>
> -Ameet
>
> sudheer wrote:
> > Hi Ameet Patil
> >
> > Ameet Patil wrote:
> >> Hi Sudheer,
> >>    Frank has already answered your questions. If you have any problems
> >> with the SysAce patch... do let me know. I have written a small
> >> tutorial here if it helps...
> > I have used your SystemAce patch with linux-2.6.16-2. The kernel gets
> > loaded with the ace module and is fine.
> > I want the driver in polling mode. So i have commented few lines related
> > to interrupt in the adapter.c file- xsysace_init function.
> >
> > When i give the fdisk command, it gives few errors and then enters to
> > the  fdisk commad promt. It prints the partitions, etc.
> >
> > But when  i try to quit from the fdisk, it hangs. I am not able to
> > complete the request properly (i guess in xsa_thread function in
> > adapter.c file)
> >
> > The dump is as follows:
> > SystemACE: Error 1 when reading sector 60.
> > end_request: I/O error, dev xsa, sector 56
> > SystemACE: Error 1351 when reading sector 62.
> > end_request: I/O error, dev xsa, sector 56
> >
> > Command (m for help): p
> >
> > Disk /dev/xsysace: 512 MB, 512483328 bytes
> > 16 heads, 62 sectors/track, 1009 cylinders
> > Units = cylinders of 992 * 512 = 507904 bytes
> > Device Boot Start End Blocks Id System
> > /dev/xsysace1 1 1009 500433 6 FAT16
> >
> > Command (m for help): q
> > -------
> > The fdisk enters into xsysace_ioctl function but no commands are
> > implemented in the ioctl function and returns an error.
> >
> > Please help me in this issue and let me know if any other details
> required.
> >
> > Thanks
> > Sudheer
> >
> >>
> >> http://linux.get2knowmore.com
> >>
> >>
> >> -Ameet
> >>
> >> sudheer wrote:
> >>> Hello Ameet Patil
> >>>
> >>> I am looking for linux kernel source 2.6.16 with system ace
> >>> controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1
> >>> source from kernel.org but could not find any files related to system
> >>> ace controller  ( No xilinx_sysace directory in  drivers/block/) .  I
> >>> have checked penguinppc.org also but could not get it.
> >>>
> >>> Can you please send to me the link where i could download the
> >>> linuxppc-2.6.16 source with system ace support.
> >>>
> >>> Thanks & Regards
> >>> Sudheer
> >>>
> >>> Ameet Patil wrote:
> >>>> Hi Raja,
> >>>>     I have ported the Xilinx System ACE driver to 2.6 kernel. Find
> >>>> the latest one here:
> >>>>
> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
> >>>>
> >>>>
> >>>> NOTE: this patch wouldn't work if you are using the TEMAC driver. In
> >>>> which case use the -after-TEMAC patch found in the patches folder
> >>>> above.
> >>>>
> >>>> Check the following discussions (threads) for more details:
> >>>> 1. "Xilinx SystemACE driver for 2.6"
> >>>> 2. "Xilinx BSP for linux 2.6"
> >>>> 3. "Kernel hangs after "Now booting the kernel"."
> >>>>
> >>>> cheers,
> >>>> -Ameet
> >>>>
> >>>> Raja Chidambaram wrote:
> >>>>
> >>>>>  Hi all,
> >>>>>  We are working on customized board with amcc 440SPe
> >>>>> processor & xilinx System Ace controller. The System
> >>>>> Ace controller is connected to compact flash driver.
> >>>>>
> >>>>> We use u-boot 1.2 as bootloader & linux kernel
> >>>>> 2.6.16-2.
> >>>>>
> >>>>> On the process the u-boot is able to detect compact
> >>>>> flash through Xilinx SystemAce controller & able to
> >>>>> load the kernel image into compact flash.But when the
> >>>>> linux boot's up it not able to detect the System Ace
> >>>>> controller or compact flash.
> >>>>>
> >>>>> Note:we need to have the root file system in compact
> >>>>> flash.
> >>>>>
> >>>>> Is their any drivers available for SystemAce
> >>>>> controller on linux 2.6,if their how to get it.please
> >>>>> help me in this
> >>>>>                                     with regards
> >>>>>                                      raja
> >>>>>
> >>>>>
> >>>>>
> >>>>> __________________________________________________
> >>>>> Do You Yahoo!?
> >>>>> Tired of spam?  Yahoo! Mail has the best spam protection around
> >>>>> http://mail.yahoo.com_______________________________________________
> >>>>> Linuxppc-embedded mailing list
> >>>>> Linuxppc-embedded@ozlabs.org
> >>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>>>
> >>>>>
> >>>> _______________________________________________
> >>>> Linuxppc-embedded mailing list
> >>>> Linuxppc-embedded@ozlabs.org
> >>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>>
> >>>>
> >>>
> >>
> >
>

------=_Part_3230_17786969.1157760240283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ameet,<br>
<br>
Today I tried the System ACE driver in interrupt mode.<br>
The driver is connected to the processor through IRQ4 .<br>
<br>
So, in xparameter_ml300.h , I have changed the <br><br>
#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 4<br>
<br>
Also, in &quot;xsysace_init&quot;,&nbsp; if I have xsa_device.gd = alloc_disk(16); , then the kernel hangs. <br>
So I have assigned alloc_disk(1), in which case the kernel boots-up fine.<br>
<br>
But when I issue 'fdisk / mount ', it goes through - '
XSysAce_SectorRead'&nbsp; which is being called from
&quot;xsysace_do_request&quot;.<br>
And at the nd of the function it hangs. I couldn't trace exactly where it hangs.<br>
<br>
Could you please suggest some pointers to debug on this issue?<br>
<br>
This is very critical for us and I am held up with this issue for the last 1 week. <br>
<br>
Thanks so much for all your help.<br>
<br>
Thanks<br>
Sudheer<br>
<br>
<br>
<br><div><span class="gmail_quote">On 9/8/06, <b class="gmail_sendername">Ameet Patil</b> &lt;<a href="mailto:ammubhai@gmail.com">ammubhai@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Sudheer,<br>&nbsp;&nbsp;&nbsp;&nbsp;Ah! I never did the test for polled mode. There might be issue with<br>that. Will have a look....<br><br>-Ameet<br><br>sudheer wrote:<br>&gt; Hi Ameet Patil<br>&gt;<br>&gt; Ameet Patil wrote:<br>&gt;&gt; Hi Sudheer,
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;Frank has already answered your questions. If you have any problems<br>&gt;&gt; with the SysAce patch... do let me know. I have written a small<br>&gt;&gt; tutorial here if it helps...<br>&gt; I have used your SystemAce patch with 
linux-2.6.16-2. The kernel gets<br>&gt; loaded with the ace module and is fine.<br>&gt; I want the driver in polling mode. So i have commented few lines related<br>&gt; to interrupt in the adapter.c file- xsysace_init function.
<br>&gt;<br>&gt; When i give the fdisk command, it gives few errors and then enters to<br>&gt; the&nbsp;&nbsp;fdisk commad promt. It prints the partitions, etc.<br>&gt;<br>&gt; But when&nbsp;&nbsp;i try to quit from the fdisk, it hangs. I am not able to
<br>&gt; complete the request properly (i guess in xsa_thread function in<br>&gt; adapter.c file)<br>&gt;<br>&gt; The dump is as follows:<br>&gt; SystemACE: Error 1 when reading sector 60.<br>&gt; end_request: I/O error, dev xsa, sector 56
<br>&gt; SystemACE: Error 1351 when reading sector 62.<br>&gt; end_request: I/O error, dev xsa, sector 56<br>&gt;<br>&gt; Command (m for help): p<br>&gt;<br>&gt; Disk /dev/xsysace: 512 MB, 512483328 bytes<br>&gt; 16 heads, 62 sectors/track, 1009 cylinders
<br>&gt; Units = cylinders of 992 * 512 = 507904 bytes<br>&gt; Device Boot Start End Blocks Id System<br>&gt; /dev/xsysace1 1 1009 500433 6 FAT16<br>&gt;<br>&gt; Command (m for help): q<br>&gt; -------<br>&gt; The fdisk enters into xsysace_ioctl function but no commands are
<br>&gt; implemented in the ioctl function and returns an error.<br>&gt;<br>&gt; Please help me in this issue and let me know if any other details required.<br>&gt;<br>&gt; Thanks<br>&gt; Sudheer<br>&gt;<br>&gt;&gt;<br>&gt;&gt; 
<a href="http://linux.get2knowmore.com">http://linux.get2knowmore.com</a><br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; -Ameet<br>&gt;&gt;<br>&gt;&gt; sudheer wrote:<br>&gt;&gt;&gt; Hello Ameet Patil<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; I am looking for linux kernel source 
2.6.16 with system ace<br>&gt;&gt;&gt; controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1<br>&gt;&gt;&gt; source from <a href="http://kernel.org">kernel.org</a> but could not find any files related to system
<br>&gt;&gt;&gt; ace controller&nbsp;&nbsp;( No xilinx_sysace directory in&nbsp;&nbsp;drivers/block/) .&nbsp;&nbsp;I<br>&gt;&gt;&gt; have checked <a href="http://penguinppc.org">penguinppc.org</a> also but could not get it.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Can you please send to me the link where i could download the
<br>&gt;&gt;&gt; linuxppc-2.6.16 source with system ace support.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Thanks &amp; Regards<br>&gt;&gt;&gt; Sudheer<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Ameet Patil wrote:<br>&gt;&gt;&gt;&gt; Hi Raja,
<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; I have ported the Xilinx System ACE driver to 2.6 kernel. Find<br>&gt;&gt;&gt;&gt; the latest one here:<br>&gt;&gt;&gt;&gt; <a href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">
http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a><br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; NOTE: this patch wouldn't work if you are using the TEMAC driver. In
<br>&gt;&gt;&gt;&gt; which case use the -after-TEMAC patch found in the patches folder<br>&gt;&gt;&gt;&gt; above.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Check the following discussions (threads) for more details:<br>&gt;&gt;&gt;&gt; 1. &quot;Xilinx SystemACE driver for 
2.6&quot;<br>&gt;&gt;&gt;&gt; 2. &quot;Xilinx BSP for linux 2.6&quot;<br>&gt;&gt;&gt;&gt; 3. &quot;Kernel hangs after &quot;Now booting the kernel&quot;.&quot;<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; cheers,<br>&gt;&gt;&gt;&gt; -Ameet
<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Raja Chidambaram wrote:<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;Hi all,<br>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;We are working on customized board with amcc 440SPe<br>&gt;&gt;&gt;&gt;&gt; processor &amp; xilinx System Ace controller. The System
<br>&gt;&gt;&gt;&gt;&gt; Ace controller is connected to compact flash driver.<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; We use u-boot 1.2 as bootloader &amp; linux kernel<br>&gt;&gt;&gt;&gt;&gt; 2.6.16-2.<br>&gt;&gt;&gt;&gt;&gt;
<br>&gt;&gt;&gt;&gt;&gt; On the process the u-boot is able to detect compact<br>&gt;&gt;&gt;&gt;&gt; flash through Xilinx SystemAce controller &amp; able to<br>&gt;&gt;&gt;&gt;&gt; load the kernel image into compact flash.But
 when the<br>&gt;&gt;&gt;&gt;&gt; linux boot's up it not able to detect the System Ace<br>&gt;&gt;&gt;&gt;&gt; controller or compact flash.<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Note:we need to have the root file system in compact
<br>&gt;&gt;&gt;&gt;&gt; flash.<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Is their any drivers available for SystemAce<br>&gt;&gt;&gt;&gt;&gt; controller on linux 2.6,if their how to get it.please<br>&gt;&gt;&gt;&gt;&gt; help me in this
<br>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
with regards<br>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;raja<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; __________________________________________________
<br>&gt;&gt;&gt;&gt;&gt; Do You Yahoo!?<br>&gt;&gt;&gt;&gt;&gt; Tired of spam?&nbsp;&nbsp;Yahoo! Mail has the best spam protection around<br>&gt;&gt;&gt;&gt;&gt; <a href="http://mail.yahoo.com">http://mail.yahoo.com</a> _______________________________________________
<br>&gt;&gt;&gt;&gt;&gt; Linuxppc-embedded mailing list<br>&gt;&gt;&gt;&gt;&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt;&gt;&gt;&gt;&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; _______________________________________________<br>&gt;&gt;&gt;&gt; Linuxppc-embedded mailing list
<br>&gt;&gt;&gt;&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt;&gt;&gt;&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</a><br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;<br>&gt;<br></blockquote></div><br>

------=_Part_3230_17786969.1157760240283--
