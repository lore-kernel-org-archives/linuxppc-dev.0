Return-Path: <JOFT@gmx.de>
Received: from smtp.missinglinkelectronics.com
	(odin.missinglinkelectronics.com [188.40.137.181])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 466B7B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 00:31:04 +1100 (EST)
Received: from localhost (odin.missinglinkelectronics.com [127.0.0.1])
	by smtp.missinglinkelectronics.com (Postfix) with ESMTP id B842A386359
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 14:25:34 +0100 (CET)
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
	by localhost (smtp.missinglinkelectronics.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id AL9MvutCt313 for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 14:25:32 +0100 (CET)
Received: from [10.89.231.32] (unknown [217.10.6.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: joachim)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id
	6CB54386358 for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 14:25:32 +0100 (CET)
Message-ID: <4CF64CD7.2060802@gmx.de>
Date: Wed, 01 Dec 2010 14:25:43 +0100
From: Joachim Foerster <JOFT@gmx.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: _extending_ platform support options?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

currently I'm wondering what the preferred/recommend way of _extending_ an existing 
"Platform support" option is?

We are working with custom design/boards based on Virtex4/5. So we are primarily using the 
  CONFIG_XILINX_VIRTEX*_GENERIC_BOARD options. In our case we have some special needs, 
like custom ppc_md.restart(), ppc_md.power_off() or ppc_md.show_cpuinfo().

Till now, we just duplicated arch/powerpc/platforms/4?x/virtex.c and added our special 
stuff. Properly renaming everything, etc ...

An alternative could be to add a virtex_my.c which extends virtex.c, like this
(also like virtex_ml510.c extends virtex.c):

static void virtex_my_show_cpuinfo(struct seq_file *m)
{
	seq_printf(m, something);
}

static int __init virtex_mle_init(void)
{
	ppc_md.show_cpuinfo = virtex_my_show_cpuinfo;
	return 0;
}
machine_core_initcall(virtex, virtex_my_init);

Though, to me, it does not seem really OK to assign ppc_md members that way. The original 
struct machdep for "virtex" (which is defined in virtex.c with define_machine()) is not 
adjusted either. Ok, we could modify that one, too.
Especially I'm not sure if it is OK to use machine_core_initcall() for such modifications.

So my question is: Is there any recommended way for doing such "extensions"? Or is it OK 
to just duplicate virtex.c (which does not seem really OK, too)?

Thanks,
  Joachim
