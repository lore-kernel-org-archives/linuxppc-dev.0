Return-Path: <jakemagee@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 39941B7D16
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 12:26:18 +1100 (EST)
Received: by gwj20 with SMTP id 20so3276895gwj.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 17:26:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B956CD9.9090401@harris.com>
References: <4B956156.8010807@harris.com> <4B956CD9.9090401@harris.com>
Date: Mon, 8 Mar 2010 19:26:16 -0600
Message-ID: <a8142e731003081726j1b60e9dfyeead2e89bc51a5e5@mail.gmail.com>
Subject: Re: BUG: Bad page map in process mm2
From: Jake Magee <jakemagee@gmail.com>
To: "Steven A. Falco" <sfalco@harris.com>
Content-Type: multipart/alternative; boundary=001636ed6f5975c65104815411c1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636ed6f5975c65104815411c1
Content-Type: text/plain; charset=ISO-8859-1

Steven,

Try these patches...
http://patchwork.ozlabs.org/patch/34047/
http://patchwork.ozlabs.org/patch/34113/

Both patches work for my situation, but I went with the second set as a
final patch(34113).


On Mon, Mar 8, 2010 at 3:32 PM, Steven A. Falco <sfalco@harris.com> wrote:

> Steven A. Falco wrote:
>
> Apologies - previous crash dump was mangled by the
> interspersed program output.  Here is one showing
> just the crash dump.
>
> Interestingly, the program does produce correct output,
> as verified by dd'ing from /dev/mem to a file, then
> doing "od" on the result.  So in some sense, the error
> is spurious.
>
>        Steve
>
> # ./mm2 > foo 2>&1
> BUG: Bad page map in process mm2  pte:00000452 pmd:0f6c8400
> page:c0396000 flags:00000404 count:1 mapcount:-1 mapping:(null) index:0
> addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:cea78430 index:0
> vma->vm_ops->fault: 0x0
> vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa4
> Call Trace:
> [cf4c5d90] [c0006cf4] show_stack+0x44/0x16c (unreliable)
> [cf4c5dd0] [c0067800] print_bad_pte+0x140/0x1cc
> [cf4c5e00] [c0068640] unmap_vmas+0x41c/0x594
> [cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
> [cf4c5ea0] [c0020948] mmput+0x50/0xe0
> [cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
> [cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
> [cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
> [cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
> [cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c
> Disabling lock debugging due to kernel taint
> BUG: Bad page state in process mm2  pfn:00000
> page:c0396000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0
> Call Trace:
> [cf4c5d80] [c0006cf4] show_stack+0x44/0x16c (unreliable)
> [cf4c5dc0] [c00585bc] bad_page+0x94/0x12c
> [cf4c5de0] [c005d234] put_page+0x4c/0x170
> [cf4c5df0] [c0073e54] free_page_and_swap_cache+0x34/0x8c
> [cf4c5e00] [c0068490] unmap_vmas+0x26c/0x594
> [cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
> [cf4c5ea0] [c0020948] mmput+0x50/0xe0
> [cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
> [cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
> [cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
> [cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
> [cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c
> # cat foo
> 00000000: 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378
> 00000010: 7cfb3b78 480022ad 3c000002 60001032
> 00000020: 7c1b03a6 3c00c000 60002210 7c1a03a6
> 00000030: 4c000064 48000000 00000000 00000000
> # dd count=1 if=/dev/mem of=goo
> # od -X goo
> 0000000         7c7f1b78        7c9e2378        7cbd2b78        7cdc3378
> 0000020         7cfb3b78        480022ad        3c000002        60001032
> 0000040         7c1b03a6        3c00c000        60002210        7c1a03a6
> 0000060         4c000064        48000000        00000000        00000000
> 0000100
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--001636ed6f5975c65104815411c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven,<br><br>Try these patches...<br><a href=3D"http://patchwork.ozlabs.o=
rg/patch/34047/" target=3D"_blank">http://patchwork.ozlabs.org/patch/34047/=
</a><br><a href=3D"http://patchwork.ozlabs.org/patch/34113/" target=3D"_bla=
nk">http://patchwork.ozlabs.org/patch/34113/</a><br>

<br>Both patches work for my situation, but I went with the second set=20
as a final patch(34113).<br>
<br><br><div class=3D"gmail_quote">On Mon, Mar 8, 2010 at 3:32 PM, Steven A=
. Falco <span dir=3D"ltr">&lt;<a href=3D"mailto:sfalco@harris.com">sfalco@h=
arris.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">
Steven A. Falco wrote:<br>
<br>
Apologies - previous crash dump was mangled by the<br>
interspersed program output. =A0Here is one showing<br>
just the crash dump.<br>
<br>
Interestingly, the program does produce correct output,<br>
as verified by dd&#39;ing from /dev/mem to a file, then<br>
doing &quot;od&quot; on the result. =A0So in some sense, the error<br>
is spurious.<br>
<br>
 =A0 =A0 =A0 =A0Steve<br>
<br>
# ./mm2 &gt; foo 2&gt;&amp;1<br>
BUG: Bad page map in process mm2 =A0pte:00000452 pmd:0f6c8400<br>
<div class=3D"im">page:c0396000 flags:00000404 count:1 mapcount:-1 mapping:=
(null) index:0<br>
</div>addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:cea78430 inde=
x:0<br>
vma-&gt;vm_ops-&gt;fault: 0x0<br>
<div class=3D"im">vma-&gt;vm_file-&gt;f_op-&gt;mmap: mmap_mem+0x0/0xa4<br>
</div>Call Trace:<br>
[cf4c5d90] [c0006cf4] show_stack+0x44/0x16c (unreliable)<br>
<div class=3D"im">[cf4c5dd0] [c0067800] print_bad_pte+0x140/0x1cc<br>
</div><div class=3D"im">[cf4c5e00] [c0068640] unmap_vmas+0x41c/0x594<br>
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150<br>
[cf4c5ea0] [c0020948] mmput+0x50/0xe0<br>
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c<br>
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4<br>
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4<br>
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28<br>
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c<br>
Disabling lock debugging due to kernel taint<br>
BUG: Bad page state in process mm2 =A0pfn:00000<br>
page:c0396000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0<br>
Call Trace:<br>
[cf4c5d80] [c0006cf4] show_stack+0x44/0x16c (unreliable)<br>
[cf4c5dc0] [c00585bc] bad_page+0x94/0x12c<br>
[cf4c5de0] [c005d234] put_page+0x4c/0x170<br>
[cf4c5df0] [c0073e54] free_page_and_swap_cache+0x34/0x8c<br>
[cf4c5e00] [c0068490] unmap_vmas+0x26c/0x594<br>
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150<br>
[cf4c5ea0] [c0020948] mmput+0x50/0xe0<br>
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c<br>
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4<br>
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4<br>
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28<br>
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c<br>
</div># cat foo<br>
00000000: 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378<br>
00000010: 7cfb3b78 480022ad 3c000002 60001032<br>
00000020: 7c1b03a6 3c00c000 60002210 7c1a03a6<br>
00000030: 4c000064 48000000 00000000 00000000<br>
# dd count=3D1 if=3D/dev/mem of=3Dgoo<br>
# od -X goo<br>
0000000 =A0 =A0 =A0 =A0 7c7f1b78 =A0 =A0 =A0 =A07c9e2378 =A0 =A0 =A0 =A07cb=
d2b78 =A0 =A0 =A0 =A07cdc3378<br>
0000020 =A0 =A0 =A0 =A0 7cfb3b78 =A0 =A0 =A0 =A0480022ad =A0 =A0 =A0 =A03c0=
00002 =A0 =A0 =A0 =A060001032<br>
0000040 =A0 =A0 =A0 =A0 7c1b03a6 =A0 =A0 =A0 =A03c00c000 =A0 =A0 =A0 =A0600=
02210 =A0 =A0 =A0 =A07c1a03a6<br>
0000060 =A0 =A0 =A0 =A0 4c000064 =A0 =A0 =A0 =A048000000 =A0 =A0 =A0 =A0000=
00000 =A0 =A0 =A0 =A000000000<br>
0000100<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--001636ed6f5975c65104815411c1--
