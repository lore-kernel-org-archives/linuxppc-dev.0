Return-Path: <bharata.rao@gmail.com>
Received: from mail-oi0-x22c.google.com (mail-oi0-x22c.google.com
 [IPv6:2607:f8b0:4003:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTjkj23ffzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 19:42:05 +1000 (AEST)
Received: by mail-oi0-x22c.google.com with SMTP id l18so85565505oig.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 02:42:05 -0700 (PDT)
MIME-Version: 1.0
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 19 May 2017 15:12:03 +0530
Message-ID: <CAGZKiBqqwp1ZCe8Bgwe7H+XgR65-D4LPvuPTtW_mR=WsHaBVSQ@mail.gmail.com>
Subject: Memory hotplug broken on powerkvm/pseries with
 CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="001a113ac6a6710db0054fdd55c4"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113ac6a6710db0054fdd55c4
Content-Type: text/plain; charset="UTF-8"

Hi,

Memory hotplug for a pseries guest on PowerKVM fails with the following
error when CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y in the guest kernel. (I
am on commit b23afd384801)

[root@localhost ~]#  pseries-hotplug-mem: Attempting to hot-add 4 LMB(s) at
index 80000020
removing memory fails, because memory
[0x0000000200000000-0x000000020fffffff] is onlined
------------[ cut here ]------------
kernel BUG at mm/memory_hotplug.c:2189!
Oops: Exception in kernel mode, sig: 5 [#1]
Call Trace:
remove_memory+0x70/0x100 (unreliable)
dlpar_add_lmb+0x370/0x3f0
dlpar_memory+0x7bc/0xcd0
handle_dlpar_errorlog+0xf8/0x160
pseries_hp_work_fn+0x94/0xa0
process_one_work+0x240/0x510
worker_thread+0x9c/0x550
kthread+0x164/0x1b0
ret_from_kernel_thread+0x5c/0x7c

This failure occurs because the current code results in double onlining as
memhp_auto_online gets set with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y.

It appears that by reverting commit 943db62c316c5 (powerpc/pseries: Revert
'Auto-online hotplugged memory'), hotplug is working again.

Apparently that commit itself is a revert of other two commits which caused
"the pseries memory DLPAR code to fail when trying to remove an LMB that
was previously removed and added back". However I am able to do hotplug,
unplug, plug and unplug of the same DIMM device (set of LMBs) most of the
times with the above commit (943db62c316c5) reverted. The only occasional
failure to unplug occurs when guest refuses to offline an LMB (with -EBUSY)
possibly because it is in use, which I think is a valid failure.

Nathan - Could you please let me know the exact way to reproduce the
problem that led to this commit (943db62c316c5) ?

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/

--001a113ac6a6710db0054fdd55c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div>Memory hotp=
lug for a pseries guest on PowerKVM fails with the following error when CON=
FIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy in the guest kernel. (I am on commit =
b23afd384801)<br><br>[root@localhost ~]#=C2=A0 pseries-hotplug-mem: Attempt=
ing to hot-add 4 LMB(s) at index 80000020<br>removing memory fails, because=
 memory [0x0000000200000000-0x000000020fffffff] is onlined<br>------------[=
 cut here ]------------<br>kernel BUG at mm/memory_hotplug.c:2189!<br>Oops:=
 Exception in kernel mode, sig: 5 [#1]<br>Call Trace:<br>remove_memory+0x70=
/0x100 (unreliable)<br>dlpar_add_lmb+0x370/0x3f0<br>dlpar_memory+0x7bc/0xcd=
0<br>handle_dlpar_errorlog+0xf8/0x160<br>pseries_hp_work_fn+0x94/0xa0<br>pr=
ocess_one_work+0x240/0x510<br>worker_thread+0x9c/0x550<br>kthread+0x164/0x1=
b0<br>ret_from_kernel_thread+0x5c/0x7c<br><br></div><div>This failure occur=
s because the current code results in double onlining as memhp_auto_online =
gets set with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy.<br></div><div><br><=
/div>It appears that by reverting commit 943db62c316c5 (powerpc/pseries: Re=
vert &#39;Auto-online hotplugged memory&#39;), hotplug is working again.<br=
><br></div>Apparently that commit itself is a revert of other two commits w=
hich caused &quot;the pseries memory DLPAR code to fail when trying to remo=
ve an LMB that was previously removed and added back&quot;. However I am ab=
le to do hotplug, unplug, plug and unplug of the same DIMM device (set of L=
MBs) most of the times with the above commit (943db62c316c5) reverted. The =
only occasional failure to unplug occurs when guest refuses to offline an L=
MB (with -EBUSY) possibly because it is in use, which I think is a valid fa=
ilure.<br><br></div>Nathan - Could you please let me know the exact way to =
reproduce the problem that led to this commit (943db62c316c5) ?<br><br></di=
v>Regards,<br></div>Bharata.<br><div><div><div><div><div><div><div><div>-- =
<br><div class=3D"gmail_signature"><a href=3D"http://raobharata.wordpress.c=
om/" target=3D"_blank">http://raobharata.wordpress.com/</a></div>
</div></div></div></div></div></div></div></div></div>

--001a113ac6a6710db0054fdd55c4--
