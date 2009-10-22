Return-Path: <jakemagee@gmail.com>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id CED4CB7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 09:28:49 +1100 (EST)
Received: by ywh39 with SMTP id 39so8394637ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 15:28:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330707311@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330707311@midas.usurf.usu.edu>
Date: Thu, 22 Oct 2009 17:28:47 -0500
Message-ID: <a8142e730910221528j185a7d51h6caa604b8695ee50@mail.gmail.com>
Subject: Re: Page map BUG on program exit
From: Jake Magee <jakemagee@gmail.com>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Content-Type: multipart/alternative; boundary=001636b2b2806d2c8b04768d9eb1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636b2b2806d2c8b04768d9eb1
Content-Type: text/plain; charset=ISO-8859-1

Here ya go Jonathan,
http://patchwork.ozlabs.org/patch/34047/
http://patchwork.ozlabs.org/patch/34113/

Both patches work for my situation, but I went with the second set as a
final patch(34113).

- Jake Magee

On Thu, Oct 22, 2009 at 3:57 PM, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>wrote:

> All,
>
> I am using a 405EX CPU on a custom board.  The layout and hardware is very
> similar to the AMCC Kilauea board.  Here is the output of uname -a:
>
> Linux (none) 2.6.30.3-wolverine-dirty #3 PREEMPT Thu Sep 10 11:41:37 MDT
> 2009 ppc unknown
>
> I am getting the following BUG output when my program exits:
>
> BUG: Bad page map in process main  pte:980005d7 pmd:0d840400
> addr:48000000 vm_flags:400844fb anon_vma:(null) mapping:cd8454f8
> index:98000
> vma->vm_file->f_op->mmap: fpga_mmap+0x0/0x178 [fpgaDriver]
> Call Trace:
> [cd84dc40] [c0006f0c] show_stack+0x44/0x16c (unreliable)
> [cd84dc80] [c00ba314] print_bad_pte+0x140/0x1d0
> [cd84dcb0] [c00ba3ec] vm_normal_page+0x48/0x50
> [cd84dcc0] [c00bb2ec] unmap_vmas+0x214/0x614
> [cd84dd40] [c00bffe0] exit_mmap+0xd0/0x1b4
> [cd84dd70] [c0031e40] mmput+0x50/0x134
> [cd84dd80] [c0036470] exit_mm+0x114/0x13c
> [cd84ddb0] [c0037d80] do_exit+0xc0/0x68c
> [cd84de00] [c0038390] do_group_exit+0x44/0xd8
> [cd84de10] [c0044468] get_signal_to_deliver+0x1f8/0x430
> [cd84de70] [c0008224] do_signal+0x54/0x29c
> [cd84df40] [c0010d5c] do_user_signal+0x74/0xc4
>
> I have an FPGA on the PCIe bus that I am mapping BAR0 to user space with a
> call to mmap().  The mapping works just fine and I can access all the
> registers in the BAR without a problem.  However, on exit this comes up.
>
> A Google search showed tons of people with similar problems in standard
> distributions (Ubuntu primarily), but no resolutions.
>
> Has anyone seen this crop up before and know what the issue is?  I include
> any source code, if that is required.
>
> Thanks!
>
> Jonathan
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--001636b2b2806d2c8b04768d9eb1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here ya go Jonathan,<br><a href=3D"http://patchwork.ozlabs.org/patch/34047/=
">http://patchwork.ozlabs.org/patch/34047/</a><br><a href=3D"http://patchwo=
rk.ozlabs.org/patch/34113/">http://patchwork.ozlabs.org/patch/34113/</a><br=
>
<br>Both patches work for my situation, but I went with the second set as a=
 final patch(34113).<br><br>
- Jake Magee<br><br><div class=3D"gmail_quote">On Thu, Oct 22, 2009 at 3:57=
 PM, Jonathan Haws <span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.Haws@sd=
l.usu.edu">Jonathan.Haws@sdl.usu.edu</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
All,<br>
<br>
I am using a 405EX CPU on a custom board. =A0The layout and hardware is ver=
y similar to the AMCC Kilauea board. =A0Here is the output of uname -a:<br>
<br>
Linux (none) 2.6.30.3-wolverine-dirty #3 PREEMPT Thu Sep 10 11:41:37 MDT 20=
09 ppc unknown<br>
<br>
I am getting the following BUG output when my program exits:<br>
<br>
BUG: Bad page map in process main =A0pte:980005d7 pmd:0d840400<br>
addr:48000000 vm_flags:400844fb anon_vma:(null) mapping:cd8454f8 index:9800=
0<br>
vma-&gt;vm_file-&gt;f_op-&gt;mmap: fpga_mmap+0x0/0x178 [fpgaDriver]<br>
Call Trace:<br>
[cd84dc40] [c0006f0c] show_stack+0x44/0x16c (unreliable)<br>
[cd84dc80] [c00ba314] print_bad_pte+0x140/0x1d0<br>
[cd84dcb0] [c00ba3ec] vm_normal_page+0x48/0x50<br>
[cd84dcc0] [c00bb2ec] unmap_vmas+0x214/0x614<br>
[cd84dd40] [c00bffe0] exit_mmap+0xd0/0x1b4<br>
[cd84dd70] [c0031e40] mmput+0x50/0x134<br>
[cd84dd80] [c0036470] exit_mm+0x114/0x13c<br>
[cd84ddb0] [c0037d80] do_exit+0xc0/0x68c<br>
[cd84de00] [c0038390] do_group_exit+0x44/0xd8<br>
[cd84de10] [c0044468] get_signal_to_deliver+0x1f8/0x430<br>
[cd84de70] [c0008224] do_signal+0x54/0x29c<br>
[cd84df40] [c0010d5c] do_user_signal+0x74/0xc4<br>
<br>
I have an FPGA on the PCIe bus that I am mapping BAR0 to user space with a =
call to mmap(). =A0The mapping works just fine and I can access all the reg=
isters in the BAR without a problem. =A0However, on exit this comes up.<br>

<br>
A Google search showed tons of people with similar problems in standard dis=
tributions (Ubuntu primarily), but no resolutions.<br>
<br>
Has anyone seen this crop up before and know what the issue is? =A0I includ=
e any source code, if that is required.<br>
<br>
Thanks!<br>
<br>
Jonathan<br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--001636b2b2806d2c8b04768d9eb1--
