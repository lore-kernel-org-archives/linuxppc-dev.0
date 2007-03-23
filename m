Return-Path: <sakurken@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id E1CFDDDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 08:30:57 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1971771nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 14:30:56 -0700 (PDT)
Message-ID: <393e3a4b0703231430n65b01a79jaff5942004405aa4@mail.gmail.com>
Date: Fri, 23 Mar 2007 16:30:50 -0500
From: "Ken Sakurai" <sakurken@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: AVNET 440GX board
In-Reply-To: <393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_178596_16058867.1174685450544"
References: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
	<200703230722.25498.sr@denx.de>
	<393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_178596_16058867.1174685450544
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I decided to start tracing down the issue. I'm debugging early stage
by adding primitive debug code ( I don't have a fancy cpu debugger,
sign)

foobar:
        .long 0
start_:
        lis   r4, foobar@h
        ori   r4, r4, foobar@l
    li    r8, 0x1111
        stw   r8, 0(r4)

I found that the bootelf command actually jumped to _start(), and then
stoped inside load_kernel()@arch/ppc/boot/simple/misc.c.  Because of
stupid debugging method, just slow progress.

- ken


On 3/23/07, Ken Sakurai <sakurken@gmail.com> wrote:
>
> Stephen,
>
> > I don't know the AVNET 440GX eval board. Is it _identical_ to the
> IBM/AMCC
> > Ocotea? If not you will most likely have no luck with this image. You
> will
> > have to port Linux to this special board.
>
> yeah, sounds like. I was so optimistic that Linux is kind of primary OS
> for
> any ppc board  when I choosed this board :-)
>
> I was just using the elf image, instead of uimage.
> '6501A8C0.img' is refereing zImage.img which is Linux elf image.
> It looks to me that the bootelf command interprets ELF format corrently.
>
> As you sugested, I also made uImage and used bootm to boot it.
> But no luck. Here is the log.
>
> => setenv bootargs "console=ttyS0,19200 console=/dev/ttyS0"
> => tftp 0x100000 uImage
> Waiting for PHY auto negotiation to complete.. done
> ENET Speed is 100 Mbps - FULL duplex connection
> Using ppc_440x_eth2 device
> TFTP from server 192.168.1.1; our IP address is 192.168.1.101
> Filename 'uImage'.
> Load address: 0x100000
> Loading: #################################################################
>
>          #################################################################
>          ######
> done
> Bytes transferred = 695605 (a9d35 hex)
> => bootm
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.6.21-rc4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    695541 Bytes = 679.2 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> (freeze at this point)
>
> - Ken
>
> On 3/23/07, Stefan Roese <sr@denx.de> wrote:
> >
> > Ken,
> >
> > On Thursday 22 March 2007 20:34, Ken Sakurai wrote:
> > > I'm trying to boot Linux on  AVNET 440gx eval board but no luck so
> > far.
> > > What I did are that I downloaded a plain 2.6.20 kernel from kernel.org
> > ,
> > > configured with 440GX, OCOTEA target (I'm not sure OCOTEA is correct
> > > target),
> >
> > I don't know the AVNET 440GX eval board. Is it _identical_ to the
> > IBM/AMCC
> > Ocotea? If not you will most likely have no luck with this image. You
> > will
> > have to port Linux to this special board.
> >
> > > then loaded the kernel image via tftp  and tried to boot with bootelf
> > > command.
> > > But I had no output message from Linux.
> > >
> > > I suspected setting of Linux serial console. So I changed the kernel
> > > parameter to
> > > "ttyS0,19200" which I suppose correct becuase this is the minicom
> > setting.
> > > But still didn't work.
> > >
> > > The board comes with u-boot 1.0.2 with some fixes.  I'm checking the
> > u-boot
> > > source code (might be some hint in there) and the serial device
> > > initialization code in Linux.
> > >
> > > Has anyone had experiece with Linux on AVNET 440GX board?
> > > Any advise would be appreciated !
> >
> > See below.
> >
> > > -
> > > Ken
> > >
> > > ------
> > >
> > > => tftp
> > > Waiting for PHY auto negotiation to complete.. done
> > > ENET Speed is 100 Mbps - FULL duplex connection
> > > *** Warning: no boot file name; using ' 6501A8C0.img'
> >
> > Hmmmm. That's a strange image name. Normally you should boot the uImage
> > file
> > from U-Boot.
> >
> > > Using ppc_440x_eth2 device
> > > TFTP from server 192.168.1.1 ; our IP address is 192.168.1.101
> > > Filename '6501A8C0.img'.
> > > Load address: 0x100000
> > > Loading:
> > #################################################################
> >
> > >          #################################################################
> > >          #################################
> > > done
> > > Bytes transferred = 832121 (cb279 hex)
> > > => bootelf
> > > Loading .text @ 0x01000000 (15316 bytes)
> > > Loading .data @ 0x01004000 (700416 bytes)
> > > Clearing .bss @ 0x010af000 (8500 bytes)
> > > ## Starting application at 0x01000000 ...
> >
> > And use the "bootm" command to boot the uImage.
> >
> > Best regards,
> > Stefan
> >
> > =====================================================================
> > DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
> > Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
> > =====================================================================
> >
>
>

