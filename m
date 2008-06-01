Return-Path: <zhulida@hotmail.com>
Received: from bay0-omc3-s25.bay0.hotmail.com (bay0-omc3-s25.bay0.hotmail.com
	[65.54.246.225]) by ozlabs.org (Postfix) with ESMTP id 081CFDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jun 2008 15:59:36 +1000 (EST)
Message-ID: <BAY124-W269F1CF8A286D2F6803A32A8B80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_1fe11c55-2d73-45ee-bdf2-ec1e7fa90e82_"
From: =?gb2312?B?1uzA+7Tv?= <zhulida@hotmail.com>
To: Alan Nishioka <alan@nishioka.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Error occured when appended FPGA image in the section of
	.init.text then bootup
Date: Sun, 1 Jun 2008 13:59:35 +0800
In-Reply-To: <4841270B.9080805@nishioka.com>
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
	<4841270B.9080805@nishioka.com>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_1fe11c55-2d73-45ee-bdf2-ec1e7fa90e82_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


> Date: Sat, 31 May 2008 03:23:07 -0700> From: alan@nishioka.com> To: linuxppc-embedded@ozlabs.org> Subject: Re: FW: Error occured when appended FPGA image in the section of .init.text then bootup> > 朱利达 (lida zhu)wrote:> >> >> > The request below give rise to the problem.> > I have some boards equiped with MPC8247 and FPGA without storage> > media which used as a PCI interface. So when the linux bootup> > before initialize the PCI, the code of FPGA will download. I> > append the FPGA code file in the Kernel section '.init.text'. when> > linux bootup firstly it check the board type(different board type> > would download different code), and download fpga code. More board> > types lead to more FPGA code. I append them all in the section of> > '.init.text'. when the total size of the code reach out 2M. The> > error occured. I read the '__log_buf' the kernel access some bad> > area. As the powerpce603 will map 16M address use two bat, how and> > why the problem occured, and how to solved it .> >> > Since the error occurs at 2M, I am going to guess it is similar to> problem I had. The default link/load address for booting is 0x200000.> > Here is a link:> <http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=14717>> > This fix is for the arch/ppc tree. I don't know if the arch/powerpc tree> works the same way.> > In the future, you should say what kernel version you are using and what> the error was.> > Alan Nishioka> alan@nishioka.com> > _______________________________________________> Linuxppc-embedded mailing list> Linuxppc-embedded@ozlabs.org> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
 
Thanks! Mr.西岡
The u-boot uncompress the Muti-file image.
 when the u-boot show:
## Booting image at 01000000 ...   Image Name:   E300-2.0(8), alpha   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)   Data Size:    15246424 Bytes = 14.5 MB   Load Address: 00000000   Entry Point:  00000000   Contents:   Image 0:  1887243 Bytes =  1.8 MB   Image 1: 13359168 Bytes = 12.7 MB   Verifying Checksum ... OK    ... OK   Loading Ramdisk to 0ef08000, end 0fbc5840 ... OK
 
the image 0 is 1.8MB.It can not bootup. No matter I put the FPGA images in section '.init.data' or '.init.text'.
 
 
when the u-boot show
Bytes transferred = 15163187 (e75f33 hex)## Booting image at 01000000 ...   Image Name:   E300-2.0(8), alpha   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)   Data Size:    15163123 Bytes = 14.5 MB   Load Address: 00000000   Entry Point:  00000000   Contents:   Image 0:  1803789 Bytes =  1.7 MB   Image 1: 13359319 Bytes = 12.7 MB   Verifying Checksum ... OK   Uncompressing Multi-File Image ... OK   Loading Ramdisk to 0ef08000, end 0fbc58d7 ... OK
 
I cut one of the FPGA images. The Kernel image is 1.7MB.It can bootup. No matter I put the FPGA images in the section '.init.data' or '.init.text'. And when i fill the FPGA images in the section of '.init.data' the kernel makes mistake when she access the  '__setup_start = .;' At the vmlinux.ld.s, I find it just behind the section .init.data.  May be i can not describe correctly, because Truly I don't why.
 
 
My linux version is 2.6.18, using the arch/ppc tree. and the u-boot verison is 1.1.4.
 
 
 
