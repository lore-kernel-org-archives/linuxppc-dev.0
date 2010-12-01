Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C6A2B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 00:48:22 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB1DYf8b029273
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 06:34:41 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id oB1Dm6sZ043998
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 06:48:06 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB1Dm69U013690
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 06:48:06 -0700
Date: Wed, 1 Dec 2010 08:47:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joachim Foerster <JOFT@gmx.de>
Subject: Re: _extending_ platform support options?
Message-ID: <20101201134719.GA1053@zod.rchland.ibm.com>
References: <4CF64CD7.2060802@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CF64CD7.2060802@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 01, 2010 at 02:25:43PM +0100, Joachim Foerster wrote:
>Hi all,
>
>currently I'm wondering what the preferred/recommend way of
>_extending_ an existing "Platform support" option is?
>
>We are working with custom design/boards based on Virtex4/5. So we
>are primarily using the  CONFIG_XILINX_VIRTEX*_GENERIC_BOARD options.
>In our case we have some special needs, like custom ppc_md.restart(),
>ppc_md.power_off() or ppc_md.show_cpuinfo().
>
>Till now, we just duplicated arch/powerpc/platforms/4?x/virtex.c and
>added our special stuff. Properly renaming everything, etc ...
>
>An alternative could be to add a virtex_my.c which extends virtex.c, like this
>(also like virtex_ml510.c extends virtex.c):
>
>static void virtex_my_show_cpuinfo(struct seq_file *m)
>{
>	seq_printf(m, something);
>}
>
>static int __init virtex_mle_init(void)
>{
>	ppc_md.show_cpuinfo = virtex_my_show_cpuinfo;
>	return 0;
>}
>machine_core_initcall(virtex, virtex_my_init);
>
>Though, to me, it does not seem really OK to assign ppc_md members
>that way. The original struct machdep for "virtex" (which is defined
>in virtex.c with define_machine()) is not adjusted either. Ok, we
>could modify that one, too.
>Especially I'm not sure if it is OK to use machine_core_initcall() for such modifications.
>
>So my question is: Is there any recommended way for doing such
>"extensions"? Or is it OK to just duplicate virtex.c (which does not
>seem really OK, too)?

Duplicate it as you have done, naming the file something unique.  We try
to prevent unnecessary duplication of code, but sometimes it's cleaner
to just have a separate board file instead.

josh
