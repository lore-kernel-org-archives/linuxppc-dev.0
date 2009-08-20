Return-Path: <victorgallardo@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C1EDFB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 04:51:43 +1000 (EST)
Received: from web39804.mail.mud.yahoo.com (web39804.mail.mud.yahoo.com
	[209.191.106.65]) by ozlabs.org (Postfix) with SMTP id 19F3BDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 04:51:42 +1000 (EST)
Message-ID: <887471.64543.qm@web39804.mail.mud.yahoo.com>
Date: Thu, 20 Aug 2009 11:45:02 -0700 (PDT)
From: Victor Gallardo <victorgallardo@yahoo.com>
Subject: JFFS2 overflow bug in read_dnone
To: linux-mtd@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,=0A=A0=0AI noticed if I compile with CONFIG_PPC_64K_PAGES, I run into th=
e following issue.=0A=A0=0A******** read_dnode: tn->csize =3D=3D 0, csize =
=3D=3D 65536=0A******** check_node: tn->csize =3D=3D 0 <=3D=3D=3D=3D=3D=3D=
=3D=3D BUG_ON assert=0A=A0=0ALook like an OVERFLOW bug. Is this correct?=0A=
=A0=0AHere is the problem=0A=A0=0Afs/jffs2/nodelist.h=0A=A0=A0=A0 struct jf=
fs2_tmp_dnode_info=0A=A0=A0=A0 {=0A=A0=A0=A0=A0=A0=A0=A0 ...=0A=A0=A0=A0=A0=
=A0=A0=A0 uint16_t csize;=0A=A0=A0=A0=A0=A0=A0=A0 ...=0A=A0=A0=A0 };=0A=A0=
=0Afs/jffs2/readinode.c=0A=A0=A0=A0 static inline int read_dnode(...)=0A=A0=
=A0=A0 {=0A=A0=A0=A0=A0=A0=A0=A0 struct jffs2_tmp_dnode_info *tn;=0A=A0=A0=
=A0=A0=A0=A0=A0 uint32_t csize;=0A=A0=A0=A0=A0=A0=A0=A0 ...=0A=A0=A0=A0=A0=
=A0=A0=A0 csize =3D je32_to_cpu(rd->csize);=0A=A0=A0=A0=A0=A0=A0=A0 ...=0A=
=A0=A0=A0=A0=A0=A0=A0 tn->csize =3D csize;=0A=A0 #ifdef DBG_BUG_ON_ASSERT=
=0A=A0=A0=A0=A0=A0=A0=A0 if ( tn->csize =3D=3D 0 && csize !=3D 0) {=0A=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("******* %s: tn->csize =
=3D=3D 0, csize =3D=3D %d\n",__func__,csize);=0A=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0 #endif=0A=A0=A0=A0=A0=A0=A0=A0 ....=0A=A0=A0 }=0ABest Regards,=0A=A0=0A=
Victor Gallardo=0A