_________________________________________________________________
多个邮箱同步管理，live mail客户端万人抢用中
http://get.live.cn/product/mail.html
--_1fe11c55-2d73-45ee-bdf2-ec1e7fa90e82_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
<BR><BR><FONT size=4>&gt; Date: Sat, 31 May 2008 03:23:07 -0700<BR>&gt; From: alan@nishioka.com<BR>&gt; To: linuxppc-embedded@ozlabs.org<BR>&gt; Subject: Re: FW: Error occured when appended FPGA image in the section of .init.text then bootup<BR>&gt; <BR>&gt; 朱利达 (lida zhu)wrote:<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; The request below give rise to the problem.<BR>&gt; &gt; I have some boards equiped with MPC8247 and FPGA without storage<BR>&gt; &gt; media which used as a PCI interface. So when the linux bootup<BR>&gt; &gt; before initialize the PCI, the code of FPGA will download. I<BR>&gt; &gt; append the FPGA code file in the Kernel section '.init.text'. when<BR>&gt; &gt; linux bootup firstly it check the board type(different board type<BR>&gt; &gt; would download different code), and download fpga code. More board<BR>&gt; &gt; types lead to more FPGA code. I append them all in the section of<BR>&gt; &gt; '.init.text'. when the total size of the code reach out 2M. The<BR>&gt; &gt; error occured. I read the '__log_buf' the kernel access some bad<BR>&gt; &gt; area. As the powerpce603 will map 16M address use two bat, how and<BR>&gt; &gt; why the problem occured, and how to solved it .<BR>&gt; &gt;<BR>&gt; <BR>&gt; Since the error occurs at 2M, I am going to guess it is similar to<BR>&gt; problem I had. The default link/load address for booting is 0x200000.<BR>&gt; <BR>&gt; Here is a link:<BR>&gt; &lt;http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=14717&gt;<BR>&gt; <BR>&gt; This fix is for the arch/ppc tree. I don't know if the arch/powerpc tree<BR>&gt; works the same way.<BR>&gt; <BR>&gt; In the future, you should say what kernel version you are using and what<BR>&gt; the error was.<BR>&gt; <BR>&gt; Alan Nishioka<BR>&gt; alan@nishioka.com<BR>&gt; <BR>&gt; _______________________________________________<BR>&gt; Linuxppc-embedded mailing list<BR>&gt; Linuxppc-embedded@ozlabs.org<BR>&gt; </FONT><A href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded"><FONT size=4>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</FONT></A><BR>
&nbsp;<BR>
<FONT size=5>Thanks! Mr.西岡</FONT><BR>
<FONT size=5><BR></FONT><FONT size=4>The u-boot uncompress the Muti-file image.</FONT><BR>
<FONT size=4></FONT>&nbsp;<FONT size=4>when the u-boot show:</FONT><BR>
<FONT size=4>## Booting image at 01000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; E300-2.0(8), alpha<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Multi-File Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 15246424 Bytes = 14.5 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Contents:<BR>&nbsp;&nbsp; Image 0:&nbsp; 1887243 Bytes =&nbsp; 1.8 MB<BR>&nbsp;&nbsp; Image 1: 13359168 Bytes = 12.7 MB<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp;&nbsp; ... OK<BR>&nbsp;&nbsp; Loading Ramdisk to 0ef08000, end 0fbc5840 ... OK</FONT><BR>
<FONT size=4></FONT>&nbsp;<BR>
<FONT size=4>the image 0 is 1.8MB.It can not bootup. No matter I put the FPGA&nbsp;images in section '.init.data' or '.init.text'.</FONT><BR>
<FONT size=4></FONT>&nbsp;<BR>
<FONT size=4></FONT>&nbsp;<BR>
<FONT size=4>when the u-boot show</FONT><BR>
<FONT size=4>Bytes transferred = 15163187 (e75f33 hex)<BR>## Booting image at 01000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; E300-2.0(8), alpha<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Multi-File Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 15163123 Bytes = 14.5 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Contents:<BR>&nbsp;&nbsp; Image 0:&nbsp; 1803789 Bytes =&nbsp; 1.7 MB<BR>&nbsp;&nbsp; Image 1: 13359319 Bytes = 12.7 MB<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Multi-File Image ... OK<BR>&nbsp;&nbsp; Loading Ramdisk to 0ef08000, end 0fbc58d7 ... OK</FONT><BR>
<FONT size=4></FONT>&nbsp;<BR>
<FONT size=4>I cut one of the FPGA images. The Kernel image is 1.7MB.It can bootup. No matter I put the FPGA&nbsp;images in the section '.init.data' or '.init.text'. And when i fill the FPGA images in the section of '.init.data' the kernel makes mistake when she access the&nbsp; '__setup_start = .;' At the vmlinux.ld.s, I find it just behind the section .init.data.&nbsp; May be i can not describe correctly, because Truly I don't why.</FONT><BR>
<FONT size=4></FONT>&nbsp;<BR>
&nbsp;<BR>
<FONT size=4>My linux version is 2.6.18, using the arch/ppc tree. and the u-boot verison is 1.1.4.</FONT><BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR><br /><hr />用 Windows Live Spaces 展示个性自我，与好友分享生活！  <a href='http://spaces.live.com/?page=HP' target='_new'>了解更多信息！</a></body>
</html>
--_1fe11c55-2d73-45ee-bdf2-ec1e7fa90e82_--
