Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1F1B0B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 02:14:59 +1000 (EST)
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30576DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 02:14:57 +1000 (EST)
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by e24smtp05.br.ibm.com (8.14.3/8.13.1) with ESMTP id n73GDpoI021019
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:13:51 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73HDsqZ3625114
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 14:13:54 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73GEmwB032761
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:14:49 -0300
Subject: Re: [Patch 0/6] [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint
	interfaces - ver VIII
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20090731061013.GG3950@yookeroo.seuss>
References: <20090727001152.GA13562@in.ibm.com>
	<20090731061013.GG3950@yookeroo.seuss>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 13:14:56 -0300
Message-Id: <1249316097.3362.13.camel@gargoyle>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2009-07-31 at 16:10 +1000, David Gibson wrote:
> On Mon, Jul 27, 2009 at 05:41:52AM +0530, K.Prasad wrote:
> > Hi David,
> > 	I'm back with a new version of patches after a brief hiatus!
> > 
> > After much deliberation about modifying the code to change the timing of signal
> > delivery to user-space, it has been decided to retain the existing behaviour
> > i.e. SIGTRAP delivered to user-space after execution of causative instruction
> > although exception is raised before execution of it.
> 
> Ok.  Except, presumably for ptrace, since changing that would break
> gdb.

Yes. GDB works with some assumptions in mind. Hardware breakpoints
(they're not supported right now) trigger before execution, then GDB
just removes them and stepi's until we're past the breakpoint.

As for HW watchpoints, we always stop before execution (by ppc design
presumably). GDB will check the value before the trigger, remove the HW
watch, stepi it, and will check the value again to see if it has
changed.

If we're to trigger after the data load/store has happened, we could
have breakage in GDB.

Regards,
Luis