------=_Part_178596_16058867.1174685450544
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I decided to start tracing down the issue. I&#39;m debugging early stage<br>by adding primitive debug code ( I don&#39;t have a fancy cpu debugger,<br>sign)<br><br>foobar:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .long 0<br>start_:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp; r4, 
foobar@h<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp; r4, r4, foobar@l<br>&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp; r8, 0x1111<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp; r8, 0(r4)<br><br>I found that the bootelf command actually jumped to _start(), and then<br>stoped inside load_kernel()@arch/ppc/boot/simple/misc.c.&nbsp; Because of
<br>stupid debugging method, just slow progress.<br><br>- ken<br><br><br><div><span class="gmail_quote">On 3/23/07, <b class="gmail_sendername">Ken Sakurai</b> &lt;<a href="mailto:sakurken@gmail.com">sakurken@gmail.com</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Stephen,<span class="q"><br><br>&gt; I don&#39;t know the AVNET 440GX eval board. Is it _identical_ to the IBM/AMCC
<br>&gt; Ocotea? If not you will most likely have no luck with this image. You will<br>&gt; have to port Linux to this special board.
<br><br></span>yeah, sounds like. I was so optimistic that Linux is kind of primary OS for<br>any ppc board&nbsp; when I choosed this board :-)<br><br>I was just using the elf image, instead of uimage.<br>&#39;6501A8C0.img&#39; is refereing 
zImage.img which is Linux elf image.<br>It looks to me that the bootelf command interprets ELF format corrently.<br><br>As you sugested, I also made uImage and used bootm to boot it.<br>But no luck. Here is the log.<br><br>

=&gt; setenv bootargs &quot;console=ttyS0,19200 console=/dev/ttyS0&quot;<br>=&gt; tftp 0x100000 uImage<span class="q"><br>Waiting for PHY auto negotiation to complete.. done<br>ENET Speed is 100 Mbps - FULL duplex connection
<br></span><span class="q">Using ppc_440x_eth2 device
<br>TFTP from server <a href="http://192.168.1.1" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">192.168.1.1</a>; our IP address is <a href="http://192.168.1.101" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
192.168.1.101</a><br></span>Filename &#39;uImage&#39;.<span class="q"><br>Load address: 0x100000<br>Loading: #################################################################
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ######<br>done<br></span>Bytes transferred = 695605 (a9d35 hex)<br>=&gt; bootm<br>## Booting image at 00100000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; 
Linux-2.6.21-rc4
<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 695541 Bytes = 679.2 kB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK
<br>(freeze at this point)<br><span class="sg"><br>- Ken</span><div><span class="e" id="q_111801e71310130a_9"><br><br><div><span class="gmail_quote">On 3/23/07, <b class="gmail_sendername">Stefan Roese</b> &lt;<a href="mailto:sr@denx.de" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
sr@denx.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ken,<br><br>On Thursday 22 March 2007 20:34, Ken Sakurai wrote:<br>&gt; I&#39;m trying to boot Linux on&nbsp;&nbsp;AVNET 440gx eval board but no luck so far.<br>&gt; What I did are that I downloaded a plain 2.6.20 kernel from <a href="http://kernel.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

kernel.org</a>,<br>&gt; configured with 440GX, OCOTEA target (I&#39;m not sure OCOTEA is correct<br>&gt; target),<br><br>I don&#39;t know the AVNET 440GX eval board. Is it _identical_ to the IBM/AMCC<br>Ocotea? If not you will most likely have no luck with this image. You will
<br>have to port Linux to this special board.<br><br>&gt; then loaded the kernel image via tftp&nbsp;&nbsp;and tried to boot with bootelf<br>&gt; command.<br>&gt; But I had no output message from Linux.<br>&gt;<br>&gt; I suspected setting of Linux serial console. So I changed the kernel
<br>&gt; parameter to<br>&gt; &quot;ttyS0,19200&quot; which I suppose correct becuase this is the minicom setting.<br>&gt; But still didn&#39;t work.<br>&gt;<br>&gt; The board comes with u-boot 1.0.2 with some fixes.&nbsp;&nbsp;I&#39;m checking the u-boot
<br>&gt; source code (might be some hint in there) and the serial device<br>&gt; initialization code in Linux.<br>&gt;<br>&gt; Has anyone had experiece with Linux on AVNET 440GX board?<br>&gt; Any advise would be appreciated !
<br><br>See below.<br><br>&gt; -<br>&gt; Ken<br>&gt;<br>&gt; ------<br>&gt;<br>&gt; =&gt; tftp<br>&gt; Waiting for PHY auto negotiation to complete.. done<br>&gt; ENET Speed is 100 Mbps - FULL duplex connection<br>&gt; *** Warning: no boot file name; using &#39;
6501A8C0.img&#39;<br><br>Hmmmm. That&#39;s a strange image name. Normally you should boot the uImage file<br>from U-Boot.<br><br>&gt; Using ppc_440x_eth2 device<br>&gt; TFTP from server <a href="http://192.168.1.1" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
192.168.1.1
</a>; our IP address is <a href="http://192.168.1.101" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">192.168.1.101</a><br>&gt; Filename &#39;6501A8C0.img&#39;.<br>&gt; Load address: 0x100000<br>&gt; Loading: #################################################################
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#################################################################<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#################################<br>&gt; done<br>&gt; Bytes transferred = 832121 (cb279 hex)<br>&gt; =&gt; bootelf<br>
&gt; Loading .text @ 0x01000000 (15316 bytes)
<br>&gt; Loading .data @ 0x01004000 (700416 bytes)<br>&gt; Clearing .bss @ 0x010af000 (8500 bytes)<br>&gt; ## Starting application at 0x01000000 ...<br><br>And use the &quot;bootm&quot; command to boot the uImage.<br><br>

Best regards,<br>Stefan<br><br>=====================================================================<br>DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk<br>Office:&nbsp;&nbsp;Kirchenstr. 5,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-82194 Groebenzell,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Germany
<br>=====================================================================<br></blockquote></div><br>
</span></div></blockquote></div><br>

------=_Part_178596_16058867.1174685450544--
