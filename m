Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A084B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 15:09:03 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <6213bc560908102335n2b6a2bc1icb2acafe7f4117@mail.gmail.com>
References: <6213bc560908102335n2b6a2bc1icb2acafe7f4117@mail.gmail.com>
Date: Fri, 14 Aug 2009 10:38:59 +0530
Message-ID: <6213bc560908132208q11c36d2ai2117263a237d6f1a@mail.gmail.com>
Subject: Re: PowerPC kernel linux-2.6.29.6 PANIC's at include/linux/cred.h for
	ipsec enabled kernel
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00504502afbabfc9470471130ce6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502afbabfc9470471130ce6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Target : PowerPC440
Kernel : Linux-2.6.29.6

The issue still remains in kernel linux-2.6.29.6  enabling following options
in kernel, the kernel panics and won't boot anymore

The following kernel options enabled :


# Networking support
CONFIG_NET=y
CONFIG_INET=y
CONFIG_NET_KEY=y
CONFIG_XFRM_USER=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
# IPV6
CONFIG_IPV6=y
CONFIG_IPV6_TUNNEL=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_INET6_TUNNEL=y
# Cryptographic API
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_DEFLATE=y

and while bootup I am seeing the panic/crash message as :

Looking up port of RPC 100005/1 on 10.50.21.151
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing unused kernel memory: 184k init
INIT: version 2.86 booting
Starting udevudevd version 124 started

Remounting root file system...
------------[ cut here ]------------
kernel BUG at include/linux/cred.h:206!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT LTT NESTING LEVEL : 0
Xilinx PPC440
Modules linked in:
NIP: c00a8414 LR: c0067804 CTR: c00a83ec
REGS: ce977da0 TRAP: 0700   Not tainted  (2.6.29.6-ipsec)
MSR: 00029000 <EE,ME,CE>  CR: 24028448  XER: 00000005
TASK = cf9a9430[472] 'mount.sh' THREAD: ce976000
GPR00: ffffffff ce977e50 cf9a9430 cf9e00c0 cf3c7ee0 fffeb038 00000003 c04f2224
GPR08: 000000bf 00000001 cf8070e0 c05255e8 44022444 100db7bc 4802e5a4 bf9f09c8
GPR16: c0456670 00000000 c0511188 c05111a8 c0525624 00000001 c0522ca0 ce976034
GPR24: c0511328 ce976034 ce976000 c05255e8 00000003 cf3c7160 c00a83ec cf99aaa0
NIP [c00a8414] file_free_rcu+0x28/0x6c
LR [c0067804] __rcu_process_callbacks+0x1e4/0x400
Call Trace:
[ce977e50] [c00a8444] file_free_rcu+0x58/0x6c (unreliable)
[ce977e60] [c0067804] __rcu_process_callbacks+0x1e4/0x400
[ce977e90] [c0067a4c] rcu_process_callbacks+0x2c/0x4c
[ce977eb0] [c0038cb0] __do_softirq+0xfc/0x1e0
[ce977f00] [c0004124] do_softirq+0x5c/0x60
[ce977f10] [c0038b18] irq_exit+0x98/0xc4
[ce977f20] [c000b2b4] timer_interrupt+0x104/0x1cc
[ce977f40] [c000e7d8] ret_from_except+0x0/0x18
Instruction dump:
4832cfa9 4bffffd8 9421fff0 7c0802a6 93e1000c 7c7f1b78 90010014 8063003c
81230000 3809ffff 7d290378 55290ffe <0f090000> 7c001828 3000ffff 7c00192d
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..

Any suggestions or the filed bug report anywhere ??


-Srikant



On Tue, Aug 11, 2009 at 12:05 PM, srikanth krishnakar <skrishnakar@gmail.com
> wrote:

> Hi All,
>
> Target : PowerPC (ppc440)
>
> While testing kernel linux-2.6.29.6 with IPSEC enabled I observed frequent
> panic messages as shown below while bootup:
>
> VFS: Mounted root (nfs filesystem) on device 0:13.
>
> Freeing unused kernel memory: 184k init
> INIT: version 2.86 booting
> Starting udevudevd version 124 started
>
> Remounting root file system...
> logger: mount: mount point /proc/bus/usb does not exist
> FAT: invalid media value (0x01)
>
> VFS: Can't find a valid FAT filesystem on dev xsa.
> ------------[ cut here ]------------
> kernel BUG at include/linux/cred.h:206!
> Oops: Exception in kernel mode, sig: 5 [#1]
> PREEMPT LTT NESTING LEVEL : 0
>
> Xilinx Virtex440
> Modules linked in: nls_iso8859_1
> NIP: c0031800 LR: c0031864 CTR: c0033e2c
> REGS: c0515d00 TRAP: 0700   Not tainted  (2.6.29.6.xilinx-ml507.0908071454-ipsec)
> MSR: 00029000 <EE,ME,CE>  CR: 24028028  XER: 00000005
>
> TASK = c04e74c0[0] 'swapper' THREAD: c0514000
> GPR00: ffffffff c0515db0 c04e74c0 cf9e0120 c00539b4 00000002 ffffffff c04f2224
> GPR08: 000002fd 00000001 000002fc c05255e8 44022024 ffffd6c4 dce9ee1f bfefe53f
>
> GPR16: c0456690 00000000 c0511188 c05111a8 c0525624 00000001 c0522ca0 c0514034
> GPR24: c0511328 c0514034 c0514000 c05255e8 0000000a cf3e7920 ce89e050 ce89e050
> NIP [c0031800] __put_task_struct+0x8c/0xf4
> LR [c0031864] __put_task_struct+0xf0/0xf4
>
> Call Trace:
> [c0515db0] [c0031864] __put_task_struct+0xf0/0xf4 (unreliable)
> [c0515dc0] [c0033ecc] delayed_put_task_struct+0xa0/0xbc
> [c0515de0] [c0067804] __rcu_process_callbacks+0x1e4/0x400
> [c0515e10] [c0067a4c] rcu_process_callbacks+0x2c/0x4c
>
> [c0515e30] [c0038cb0] __do_softirq+0xfc/0x1e0
> [c0515e80] [c0004124] do_softirq+0x5c/0x60
> [c0515e90] [c0038b18] irq_exit+0x98/0xc4
> [c0515ea0] [c000b2b4] timer_interrupt+0x104/0x1cc
> [c0515ec0] [c000e7d8] ret_from_except+0x0/0x18
>
> [c0515f80] [c0007294] cpu_idle+0x58/0xf4
> [c0515fa0] [c03db4dc] __got2_end+0x80/0x94
> [c0515fc0] [c04b6734] start_kernel+0x25c/0x2b0
> [c0515ff0] [c0000218] skpinv+0x1a8/0x1e4
> Instruction dump:
> 0f090000 7c001828 3000ffff 7c00192d 40a2fff4 2f800000 419e0078 807f01a4
>
> 81230000 3809ffff 7d290378 55290ffe <0f090000> 7c001828 3000ffff 7c00192d
> Kernel panic - not syncing: Fatal exception in interrupt
> Rebooting in 180 seconds..
>
>
> Attachment: kernel config
>
> your early comments are appreciated !
>
>
>
> Regards
> Srikanth Krishnakar
> **********************
>



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--00504502afbabfc9470471130ce6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Target : PowerPC440<br>Kernel : Linux-2.6.29.6<br><br>The is=
sue still remains in kernel linux-2.6.29.6=A0 enabling following options in=
 kernel, the kernel panics and won&#39;t boot anymore<br><br>The following =
kernel options enabled :<br>
<br><br># Networking support<br>CONFIG_NET=3Dy<br>CONFIG_INET=3Dy<br>CONFIG=
_NET_KEY=3Dy<br>CONFIG_XFRM_USER=3Dy<br>CONFIG_INET_AH=3Dy<br>CONFIG_INET_E=
SP=3Dy<br>CONFIG_INET_IPCOMP=3Dy<br>CONFIG_INET_TUNNEL=3Dy<br># IPV6<br>CON=
FIG_IPV6=3Dy<br>
CONFIG_IPV6_TUNNEL=3Dy<br>CONFIG_INET6_AH=3Dy<br>CONFIG_INET6_ESP=3Dy<br>CO=
NFIG_INET6_IPCOMP=3Dy<br>CONFIG_INET6_TUNNEL=3Dy<br># Cryptographic API<br>=
CONFIG_CRYPTO=3Dy<br>CONFIG_CRYPTO_HMAC=3Dy<br>CONFIG_CRYPTO_NULL=3Dy<br>CO=
NFIG_CRYPTO_MD5=3Dy<br>
CONFIG_CRYPTO_SHA1=3Dy<br>CONFIG_CRYPTO_DES=3Dy<br>CONFIG_CRYPTO_AES=3Dy<br=
>CONFIG_CRYPTO_DEFLATE=3Dy<br><br>and while bootup I am seeing the panic/cr=
ash message as :<br><br><pre>Looking up port of RPC 100005/1 on 10.50.21.15=
1<br>
VFS: Mounted root (nfs filesystem) on device 0:13.<br>Freeing unused kernel=
 memory: 184k init<br>INIT: version 2.86 booting<br>Starting udevudevd vers=
ion 124 started<br><br>Remounting root file system...<br>------------[ cut =
here ]------------<br>
kernel BUG at include/linux/cred.h:206!<br>Oops: Exception in kernel mode, =
sig: 5 [#1]<br>PREEMPT LTT NESTING LEVEL : 0<br>Xilinx PPC440<br>Modules li=
nked in:<br>NIP: c00a8414 LR: c0067804 CTR: c00a83ec<br>REGS: ce977da0 TRAP=
: 0700   Not tainted  (2.6.29.6-ipsec)<br>
MSR: 00029000 &lt;EE,ME,CE&gt;  CR: 24028448  XER: 00000005<br>TASK =3D cf9=
a9430[472] &#39;mount.sh&#39; THREAD: ce976000<br>GPR00: ffffffff ce977e50 =
cf9a9430 cf9e00c0 cf3c7ee0 fffeb038 00000003 c04f2224<br>GPR08: 000000bf 00=
000001 cf8070e0 c05255e8 44022444 100db7bc 4802e5a4 bf9f09c8<br>
GPR16: c0456670 00000000 c0511188 c05111a8 c0525624 00000001 c0522ca0 ce976=
034<br>GPR24: c0511328 ce976034 ce976000 c05255e8 00000003 cf3c7160 c00a83e=
c cf99aaa0<br>NIP [c00a8414] file_free_rcu+0x28/0x6c<br>LR [c0067804] __rcu=
_process_callbacks+0x1e4/0x400<br>
Call Trace:<br>[ce977e50] [c00a8444] file_free_rcu+0x58/0x6c (unreliable)<b=
r>[ce977e60] [c0067804] __rcu_process_callbacks+0x1e4/0x400<br>[ce977e90] [=
c0067a4c] rcu_process_callbacks+0x2c/0x4c<br>[ce977eb0] [c0038cb0] __do_sof=
tirq+0xfc/0x1e0<br>
[ce977f00] [c0004124] do_softirq+0x5c/0x60<br>[ce977f10] [c0038b18] irq_exi=
t+0x98/0xc4<br>[ce977f20] [c000b2b4] timer_interrupt+0x104/0x1cc<br>[ce977f=
40] [c000e7d8] ret_from_except+0x0/0x18<br>Instruction dump:<br>4832cfa9 4b=
ffffd8 9421fff0 7c0802a6 93e1000c 7c7f1b78 90010014 8063003c<br>
81230000 3809ffff 7d290378 55290ffe &lt;0f090000&gt; 7c001828 3000ffff 7c00=
192d<br>Kernel panic - not syncing: Fatal exception in interrupt<br>Rebooti=
ng in 180 seconds..<br><br>Any suggestions or the filed bug report anywhere=
 ??<br>
<br><br>-Srikant<br></pre><br><br><div class=3D"gmail_quote">On Tue, Aug 11=
, 2009 at 12:05 PM, srikanth krishnakar <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:skrishnakar@gmail.com">skrishnakar@gmail.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi All,<br><br>Target : PowerPC (ppc440)<br><br>While testing kernel linux-=
2.6.29.6 with IPSEC enabled I observed frequent panic messages as shown bel=
ow while bootup:<br><br><pre>VFS: Mounted root (nfs filesystem) on device 0=
:13.<br>

Freeing unused kernel memory: 184k init<br>INIT: version 2.86 booting<br>St=
arting udevudevd version 124 started<br><br>Remounting root file system...<=
br>logger: mount: mount point /proc/bus/usb does not exist<br>FAT: invalid =
media value (0x01)<br>

VFS: Can&#39;t find a valid FAT filesystem on dev xsa.<br>------------[ cut=
 here ]------------<br>kernel BUG at include/linux/cred.h:206!<br>Oops: Exc=
eption in kernel mode, sig: 5 [#1]<br>PREEMPT LTT NESTING LEVEL : 0<br>

Xilinx Virtex440<br>Modules linked in: nls_iso8859_1<br>NIP: c0031800 LR: c=
0031864 CTR: c0033e2c<br>REGS: c0515d00 TRAP: 0700   Not tainted  (2.6.29.6=
.xilinx-ml507.0908071454-ipsec)<br>MSR: 00029000 &lt;EE,ME,CE&gt;  CR: 2402=
8028  XER: 00000005<br>

TASK =3D c04e74c0[0] &#39;swapper&#39; THREAD: c0514000<br>GPR00: ffffffff =
c0515db0 c04e74c0 cf9e0120 c00539b4 00000002 ffffffff c04f2224<br>GPR08: 00=
0002fd 00000001 000002fc c05255e8 44022024 ffffd6c4 dce9ee1f bfefe53f<br>

GPR16: c0456690 00000000 c0511188 c05111a8 c0525624 00000001 c0522ca0 c0514=
034<br>GPR24: c0511328 c0514034 c0514000 c05255e8 0000000a cf3e7920 ce89e05=
0 ce89e050<br>NIP [c0031800] __put_task_struct+0x8c/0xf4<br>LR [c0031864] _=
_put_task_struct+0xf0/0xf4<br>

Call Trace:<br>[c0515db0] [c0031864] __put_task_struct+0xf0/0xf4 (unreliabl=
e)<br>[c0515dc0] [c0033ecc] delayed_put_task_struct+0xa0/0xbc<br>[c0515de0]=
 [c0067804] __rcu_process_callbacks+0x1e4/0x400<br>[c0515e10] [c0067a4c] rc=
u_process_callbacks+0x2c/0x4c<br>

[c0515e30] [c0038cb0] __do_softirq+0xfc/0x1e0<br>[c0515e80] [c0004124] do_s=
oftirq+0x5c/0x60<br>[c0515e90] [c0038b18] irq_exit+0x98/0xc4<br>[c0515ea0] =
[c000b2b4] timer_interrupt+0x104/0x1cc<br>[c0515ec0] [c000e7d8] ret_from_ex=
cept+0x0/0x18<br>

[c0515f80] [c0007294] cpu_idle+0x58/0xf4<br>[c0515fa0] [c03db4dc] __got2_en=
d+0x80/0x94<br>[c0515fc0] [c04b6734] start_kernel+0x25c/0x2b0<br>[c0515ff0]=
 [c0000218] skpinv+0x1a8/0x1e4<br>Instruction dump:<br>0f090000 7c001828 30=
00ffff 7c00192d 40a2fff4 2f800000 419e0078 807f01a4<br>

81230000 3809ffff 7d290378 55290ffe &lt;0f090000&gt; 7c001828 3000ffff 7c00=
192d<br>Kernel panic - not syncing: Fatal exception in interrupt<br>Rebooti=
ng in 180 seconds..<br></pre><br>Attachment: kernel config<br><br>your earl=
y comments are appreciated !<br clear=3D"all">

<br><br><br>Regards<br><font color=3D"#888888">Srikanth Krishnakar<br>*****=
*****************<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good Y=
ou Do, The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>****=
******************<br>

--00504502afbabfc9470471130ce6--
